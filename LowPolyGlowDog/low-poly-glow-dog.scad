dogScale = 2.2;
box = 300;
cutInHalf = false; // [true:Yes, false:No]
printablePart = "all"; // [all:All Parts, body:Dog Body, lamp:Lamp Holder]
use <../Lib/hollower.scad>;
use <../Lib/metric_bolts.scad>;
use <../Lib/pcd.scad>;
use <../Lib/mirrorcopy.scad>;
$fn=120;

module dogModel() {
    scale(dogScale)
        translate([110,-27,0])
            import("beto-lowpoly-flowalistik.STL");
} 

module bulbStandPlastic(){
    translate([0,0,(55+10-50)/2])cylinder(d=40+8, h=55+10+50, center=true);
}
module bulbStandHole(){
    translate([0,0,110])sphere(d=55);
    translate([0,0,(55+30-50)/2])cylinder(d=28,h=55+30+50, center=true);
    translate([0,0,(55-50)/2])cylinder(d=40,h=55+50, center=true);
}

module plastic(){
    hollower(box=box, wallThickness=1, bottomLift=30.2)
        dogModel();
    
    translate([0,-60,0])
        rotate([-23,0,0])
            bulbStandPlastic();
}

module hole(){
    translate([0,-60,0])
        rotate([-23,0,0])
            bulbStandHole();
    // Butt trimmer
    translate([0,0,box/-2])
        cube([box,box,box], center=true);
    
    // cable duct
    translate([0,-120,0])
        rotate([90,0,0])
            cylinder(d=10, h=100, center=true);

    // bottom bolts
    translate([0,-55,0]){
        mirrorCopy([1,0,0])
            translate([-30,5,15])
                rotate(90)rotate([0,180,0])
                    #metricCapheadAndBolt(6, 20,recessNut=3, recessCap=3);
    }

}

module partSplitter(){
    translate([0,-60,0])
        rotate([-23,0,0])
            scale([1.01,1.01,1.01])bulbStandPlastic();
    translate([0,-60,0])
        rotate([-23,0,0])
    cube([74,29,29], center=true);
}


module dog(){
    difference(){
        plastic();
        hole();
    }
}

if(printablePart=="all" || printablePart=="body"){
    difference(){
        if(cutInHalf){
            intersection(){
                dog();
                translate([box/4,0,box/2])cube([box/2,box,box], center=true);
            }
        }else{
            dog();
        }
        partSplitter();
    }
}
if(printablePart=="all" || printablePart=="lamp"){
    translate([150,0,0])intersection(){
        dog();
        partSplitter();
        translate([-0,-40,50+2])cube([100,100,100], center=true);
    }
}

//color("grey",0.3)circle(d=255);
/**/