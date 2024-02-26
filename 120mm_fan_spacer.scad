cornerRadius = 20;
$fn=$preview?60:120;
use <Lib/mirrorcopy.scad>;
bevelOffset=49;
module 120mmSpacer(){
    difference(){
        hull(){
            mirrorCopy([1,0,0],[0,1,0]){
                translate([(120-cornerRadius)/2,(120-cornerRadius)/2,0]){
                    cylinder(h=1, d=cornerRadius, center=true);
                }
            }
        }
        cylinder(h=1.1, d=120-4, center=true);
        
        color("green"){
            mirrorCopy([1,0,0],[0,1,0]){
                difference(){
                    translate([bevelOffset-5,bevelOffset-5,0])
                        cylinder(h=1.1,d=10, center=true);
                    translate([bevelOffset,bevelOffset,0])
                        cylinder(h=1.2,d=10, center=true);
                }
            }
        }
        color("purple"){
            mirrorCopy([1,1,0])hull()mirrorCopy([1,0,0],[0,1,0]){
                translate([((120-10)/2)-4-12, ((120-10)/2)-4, 0]){
                    cylinder(h=1.1, d=10, center=true);
                }
            }
        }

        color("red"){
            mirrorCopy([1,0,0],[0,1,0]){
                translate([(105/2), (105/2), 0]){
                    cylinder(h=1.1,d=4.5, center=true);
                }
            }
        }
    }

}

120mmSpacer();
