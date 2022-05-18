use <Lib/mirrorcopy.scad>
$fn=120;
difference(){
    translate([30,0,18-15])cube([60,50,100], center=true);
    // The cabinet
    union(){
        translate([0,0,36.8/2])cube([100,150,36.8], center=true);
        translate([0,0,(50/2)+36.8])cube([100,16.2,50+0.01], center=true);
    }

    // The pattern of drill holes 
    translate([30,0,1.5/-2])
    union(){
        mirrorCopy([1,0,0])mirrorCopy([0,1,0])translate([25/2,25/2,-20])cylinder(d=2.25,h=100, center=true);
        //cube([38,38,1.5], center=true);
    }
    translate([30,0,-70])
        cube([100,100,100], center=true);
}



