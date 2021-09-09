$fn=360;
width=13;
difference(){
    union(){
        translate([0,0,9.5])
        cube([width,10,11]);
        translate([0,-10,9.5])
        cube([width,10,2]);
        translate([0,-2.3,17.5])
        cube([width,2.3,3]);
    }
    
    #translate([width/2,12,-5])
    rotate([15,0,0])
    cylinder(40,d=5.6);
    #translate([width/2,-5.5,9.5])
    cylinder(2,d=3.2);   
}