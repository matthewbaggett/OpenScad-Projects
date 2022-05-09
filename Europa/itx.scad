use <../Lib/mattlib.scad>;

module itx(){
    color("lightgreen",0.5){
        translate([0,0,(5/2)+(1/2)+3.25]){
            #difference(){
                cube([170,170,1.5], center=true);
                translate([-170/2,170/2]){
                    // Hole C
                    translate([6.35,-10.16,0]){
                        cylinder(h=10, d=3.96, $fn=60, center=true);
                    }
                    // Hole F
                    translate([6.35+157.48,-10.16-22.86,0]){
                        cylinder(h=10, d=3.96, $fn=60, center=true);
                    }
                    // Hole H
                    translate([6.35,-10.16-154.94,0]){
                        cylinder(h=10, d=3.96, $fn=60, center=true);
                    }
                    // Hole J
                    translate([6.35+157.48,-10.16-154.94,0]){
                        cylinder(h=10, d=3.96, $fn=60, center=true);
                    }
                }
                linear_extrude(1+0.1){
                    text("ITX Board", font = "Liberation Sans:style=Bold Italic", valign="center", halign="center");
                }
            }
            // rear IO keepout
            color("red")
            translate([-170/2,170/2])
                translate([6.35+7.52+158.75/2,25,29.225-3.81-5])
                    cube([158.75,50,44.45], center=true);
            
            // heatsink
            color("lightgrey")
                translate([-(170/2)+(90/2)+16,-(170/2)+(90/2)+6.5,36/2+(1.5/2)])
                    cube([90,90,36], center=true);
        }
    }
}

module itxHoles(){
    translate([-170/2,170/2]){
        // Hole C
        translate([6.35,-10.16,0]){
            cylinder(h=20, d=3.96, $fn=60, center=true);
        }
        // Hole F
        translate([6.35+157.48,-10.16-22.86,0]){
            cylinder(h=20, d=3.96, $fn=60, center=true);
        }
        // Hole H
        translate([6.35,-10.16-154.94,0]){
            cylinder(h=20, d=3.96, $fn=60, center=true);
        }
        // Hole J
        translate([6.35+157.48,-10.16-154.94,0]){
            cylinder(h=20, d=3.96, $fn=60, center=true);
        }
    }
}

module itxM3Bolts(){
    translate([-170/2,170/2]){
        // Hole C
        translate([6.35,-10.16,0]){
            rotate([0,180,0])metricCapheadAndBolt(3, 20, recessNut=0, recessCap=10, chamfer=false);
        }
        // Hole F
        translate([6.35+157.48,-10.16-22.86,0]){
            rotate([0,180,0])metricCapheadAndBolt(3, 20, recessNut=0, recessCap=10, chamfer=false);
        }
        // Hole H
        translate([6.35,-10.16-154.94,0]){
            rotate([0,180,0])metricCapheadAndBolt(3, 20, recessNut=0, recessCap=10, chamfer=false);
        }
        // Hole J
        translate([6.35+157.48,-10.16-154.94,0]){
            rotate([0,180,0])metricCapheadAndBolt(3, 20, recessNut=0, recessCap=10, chamfer=false);
        }
    }
}

module itxStandoffs(){
    translate([-170/2,170/2,4]){
        // Hole C
        translate([6.35,-10.16,0]){
            cylinder(h=3, d=10, $fn=60, center=true);
        }
        // Hole F
        translate([6.35+157.48,-10.16-22.86,0]){
            cylinder(h=3, d=10, $fn=60, center=true);
        }
        // Hole H
        translate([6.35,-10.16-154.94,0]){
            cylinder(h=3, d=10, $fn=60, center=true);
        }
        // Hole J
        translate([6.35+157.48,-10.16-154.94,0]){
            cylinder(h=3, d=10, $fn=60, center=true);
        }
    }
}

module itxBackplate(){
    difference(){
        union(){
            hull(){
                mirrorCopy([0,1,0]){
                    mirrorCopy([1,0,0]){
                        translate([(180/2)-(10/2),(180/2)-(10/2),0]){
                            cylinder(h=5, d=10, center=true);
                        }
                    }
                }
                translate([69,50,0])cube([30,20,5], center=true);
            }
            itxStandoffs();
        }
        
        itxHoles();
        
        // Decorative plastic savers
        mirrorCopy([1,-1,0]){
            mirrorCopy([1,1,0]){
                hull(){
                    translate([50,-75,0])cylinder(h=20,d=10, center=true);
                    translate([-50,-69,0])cylinder(h=20,d=10,center=true);
                    translate([0,-15,0])cylinder(h=20,d=10,center=true);
                }
            }
        }
    }
}

//itx();
itxHoles();
itxM3Bolts();
    
//itxBackplate();