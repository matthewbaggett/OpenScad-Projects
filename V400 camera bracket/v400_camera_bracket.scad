$fn=$preview?30:120;
use <../Lib/metric_bolts.scad>
use <../Lib/mirrorcopy.scad>
module profile_piece(){
    translate([0,-18/2,0])
    difference(){
        translate([-43.87,0.727,50])color("red")import("railmount.stl");
        translate([-5,-5,10])cube([40,40,100]);
        translate([-5,-5,-100])cube([40,40,100]);
    }
}
module hole(){
  translate([0,0,2.75+6.5+1])cylinder(d1=3.5,d2=6.5,h=12, center=true);
  translate([0,0,2.75])cylinder(d=2.2,h=3.01, center=true);
  cube([5.5,5.5,2.5], center=true);
}

//#profile_piece();
module arm(){
    translate([-10,0,0])hull(){
        translate([5.45,0,0])cube([2.8,18,30], center=true);
        translate([0.5,0,0])cube([1,11,30], center=true);
    }

    hull(){
        translate([0,0,0])cube([2.8,18,30], center=true);
        translate([20,0,0])cylinder(h=30, d=18, center=true);
    }
    hull(){
        translate([20,0,0])cylinder(h=30, d=18, center=true);
        translate([90,-30,15/2])rotate([0,0,90])cylinder(h=15, d=18, center=true);
    }
}
module screw(){
    mirrorCopy([0,0,1])
        translate([1.75,0,8])
            rotate([0,90,0])
                metricCapheadAndBolt(3, 18, recessNut=1, recessCap=60, chamfer=false);
}

difference(){
    arm();
    translate([90,-30,13.8])rotate([0,180,0])hole();
   
    screw();
}
