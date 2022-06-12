use <Lib/mattlib.scad>
use <m93p_bracket.scad>
use <lenovo-45w-bracket.scad>
$fn = 30;
ikeaKallax = [335,385,335];
m93=[154+25,104.2+77.7,34.5];   // Dimensons of a Lenovo M93p SFF PC
lenovo_psu=[29.5,108,46.1];     // Dimensions of a Lenovo 45w PSU

moduleCount = 7;
interModuleOffset = (ikeaKallax.x/moduleCount-1)-m93.z;         // Gap between each node

module computerCutouts(){
    // CPU Units
    for(i = [-3:3]){
        translate([(m93.z+interModuleOffset)*-i,(-10*abs(i))-60,0])
            rotate([180,180,0])
                m93_body();
    }
}

square([ikeaKallax.x, ikeaKallax.y], center=true);
rotate([90,0,0])square([ikeaKallax.x, ikeaKallax.z], center=true);


#cube([ikeaKallax.x/8, ikeaKallax.y, ikeaKallax.z], center=true);
module slice(n=1){
    for (i = [0:moduleCount+1]){
        if(n==i){
        translate([
            (ikeaKallax.x/2)-((ikeaKallax.x/8)/2)-((ikeaKallax.x/8)*i),
            (ikeaKallax.y/2)-((ikeaKallax.y)/2),
            ikeaKallax.z/2
        ])
            color(i%2==1?"lightblue":"lightgreen")
                cube([ikeaKallax.x/8, ikeaKallax.y, ikeaKallax.z], center=true);
        }
    }
}


module boltCutouts(){
    mirrorCopy([0,0,1])
    for(i = [-3:3]){
        translate([(m93.z+interModuleOffset)*-i,(-10*abs(i))-50,0]){
            translate([0,-90,(ikeaKallax.z-30)/-2])
                rotate([0,90,0])
                    metricCapheadAndBolt(6, 20, recessCap=20, recessNut=20, recessNutIsCircleMM=true);
        }
    }
}

#slice(1);
#slice(3);
computerCutouts();
boltCutouts();
