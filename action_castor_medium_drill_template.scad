use <Lib/mattlib.scad>;
rotate([0,180,0])
difference(){
    translate([2.5,2.5,10/2])cube([80,65,10], center=true);
    mirrorCopy([1,0,0])mirrorCopy([0,1,0])translate([55/2,40/2,10])cylinder(h=20,d=6, center=true);
    translate([0,0,5/2])cube([75,60,5]+[0,0,0.01], center=true);
}
