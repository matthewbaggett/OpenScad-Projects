use <Lib/mattlib.scad>
use <m93p_bracket.scad>
use <lenovo-45w-bracket.scad>
$fn = 30;
ikeaKallax = [335,385,335];
m93=[154+25,104.2+77.7,34.5];   // Dimensons of a Lenovo M93p SFF PC
lenovo_psu=[29.5,108,46.1];     // Dimensions of a Lenovo 45w PSU

moduleCount = 7;
interModuleOffset = (335/moduleCount-1)-m93.z;         // Gap between each node
/*
#difference(){
    cube(ikeaKallax + [20,-0.1,20], center=true);
    cube(ikeaKallax, center=true);
}
/**/


module computerCutouts(){
    // CPU Units
    for(i = [-3:3]){
        translate([(m93.z+interModuleOffset)*-i,(-10*abs(i))-60,0])
            rotate([180,180,0])
                m93_body();
    }

mirrorCopy([0,0,1])
    for(i = [-3:3]){
        translate([(m93.z+interModuleOffset)*-i,(-10*abs(i))-60,-130]){
            translate([0,31,18+10]){
                rotate([90,0,0])
                    cylinder(h=200,d=10, center=true);
                translate([0,0,-3])
                    cube([10,200,6], center=true);
            }
            rotate([180,90,0]){
                lenovo_psu_body();
            }
        }
    }
}

module boltCutouts(){
    mirrorCopy([0,0,1])
    for(i = [-3:3]){
        translate([(m93.z+interModuleOffset)*-i,(-10*abs(i))-50,0]){
            translate([0,-90,(ikeaKallax.z-30)/-2])
                rotate([0,90,0])
                    #metricCapheadAndBolt(6, 40, recessCap=20, recessNut=20, recessNutIsCircleMM=true);
        }
    }
}

faciaDepth = 110;

difference(){
    translate([0,(ikeaKallax.y-faciaDepth)/-2,0])
        cube([ikeaKallax.x,faciaDepth, ikeaKallax.z], center=true);
    translate([0,-640+8,0])
        sphere(d=1000, $fn=30);

    computerCutouts();
    //boltCutouts();
}

