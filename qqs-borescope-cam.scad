use <Lib/mattlib.scad>
$fn=60;
bore=7.2+0.4; // 7.2mm + bullshit factor
angleTiltDown=20;
bodyRadiusMM = 3;

/*
translate([(18/2)*-1,0,0])
color("green")difference(){
    union(){
        cube([18,10,23.50]);
        translate([0,-10,12.5])
        cube([18,10,2]);
        translate([0,-2.3,20.5])
        cube([18,2.3,3]);
    }
    
    translate([18/2,0,5])
    rotate([-90+angleTiltDown,0,0])
    #cylinder(40,d=bore,center=true);
    translate([18/2,-5.5,zOffset])
    #cylinder(4,d=3.2);   
}/**/


module qqs_borescope_cam_mount(){
    difference(){
        union(){
            // Main body
            hull(){
                mirrorCopy([1,0,0]){
                    translate([(18/2)-(bodyRadiusMM/2),5,-0.5+(bodyRadiusMM/2)]){
                        rotate([90,0,0]){
                            cylinder(h=10,d=bodyRadiusMM, center=true);
                        }
                    }
                    translate([(18/2)-(bodyRadiusMM/2),5,23.5-(bodyRadiusMM/2)]){
                        rotate([90,0,0]){
                            cylinder(h=10,d=bodyRadiusMM, center=true);
                        }
                    }
                }
            }

            // Lower deck
            deckThicknessMM = 2;
            hull(){
                mirrorCopy([1,0,0]){
                    translate([(18/2)-(bodyRadiusMM/2),-10+(bodyRadiusMM/2),13.5]){
                        cylinder(h=deckThicknessMM, d=bodyRadiusMM, center=true);
                    }
                }
                translate([0,0,13.5])
                    cube([18,1,2], center=true);
            }

            // Upper Deck
            hull(){
                mirrorCopy([1,0,0]){
                    translate([(18/2)-(bodyRadiusMM/2),-(2.3/2),23.5-(bodyRadiusMM/2)]){
                        rotate([90,0,0]){
                            cylinder(h=2.3,d=bodyRadiusMM, center=true);
                        }
                    }
                    
                }
                
            }
        }
        union(){
            translate([0,0,5]){
                rotate([-90+angleTiltDown,0,0]){
                    cylinder(40,d=bore,center=true, center=true);
                }
            }
            translate([0,-5.5,13.5]){
                cylinder(4,d=3.2, center=true);   
            }
        }
    }
}

if($preview){
    qqs_borescope_cam_mount();
}else{
    rotate([-90,0,0]){
        qqs_borescope_cam_mount();
    }
}