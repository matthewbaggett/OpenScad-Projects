use <Lib/mattlib.scad>;
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


mirrorCopy([0,1,0]){
translate([270,275,200-50-10])extrusion40x20(500, center=true);
translate([-270,275,200-50-10])extrusion40x20(500, center=true);
}

translate([0,0,370]){
    anycubicChiron(chiron = [530,630,320]);
}
translate([0,0,0]){
    anycubicChiron(chiron = [530,630,320]);
}

