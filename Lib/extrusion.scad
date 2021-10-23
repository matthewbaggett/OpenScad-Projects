use <mirrorcopy.scad>
module doubleExtrusion(width,length){
    extraWallWidth = width*0.09;
    mirrorCopy([0,1,0]){
        color("orange")
        translate([0,(width - extraWallWidth)/2,length/2])
        cube([width/2,extraWallWidth,length], center=true);
    }
    translate([(width/2),0,0])
    children();
    translate([(width/2)*-1,0,0])
    children();
}

module extrusion(length=10, outer=40, tSlot=8, gusset=4.5, bore=7){
    translate([0,0,length/2])
    difference(){
        color("orange")
        union(){
            // Corners
            mirrorCopy([1,0,0]){
                mirrorCopy([0,1,0]){
                    difference(){
                        union(){
                            translate([((outer-(outer-tSlot)/2)/2),(outer-(gusset))/2,0])
                            cube([(outer-tSlot)/2, (gusset),length], center=true);
                            mirror([-1,1,0])
                            translate([((outer-(outer-tSlot)/2)/2),(outer-(gusset))/2,0])
                            cube([(outer-tSlot)/2, (gusset),length], center=true);
                        }
                        difference(){
                            translate([((outer-(gusset))/2)+1,((outer-(gusset))/2)+1,0])
                                cube([gusset*2,gusset*2,length+2], center=true);
                            translate([(outer-(gusset*2))/2,(outer-(gusset*2))/2,0])
                                cylinder(d=gusset*2,h=length+4, center=true);
                        }
                    }
                }
            }
            
            // Crossbar
            mirrorCopy(){
                rotate(45)
                cube([outer*1.3, gusset, length], center=true);
            }
            
            // Core
            cube([bore*2,bore*2,length], center=true);
        };
        
        union(){
            // Tappable Bore
            cylinder(d=bore, h=length+2, center=true);
        }
    }
}

module extrusion80x40(length){
    doubleExtrusion(40,length)
    extrusion40x40(length);
}
module extrusion60x30(length){
    doubleExtrusion(30,length)
    extrusion30x30(length);
}
module extrusion40x20(length){
    doubleExtrusion(20,length)
    extrusion20x20(length);
}

module extrusion20x20(length)
{
    extrusion(length=length, outer=20,tSlot=5, gusset=1.8, bore=4);
}

module extrusion30x30(length)
{
    extrusion(length=length, outer=30,tSlot=8, gusset=2.5, bore=7);
}

module extrusion40x40(length)
{
    extrusion(length=length, outer=40,tSlot=8, gusset=4.5, bore=7);
}
/**/
translate([0,0,0])extrusion20x20(10);
translate([0,30,0])extrusion30x30(10);
translate([0,30+40,0])extrusion40x40(10);

translate([40,0,0])extrusion40x20(10);
translate([60,30,0])extrusion60x30(10);
translate([80,30+40,0])extrusion80x40(10);
/**/