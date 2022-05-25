part = "all"; // [all, left, right, top, hat]
layOutForPrint = "yes"; // [no, yes]
use <Lib/mattlib.scad>
$fn=$preview?30:360;
m93=[154+25,104.2+77.7,34.5];

module bracket(){
        
    difference(){
        // Plastic body
        union(){
            translate([0,0,45])cylinder(h=10,d=17, center=true);
            translate([0,0,51.5])cylinder(h=3,d=23, center=true);
        
            hull(){
                translate([0,0,40])cylinder(h=1,d=23, center=true);
                // Top
                mirrorCopy([0,1,0])
                    translate([0,40,25])
                        rotate([0,90,0])
                            cylinder(h=m93.z+20,d=10, center=true);
                
                // Middle
                mirrorCopy([0,1,0])
                    translate([0,45,15])
                        rotate([0,90,0])
                            cylinder(h=m93.z+20,d=10, center=true);
                // Bottom
                mirrorCopy([0,1,0])
                    translate([0,(70/2)-15,-10-15])
                        rotate([0,90,0])
                            cylinder(h=m93.z+10,d=10, center=true);
            }
        }

        // Bottom bolts
        translate([-6,0,-20])
                rotate([0,90,0])
                    rotate(30)  
                        metricCapheadAndBolt(6, 20, recessNut=20, recessCap=20);
        
        // Top bolts
        mirrorCopy([0,1,0])
            translate([-6,35,20])
                rotate([0,90,0])
                    rotate(30)  
                        metricCapheadAndBolt(6, 20, recessNut=20, recessCap=20);
        
        // Extrusion cutout
        rotate([90,0,0])
            extrusion40x20(m93.y*1.1, center=true);

        // Retaining cap bolt
        translate([0,0,38])metricCapheadAndBolt(6, 20, recessNut=20, recessCap=2);
        // Bearing
        translate([0,0,45])bearing_6003(labels=false);        
    }
}


module hat(){
    difference(){
        translate([0,0,9.75])cylinder(d=180,h=20, center=true);
    
        // Bearing
        translate([0,0,4.5])hull()bearing_6003(labels=false);        
        translate([0,0,10])cylinder(h=50, d=24, center=true);
        
        translate([0,0,25+5]){
            difference(){
                cylinder(d=200,h=50, center=true);
                cylinder(d1=52,d2=48,h=52, center=true);
            }
        }
        
        
        pcd(360/7)translate([60,0,0])cylinder(h=30,d=40, center=true);
    }    
}

module partSplitter(){
    translate([25,0,25]){
       //translate([-25,0,5])cylinder(h=50, d=30, center=true);
    }
    translate([15,0,25]){
        cube([50,200,150], center=true);
    }
}
module partSplitterInvert(){
    difference(){
        translate([0,0,25]){
            cube([100,200,150]+[-0.02,-0.02,-0.02], center=true);
        }
        partSplitter();
    }
}
module topSplitter(){
    translate([0,0,141])cube([200,200,200], center=true);
}
module bottomSplitter(){
    translate([0,0,141-200])cube([200,200,200], center=true);
}


if(layOutForPrint=="no"){
    if($preview){
        // Extrusion cutout
        rotate([90,0,0])
            extrusion40x20(m93.y*1.1, center=true);
        //#partSplitter();
    }
    
    bracket();
}else{
    if (part == "all" || part == "left") {
        rotate([0,90,0])
            translate([10,0,50])
                difference(){
                    bracket();
                    partSplitter();
                    topSplitter();
                }
    }
    
    if (part == "all" || part == "right") {
        rotate([0,-90,0])
            translate([10,0,50])
                difference(){
                    bracket();
                    partSplitterInvert();
                    topSplitter();
                }
    }
    
    if (part == "all" || part == "top") {
        translate([0,0,53])
            rotate([180,0,0])
                difference(){
                    bracket();
                    //partSplitterInvert();
                    bottomSplitter();
                }
    }
    if(part=="all" || part == "hat") {
        translate([0,130,0])hat();

    }
}
/**/