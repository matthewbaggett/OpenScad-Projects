use <../Lib/mattlib.scad>;

module usbHeaderConnectorCutout(){
    distanceBetweenBolts = 30;

    mirrorCopy(){
        translate([distanceBetweenBolts/2,0,0]){
           translate([0,0,12-5.55])
                rotate([0,180,0])
                    metricCapheadAndBolt(3, 20, recessNut=0, recessCap=2, chamfer=false);
       }
    }
    hull(){
        mirrorCopy(){
            translate([distanceBetweenBolts/2,0,0]){
                translate([0,0,5])
                    cylinder(h=10,d=10, center=true);
                
            }
        }
        translate([0,0,5])cube([22,12,10], center=true);
        
    }
    translate([0,0,-5])cube([15,7,10+0.1], center=true);

}

usbHeaderConnectorCutout();
difference(){
    #hull()mirrorCopy()translate([15,0,0.5])cylinder(h=10,d=15, center=true);
    usbHeaderConnectorCutout();
}