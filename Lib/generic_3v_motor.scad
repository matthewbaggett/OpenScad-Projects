module generic3vMotor(){
    // Main body
    color("silver"){
        translate([0,0,-2.5]){
            intersection(){
                cube([15,20,20], center=true);
                cylinder(d=20,h=20, center=true);
            }
        }
    }
    color("#333333"){
        translate([0,0,10]){
            intersection(){
                cube([15,20,5], center=true);
                cylinder(d=20,h=5, center=true);
            }
        }
    }
    // Rear motor hump
    color("#333333"){
        translate([0,0,(25+2)/2]){
            difference(){
                cylinder(d=10,h=2, center=true);
                translate([10-(10-8.8),0,0])cube([10,10,2+0.1], center=true);
            }
        }
    }
    // Power solder tabs + plastic lump
    color("#333333")translate([-8.3,0,10])cube([1.6,13.2,5], center=true);
    // Motor housing snoot
    color("silver")translate([0,0,(25+1.6)/-2])cylinder(d=6,h=1.6, center=true);
    // Motor shaft and rear pip
    color("silver")translate([0,0,-3.9])cylinder(d=1.8,h=37.8, center=true);
}


generic3vMotor();