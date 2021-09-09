$fn=360;
bore=5.7;
angleTiltDown=20;
zOffset=11.5;


difference(){
    union(){
        cube([18,10,23.50]);
        translate([0,-10,12.5])
        cube([18,10,2]);
        translate([0,-2.3,20.5])
        cube([18,2.3,3]);
    }
    
    translate([18/2,0,5])
    rotate([-90+angleTiltDown,0,0])
    #cylinder(40,d=bore,center=true);
    translate([18/2,-5.5,zOffset])
    #cylinder(4,d=3.2);   
}