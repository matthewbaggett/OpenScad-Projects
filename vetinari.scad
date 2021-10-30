$fn=60;

use <Lib/mattlib.scad>;

module motorGearAssy(){
    color("lightgrey"){
        stepper28BYJ48();
    }

    difference(){
        translate([0,0,1.5]){
            spur_gear (modul=1, tooth_number=30, width=5, bore=4, pressure_angle=20, helix_angle=20, optimized=true, no_bore=true);
        }
        stepper28BYJ48();
    }
}

module motors(){
    rotate(0){
        translate([0,-15-16,0+7+7]){
            motorGearAssy();
        }
    }
    rotate(65){
        translate([0,-15-16,0+7]){
            motorGearAssy();
        }
    }
    rotate(-65){
        translate([0,-15-16,0]){
            motorGearAssy();
        }
    }
}

module hands(){
    hands_hours();
    hands_minutes();
    hands_seconds();
}
module hands_hours(){
    color("red"){
        difference(){
            union(){
                translate([0,0,1.5+5])
                    rotate([0,180,0])
                        spur_gear (modul=1, tooth_number=30, width=5, bore=4, pressure_angle=20, helix_angle=20, optimized=true, no_bore=true);
                // Main Shaft  
                translate([0,0,-7.5]){
                    difference(){
                        cylinder(h=25,d=12, center=true);
                        cylinder(h=25+0.01,d=7, center=true);
                    }
                }
            }
            bearings();
        }
    }
}
module hands_minutes(){
    color("green"){
        difference(){
            union(){
                translate([0,0,1.5+7+5])
                    rotate([0,180,0])
                        spur_gear (modul=1, tooth_number=30, width=5, bore=4, pressure_angle=20, helix_angle=20, optimized=true, no_bore=true);
                // Main Shaft  
                translate([0,0,-5]){
                    difference(){
                        cylinder(h=30,d=6, center=true);
                        cylinder(h=30+0.01,d=3, center=true);
                    }
                }
                translate([0,0,5]){
                    // Top bearing shoulder
                    translate([0,0,3])
                        cylinder(h=3,d=8, center=true);
                }
            }
            bearings();
        }
    }    

}
module hands_seconds(){
    color("blue"){
        difference(){
            union(){
                translate([0,0,1.5+7+7+5])
                    rotate([0,180,0])
                        spur_gear (modul=1, tooth_number=30, width=5, bore=4, pressure_angle=20, helix_angle=20, optimized=true, no_bore=true);
                // Main Shaft
                translate([0,0,(0/2)]){
                    cylinder(h=40,d=2, center=true);
                }
                // Top Bearing Shoulder
                translate([0,0,14.5]){
                    cylinder(h=2,d=4, center=true);
                }
            }
            bearings();
        }
    }
    

}

module bearings(){
    
    // Seconds<->Minutes Upper
    translate([0,0,12.3]){
        // 628zz
        bearing(series="628zz",id=2, od=5, wd=2.3);
    }
    // Seconds<->Minutes Lower
    translate([0,0,-20+(2.3/2)-0.01]){
        // 628zz
        bearing(series="628zz",id=2, od=5, wd=2.3);
    }
    // Minutes<->Hours Upper
    translate([0,0,5]){
        // MR106ZZ
        bearing(series="MR106zz",id=6,od=10,wd=3);
    }
    // Minuites<->Hours Lower
    translate([0,0,-18.5-0.01]){
        // MR106ZZ
        bearing(series="MR106zz",id=6,od=10,wd=3);
    }
    
}

motors();
//hands();

hands_seconds();
hands_minutes();
hands_hours();

if($preview){
    bearings();
}