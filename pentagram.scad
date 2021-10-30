use <Lib/mattlib.scad>;
$fn=360;
wallThickness=6;
diameter=100;
zThickness=0.4;
union(){
    difference(){
        cylinder(h=zThickness,d=diameter, center=true);
        cylinder(h=zThickness+0.01,d=diameter-(wallThickness*2), center=true);
    }
    pcd(360/5){
        translate([17,0,0]){
            cube([wallThickness,(diameter*.85),zThickness], center=true);
        }
    }
}