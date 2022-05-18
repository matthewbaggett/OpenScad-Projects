use <../Lib/mattlib.scad>
module screenCutout(){
    color("green"){
        rotate([-5,0,0]){
            hull(){
                mirrorCopy(){
                    translate([86.5,-128,136.5])rotate([90,0,0])cylinder(d=15,h=1, center=true);
                    translate([86.5,-128,136.5+131.5])rotate([90,0,0])cylinder(d=15,h=1, center=true);
                }
                mirrorCopy(){
                    translate([74.25,-118,148.5])rotate([90,0,0])cylinder(d=13,h=1, center=true);
                    translate([74.25,-118,148.5+108.5])rotate([90,0,0])cylinder(d=13,h=1, center=true);
                }
            }
            hull(){
                mirrorCopy(){
                    translate([74.25,-118,148.5])rotate([90,0,0])cylinder(d=13,h=1, center=true);
                    translate([74.25,-118,148.5+108.5])rotate([90,0,0])cylinder(d=13,h=1, center=true);
                }
                mirrorCopy(){
                    translate([74.25,-114,148.5])rotate([90,0,0])cylinder(d=13,h=1, center=true);
                    translate([74.25,-114,148.5+108.5])rotate([90,0,0])cylinder(d=13,h=1, center=true);
                }
            }
        }
    }
}

module screenAperture(depth=0.1){
    translate([-(10/2)+3,-1.5-(depth/2),(13/2)-3])color("black")cube([175-10,depth,136-13], center=true);
}

lcdPanelAssemblyDims = [175,3,136];
module lcdPanelAssembly(){
        color("silver")cube(lcdPanelAssemblyDims, center=true);
        translate([-(10/2)+3,-1.5,(13/2)-3])color("black")cube([175-10,0.1,136-13], center=true);
        color("green")translate([0,11.5,0])cube([120,20+0.1,lcdPanelAssemblyDims.z*1.3], center=true);
    
}

module lcdPanelCutout(){
    rotate([-90,180,0]){
        lcdPanelAssembly();
        screenAperture(100);
    }

    mirrorCopy([1,0,0]){
        mirrorCopy([0,1,0]){
            translate([(lcdPanelAssemblyDims.x/2)+5,(lcdPanelAssemblyDims.z/2)+5,5.1]){
                rotate(90)
                    metricCapheadAndBolt(6, 11, recessNut=1, recessCap=20);
            }
        }
    }
}


lcdCutout_testFixture_radius = 8;

module lcdCutout_testFixture(){
    difference(){
        color("lightblue")
            translate([0,0,-0])
                hull(){
                    mirrorCopy([1,0,0]){
                        mirrorCopy([0,1,0]){
                            translate([((lcdPanelAssemblyDims.x+25)/2)-lcdCutout_testFixture_radius,((lcdPanelAssemblyDims.z+25)/2)-lcdCutout_testFixture_radius,0])
                                cylinder(h=17, r=lcdCutout_testFixture_radius, center=true);
                        }
                    }
                }

        lcdPanelCutout();
    }
}
//lcdCutout_testFixture();/*

/*translate([0,0,10]){
    difference(){
        lcdCutout_testFixture();
        translate([0,0,-25])
            cube([300,300,50], center=true);
    }
}
/**/
translate([0,0,-10]){
    difference(){
        lcdCutout_testFixture();
        translate([0,0,+25])
            cube([300,300,50], center=true);
    }
}
/**/