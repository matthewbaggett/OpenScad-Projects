use <Lib/mattlib.scad>;
$fn=120;
arc = 144+35-3;
pcbWidth = 202;
difference(){
    union(){
        difference(){
            circle(r=arc);
            translate([0,(144)/2,0])color("red")square([500,(144)*1], center=true);
            translate([0,-250,0])color("red")square([500,500], center=true);
        }
        translate([0,144/2,0]){
            square([pcbWidth,144], center=true);
        }
    }

    translate([(pcbWidth-8.5)/2,56+(40/2),0])square([8.5+0.01,40], center=true);
    translate([(pcbWidth-8.5)/-2,17.7+(78/2),0])square([8.5+0.01,78], center=true);

    // display "puck" holes
    puckHoles = 5.8;
    puckHolesGap = 44.5+puckHoles;
    translate([0,3.5+(puckHoles/2)+(puckHolesGap/2),0]){
        mirrorCopy([1,0,0]){
            mirrorCopy([0,1,0]){
                translate([puckHolesGap/2,puckHolesGap/2,0]){
                    circle(d=puckHoles);
                }
            }
        }
    }

    pcbScrewHole = 3.0;
    mirrorCopy()
        translate([((pcbWidth-pcbScrewHole)/2)-19,5+pcbScrewHole/2,0])
            circle(d=pcbScrewHole);

    translate([((pcbWidth-pcbScrewHole)/2)-25.6,143+pcbScrewHole/2,0])
        circle(d=pcbScrewHole);

    translate([0,125+(pcbScrewHole/2),0])
        circle(d=pcbScrewHole);

    translate([(pcbWidth/-2)+7.1+(pcbScrewHole/2),113+(pcbScrewHole/2),0])
        circle(d=pcbScrewHole);

    mirrorCopy()
        translate([146/2,79.3+puckHoles,0])
            circle(d=puckHoles);

    mirrorCopy()
        translate([54.1/2,156+puckHoles,0])
            circle(d=puckHoles);
}