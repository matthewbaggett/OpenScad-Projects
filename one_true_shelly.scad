use <Lib/mattlib.scad>;
boltLengthMM = 40;
bolt1 = [0,108,0];
bolt2 = [85,0,0];
bolt3 = [0,-66,0];
bolt4 = [-55,0,0];
support1Height = 99;
support2Height = 78;
support3Height = 61.75;
support4Height = 48.15;

module shellyFromSTL(){
    translate([-44.5,-39,+1.25])
    import("Shell/NAUTILUS_DROIT_HIGH_fixed.stl", convexity=3);
    translate([-44.5,-39,-1.25])
    import("Shell/NAUTILUS_GAUCHE_HIGH_fixed.stl", convexity=3);
}


module shellyFromOtherSTL(){
    import("Shell/speaker.stl", convexity=3);
}

module shelly(){
    baffle_hole = 81;
    opening_size = 90;
    shell_thickness = 4.125;

    plinth_height = 15;

    starting_size = 30;
    starting_full_size = 72;
    starting_ratio = 0.4175;

    distance_between_posts = 25;
    post_diameter = 5;
    min_wall = 5;

    scaling = (opening_size/starting_size);

    full_size = starting_full_size * scaling;

    actual_ratio = scaling * starting_ratio;

    baffle_outer = opening_size+((2*shell_thickness)+2.1);
    baffle_length = ((2*opening_size)/5);

    echo(baffle_outer);
    echo(baffle_length);

    /*
    translate([-(baffle_outer+plinth_height-shell_thickness),baffle_outer/6,0]){
      rotate([0,90,0]){
        cylinder(d=baffle_outer, h=plinth_height, $fn=80);
      }
    }
    */


    // Baffle
    translate([full_size/2,0,0]){
      rotate([90,0,0]){
        difference(){
          cylinder(d=baffle_outer, h=baffle_length, $fn=80);
          translate([0,0,-1]){
            cylinder(d=baffle_hole, h=(opening_size/2)+2, $fn=80);
          }
          translate([0,0,shell_thickness]){
            hole_cutter(4, 45, 89/2, 4, baffle_length);  
          }
        }
      }
    }


    // Shell
    shell_scale = [actual_ratio, actual_ratio, actual_ratio]; // 30 mm opening, 72 mm full size
    shell_min = 720;
    shell_max = 1800;
    theta_step = 6;
    beta_step = 5;
    wall = false;
    wall_step = 2;
    wall_fill_percent = 85;
    half = false;
    beta_max = half ? 180 : 360;
    mirror = true;

    e = 2.718281828;
    pi = 3.1415926535898;

    // Fibonacci spiral, good approximation of the nautilus spiral
    function r(theta) = pow((1+sqrt(5))/2, 2 * theta / 360) + shell_thickness / 3;



    mirror([0, mirror ? 180 : 0, 0])
    scale(shell_scale)
    for(theta = [shell_min : theta_step : shell_max - theta_step]) {
        r11 = (r(theta) + r(theta - 360)) / 2;
        r12 = (r(theta + theta_step) + r(theta + theta_step - 360)) / 2;
        r21 = (r(theta) - r(theta - 360)) / 2 - shell_thickness / 2;
        r22 = (r(theta) - r(theta - 360)) / 2 + shell_thickness / 2;
        r23 = (r(theta + theta_step) - r(theta + theta_step - 360)) / 2 - shell_thickness / 2;
        r24 = (r(theta + theta_step) - r(theta + theta_step - 360)) / 2 + shell_thickness / 2;
        beta_max = half ? 180 : 360;
        
        for(beta = [0 : beta_step : beta_max - beta_step]) {
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
            xf = 0.001 * ((beta >= 0 && beta < 180) ? -1 : 1);
            yf = 0.001 * (((theta_mod >= 0 && theta_mod < 90) || (theta_mod >= 270 && theta_mod < 360)) ? 1 : -1);
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
                triangles = [
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
            );
        }

        
    }

    module hole_cutter(number_of_holes, start_angle, centre_offset, hole_diameter, hole_depth){
      if(number_of_holes>0){
        for(i=[start_angle:(360/number_of_holes):360+start_angle]){
          rotate([0,0,i]){
            translate([-centre_offset,0,0]){
              cylinder(d=hole_diameter, h=hole_depth+2);
            }
          }
        }  
      }
    }

}



module bolt(boltDim){
    translate(boltDim + [0,0,-20])
    metricCapheadAndBolt(6, 40,recessNut=35, recessCap=30);
}
module boltStruct(boltDim, boltHeight){
    color("green")
    translate(boltDim + [0,0,boltHeight*-0.5])
    cylinder(h=boltHeight,d=14, $fn=360);
}

difference(){
    difference(){
        union(){
            translate([0,0,0])mirror([1,0,0])rotate(90)shelly();
            boltStruct(bolt1, support1Height);
            boltStruct(bolt2, support2Height);
            boltStruct(bolt3, support3Height);
            boltStruct(bolt4, support4Height);
        }
        union(){
            bolt(bolt1);        
            bolt(bolt2);
            bolt(bolt3);
            bolt(bolt4);
        }
    }
    translate([0,0,75])
    cube([400,400,150], center=true);
}
