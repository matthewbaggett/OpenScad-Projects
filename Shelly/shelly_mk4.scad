use <../Lib/mattlib.scad>;

include <../dotSCAD/src/shape_circle.scad>;
include <../dotSCAD/src/golden_spiral.scad>;
include <../dotSCAD/src/cross_sections.scad>;
include <../dotSCAD/src/golden_spiral_extrude.scad>;


boltLengthMM = 40;
bolt1 = [25,95,1];
bolt2 = [79,0,1];
bolt3 = [0,-62,1];
bolt4 = [-50,0,1];
support1Height = 87;
support2Height = 72;
support3Height = 56;
support4Height = 45;

module hole_cutter(number_of_holes, start_angle, centre_offset, hole_diameter, hole_depth){
  if(number_of_holes>0){
    for(i=[start_angle:(360/number_of_holes):360+start_angle]){
      rotate([0,0,i]){
        translate([-centre_offset,0,0]){
          cylinder(d=hole_diameter, h=hole_depth+2, $fn=30);
        }
      }
    }  
  }
}
module shelly() {
    if($preview){
        rotate(90)
            shellyRaw();    
    }else {
        rotate(90)
            render()
                shellyRaw();
    }
}
module shellyRaw(){
    baffle_hole = 72;
    opening_size = 83;
    shell_thickness = 4.125;

    starting_size = 30;
    starting_full_size = 72;
    starting_ratio = 0.4175;

    scaling = (opening_size/starting_size);

    full_size = starting_full_size * scaling;

    actual_ratio = scaling * starting_ratio;

    baffle_outer = opening_size+((2*shell_thickness)+2.1)-.48;
    baffle_length = ((2*opening_size)/5);

    // Baffle
    translate([full_size/2,0,0]){
      rotate([-90,0,0]){
        difference(){
          cylinder(d=baffle_outer, h=baffle_length, $fn=180);
          translate([0,0,-1]){
            cylinder(d=baffle_hole, h=(opening_size/2)+2, $fn=80);
          }
          translate([0,0,30]){
            cylinder(d=89.5, h=5, $fn=80);
          }
          translate([0,0,shell_thickness]){
            hole_cutter(4, 45, 82/2, 4, baffle_length);  
          }
        }
      }
    }
    
    // center plug
    scale([1,1,0.95]){
        translate([3,-0.25,0]){
            sphere(d=14.5, $fn=60);
        }
    }
    

    // Shell
    shell_scale = [actual_ratio, actual_ratio, actual_ratio]; // 30 mm opening, 72 mm full size
    shell_min = 360*2; // default=2 Any less than 2 causes CGAL to shit the bed.
    shell_max = 360*5; // default=5
    theta_step = 6; // default 6
    beta_step = 5; // default 5
    wall = false;
    wall_step = 2;
    wall_fill_percent = 85;
    half = false;
    beta_max = half ? 180 : 360;

    e = 2.718281828;
    pi = 3.1415926535898;

    echo (str("Actual ratio? ", actual_ratio));
    echo (str("ShellMin=", shell_min, " ShellMax=", shell_max));

    // Fibonacci spiral, good approximation of the nautilus spiral
    function r(theta) = pow((1+sqrt(5))/2, 2 * theta / 360) + shell_thickness / 3;

    scale(shell_scale){
        union(){
            for(theta = [shell_min : theta_step : shell_max - theta_step]) {
                percentage = (100/(shell_max - theta_step - shell_min)) * (theta-shell_min);
                //echo (str("Shelly generation ", percentage, "% complete... "));
                //echo (str("theta=", theta, " shell_min=", shell_min, " theta_step=", theta_step, " limit=", (shell_max - theta_step)));
                r11 = (r(theta) + r(theta - 360)) / 2;
                r12 = (r(theta + theta_step) + r(theta + theta_step - 360)) / 2;
                r21 = (r(theta) - r(theta - 360)) / 2 - shell_thickness / 2;
                r22 = (r(theta) - r(theta - 360)) / 2 + shell_thickness / 2;
                r23 = (r(theta + theta_step) - r(theta + theta_step - 360)) / 2 - shell_thickness / 2;
                r24 = (r(theta + theta_step) - r(theta + theta_step - 360)) / 2 + shell_thickness / 2;
                beta_max = half ? 180 : 360;

                union() {
                    for (beta = [0 : beta_step : beta_max - beta_step]) {
                        //echo (str("beta=", beta, " beta_step=", beta_step, " limit=", (beta_max - beta_step)));
                        rb11 = r21 * cos(beta);
                        rb12 = r22 * cos(beta);
                        rb13 = r23 * cos(beta);
                        rb14 = r24 * cos(beta);
                        rb21 = r21 * cos(beta + beta_step);
                        rb22 = r22 * cos(beta + beta_step);
                        rb23 = r23 * cos(beta + beta_step);
                        rb24 = r24 * cos(beta + beta_step);
                        theta_mod = theta % 360;
                        // These fudge factors are required to force the object to be simple
                        xf = 0.001 * ((beta >= 0 && beta < 180) ? - 1 : 1);
                        yf = 0.001 * (((theta_mod >= 0 && theta_mod < 90) || (theta_mod >= 270 && theta_mod < 360)) ? 1
                            : - 1);
                        x1 = (r11 + rb11) * cos(theta);
                        x2 = (r11 + rb21) * cos(theta) + xf;
                        x3 = (r12 + rb23) * cos(theta + theta_step) + xf;
                        x4 = (r12 + rb13) * cos(theta + theta_step);
                        x5 = (r11 + rb12) * cos(theta);
                        x6 = (r11 + rb22) * cos(theta) + xf;
                        x7 = (r12 + rb24) * cos(theta + theta_step) + xf;
                        x8 = (r12 + rb14) * cos(theta + theta_step);
                        y1 = (r11 + rb11) * sin(theta);
                        y2 = (r11 + rb21) * sin(theta);
                        y3 = (r12 + rb23) * sin(theta + theta_step) + yf;
                        y4 = (r12 + rb13) * sin(theta + theta_step) + yf;
                        y5 = (r11 + rb12) * sin(theta);
                        y6 = (r11 + rb22) * sin(theta);
                        y7 = (r12 + rb24) * sin(theta + theta_step) + yf;
                        y8 = (r12 + rb14) * sin(theta + theta_step) + yf;
                        z1 = r21 * sin(beta);
                        z2 = r21 * sin(beta + beta_step);
                        z3 = r23 * sin(beta + beta_step);
                        z4 = r23 * sin(beta);
                        z5 = r22 * sin(beta);
                        z6 = r22 * sin(beta + beta_step);
                        z7 = r24 * sin(beta + beta_step);
                        z8 = r24 * sin(beta);

                        // octahedron
                        polyhedron(
                        points = [
                                [x1, y1, z1], [x2, y2, z2], [x3, y3, z3], [x4, y4, z4],
                                [x5, y5, z5], [x6, y6, z6], [x7, y7, z7], [x8, y8, z8]
                            ],
                        faces = [
                            // Bottom
                                [3, 0, 1], [3, 1, 2],
                            // Front
                                [0, 4, 5], [0, 5, 1],
                            // Right
                                [1, 5, 6], [1, 6, 2],
                            // Left
                                [3, 7, 4], [3, 4, 0],
                            // Top
                                [4, 7, 6], [4, 6, 5],
                            // Back
                                [7, 3, 2], [7, 2, 6]
                            ]
                        );/**/
                    }
                }
            }
        }
    }
}

module bolt(boltDim){
    translate(boltDim + [0,0,0]) {
        metricCapheadAndBolt(6, 40, recessNut = 35, recessCap = 30);
    }
}
module boltStruct(boltDim, boltHeight){
    color("green") {
        translate(boltDim + [0, 0, boltHeight * - 0.5]) {
            cylinder(h = boltHeight, d = 14, $fn = 30);
        }
    }
}

module processedShelly(){
    
    difference(){
        union(){
            shelly();

            boltStruct(bolt1, support1Height);
            boltStruct(bolt2, support2Height);
            boltStruct(bolt3, support3Height);
            boltStruct(bolt4, support4Height);
        }
            
        bolt(bolt1);        
        bolt(bolt2);
        bolt(bolt3);
        bolt(bolt4);
    }
}

/*
translate([75,108,0]){
    rotate([0,90,0]){
        cylinder(h=52,d1=89,d2=67, center=true);
    }
}/**/
/*
color("orange"){
    translate([50 ,108,0]){
        cube([3,58,58], center=true);
    }
}/**/

module mattShell(){
    $fn = 180;
    finalOuterMM = 93;
    finalInnerMM=80;

    scale = 6;
    shape_pts = concat(
        shape_circle(radius = (finalOuterMM/2)/scale),
        shape_circle(radius = (finalInnerMM/2)/scale)
    );


    golden_spiral_extrude(
        shape_pts,
        from = 4,
        to = 12,
        point_distance = 5,
        scale = scale,
        triangles = "HOLLOW"
    ); 

}



if($preview){
    //#cylinder(h=100,d=250, center=true, $fn=60);
    //translate([-10,-30,0])
        processedShelly();
        color("orange")mattShell();
}else{
    if(part==undef || part=="cap_side"){
       translate([85,0,0]){
            difference(){
                processedShelly();
                translate([0,0,-100])cube([450,450,200], center=true);
            }
        }
    }
    /**/
    if(part==undef || part=="nut_side"){
        translate([-85,0,0]){
            rotate(180){
                rotate([180,0,0]){
                    difference(){
                        processedShelly();
                        translate([0,0,100])cube([450,450,200], center=true);        
                    }
                }
            }
        }
    }/**/
}