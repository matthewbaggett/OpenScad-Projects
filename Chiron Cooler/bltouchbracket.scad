$fn=180;
use <../Lib/mattlib.scad>

module bltouch(){
    translate([0,0,-1.1]){
        color("white"){
            difference(){
                union(){
                    hull(){
                        mirrorCopy(){
                            translate([((26.2-11.6)/2),0,0]){
                                cylinder(h=2.2,d=8, center=true);
                            }
                        }
                        cylinder(h=2.2,d=11.7, center=true);
                    }
                }
                mirrorCopy(){
                    translate([18/2,0,0]){
                        cylinder(d=3.2,h=5, center=true);
                    }
                }
            }
            translate([0,0,-1.1-(8/2)]){
                cylinder(h=8, d=11.5, center=true);
            }
            translate([0,0,-22.35]){
                cylinder(h=36.7-2.2-8, d=13, center=true);
            }
            translate([0,0,-40.45]){
                cylinder(h=9.7, d2=2, d1=0.25, center=true);
            }
        }
        translate([0,0,-35.65-6]){
            color("grey", 0.1){
                cube([50,50,0.1], center=true);
            }
        }
    }
}

difference(){
    union(){
        // Main body
        hull(){
            mirrorCopy([1,0,0]){
                mirrorCopy([0,1,0]){
                    translate([20-1.5,20-1.5,0]){
                        cylinder(h=2, d=3.2, center=true);
                    }
                }
                
                translate([20-1.5,20+5-1.5,0]){
                    cylinder(h=2, d=3.2, center=true);
                }
            }
        }
        // Top flange
        hull(){
            mirrorCopy([1,0,0]){
                translate([20-1.5,20+5-1.5,0-(3.66/2)]){
                    cylinder(h=2+3.66, d=3.2, center=true);
                }
                translate([20-1.5,20+5-1.5-2,0-(3.66/2)]){
                    cylinder(h=2+3.66, d=3.2, center=true);
                }
            }
        } 
    }
    // Center hole
    translate([0,0,-0.5]){
        sphere(d=38.5);
    }
    // Wire cutout
    hull(){
        translate([-14,9,0])cylinder(h=10,d=5, center=true);
        translate([-10.5,16.75,0])cylinder(h=10,d=5, center=true);
        translate([0,16.75,0])cylinder(h=10,d=5, center=true);
    }
    // Fan screw holes
    mirrorCopy([1,0,0]){
        mirrorCopy([0,1,0]){
            translate([(32/2),(32/2),0]){
                cylinder(h=10, d=3.2, center=true);
            }
        }
    }
    // Top mount holes
    mirrorCopy([1,0,0]){
        hull(){
            translate([(32/2),(32/2)+6.5,-2]){
                translate([1,0,0])
                    cylinder(h=10, d=3.2, center=true);
                cylinder(h=10, d=3.2, center=true);
            }
        }
    
    }
}

// BLTouch Mount
offsetZ = 9;
difference(){
    // BLTouch stantion
    translate([0,21,10]){
        rotate([90,0,0]){
            difference(){
                union(){
                    // Stantion body
                    hull(){
                        // Corners on bltouch side
                        mirrorCopy(){
                            translate([((26.2-11.6)/2),0,0+offsetZ]){
                                cylinder(h=2.2,d=8, center=true);
                            }
                        }
                        // bltouch center of shaft
                        translate([0,0,0+offsetZ]){
                            cylinder(h=2.2,d=11.7, center=true);
                        }
                        // affixment location to fan bracket
                        mirrorCopy(){
                            translate([11,-10,-2]){
                                cylinder(h=2.2+2,d=2, center=true);
                            }
                        }
                    }
                }
                // Bolt holes
                mirrorCopy(){
                    translate([18/2,0,0+offsetZ]){
                        cylinder(d=3.2,h=20, center=true);
                    }
                }
            }
        }
    }
    
    // Adjustment hole
    translate([0,30-offsetZ-0.1,10]){
        rotate([90,0,0]){
            cylinder(h=20,d=4, center=true);
        }
    }
    
    // bolt shoulders
    translate([0,21-(offsetZ*.9),10]){
        rotate([90,0,0]){
            mirrorCopy(){
                translate([18/2,0,-1]){
                    translate([0,0,-10])cylinder(d=5.5,h=20, center=true);
                    translate([0,5.5/2,-10])cube([5.5,5.5,20], center=true);
                    translate([5.5/2,0,-10])cube([5.5,5.5,20], center=true);
                }
            }
        }
    }
}

if($preview){
    translate([0,20-offsetZ,10]){
        rotate([-90,0,0]){
            bltouch();
        }
    }
}