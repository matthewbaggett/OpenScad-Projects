use <Lib/mattlib.scad>;
cabinetDims = [900,700,1700];
deck1=350;
deck2=deck1+700+200;
module anycubicChiron(chiron = [530,630,600]){
    gantryY=365;
    bed = [430,410,5];
    
    mirrorCopy([1,0,0]){
        translate([chiron.y/2-(20/2),0,(20/2)]){
            rotate([90,0,0]){
                extrusion20x20(chiron.x, center=true);
            }
        }
    }

    mirrorCopy([0,1,0]){
        translate([0,chiron.x/2-(40/2),(20/2)]){
            rotate([90,0,90]){
                extrusion40x20(chiron.y, center=true);
            }
        }
    }

    mirrorCopy([0,1,0]){
        translate([-(chiron.y/2)+(20/2)+gantryY,chiron.x/2-(40/2),(chiron.z/2)+(20)]){
            rotate([0,0,90]){
                extrusion40x20(chiron.z+0, center=true);
            }
        }
    }


    translate([-(chiron.y/2)+(20/2)+gantryY,0,chiron.z+(20/2)]){
        rotate([90,0,0]){
            extrusion20x20(chiron.x, center=true);
        }
    }

    rotate(270){
        translate([-(130/2)+(chiron.x/2)+25,-250,20]){
            prism(130,40,60);
        }
    }

    translate([0,0,(5/2)+20+60]){
        cube(bed, center=true);
        color("red")cube(bed + [bed.x-10,0,-3], center=true);
    }  
}



module printers(){
    color("green"){
        translate([0,70-40,0]){
            translate([0,0,deck2]){
                anycubicChiron(chiron = [530,630,320]);
            }
            translate([0,0,deck1]){
                anycubicChiron();
            }
        }
    }
}
module frame(){
    mirrorCopy([1,0,0]){
        mirrorCopy([0,1,0]){
            translate([cabinetDims.x/2, cabinetDims.y/2,(cabinetDims.z/2)]){
                extrusion30x30(cabinetDims.z, center=true);
            }
        }
    }
}

module deck(wood=true){
    color("blue"){
        mirrorCopy([0,1,0]){
            translate([0,cabinetDims.y/2,0]){
                rotate([0,90,0]){
                    extrusion30x30(cabinetDims.x-30, center=true);
                }
            }
        }
        mirrorCopy([1,0,0]){
            translate([cabinetDims.x/2,0,0]){
                rotate([90,0,0]){
                    extrusion30x30(cabinetDims.y-30, center=true);
                }
            }
            if(wood){
                translate([cabinetDims.x/4,0,0]){
                    rotate([90,0,0]){
                        extrusion30x30(cabinetDims.y-30, center=true);
                    }
                }
            }
        }
    }        
       
    if(wood){
        translate([0,0,(30/2)+(10/2)]){        
            difference(){
                color("saddlebrown"){
                    cube([cabinetDims.x-10, cabinetDims.y-10, 10], center=true);
                }
                mirrorCopy([1,0,0]){
                    mirrorCopy([0,1,0]){
                        translate([cabinetDims.x/2, cabinetDims.y/2,0]){
                            cube([30,30,30], center=true);
                        }
                    }
                }
            }
        }
    }
}

module decks(){
    translate([0,0,0+(30/2)])deck();
    translate([0,0,deck1-100+(30/2)])deck();
    translate([0,0,deck2-100+(30/2)])deck();
    translate([0,0,cabinetDims.z-0-(30/2)]){
        deck(wood=false);
        translate([0,0,(30/2+5)]){
            color("saddlebrown"){
                cube([cabinetDims.x+30, cabinetDims.y+30, 10], center=true);
            }
        }
    }
}

module panel(zStart,zEnd){
    zHeight = zEnd - zStart - 30 ;
    color("lightblue",0.2){
        translate([cabinetDims.x/2,0,0+zStart+(zHeight/2)+(30/2)]){
                cube([5.5,cabinetDims.y-30,zHeight+(10*2)], center=true);
            }
        mirrorCopy([0,1,0]){
            translate([0,cabinetDims.y/2,0+zStart+(zHeight/2)+(30/2)]){
                cube([cabinetDims.x-30,5.5,zHeight+(10*2)], center=true);
            }
        }
    }
}
module panels(){
    panel(0+(30/2),deck1-100+(30/2));
    panel(0+(30/2),deck2-100+(30/2));
    panel(0+(30/2),cabinetDims.z-0+(30/2));
}

//printers();
frame();
decks();
panels();