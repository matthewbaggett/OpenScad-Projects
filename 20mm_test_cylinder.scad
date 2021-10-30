use <Lib/mattlib.scad>

$fn=120;

diameter = 25;
height=99;
textDiaRatio = 0.25;

module testCyl(height, diameter){
    color("orange")
    difference(){

        translate([0,0,height/2])
        cylinder(h=height, d=diameter, center=true);

        translate([0,3.5,height-1])
            linear_extrude(2)
                text(text=str(diameter, "w"), size=diameter*textDiaRatio,halign="center", valign="center", spacing=1.1);
        translate([0,-3.5,height-1])
            linear_extrude(2)
                text(text=str(height, "h"), size=diameter*textDiaRatio,halign="center", valign="center", spacing=1.1);
    }
}


translate([0,0,0])
    testCyl(20,20);
translate([0,25,0])
    testCyl(50,20);
translate([0,50,0])
    testCyl(99,25);