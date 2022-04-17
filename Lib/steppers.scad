/**
 * Implementation of a model of a 28BYJ-48 type cheapo stepper motor
 */
use <mirrorcopy.scad>;
module stepper28BYJ48(){
    color("light grey"){
        translate([0,-8,0]){
            // Motor body
            translate([0,0,(19/2)*-1]){
                cylinder(d=28,h=19, center=true);
            }

            // Motor snooter
            translate([0,8,0]){
                translate([0,0,(1.5/2)])cylinder(d=9,h=1.5, center=true);
                difference(){
                    translate([0,0,(5/2)+2])cylinder(d=5,h=6, center=true);
                    mirrorCopy([0,1,0]){
                        translate([0,4,(5/2)+2.1])cube([5,5,6.2], center=true);
                    }
                }
            }
            
            // cable gland
            translate([0,(17/2)*-1,(19/2)*-1]){
                cube([14.8,17,19], center=true);
            }
            
            // Attachment crossbar
            difference(){
                hull(){
                    mirrorCopy([1,-0,0]){
                        translate([(35/2),0,(1/2)*-1]){
                            cylinder(h=1,d=7, center=true);
                        }
                    }
                }
                mirrorCopy([1,-0,0]){
                    translate([(35/2),0,(1/2)*-1]){
                        cylinder(h=1+0.01,d=4.2, center=true);
                    }
                }
            }
        }
    }
}


module stepper28BYJ48_cutouts(){
    color("orange"){
        translate([0,-8,0]){
            mirrorCopy([1,-0,0]){
                translate([(35/2),0,(1/2)*-1]){
                    cylinder(h=1+0.01,d=4.2, center=true);
                }
            }
        }
    }
}

module nemaCutout(shaftClearance, shaftGirth, shaftLength, frameSize, holeSpacing,holeDiameter=3,       nemaSlotSlackMM=0, shaft=false){
    translate([0,0,frameSize/-2]){
        hull(){
            mirrorCopy([0,1,0]){
                translate([0,nemaSlotSlackMM/2]){
                    cube([frameSize*1.01,frameSize*1.01,frameSize], center=true);
                }
            }
        }
    }
    if(!shaft){
        translate([0,0,10/2]){
            mirrorCopy([1,0,0]){
                mirrorCopy([0,1,0]){
                    translate([holeSpacing/2,holeSpacing/2,0]){
                        hull(){
                            mirrorCopy([0,1,0]){
                                translate([0,nemaSlotSlackMM/2,0]){
                                    cylinder(d=holeDiameter*1.1,h=30,center=true);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    if(!shaft){
        translate([0,0,-0.5]){
            cylinder(d=shaftClearance*1.03,h=shaftLength+1);
        }
    }else{
        difference(){
            cylinder(d=shaftGirth*1.03,h=shaftLength*2, $fn=360);
            translate([frameSize/-2,(shaftGirth/2)-(shaftGirth)*0.15,shaftLength*0.3+0.01]){
                cube([frameSize,frameSize/2,shaftLength*0.70]);
                translate([0,0,shaftLength*0.70-1])cube([frameSize,frameSize/2,shaftLength+1]);
            }
        }
    }
}

module nema14_cutout(){
    nemaCutout(22,5,24,35,26,3,2, shaft);
}

module nema17_cutout(shaft=false){
    
    nemaCutout(22,5,24,42.3,31,3,2, shaft);
}

nema17_cutout(true);