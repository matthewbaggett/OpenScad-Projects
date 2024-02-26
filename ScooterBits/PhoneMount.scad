use <../Lib/mirrorcopy.scad>
$fn=30;
module screw(){
    translate([0,-21+30,0+1]){
        hull(){
            translate([0,0,-15+0.01])cylinder(h=30, d=6.2, center=true);
            translate([0,15.4-14,-15+0.01])cylinder(h=30, d=6.2, center=true);
        }
        hull(){
            translate([0,0,(100/2)-0.01])cylinder(h=100, d=16, center=true);
            translate([0,15.4-14,(100/2)-0.01])cylinder(h=100, d=16, center=true);
        }
    }
}
module holes(){
    screw();
}
module mount(){
    translate([0,-21+30,2.35/-2]){
            hull(){
                cylinder(d=14,h=2.35, center=true);
                translate([0,15.4-14,0])
                    cylinder(d=14,h=2.35, center=true);
            }
        }

    hull(){
        color("orange")hull(){
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
    translate([0,5,30])sphere(15);    
}

module platform(){
    hull(){
        #translate([0,40,80])rotate([90+10,0,0])hull(){
            mirrorCopy([1,0,0])mirrorCopy([0,1,0]){
                translate([25,25,0])cylinder(h=5, d=20, center=true);
            }
        }
        joinball();
    }
}
module plastic(){
    platform();
    mount();
}


difference(){
    plastic();
    holes();
}

