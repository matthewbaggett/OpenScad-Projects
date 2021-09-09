include <../Lib/mattlib.scad>;
plateThickness = 10;
printZHeight = 900;
printDiameter = 900;
bodyMainDiameter = printDiameter * 1.111111111111111;
echo("Body is ", bodyMainDiameter, "mm");
gantryDeadZHeight = 200;
bedZHeight = 10;
bedFiddleyardZHeight = 40;
extrusionLengthRequired = printZHeight + gantryDeadZHeight + bedFiddleyardZHeight;
sheetMetalThickness = 1.6;
doorCavity = [790,bodyMainDiameter,extrusionLengthRequired*0.8];
bodyColour = "PowderBlue";

module deck(){
    color("green")
    hull(){
        translate([0,0,plateThickness/2])
        cylinder(h=plateThickness,d=bodyMainDiameter, center=true);
        translate([0,400,plateThickness/2])
        cylinder(h=plateThickness,d=bodyMainDiameter/2, center=true);
    }
}

module walls(){
    height=extrusionLengthRequired+(plateThickness*2);
    translate([0,0,height/2])
    color("coral")
    difference(){
        hull(){
            translate([0,0,plateThickness/2])
            cylinder(h=height,d=bodyMainDiameter+(sheetMetalThickness*2), center=true);
            translate([0,400,plateThickness/2])
            cylinder(h=height,d=bodyMainDiameter/2+(sheetMetalThickness*2), center=true);
        }
        hull(){
            translate([0,0,plateThickness/2])
            cylinder(h=height+2,d=bodyMainDiameter, center=true);
            translate([0,400,plateThickness/2])
            cylinder(h=height+2,d=bodyMainDiameter/2, center=true);
        }
        translate([0,(bodyMainDiameter/2)*-1,0])
        cube(doorCavity, center=true);
    }  
}

module bed(){
    color("grey")
    translate([0,0,bedFiddleyardZHeight+bedZHeight])
    cylinder(h=10,d=printDiameter, center=true);
}

module loft(){
    translate([0,0,extrusionLengthRequired+plateThickness])
    difference(){
        union(){
            hull(){
                translate([0,0,plateThickness])
                sphere(d=(bodyMainDiameter)+(sheetMetalThickness*2));
                translate([0,400,plateThickness])
                sphere(d=(bodyMainDiameter/2)+(sheetMetalThickness*2));
            }
        }
        translate([0,0,((bodyMainDiameter/4)*-1)])        
        cube([bodyMainDiameter*1.1,bodyMainDiameter*1.5,bodyMainDiameter/2], center=true);
        hull(){
                translate([0,0,plateThickness])
                sphere(d=bodyMainDiameter);
                translate([0,400,plateThickness])
                sphere(d=bodyMainDiameter/2);
        }
    }
}

module uprights(){
    
    pcdAtFixedDegrees([0,120-60,120,240,240+60])
    translate([0,470,plateThickness])
    extrusion80x40(extrusionLengthRequired);
    mirrorCopy()
    translate([60,620,plateThickness])
    extrusion20x20(extrusionLengthRequired);
    
    translate([0,620,plateThickness])
    #cube([120,30,10], center=true);
}

color("silver")bed();
color(bodyColour)deck();
//translate([0,0,extrusionLengthRequired+plateThickness])color("indigo")deck();
//color(bodyColour)loft();
color("DarkOrange")uprights();
color(bodyColour)walls();