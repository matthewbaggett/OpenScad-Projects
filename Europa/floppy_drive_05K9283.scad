use <../Lib/mattlib.scad>;
$fn=60;
module floppyDrive05K9283(){
    floppyDriveDims = [103.2,140.5,17];
    cube(floppyDriveDims, center=true);
    mirrorCopy([1,0,0])mirrorCopy([0,1,0])translate([41,55,(17/-2)-((18.4-17)/2)])cylinder(h=18.4-17,d=20, center=true);
    translate([0,-80,0])rotate([90,0,0])cylinder(h=20,d=floppyDriveDims.z, center=true);
    translate([0,-(floppyDriveDims.y+2)/2,0])cube([30,2,floppyDriveDims.z], center=true);
    if($preview){
        color("black")translate([0,60,(17/-2)+9.2])cube([90,100,3], center=true);
    }
}
floppyDrive05K9283();