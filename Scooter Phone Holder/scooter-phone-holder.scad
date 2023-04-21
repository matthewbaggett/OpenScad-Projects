mountOffset= [0,12,0];
angleOfTheDangle=41;
cradleOffset = [0,70,90];

use <../Lib/mirrorcopy.scad>
$fn=$preview?30:60;

//color("green")translate([-3.5,0,0])import("Backpack_for_Titan_-_large_slits.stl");

module titan(){
    color("salmon")
    translate([0,11,0])
        hull(){
            translate([0,0,2.5])
                cube([79,150,1], center=true);
            translate([0,0,2.5+8+.5])
                cube([93,150,8], center=true);
            translate([0,0,18.5])
                cube([85,150,1], center=true);
            translate([0,-66.5-10,2.5+8])
                cube([57,1.1,17], center=true);    
        }
        translate([0,-66-5,2.5+8])
                cube([57,10,17], center=true);    
}

//titan();
radius=5;
module clamshell_body(){
    hull(){
        mirrorCopy(){
            translate([48.5+1-radius,-27,19-radius])
                rotate([90,0,0])
                    cylinder(h=80,r=radius, center=true);
            translate([48.5+1-radius/2,-27,0+radius/2])
                cube([radius, 80, radius], center=true);
                    //cylinder(h=80,r=radius, center=true);
        }
    }
}


module clamshell_back(){
    hull(){
        mirrorCopy(){
            translate([30.5,68,1])cylinder(h=2, r=radius, center=true);
            translate([43.5+1,13,1])cylinder(h=2, r=radius, center=true);
            translate([43.5+1,-62,1])cube([radius*2,radius*2,2], center=true);
        }
    }
}

module clamshell(){
    difference(){
        union(){
            clamshell_body();
            clamshell_back();
        }
        titan();
    }
}

    
module screw(){
    translate([0,-21+30,0+1]){
        hull(){
            translate([0,0,-5+0.01])cylinder(h=30, d=6.2, center=true);
            translate([0,15.4-14,-5+0.01])cylinder(h=30, d=6.2, center=true);
        }
        translate([0,0,3]){
            #hull(){
                translate([0,0,0-0.01])cylinder(h=1, d=16, center=true);
                translate([0,-17,150-0.01])cylinder(h=1, d=30, center=true);
                translate([0,15.4-14,0-0.01])cylinder(h=1, d=16, center=true);
                translate([0,-17+15.4-14,150-0.01])cylinder(h=1, d=30, center=true);
            }
            
        }
    }
}

module holes(){
    translate(mountOffset)
        screw();
    rotate([-18.7,0,0])
        translate([0,57.31,125.0635])
            cube([100,30,30], center=true);
    translate(cradleOffset)rotate([-90+angleOfTheDangle,0,0]){
        translate([0,-10,+2.5]){
            color("green")
                qi_charger();
        }
    }
}

module mount(){
    translate(mountOffset)translate([0,-21+30,2.35/-2]){
            hull(){
                cylinder(d=14,h=2.35, center=true);
                translate([0,15.4-14,0])
                    cylinder(d=14,h=2.35, center=true);
            }
        }

    hull(){
        translate(mountOffset)color("orange")hull(){
            translate([0,-12.2,0])cylinder(d=31.2,h=2, center=true);
            translate([0,13.75,0])cylinder(d=28,  h=2, center=true);

            mirrorCopy(){
                translate([(33-10)/2,1.5,0])
                cylinder(d=10, h=2, center=true);
            }
        }
        
        joinball();
    }
}


module joinball(){
    translate([0,5,30]){
        sphere(23);    
        translate([0,15,0])
            sphere(23);    
    }
}

module platform(){
    color("pink")translate(cradleOffset)rotate([-90+angleOfTheDangle,0,0]){
        translate([0,-10,+2.5]){
            clamshell();
        }
    }
    hull(){
        translate(cradleOffset)rotate([-90+angleOfTheDangle,0,0]){
            translate([0,-10,+2.5])
                color("blue")clamshell_back();
        }
        joinball();
    }
    /*hull(){
        #translate([0,40,80])rotate([90+25,0,0])hull(){
            mirrorCopy([1,0,0])mirrorCopy([0,1,0]){
                translate([25,25,0])cylinder(h=5, d=20, center=true);
            }
        }
        joinball();
    }*/
}
module plastic(){
    platform();
    mount();
}


module flattener(){
    translate([0,-21.5,100])rotate([.7,0,0])cube([100,10,210], center=true);
}
module sectioner(){
    translate([50,30,100])cube([100,100,210], center=true);
}


module scooter_mount(){
    translate([0,-6,28])rotate([90+18.7,0,0])difference(){
        plastic();
        //qi_charger();
        holes();
        //flattener();
        //scale($preview?1:0)sectioner();
    }
}

module qi_charger(){
    translate([0,-22,-3]){
        translate([0,0,4])
            cylinder(d=60,h=2.01, center=true);
        cylinder(d=56,h=6, center=true);
        translate([0,-50,-3])
            rotate([90+10,0,0])
                hull()
                    mirrorCopy()
                        translate([2.5,0,0])
                            cylinder(d=6.5,h=50, center=true);
        
        //translate([0,-50,0])
        //    cube([11,50,6], center=true);
    }
}
//scooter_mount();
//clamshell();
difference(){
    translate([0,-22,-3]){
        hull()mirrorCopy([0,1,0])mirrorCopy([1,0,0])translate([40-(20/2),40-(20/2),0])cylinder(d=20, h=10, center=true);
    }
    #qi_charger();
    
}

translate([100,-22,0])cylinder(d=60,h=2, center=true);