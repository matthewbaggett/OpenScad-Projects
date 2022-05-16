use <../Lib/mattlib.scad>;
$fn=60;

module fanCutout92mm(depthForCaphead=3, recessNut=20, boltCutout=12){
    translate([0,0,-(25/2)])cube([92.6,92.6,25], center=true);


    mirrorCopy([0,1,0])mirrorCopy([1,0,0]){
        translate([82.5/2,82.5/2,-18+depthForCaphead-.5+1])
            //cylinder(h=30,d=4.3, center=true);
            metricCapheadAndBolt(4, 38, recessNut=recessNut, recessCap=22, chamfer=false);
        translate([82.5/2,82.5/2,+7])
            cylinder(d=8.5,h=10, center=true);
        translate([82.5/2,82.5/2,-43-5-10+2])
            cylinder(d=boltCutout,h=40, center=true);
    }
    
    slotDivisor=3;
    wallGap=5;
    
    translate([0,0,30/2]){
        difference(){
            union(){
                difference(){
                    cylinder(h=30,d=88.6, center=true);
                    cylinder(h=30+0.1,d=88.6-13, center=true);
                }
                difference(){
                    cylinder(h=30,d=88.6-20, center=true);
                    cylinder(h=30+0.1,d=88.6-33, center=true);
                }
                difference(){
                    cylinder(h=30,d=88.6-40, center=true);
                    cylinder(h=30+0.1,d=88.6-53, center=true);
                }
            }
            for(i = [1:slotDivisor]){
                rotate((180/slotDivisor)*i)cube([120,5,30+0.1], center=true);
            }
        }
        translate([0,0,-(30/2)+(2/2)])cylinder(h=2+0.1,d=88.6, center=true);
    }
}
//fanCutout92mm(); /*
rotate([0,180,0])difference(){
    translate([0,0,2.5])cube([92+5,92+5,9], center=true);
    fanCutout92mm();
}
/**/