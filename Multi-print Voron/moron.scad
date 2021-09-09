use <../Lib/mattlib.scad>

module extrusion_misumi(length){
    //HFSB5_2020
    color("darkgrey")
    extrusion(length=length, outer=20,tSlot=6, gusset=1.8, bore=4.2);
}

// extrusion front left
extrusion_misumi(530);

// extrusion front right
translate([470+20,0,0])
extrusion_misumi(530);


// extrusion rear left
translate([0,470+20,0])
extrusion_misumi(530);

// extrusion rear right
translate([470+20,470+20,0])
extrusion_misumi(530);

// extrusion bottom front
translate([10,0,10])
rotate([0,90,0])
extrusion_misumi(470);

// extrusion bottom rear
translate([10,470+20,10])
rotate([0,90,0])
extrusion_misumi(470);

// extrusion left bottom
translate([0,10,10])
rotate([-90,0,0])
extrusion_misumi(470);

// extrusion right bottom
translate([470+20,10,10])
rotate([-90,0,0])
extrusion_misumi(470);

// extrusion top front
translate([10,0,530-10])
rotate([0,90,0])
extrusion_misumi(470);

// extrusion top rear
translate([10,470+20,530-10])
rotate([0,90,0])
extrusion_misumi(470);

// extrusion top bottom
translate([0,10,530-10])
rotate([-90,0,0])
extrusion_misumi(470);

// extrusion top bottom
translate([470+20,10,530-10])
rotate([-90,0,0])
extrusion_misumi(470);


