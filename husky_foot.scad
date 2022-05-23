use <Lib/mattlib.scad>;
$fn=120;
difference(){
    union(){
        hull(){
            hull(){
                translate([0,0,0])cylinder(d=30,h=1, center=true);
                translate([0,0,-10])cylinder(d=30,h=1, center=true);
            }
            hull(){
                translate([0,0,-10])cube([42,42,1], center=true);
                translate([0,0,-15])cube([42,42,1], center=true);
            }
        }
    }
    
    mirrorCopy([1,0,0])mirrorCopy([0,1,0]){
        translate([32/2,32/2,-15+9/2-.5]){
            cylinder(h=30,d=5, center=true);
        }
        /*translate([32/2,32/2,-8.5-1.7]){
            rotate(45)
            cylinder(h=4,d=7.7, center=true, $fn=6);
        }
        translate([32/2,32/2,-1.5-1.7]){
            rotate(45)
            cylinder(h=10.01,d=7.7, center=true, $fn=6);
        }*/
    }

    translate([0,0,2.5]){
        cylinder(d=8,h=20, center=true);
        translate([0,0,-10-4])cylinder(d=18,h=8, center=true);
    }
}