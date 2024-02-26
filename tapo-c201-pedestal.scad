use <Lib/mirrorcopy.scad>
use <Lib/metric_screws.scad>
$fn=120;
pedestalHeight = 100;
offsety = 0;
difference(){
    union(){
        difference(){
            translate([0,43.8/4+offsety,0])
                cube([6.7,43.8/2,1.3], center=true);
            translate([-3,43.8/4,-.75])
                rotate([0,10,0])
                    cube([6.7,43.8/2+1,1.3], center=true);
        }
        difference(){
            translate([0,-43.8/4-offsety,0])
                cube([6.7,43.8/2,1.3], center=true);
            translate([3,-43.8/4,-.75])
                rotate([0,-10,0])
                    cube([6.7,43.8/2+1,1.3], center=true);
        }

        //translate([0,0,-5+(1.3/2)])cylinder(d=29,h=10, center=true);

        translate([0,0,(pedestalHeight/-2)+.65])cylinder(d1=35,d2=28,h=pedestalHeight, center=true);

        difference(){
            hull(){
                mirrorCopy([1,1,0])
                    translate([15,15,-2.5+.65-pedestalHeight+5])cylinder(h=5,d=10,center=true);
                translate([0,0,(pedestalHeight*-1)+.65+2.5])cylinder(d1=35,d2=34.8,h=5, center=true);
            }
            
            mirrorCopy([1,0,0],[0,1,0])
                translate([15,15,-2.5+.65-pedestalHeight+5])
                    translate([0,0,-12.5])
                        selfTappingScrew(mSize=3, length=30,recessCap=2);
        }
    }
    translate([0,0,-100+5])cylinder(h=200,d1=30,d2=20, center=true);
    translate([10,0,-20])rotate([0,90,0])cylinder(d=14,h=14,center=true);
    translate([10,0,(pedestalHeight*-1)+20])rotate([0,90,0])cylinder(d=14,h=16,center=true);

}

color("green")translate([0,0,(pedestalHeight*-1)-2.5]){
    difference(){
        rotate([0,0,-45]){
            cube([6,55,5], center=true);
            translate([0,0,-2.5])cube([8,55,2.5], center=true);
        }
        mirrorCopy([1,0,0],[0,1,0])
                    translate([15,15,0])
                        translate([0,0,-12.5])
                            cylinder(h=20,d=2.5);
                            //selfTappingScrew(mSize=3, length=30,recessCap=2);
    }
}

            