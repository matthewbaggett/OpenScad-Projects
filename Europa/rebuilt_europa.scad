// Render the original Europa on top?
showOriginal="no"; // [yes:Yes, no:No]
showOriginalPercentage=50; // [10:100]
// Show construction balls
showConstructionBalls="no"; // [yes:Yes, no:No]
// Render half of the model?
renderPortion="all"; // [left, right, front, back, top, bottom, all, none]

// Render printable part, overrides portion
renderPrintablePart = "none"; // [none, facia, top_front, top_rear, bottom_front, bottom_rear, screen_retainer_bracket, duct, all]
// Should the part be rotated as if it is for a print?
rotateForPrint = "no"; // [no, yes]

// Feature: Front racing stripes
featureFrontStripes="yes"; // [yes:Yes, no:No]
// Feature: Top vents
featureTopVents="yes"; // [yes:Yes, no:No]
// Feature: Feet. Add a 1mm deep, 1" wide for common stick-on foam feet to prevent scratching desks
featureFeetRecess="yes"; // [yes:Yes, no:No]
// Feature: Sticker recess on rear
featureRearStickerRecess="yes"; // [yes:Yes, no:No]
// Show the ITX board inside the machine?
showItxBoard="yes"; // [yes:Yes, no:No]
// How thick should the printed walls be?
wallThickness=10; // [3:40]

use <../Lib/mattlib.scad>;
use <itx.scad>;
use <usb_connector.scad>;
use <power_supply_brick.scad>;
use <92mm_fan.scad>;

powerSupplyLocation = [77,60.5-3,25.4+8];

module sph(){
    sphere(d=10);
}
module cyl(){
    rotate([0,90,0])cylinder(h=10,d=10, center=true);
}

module node(sphereOrCylinder="cylinder"){
    if(sphereOrCylinder=="cylinder"){
        cyl();
    }else{
        sph();
    }
}

module europa_original(){
    color("grey")
    render()
    difference(){
        translate([1.245,73.638,0])
            rotate(180)
                import("source_stls/europa-solid_fixed.stl");
        
        // Prune underside
        translate([0,0,-5])
            cube([300,300,10], center=true);
    }
}

$fn=60;
if(showOriginal=="yes"){
    echo(100/showOriginalPercentage);
    color("lightgreen",showOriginalPercentage/100)render()europa_original();
}


cornerFrontChin=[0,-83.5,5];
cornerRearBottom=[0,118.5,5];
cornerRearBelowHandle=[0,118.5,249.25];
cornerTopRear=[0,98,286.5];
cornerTopMiddle=[0,8.6,294.3];
cornerTopFront=[0,-94,303.25];
cornerFrontChinUpper=[0,-117,49];

interiorRearBottom=cornerRearBottom + [0,-wallThickness,wallThickness];
interiorFrontChin=cornerFrontChin + [0,wallThickness,wallThickness];
interiorRearBelowHandle=cornerRearBelowHandle + [0,-wallThickness,-wallThickness];

interiorTopFront = cornerTopFront + [0,wallThickness,-wallThickness];
interiorTopRear = cornerTopRear + [0,-wallThickness,-wallThickness];
interiorTopFrontBackOfCavityUpper = interiorTopFront + [0,52-wallThickness,5.5-wallThickness];
interiorTopFrontBackOfCavityLower = [interiorTopFrontBackOfCavityUpper.x,interiorTopFrontBackOfCavityUpper.y,interiorRearBelowHandle.z];
interiorFrontChinUpper = cornerFrontChinUpper + [0,wallThickness,wallThickness];
interiorFrontChinUpperRecessDepth = [interiorTopFrontBackOfCavityUpper.x,interiorTopFrontBackOfCavityUpper.y,interiorFrontChinUpper.z] + [0,0,-8];

if(showConstructionBalls=="yes"){
    color("red"){
        translate(cornerFrontChin)sph();
        translate(cornerRearBottom)sph();
        translate(cornerRearBelowHandle)sph();
        translate(cornerTopRear)sph();
        translate(cornerTopMiddle)sph();
        translate(cornerTopFront)sph();
        translate(cornerFrontChinUpper)sph();
    }
    
    color("yellow"){
        translate(interiorRearBottom)sph();
        translate(interiorFrontChin)sph();
        translate(interiorRearBelowHandle)sph();
        translate([interiorRearBelowHandle.x,interiorFrontChin.y,interiorRearBelowHandle.z])sph();
    }
    
    color("green"){
        translate(interiorTopFront)sph();
        translate(interiorTopFrontBackOfCavityUpper)sph();
        translate(interiorTopFrontBackOfCavityLower)sph();
        translate(interiorFrontChinUpper)sph();
        translate(interiorFrontChinUpperRecessDepth)sph();
    }
    
    color("lightgreen"){
        translate(interiorTopRear)sph();
        translate(interiorRearBelowHandle)sph();
    }
}

module clearance_outer(){
    // (Dark Green + Light Green) + (Yellow)
    hull(){
        // Dark Green
        translate(interiorTopFront)sph();
        translate(interiorTopFrontBackOfCavityUpper)sph();
        translate(interiorTopFrontBackOfCavityLower)sph();
        translate(interiorFrontChinUpper)sph();
        translate(interiorFrontChinUpperRecessDepth)sph();
        
        // Light Green
        translate(interiorTopRear)sph();
        translate(interiorRearBelowHandle)sph();
    }
}
module clearance_inner(){
    // (Dark Green) + (Yellow)
    hull(){
        // Dark Green
        translate(interiorTopFront)cyl();
        translate(interiorTopFrontBackOfCavityUpper)cyl();
        translate(interiorTopFrontBackOfCavityLower)cyl();
        translate(interiorFrontChinUpper)cyl();
        translate(interiorFrontChinUpperRecessDepth)cyl();
    }
}
module clearance_lower(){
    hull(){
        // Yellow
        translate(interiorRearBottom)sph();
        translate(interiorFrontChin)sph();
        translate(interiorRearBelowHandle)sph();
        translate([interiorRearBelowHandle.x,interiorFrontChin.y,interiorRearBelowHandle.z])sph();
    }
}

//clearance_outer();
//clearance_inner();

module interior_volume(){
    union(){
        hull(){
            translate([-55,0,0])clearance_inner();
            translate([55,0,0])clearance_inner();
        }
        hull(){
            translate([60,0,0])clearance_outer();
            translate([100,0,0])clearance_outer();
        }
        hull(){
            translate([-60,0,0])clearance_outer();
            translate([-100,0,0])clearance_outer();
        }
        hull(){
            translate([-100,0,0])clearance_lower();
            translate([100,0,0])clearance_lower();
        }
    }
}

// Lower body extrusion
module lower_body_extrusion(sphereOrCylinder="cylinder"){
    hull(){
        translate(cornerFrontChin+[0,0,50])node(sphereOrCylinder);
        translate(cornerRearBottom+[0,0,50])node(sphereOrCylinder);
        translate(cornerFrontChin)node(sphereOrCylinder);
        translate(cornerRearBottom)node(sphereOrCylinder);
    }
}

module outer_extrusion_excluding_handle(sphereOrCylinder="cylinder"){
    hull(){
        translate(cornerTopFront)node(sphereOrCylinder);
        translate(cornerFrontChinUpper)node(sphereOrCylinder);
        translate(cornerRearBottom+[0,0,24.5])node(sphereOrCylinder);
        translate(cornerTopRear)node(sphereOrCylinder);
        translate(cornerRearBelowHandle)node(sphereOrCylinder);
    }
}
module handle_grab_part(){
    color("orange")
    hull(){
        translate(cornerTopMiddle)cyl();
        translate(cornerTopMiddle-[0,0,5])cyl();
        translate(cornerTopFront)cyl();
        translate(cornerTopFront-[0,0,5])cyl();
    }
}
module handle_grab_recess_trimming(){
    translate([-2.5,41+90-7.5,242.5+7.5])rotate([45,0,0])cube([100,11,10], center=true);
}
module handle_grab_recess(){
    difference(){
        union(){
            color("red")translate([0,41,242.5])cube([10,165,15], center=true);
            color("blue")translate([0,-34,265])cube([10,15,60], center=true);
        }
        handle_grab_recess_trimming();
    }
}

module handle(){
    color("darkgrey")
    union(){
        handle_grab_part();
        handle_grab_recess();
   }
}

module handle_section(){
    hull(){
        translate(cornerFrontChin+[0,0,50])cyl();
        translate(cornerRearBottom+[0,0,50])cyl();
        translate(cornerFrontChin)cyl();
        translate(cornerRearBottom)cyl();
    }
    hull(){
        translate(cornerTopFront)cyl();
        translate(cornerFrontChinUpper)cyl();
        translate(cornerRearBottom+[0,0,24.5])cyl();
    }
    hull(){
        translate(cornerTopFront)cyl();
        translate(cornerFrontChinUpper)cyl();
        translate([0,-34,265])cube([10,15,60], center=true);
    }
    difference(){
        hull(){
            translate(cornerRearBottom+[0,0,24.5])cyl();
            translate(cornerFrontChinUpper)cyl();
            translate([0,41,242.5])cube([10,165,15], center=true);
        }
        handle_grab_recess_trimming();
    }/**/
    handle();
}

module body(){
    difference(){
        union(){
            // Lower Body
            hull()mirrorCopy()translate([108.5,0,0])lower_body_extrusion("sphere");
            // Sides
            mirrorCopy()hull(){
                translate([108.5,0,0])outer_extrusion_excluding_handle("sphere");
                translate([108.5-55,0,0])outer_extrusion_excluding_handle("sphere");
            }
            // Center
            scale([12,1,1])translate([0,0,0])handle_section();
        }
        // Cut off facia
        rotate([-5,0,0])
            translate([0,-145,190])
                cube([300,50,400], center=true);
    }
}
module faciaSliver(){
    difference(){
        body();
        rotate([-5,0,0])
            translate([0,105.25,190])
                cube([300,450,400], center=true);
    }
}
faciaSize=[213,245,0.25];
module facia(){
       hull(){
        rotate([-5,0,0])
            translate([0,-120-8,166.5])
                rotate([90,0,0])
                    translate(faciaSize/-2)
                        cube(faciaSize);
        faciaSliver();
    }
}
module screenCutout(){
    color("green"){
        rotate([-5,0,0]){
            hull(){
                mirrorCopy(){
                    translate([86.5,-128,136.5])rotate([90,0,0])cylinder(d=15,h=1, center=true);
                    translate([86.5,-128,136.5+131.5])rotate([90,0,0])cylinder(d=15,h=1, center=true);
                }
                mirrorCopy(){
                    translate([74.25,-118,148.5])rotate([90,0,0])cylinder(d=13,h=1, center=true);
                    translate([74.25,-118,148.5+108.5])rotate([90,0,0])cylinder(d=13,h=1, center=true);
                }
            }
            hull(){
                mirrorCopy(){
                    translate([74.25,-118,148.5])rotate([90,0,0])cylinder(d=13,h=1, center=true);
                    translate([74.25,-118,148.5+108.5])rotate([90,0,0])cylinder(d=13,h=1, center=true);
                }
                mirrorCopy(){
                    translate([74.25,-114,148.5])rotate([90,0,0])cylinder(d=13,h=1, center=true);
                    translate([74.25,-114,148.5+108.5])rotate([90,0,0])cylinder(d=13,h=1, center=true);
                }
            }
        }
    }
}

module feet(){
    if(featureFeetRecess=="yes"){
        translate([0,19,0])
            mirrorCopy([1,0,0])mirrorCopy([0,1,0])
                translate([80,70,0.5])
                    cylinder(h=1+0.1,d=25.4+0.2, center=true);
    }
}

module rearStickerRecess(){
    if(featureRearStickerRecess=="yes"){
        translate([0,123,175])
        cube([100,1+0.1,50], center=true);
    }
}

module vents(){
    // Passive Cooling vents
    if(featureTopVents=="yes"){
        color("blue")mirrorCopy(){
            // Top slots
            for(i = [-7:8]){
                translate([0,0,255])
                    rotate([-5,0,0])
                        translate([81,(i*10)+1,0])
                            cube([35,3,100], center=true);
            }
            // Rear slots
            for(i = [1:4]){
                translate([0,100,255+50-8.75])
                    rotate([-60,0,0])
                        translate([81,(i*10)+1,-50])
                            cube([35,3,100], center=true);
            }
        }
    }
    // Decorative front slashes
    if(featureFrontStripes=="yes"){
        color("darkgrey"){
            for(i=[1:3]){
                translate(cornerFrontChin+[0,-5,(i*(3+3))+15])
                    cube([300,3,3], center=true);
            }
        }
    }
}


module cutouts(){
    screenCutout();
    vents();
    feet();
    rearStickerRecess();
    color("grey")interior_volume();
    
    // Front panel screen retainer screws
    rotate([-5,0,0])translate([2,-114.5,200]){
        translate([0,-2,-70])rotate([-90,0,0])#screenRetainerScrews();
    }

}

module screenAssembly(){
    //rotate([-5,0,0]){
        color("silver")cube([175,3,136], center=true);
        translate([-(10/2)+3,-1.5,(13/2)-3])color("black")cube([175-10,0.1,136-13], center=true);
        color("green")translate([0,11.5,(-36/2)-3])cube([120,20+0.1,100], center=true);
    //}
}

module screen(){
    rotate([-5,0,0])translate([2,-114.5,200]){
        screenAssembly();
        translate([0,-2,-70])rotate([-90,0,0])screenRetainer();
        translate([0,1,69])rotate([45,0,0])cube([180,6,8], center=true);
    }
}


module selfTappingScrew(){
    translate([0,0,15/2])cylinder(h=15,d=3, center=true);
    translate([0,0,15-2.5-4])cylinder(h=5,d=5, center=true);
    translate([0,0,15-(4/2)])cylinder(h=4,d2=7,d1=5, center=true);
}
module screenRetainerScrews(){
    mirrorCopy()translate([90,3,-6])selfTappingScrew();
}
module screenRetainer(){
    difference(){
        hull(){
            mirrorCopy([1,0,0])mirrorCopy([0,1,0])
                translate([100,5,9/2])cylinder(h=9,d=10, center=true);
        }
        screenRetainerScrews();
    }
}

module boltSideFrameRetainer(){
    rotate([90,90,0]){
        difference(){
            hull(){
                cylinder(h=20+8,d=20, center=true);
                translate([0,-10,0])cube([20,0.1,45], center=true);
            }
            metricCapheadAndBolt(6, 20, recessNut=20, recessCap=20);
        }
        //if($preview){
        //    color("red")metricCapheadAndBolt(6, 20, recessNut=20, recessCap=20);
        //}
    }
}
module boltTopFrameRetainerBolt(){
    rotate([0,180,0])metricCapheadAndBolt(6,50, recessNut=5, recessCap=110);
}
module boltTopFrameRetainerRear(){
    translate([0,0,-50])cylinder(h=160,d=20, center=true);
    translate([0,5,-50])cube([20,10,160],center=true);
    translate([-5,0,-50])cube([10,20,160],center=true);
}

module boltTopFrameRetainerFront(){
    translate([0,0,-50])cylinder(h=160,d=20, center=true);
    translate([-5,0,-50])cube([10,20,160],center=true);
}




/*
rotate([-5,0,0])translate([0,-90,0]){
    translate([0,0,275])rotate([-90,90,0])metricCapheadAndBolt(6, 10, recessNut=10, recessCap=30);
    //mirrorCopy()translate([90,0,50])rotate([-90,90,0])metricCapheadAndBolt(6, 10, recessNut=1, recessCap=20);
}*/


module usbCutouts(){
    // Front
    translate([50,-84.5,17])
        mirrorCopy()
            color("darkgrey")
                translate([20,0,0])
                    rotate([270,0,0])
                        usbHeaderConnectorCutout();
    // Rear
    translate([-87+50,123.5-1.7-2.8-0.1,24])
        mirrorCopy([0,0,1])
            color("darkgrey")
                translate([0,0,7])
                    rotate([90,0,0])
                        usbHeaderConnectorCutout();
}
    




// Slicers
sliceHeight = 45;
sliceDepth = -30;
module sliceFront(){
    rotate([-5,0,0]){
        translate([0,-150-91.75,200-10])cube([300,300,400], center=true);
        translate([0,-80-1,200-10-150])cube([50,10,10], center=true);
        translate([0,-90,200-10-150+5])cube([50,10,10], center=true);
    }
}
module sliceRear(){
    difference(){
        translate([0,0,200-20])cube([300-0.1,400,400], center=true);
        sliceFront();
    }
}

module sliceBodyBottom(){
    translate([0,150,sliceHeight])cube([300,600,200], center=true);
}
module sliceBodyTop(){
    translate([0,150,sliceHeight+200])cube([300,600,200], center=true);
}
module sliceBodyFront(){
    translate([0,200 + sliceDepth,200-20])cube([300,300,400+1], center=true);   
    translate([0,0,200+35+0.01])cube([130,150,30], center=true);   
}
module sliceBodyRear(){
    difference(){
        translate([0,200 + sliceDepth-300,200-20])cube([300,300,400+1], center=true);   
        sliceBodyFront();
    }
    
}




module powerSupplyCutout(){
    translate(powerSupplyLocation)rotate([0,-90,0]){
        color("brown"){
            power_supply_cutout(); 
        }
    }
}
module powerSupplyBrace(){
    translate(powerSupplyLocation){
        translate([5,-32.5+0.01,0])cube([31,0,51]+[20,10,10], center=true);
    }
}

itxOffset = [0,116,154];
itxRotation = [-90,0,180];

if($preview && showItxBoard=="yes"){
    translate(itxOffset)rotate(itxRotation)itx();
    translate(itxOffset)rotate(itxRotation)translate([0,0,6])itxM3Bolts();
}
    
fanCutoutPosition = [0,20,250-5.75];

fanOpeningRear = [0,20+45+.5+2,250-0.5-5-.75-25+1];
fanOpeningRearLower = fanOpeningRear + [0,0,-14-1];
fanOpeningFront = fanOpeningRear + [0,-93-1,0];
fanOpeningFrontLower = fanOpeningFront + [0,0,-14-1];
radiatorTop = [24,73.5,187.5+(90/2)-.5];
radiatorBottom = radiatorTop + [0,0,-90+1];

fanInnerWallThickness = 2;
fanOpeningRear_inner = fanOpeningRear + [0,fanInnerWallThickness,-fanInnerWallThickness] + [0,0,0.1] + [2.5,0,0];
fanOpeningRearCavity_inner = fanOpeningRear + [0,-fanInnerWallThickness,0];
fanOpeningFront_inner = fanOpeningFront + [0,fanInnerWallThickness,0] + [0,0,0.1];
fanOpeningFrontLower_inner = fanOpeningFrontLower + [0,fanInnerWallThickness,-fanInnerWallThickness/3];
radiatorTop_inner = radiatorTop + [0,0,-fanInnerWallThickness] + [0,0.1,0];
radiatorBottom_inner = radiatorBottom + [0,0,fanInnerWallThickness];

/*
color("green"){
    translate(fanOpeningRear)cube([90-fanInnerWallThickness*2,1,1], center=true);
    translate(fanOpeningFront)cube([90-fanInnerWallThickness*2,1,1], center=true);
    translate(fanOpeningFrontLower)cube([90-fanInnerWallThickness*2,1,1], center=true);
    translate(fanOpeningRearLower)cube([90-fanInnerWallThickness*2,1,1], center=true);
    translate(radiatorTop)cube([90-fanInnerWallThickness*2,1,1], center=true);
    translate(radiatorBottom)cube([90-fanInnerWallThickness*2,1,1], center=true);
}
color("blue"){
    translate(fanOpeningRear_inner)cube([92,1,1], center=true);
    translate(fanOpeningRearCavity_inner)cube([92,1,1], center=true);
    translate(fanOpeningFront_inner)cube([92,1,1], center=true);
    translate(fanOpeningFrontLower_inner)cube([92,1,1], center=true);
    translate(radiatorTop_inner)cube([92,1,1], center=true);
    translate(radiatorBottom_inner)cube([92,1,1], center=true);
}/**/
module duct_outer(){
    hull(){
        translate(fanOpeningRear)cube([94,1,1], center=true);
        translate(fanOpeningRearLower)cube([92,4,1], center=true);
        translate(fanOpeningFront)cube([94,1,1], center=true);
        translate(fanOpeningFrontLower)cube([94,1,1], center=true);
        translate(radiatorBottom)cube([92,1,1], center=true);
    }
    hull(){
        translate(fanOpeningRear)cube([92,1,1], center=true);
        translate(radiatorTop)cube([92,1,1], center=true);
        translate(radiatorBottom)cube([92,1,1], center=true);
    }
    hull(){
        translate(fanOpeningFront)cube([94,1,1], center=true);
        translate(fanOpeningRear)cube([94,1,1], center=true);
        translate(radiatorTop)cube([92,1,1], center=true);
        translate(radiatorBottom)cube([92,1,1], center=true);
    }
}

module duct_inner(){
    hull(){
        translate(radiatorBottom_inner)cube([90-fanInnerWallThickness*2,1,1], center=true);
        translate(fanOpeningRear_inner)cube([90-5-2-fanInnerWallThickness*2,1,1], center=true);//???
        translate(fanOpeningFrontLower_inner)cube([90-fanInnerWallThickness*2,1,1], center=true);
    }    
    hull(){
        translate(radiatorTop_inner)cube([90-fanInnerWallThickness*2,1,1], center=true);
        translate(radiatorBottom_inner)cube([90-fanInnerWallThickness*2,1,1], center=true);
        translate(fanOpeningRear_inner)cube([90-5-2-fanInnerWallThickness*2,1,1], center=true);
    }
    hull(){
        translate(fanOpeningRearCavity_inner)cube([90-fanInnerWallThickness*2,1,1], center=true);
        translate(fanOpeningFront_inner)cube([90-fanInnerWallThickness*2,1,1], center=true);
        translate(fanOpeningFrontLower_inner)cube([90-fanInnerWallThickness*2,1,1], center=true);
        translate(fanOpeningRear_inner)cube([90-5-2-fanInnerWallThickness*2,1,1], center=true);//???
    }    
}
//color("green",0.2)duct_inner();/*


module duct_support_posts(){
    difference(){
        translate(fanCutoutPosition){
            translate([82.5/2,82.5/2,-31.5])cylinder(h=13,d=9, center=true);
            translate([82.5/2,82.5/-2,-50])cylinder(h=50,d=9, center=true);
            translate([82.5/-2,82.5/2,-50])cylinder(h=50,d=9, center=true);
            translate([82.5/-2,82.5/-2,-50])cylinder(h=50,d=9, center=true);
        }
        difference(){
            translate([20,20,210])cube([150,150,150], center=true);
            hull()duct_outer();
        }
    }
}



module duct(){
    difference(){
        union(){
            difference(){
              duct_outer();
                duct_inner();
            }
           duct_support_posts();
            translate(fanOpeningRear+[2,-1.25,-0])cube([89.5,5.5,3], center=true);
       }
    
        translate(fanCutoutPosition)fanCutout92mm(depthForCaphead=2, recessNut=30);
    }
    
}


//duct();

//translate(fanCutoutPosition)fanCutout92mm(depthForCaphead=2, recessNut=0);


module wholeThing(){
    difference(){
        union(){
            difference(){
                union(){
                    body();
                    facia();
                    
                }
                cutouts();
            }
            // motherboard standoffs
            translate(itxOffset)rotate(itxRotation)itxStandoffs();
            
            difference(){
                rotate([-5,0,0])translate([2,-114.5,200]){
                    translate([0,-2,-70])rotate([-90,0,0])screenRetainer();
                    translate([0,1,69])rotate([45,0,0])cube([180,6,8], center=true);
                }
                rotate([-5,0,0])translate([2,-114.5,200]){
                    screenAssembly();
                }
            }
            // Top side bolts
            mirrorCopy()translate([-96,20,200])boltSideFrameRetainer();
            // Lower side bolts
            mirrorCopy()translate([-96,20,70])boltSideFrameRetainer();
            // Bottom bolts (rear)
            mirrorCopy()translate([-99,108,135])boltTopFrameRetainerRear();
            // Bottom bolts (front)
            mirrorCopy()translate([-99,-67,135])boltTopFrameRetainerFront();
            
            powerSupplyBrace();

        }
        // Bottom bolt holes (rear)
        mirrorCopy()translate([-99,108,135])boltTopFrameRetainerBolt();
        // Bottom bolt holes (front)
        mirrorCopy()translate([-99,-67,135])boltTopFrameRetainerBolt();
        
        // USB cutouts
        usbCutouts();
        
        // Fan cutout
        translate(fanCutoutPosition)fanCutout92mm(depthForCaphead=2, recessNut=62);
        
        // Cutout for PSU
        powerSupplyCutout();
        
        // Motherboard screw holes
        translate(itxOffset)rotate(itxRotation)translate([0,0,6])itxM3Bolts();
    }
    
    if($preview && renderPrintablePart=="none"){
        duct();
    }
}

module part_facia(){
    difference(){
        rotate([5,0,0]){
            difference(){
                wholeThing();
                sliceRear();
            }
        }
        color("red")translate([0,-110,28.75])cube([230,70,10], center=true);    
    }
}   
    
module part_top_front(){
    difference(){
        wholeThing();
        sliceFront();
        sliceBodyFront();
        sliceBodyBottom();
    }
}
module part_top_rear(){
    difference(){
            wholeThing();
            sliceFront();
            sliceBodyRear();
            sliceBodyBottom();
        }
    }
module part_bottom_front(){
    difference(){
            wholeThing();
            sliceFront();
            sliceBodyFront();
            sliceBodyTop();
        }
}
module part_bottom_rear(){
    difference(){
            wholeThing();
            sliceFront();
            sliceBodyRear();
            sliceBodyTop();
        }
}
module part_duct(){
    if(rotateForPrint=="yes"){
        difference(){
            translate([0,0,0])rotate([31.69,0,0])
                color("lightblue")duct();
           color("red")translate([0,-50,155-0.38])cube([200,200,10], center=true);
        }
    }else{
        color("lightblue")duct();
    }
}


if(renderPrintablePart != "none"){
    if(renderPrintablePart == "facia"){
        part_facia();
    }else if(renderPrintablePart == "top_front"){
        part_top_front();
    }else if(renderPrintablePart == "top_rear"){
        part_top_rear();
    }else if(renderPrintablePart == "bottom_front"){
        part_bottom_front();
    }else if(renderPrintablePart == "bottom_rear"){
        part_bottom_rear();
    }else if(renderPrintablePart == "duct"){
        part_duct();
    }else if(renderPrintablePart == "all"){
        translate([0,-20,10])part_facia();
        translate([0,0,20])part_top_front();
        translate([0,0,0])part_bottom_front();
        translate([-100,160,0])rotate([0,0,90]){
            translate([0,20,20])part_top_rear();
            translate([0,20,0])part_bottom_rear();
        }
    }
}else{
    if(renderPortion=="all"){
        wholeThing();
    }else if(renderPortion=="left"){
        difference(){
            wholeThing();
            translate([100,0,200-5])cube([200,400,400], center=true);
        }
    }else if(renderPortion=="right"){
        difference(){
            wholeThing();
            translate([-100,0,200-5])cube([200,400,400], center=true);
        }
    }else if(renderPortion=="front"){
        difference(){
            wholeThing();
            translate([0,100,200-5])cube([400,200,400], center=true);
        }
    }else if(renderPortion=="back"){
        difference(){
            wholeThing();
            translate([0,-100,200-5])cube([400,200,400], center=true);
        }
    }else if(renderPortion=="bottom"){
        difference(){
            wholeThing();
            translate([0,0,200+130])cube([400,400,400], center=true);
        }
    }else if(renderPortion=="top"){
        difference(){
            wholeThing();
            translate([0,0,-200+130])cube([400,400,400], center=true);
        }
    }
}

/**/