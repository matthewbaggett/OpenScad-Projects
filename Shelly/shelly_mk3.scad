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

    // Baffle
    translate([full_size/2,0,0]){
      rotate([-90,0,0]){
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
    shell_min = 360*(startPi==undef?2:startPi); // default=2
    shell_max = 360*(endPi==undef?5:endPi); // default=5
    theta_step = 6;
    beta_step = 5;
    wall = false;
    wall_step = 2;
    wall_fill_percent = 85;
    half = false;
    beta_max = half ? 180 : 360;

    e = 2.718281828;
    pi = 3.1415926535898;

    echo (str("Actual ratio? ", actual_ratio));
    echo (str("StartPi=", startPi, " EndPi=", endPi));
    echo (str("ShellMin=", shell_min, " ShellMax=", shell_max));

    // Fibonacci spiral, good approximation of the nautilus spiral
    function r(theta) = pow((1+sqrt(5))/2, 2 * theta / 360) + shell_thickness / 3;

    scale(shell_scale){
        union(){
            for(theta = [shell_min : theta_step : shell_max - theta_step]) {
                percentage = (100/(shell_max - theta_step - shell_min)) * (theta-shell_min);
                echo (str("Shelly generation ", percentage, "% complete... "));
                //echo (str("theta=", theta, " shell_min=", shell_min, " theta_step=", theta_step, " limit=", (shell_max - theta_step)));
                beta_max = half ? 180 : 360;
                
                for(beta = [0 : beta_step : beta_max - beta_step]) {
                    polyhedron(
                        points = [
                            [(((r(theta) + r(theta - 360)) / 2) + ((r(theta) - r(theta - 360)) / 2 - shell_thickness / 2) * cos(beta)) * cos(theta),                                 (((r(theta) + r(theta - 360)) / 2) + ((r(theta) - r(theta - 360)) / 2 - shell_thickness / 2) * cos(beta)) * sin(theta), ((r(theta) - r(theta - 360)) / 2 - shell_thickness / 2) * sin(beta)],
                            [(((r(theta) + r(theta - 360)) / 2) + ((r(theta) - r(theta - 360)) / 2 - shell_thickness / 2) * cos(beta + beta_step)) * cos(theta) + (0.001 * ((beta >= 0 && beta < 180) ? -1 : 1)),                 (((r(theta) + r(theta - 360)) / 2) + ((r(theta) - r(theta - 360)) / 2 - shell_thickness / 2) * cos(beta + beta_step)) * sin(theta),                       ((r(theta) - r(theta - 360)) / 2 - shell_thickness / 2) * sin(beta + beta_step)],
                            [(((r(theta + theta_step) + r(theta + theta_step - 360)) / 2) + ((r(theta + theta_step) - r(theta + theta_step - 360)) / 2 - shell_thickness / 2) * cos(beta + beta_step)) * cos(theta + theta_step) + (0.001 * ((beta >= 0 && beta < 180) ? -1 : 1)),    (((r(theta + theta_step) + r(theta + theta_step - 360)) / 2) + ((r(theta + theta_step) - r(theta + theta_step - 360)) / 2 - shell_thickness / 2) * cos(beta + beta_step)) * sin(theta + theta_step) + (0.001 * ((((theta % 360) >= 0 && (theta % 360) < 90) || ((theta % 360) >= 270 && (theta % 360) < 360)) ? 1 : -1)),     ((r(theta + theta_step) - r(theta + theta_step - 360)) / 2 - shell_thickness / 2) * sin(beta + beta_step)],
                            [(((r(theta + theta_step) + r(theta + theta_step - 360)) / 2) + ((r(theta + theta_step) - r(theta + theta_step - 360)) / 2 - shell_thickness / 2) * cos(beta)) * cos(theta + theta_step),                     (((r(theta + theta_step) + r(theta + theta_step - 360)) / 2) + ((r(theta + theta_step) - r(theta + theta_step - 360)) / 2 - shell_thickness / 2) * cos(beta)) * sin(theta + theta_step) + (0.001 * ((((theta % 360) >= 0 && (theta % 360) < 90) || ((theta % 360) >= 270 && (theta % 360) < 360)) ? 1 : -1)),                 ((r(theta + theta_step) - r(theta + theta_step - 360)) / 2 - shell_thickness / 2) * sin(beta)],
                            [(((r(theta) + r(theta - 360)) / 2) + ((r(theta) - r(theta - 360)) / 2 + shell_thickness / 2) * cos(beta)) * cos(theta),                                  (((r(theta) + r(theta - 360)) / 2) + ((r(theta) - r(theta - 360)) / 2 + shell_thickness / 2) * cos(beta)) * sin(theta),                                   ((r(theta) - r(theta - 360)) / 2 + shell_thickness / 2) * sin(beta)],
                            [(((r(theta) + r(theta - 360)) / 2) + ((r(theta) - r(theta - 360)) / 2 + shell_thickness / 2) * cos(beta + beta_step)) * cos(theta) + (0.001 * ((beta >= 0 && beta < 180) ? -1 : 1)), (((r(theta) + r(theta - 360)) / 2) + ((r(theta) - r(theta - 360)) / 2 + shell_thickness / 2) * cos(beta + beta_step)) * sin(theta), ((r(theta) - r(theta - 360)) / 2 + shell_thickness / 2) * sin(beta + beta_step)],
                            [(((r(theta + theta_step) + r(theta + theta_step - 360)) / 2) + ((r(theta + theta_step) - r(theta + theta_step - 360)) / 2 + shell_thickness / 2) * cos(beta + beta_step)) * cos(theta + theta_step) + (0.001 * ((beta >= 0 && beta < 180) ? -1 : 1)), (((r(theta + theta_step) + r(theta + theta_step - 360)) / 2) + ((r(theta + theta_step) - r(theta + theta_step - 360)) / 2 + shell_thickness / 2) * cos(beta + beta_step)) * sin(theta + theta_step) + (0.001 * ((((theta % 360) >= 0 && (theta % 360) < 90) || ((theta % 360) >= 270 && (theta % 360) < 360)) ? 1 : -1)), ((r(theta + theta_step) - r(theta + theta_step - 360)) / 2 + shell_thickness / 2) * sin(beta + beta_step)],
                            [(((r(theta + theta_step) + r(theta + theta_step - 360)) / 2) + ((r(theta + theta_step) - r(theta + theta_step - 360)) / 2 + shell_thickness / 2) * cos(beta)) * cos(theta + theta_step), (((r(theta + theta_step) + r(theta + theta_step - 360)) / 2) + ((r(theta + theta_step) - r(theta + theta_step - 360)) / 2 + shell_thickness / 2) * cos(beta)) * sin(theta + theta_step) + (0.001 * ((((theta % 360) >= 0 && (theta % 360) < 90) || ((theta % 360) >= 270 && (theta % 360) < 360)) ? 1 : -1)), ((r(theta + theta_step) - r(theta + theta_step - 360)) / 2 + shell_thickness / 2) * sin(beta)]
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
shelly();
