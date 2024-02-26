use <../Lib/mirrorcopy.scad>
use <../Lib/metric_bolts.scad>
module nema23_body(length=80){
    color("green"){
        // Body of motor
        linear_extrude(80)
            difference(){
                hull()
                    mirrorCopy([0,1,0],[1,0,0])
                        translate([(56.4-4)/2,(56.4-4)/2,0])
                           circle(d=4);
                mirrorCopy([0,1,0],[1,0,0])
                    translate([47.14/2,47.14/2,0])
                        circle(d=5.3);
            }
        // Snout
        translate([0,0,2/-2])cylinder(h=2, d=40, center=true);
        // Shaft
        translate([0,0,21/-2])cylinder(h=21,d=8, center=true);
    }
}
module nema23_fasteners(length){
    color("red")
        mirrorCopy([0,1,0],[1,0,0])
        translate([47.14/2,47.14/2,6-(length/2)])rotate([0,180,0])metricCapheadAndBolt(5, length);
}


nema23_body();
nema23_fasteners(length=40);