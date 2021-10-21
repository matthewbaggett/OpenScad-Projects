use <Lib/mattlib.scad>;
$fn=60;
module boltHoleTester(){
    
    difference(){
        hull(){    
            translate([0,9,0])
            cylinder(h=33,d=18);
            translate([0,50,0])
            cylinder(h=33,d=18);
        }
        color("orange")
        translate([0,0,11.5])
            union(){
                translate([0,3+3,5-0.01])
                    metricCapheadAndBolt(3, 20, recessCap=5, recessNut=5, chamfer=false);
                translate([0,3+3+8,5-0.01])
                    metricCapheadAndBolt(4, 20, recessCap=5, recessNut=5, chamfer=false);
                translate([0,3+3+8+10,4-0.01])
                    metricCapheadAndBolt(5, 20, recessCap=5, recessNut=5, chamfer=false);
                translate([0,3+3+8+10+12,4-0.01])
                    metricCapheadAndBolt(6, 20, recessCap=5, recessNut=5, chamfer=false);
                translate([0,3+3+8+10+12+14,3-0.01])
                    metricCapheadAndBolt(8, 20, recessCap=5, recessNut=5, chamfer=false);
            }
    }
}
/**/
if(!$preview){
partSplitter(maxSize=200, height=33/2,top=true, bottom=true)
    boltHoleTester();
}else{
    boltHoleTester();
}
/**/