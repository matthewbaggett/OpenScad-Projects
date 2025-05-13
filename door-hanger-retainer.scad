$fn=90;
fudge = 0.01;

module handle(){
    translate([10,0,0])rotate([0,90,0])cylinder(h=20+fudge,d=23, center=true);
    translate([-10,0,0])rotate([0,90,0])cylinder(h=20+fudge,d=25, center=true);
}

module bracket(){
    translate([-5+2,0,0])rotate([0,90,0])cylinder(h=10,d=33, center=true);
}

module slot(){
    translate([-5+2+2,0,0]){
        rotate([0,90,0]){
            difference(){
                cylinder(h=9,d=50, center=true);
                cylinder(h=10,d=27, center=true);
            }
        }
    }
}

module cutout(){
    translate([-6,-15,0]){
        rotate([90,90,0]){
            hull(){
                translate([0,-3,0])cube([6,1,10], center=true);
                cylinder(h=10,d=6,center=true);
            }
        }
    }
}
difference(){
    bracket();
    handle();
    slot();
    cutout();
}


