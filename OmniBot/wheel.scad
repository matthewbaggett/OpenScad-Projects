showWheel = true; // [true:Yes,false:No]
showGearbox = true; // [true:Yes,false:No]
showCutouts = true; // [true:Yes,false:No]
showBearings = true; // [true:Yes,false:No]
showFrame = true; // [true:Yes,false:No]

printablePart = "no"; // [no:No, hub_outer:Wheel Hub Outer, hub_inner:Wheel Hub Inner, hub_roller:Wheel Hub Roller, drivegear:Drive Gear, test_frame:Test Motor Frame, test_frame_undriven_carrier:Test Motor Frame Undriven Carrier]

// Should I show my print bed volume?
showPrintBed = true; // [true:Yes, false:No]

use <../Lib/mirrorcopy.scad>
use <../Lib/pcd.scad>
use <../Lib/metric_bolts.scad>
use <../Lib/metric_screws.scad>
use <../Lib/gears.scad>
use <../Lib/bearings.scad>
use <../Lib/dollatek_motor.scad>
use <../Lib/omniwheel.scad>

module herpderp(){}
mod=2.5;
$fn=$preview?60:120;
omniWheelSize = 120;
cutoutSpacing = 2;
gearMeshHeight = -38;

module wheelBearings_undriven(){
    // Un-driven side bearing
    translate([25,0,0])rotate([0,90,0])bearing_6003(labels=false);
}
module wheelBearings_driven(){
    // Driven side bearing
    translate([-49,0,0])rotate([0,90,0])bearing_6003(labels=false);
}

module wheelBearings(){
    wheelBearings_driven();
    wheelBearings_undriven();
}
module wheelBearings_cutouts(){
    hull()wheelBearings_driven();
    hull()wheelBearings_undriven();
}


module wheelRotorAndHub(includeRollers=true){
    difference(){
        union(){
            // Rotor hub undriven side
            hull(){
                translate([0,0,0])rotate([0,90,0])cylinder(h=35,d=60, center=true);
                translate([19,0,0])rotate([0,90,0])cylinder(h=1,d=27, center=true);
            }
            translate([19.5,0,0])rotate([0,90,0])cylinder(h=20,d=23, center=true);
            // Rotor hub driven side
            hull(){
                translate([0,0,0])rotate([0,90,0])cylinder(h=35,d=60, center=true);
                translate([-20,0,0])rotate([0,90,0])cylinder(h=1,d=30, center=true);
            }
            translate([-43+20,0,0])rotate([0,90,0])cylinder(h=60,d=23, center=true);
        }
        // Remove bearing material
        wheelBearings();
        
        

    }
    
    // Wheel
    omniwheel(outerDiameterMM=omniWheelSize,includeRollers=includeRollers);
}

module wheelGearbox_dollatekGearbox(){
    // Dollatek gearbox
    translate([-53,0,gearMeshHeight])
        rotate([90,0,0])
            dollatek_gearbox();
}
module wheelGearbox_dollatekGearbox_cutouts(){
    // Dollatek gearbox
    translate([-53,0,gearMeshHeight])
        rotate([90,0,0]){
            render()dollatek_gearbox(cutouts=true);
            mirrorCopy([0,1,0])
                translate([0,(20.5-3)/2,24.5-5.3])
                    translate([-3.6+2.5,0,0])
                        rotate([0,90,0])
                            rotate(90)metricCapheadAndBolt(3, 25, recessNut=10, recessCap=1);

            translate([-8.3+8.6,0,-13.5])
                rotate([0,90,0])
                    metricCapheadAndBolt(3, 25, recessNut=10, recessCap=1);
        }
    
}

module wheelGearbox_mainGear(){
    // Main gear
    translate([-27-15,0,0])
        rotate([0,90,0])
            spur_gear(modul=mod, tooth_number=(50/mod), width=25, bore=0, pressure_angle=20, helix_angle=20, optimized=false);
}
module wheelGearbox_driveGear(){
    // Drive gear
    difference(){
        translate([-27-15,0,gearMeshHeight])
            rotate([0,90,0])
                rotate(17.5)
                    mirror([0,1,0])
                        spur_gear(modul=mod, tooth_number=(25/mod), width=10, bore=0, pressure_angle=20, helix_angle=20, optimized=false);
        translate([-53,0,gearMeshHeight])
            rotate([90,0,0])
                dollatek_gearbox_cutout_shaft();
            
        translate([-53+18.5,0,gearMeshHeight]){
            rotate([0,90,0])
                selfTappingScrew(mSize=2, length=5);
        }
        
    }
    
}

module wheelGearbox(){
    wheelGearbox_mainGear();
    wheelGearbox_driveGear();
    wheelGearbox_dollatekGearbox();
}

// Cutouts
module wheelAndGearboxCutout(){
    union(){
        hull(){
            translate([-27-15,0,0])rotate([0,90,0])cylinder(h=25+cutoutSpacing,d=60+cutoutSpacing);
            translate([-27-15,0,gearMeshHeight])rotate([0,90,0])cylinder(h=25+cutoutSpacing,d=30+cutoutSpacing);
        }
        difference(){
            hull(){
                rotate([0,90,0])
                    cylinder(d=omniWheelSize+5+cutoutSpacing, h=58+cutoutSpacing, center=true);
                translate([0,0,(omniWheelSize/-2)])
                    hull()
                        mirrorCopy([1,0,0],[0,1,0])
                            translate([(58+cutoutSpacing-10)/2, (omniWheelSize+5+cutoutSpacing-10)/2,0])
                                cylinder(h=1, d=10, center=true);
            }
            translate([30,0,0])
                scale([0.15,.6,.6])
                    sphere(d=omniWheelSize+5+cutoutSpacing);
        }
    }
}


module wheelFloor(){
    // Floor
    translate([-15+5,0,-53])
        cube([110+10,140,6], center=true);
}
module wheelGearboxCover(){
    // Gearbox cover
    difference(){
        hull(){
            translate([-45,0,0])rotate([0,90,0])cylinder(d=35+(10*2), h=1, center=true);
            translate([-53.5,0,0])rotate([0,90,0])cylinder(d=35+(10*2), h=1, center=true);
            translate([-53.5-10,0,0])rotate([0,90,0])cylinder(d=20+(10*2), h=1, center=true);
            translate([-54.25-3,0,-50+0.5])
                cube([19.5+6,50,1], center=true);
        }
        wheelBearings_cutouts();
        
        wheelGearbox_dollatekGearbox_cutouts();
        
    }
}

module wheelUndrivenBearingCover_boltHoles(){
    mirrorCopy([0,1,0])
        translate([35+5-2,70/2,-50+2.5+.25+8])
            rotate(90)
                metricCapheadAndBolt(6, 10, recessNut=10, recessCap=40);
}
module wheelUndrivenBearingCover(){
    difference(){
        union(){
            hull(){
                translate([29+10+.5,0,0])rotate([0,90,0])cylinder(d=35+(10*2), h=1, center=true);
                translate([29,0,0])rotate([0,90,0])cylinder(d=35+(10*2), h=1, center=true);
                translate([21,0,0])rotate([0,90,0])cylinder(d=20+(10*2), h=1, center=true);
                translate([35+5,0,-50+9])cube([20,50+40,1], center=true);
            }
            translate([35+5,0,-50+1.5])cube([20,50+40,15], center=true);
        }
        wheelAndGearboxCutout();   
        wheelBearings_cutouts();
        wheelUndrivenBearingCover_boltHoles();
    }

}



module frame(){
    difference(){
        union(){
            wheelFloor();
            wheelGearboxCover();
            wheelUndrivenBearingCover();
        }
        wheelAndGearboxCutout();
        wheelBearings();
        wheelUndrivenBearingCover_boltHoles();

    }
}

module part_wheelhub(){

    difference(){
        union(){
            wheelRotorAndHub(includeRollers=false);
            wheelGearbox_mainGear();
        }
        rotate([0,90,0])
            translate([0,0,20-1-1])
                difference(){
                    dia=60+5;
                    cylinder(h=5,d=dia+10,center=true);
                    cylinder(h=5+1,d=dia-18,center=true);
                }
        rotate([0,-90,0])
            for(i=[0:2]){
                rotate([0,0,(360/3)*i])
                    translate([15,0,-5])
                        metricCapheadAndBolt(6, 20, recessNut=50, recessCap=50, recessNutIsCircleMM=false);
        }
    }
}

module part_wheelhub_A(){
    difference(){
        part_wheelhub();
        part_wheelhub_AB_slicer();
    }
}
module part_wheelhub_B(){
    intersection(){
        part_wheelhub();
        part_wheelhub_AB_slicer();
    }
}

module part_wheelhub_render_outer(){
    translate([0,0,17.5-1])
        rotate([0,90,0])
            color("orange")
                translate([0,0,0])
                    part_wheelhub_A();
}
module part_wheelhub_render_inner(){
    translate([0,0,-59.5])
        rotate([0,-90,0])
            color("yellow")
                translate([50,0,0])
                    part_wheelhub_B();
}

module part_wheelhub_AB_slicer(){
    translate([30-0.5-5,0,0])
        rotate([0,90,0])
            cylinder(h=30,d=50, center=true, $fn=240);
}

module part_drivegear(){
    translate([38,0,-32])
        rotate([0,90,0])
            wheelGearbox_driveGear();   
}

module part_frame_split_undrivenCarrier(){
    translate([40,0,55])
    cube([50,100,80], center=true);
}
module part_frame(){
    difference(){
        translate([0,0,56])frame();
        part_frame_split_undrivenCarrier();
    }
}
module part_frame_undrivenCarrier(){
    intersection(){
        translate([0,0,56])frame();
        part_frame_split_undrivenCarrier();
    }
}    

if(printablePart!="no" && showPrintBed && $preview){
    color("black",0.1)
        circle(d=255,center=true);
}
if(printablePart=="hub_outer"){
    part_wheelhub_render_outer();
}else if(printablePart=="hub_inner"){
    part_wheelhub_render_inner();
}else if(printablePart=="hub_roller"){
    pcd(360/8,180)
        part_rollers(outerDiameterMM=120,distanceBetween=215);
}else if(printablePart=="test_frame"){
    part_frame();
}else if(printablePart=="test_frame_undriven_carrier"){
    part_frame_undrivenCarrier();
}else if(printablePart=="drivegear"){
    part_drivegear();
}else{
    if($preview && showWheel){
        wheelRotorAndHub();
    }
    if($preview && showGearbox){
        wheelGearbox();
    }
    if($preview && showBearings){
        #wheelBearings();
    }
    if($preview && showCutouts){
        #wheelAndGearboxCutout();
    }
    if($preview && showFrame){
        frame();
    }
}
/**/
