use <Lib/mattlib.scad>;

module strip_pro_300(){
    mirrorCopy([0,0,1]){
        translate([5,0,31/2]){
            difference(){
                cube([10,90,6], center=true);
                translate([2.5,0,-1.5]){
                    cube([5+0.01,90+0.01,3+0.01], center=true);
                }
            }
        }
    }

    difference(){
        cube([30,90,25], center=true);
        translate([-11,0,0]){
            translate([4,0,0]){
                rotate([90,0,0]){
                    scale([1.5,1,1]){
                        cylinder(h=90+0.01,d=2, center=true);
                    }
                }
            }
            cube([8+0.01,90+0.01,12], center=true);
        }
    }
}

module bolts(){
    rotate([0,90,0]){
        translate([0,0,0])metricCapheadAndBolt(5, 10, recessNut=0, recessCap=10, overrideCapSize=9.5);
        translate([0,-25,0])metricCapheadAndBolt(5, 10, recessNut=0, recessCap=10, overrideCapSize=9.5);
        translate([0,25,0])metricCapheadAndBolt(5, 10, recessNut=0, recessCap=10, overrideCapSize=9.5);
    }
}


/**/
difference(){
    hull(){
        translate([1.5,0,0]){
            hull(){
                mirrorCopy([0,1,0]){
                    translate([0,60/2,0])rotate([0,90,0])cylinder(h=3,d=45, center=true, $fn=360);
                }
            }
        }
        translate([32,0,0]){
            //cube([1,90,40], center=true);
            mirrorCopy([0,1,0]){
                translate([0,40/2,0])rotate([0,90,0])cylinder(h=1,d=40, center=true, $fn=360);
            }
        }
    }
    translate([20,0,0]){
        scale([1,2,1]){
            strip_pro_300();
        }
    }
    bolts();
}
/*
difference(){
    translate([-3-2,0,0]){
        hull(){
            mirrorCopy([0,1,0]){
                translate([0,60/2,0])rotate([0,90,0])cylinder(h=6,d=25, center=true, $fn=360);
            }
        }
    }
    bolts();
}
/**/
        
//color("orange")bolts();