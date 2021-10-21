use <Lib/mattlib.scad>
macMini = [7.7*25.4,7.7*25.4,36.1] + [2,2,2];
boltHoleDistance = 8;
strapSpacing = 40;
strapWidth = 22;
strapBoxHeight = 44;
boltMSize = 6;
/**/
rotate([0,180,0])
{
    difference(){
        union(){
            // Body Straps
            mirrorCopy([0,1,0])
                translate([0,strapSpacing*-1,0])
                    cube([macMini.x+(boltHoleDistance*4),strapWidth,strapBoxHeight], center=true);
            // Front Strap
            translate([0,(macMini.y/4)+(strapSpacing/1.5),0])
                cube([strapWidth,(macMini.y/2)-strapSpacing/2,strapBoxHeight], center=true);
            // Rear offset Strap
            translate([75,((macMini.y/4)+(strapSpacing/1.5))*-1,0])
                cube([strapWidth,(macMini.y/2)-strapSpacing/2,strapBoxHeight], center=true);
            mirrorCopy([1,0,0])
                translate([strapSpacing,0,0])
                    cube([strapWidth, (strapSpacing*2),strapBoxHeight], center=true);
        }
        union(){
            color("orange")
                translate([0,0,-3])
                    cube(macMini, center=true);

            // Body Straps Holes
            mirrorCopy([1,0,0])
            mirrorCopy([0,1,0]){
                translate([(macMini.x/2)+boltHoleDistance,strapSpacing,-29])
                    metricCapheadAndBolt(boltMSize, 20, recessCap=30, chamfer=true);
            }

            // Front Strap Hole
            translate([0,(macMini.y/2)+boltHoleDistance,-29])
                metricCapheadAndBolt(boltMSize, 20, recessCap=30, chamfer=true);
            
            // Rear offset strap  Hole
            translate([75,((macMini.y/2)+boltHoleDistance)*-1,-29])
                metricCapheadAndBolt(boltMSize, 20, recessCap=30, chamfer=true);
        }
    }
}
/**/
/*difference(){
    translate([0,0,-10])cylinder(h=50,d=30, $fn=360);
    metricCapheadAndBolt(boltMSize, 20, recessCap=30, recessNut=30, chamfer=true);
}/**/