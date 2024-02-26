$fn=90;
armHeight=600;
baseDiameter = 200;
topDiameter = 150;
baseHeight = 150;
wallThickness = 10;
fudge = 0.1;

use <../Lib/mirrorcopy.scad>
use <../Lib/metric_bolts.scad>
use <../Lib/gears.scad>
use <nema23.scad>

#translate([0,0,armHeight/2])cylinder(d1=baseDiameter, d2=topDiameter, h=armHeight, center=true);
#nema23_body();
nema23_fasteners(length=15);

translate([0,0,50])ring_gear (modul=2, tooth_number=90, width=20, rim_width=3, pressure_angle=20, helix_angle=20);