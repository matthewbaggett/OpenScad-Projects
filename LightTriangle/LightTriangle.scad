use <../Lib/metric_screws.scad>
use <../Lib/metric_bolts.scad>

$fn=$preview?90:180;
// Should we show the circuit board?
showCircuitBoard = "yes"; // [yes, no]
// Cut model in half?
halfIt = "no"; // [yes,no]
// Show Lasercut cover piece?
showLasercutPiece = "yes"; //[yes, no]
// Show main body
showMainBody = "yes"; //[yes, no]
// Include mounting spaces for foam pads?
includeMountingFoamPads = "yes"; //[yes, no]

if($preview && showCircuitBoard=="yes"){
    translate([0,(130/2)-43.333,1]){
        translate([-2000+900+4,2000-1200+30+0.3,-2.5])
            color("lightgreen",0.3)scale(0.254)import("pcb.stl", convexity=3);
        
        //#color("red")cube([140,130,1], center=true);
    }
}

module lasercutPiece(){
    hull()for(r = [1:3]){
        rotate(r*120){
            translate([0,73,0]){
                translate([0,0,5.5-.5-.25]){
                    cylinder(h=2.5,d=15, center=true);
                }
            }
        }
    }
}

module holes(){
    // Retaining edge
    color("red")hull()for(r = [1:3]){
        rotate(r*120){
            translate([0,73,0]){
                translate([0,0,5.5+1]){
                    cylinder(h=1+0.01,d1=14.5,d2=14, center=true);
                    cylinder(h=1+0.01,d1=15,d2=15, center=true);
                }
            }
        }
    }
    // Lasercut acrylic face
    color("blue")lasercutPiece();
    // Bottom retaining edge
    color("red")hull()for(r = [1:3]){
        rotate(r*120){
            translate([0,73,0]){
                translate([0,0,3.25-1-.25]){
                    cylinder(h=3+0.01,d1=15,d2=13, center=true);
                }
            }
        }
    }
    // interior cutout
    color("grey")hull()for(r = [1:3]){
        rotate(r*120){
            translate([0,73,0]){
                translate([0,0,-.5-.125]){
                    cylinder(h=2.75+0.01-.5,d=15, center=true);
                }
            }
        }
    }

    // Cutouts for interconnectors
    for(r = [1:3]){
        rotate(r*120)
            translate([0,-40,1.75-5.25+0.001+.5])
                cube([12,15,3], center=true);
    }
    // rear clearancing
    translate([0,0,-0.5])cylinder(h=11+1,d=80, center=true);
        
    // PCB mounting screws
    for(r = [1:3]){
        rotate(r*120)
            translate([0,73,0])
                translate([0,0,-2.1+1.6])
                    metricCapheadAndBolt(3, 5, recessNut=2);
    }

    // Customer mounting screws
    for(r = [1:3]){
        rotate(r*120)
            translate([0,62.5,-6.5])
                selfTappingScrew(mSize=3, length=10);
    }
    // Customer mounting foam pads
    if(includeMountingFoamPads=="yes"){
        for(r = [1:3]){
            rotate(r*120)
                translate([0,50,-4.5-1-0.01])
                    cube([25.2,15.2,1], center=true);
        }
    }
} 

module plastic(){
    difference(){
        hull(){
            for(r = [1:3]){
                rotate(r*120)
                    translate([0,87.5,0.5])
                        cylinder(h=13,d=3, center=true);
            }
        }
        if($preview && halfIt == "yes"){
            translate([100,0,0])cube([200,200,20], center=true);
        }
    }
}

/*
#holes();
/**/
if(showMainBody=="yes"){
    difference(){
        plastic();
        holes();
    }
}
if(showLasercutPiece=="yes"){
    if(showMainBody=="no"){
        projection()lasercutPiece();
    }else{
        translate([0,0,30])color("white",0.3)lasercutPiece();
    }
}
/**/