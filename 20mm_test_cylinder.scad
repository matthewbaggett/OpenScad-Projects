use <Lib/mattlib.scad>

$fn=360;

diameter = 20;
textDiaRatio = 0.25;
scale([1,1,1])
difference(){
    color("orange")
    translate([0,0,diameter/2])
    cylinder(h=diameter, d=diameter, center=true);

    translate([0,0,diameter-1])
    linear_extrude(2)
    text(text=str(diameter, "mm"), size=diameter*textDiaRatio,halign="center", valign="center");
}