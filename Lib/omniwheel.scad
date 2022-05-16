use <../Lib/metric_bolts.scad>;
use <../Lib/bearings.scad>;
use <../Lib/mirrorcopy.scad>;
rollerLength = 32;
rollerProfile=[17,25,25,25,25,24,23,19];
hubWidth=35;
handedness="left"; // [left, right]
rollerClearanceMM = 4;
part = "all"; //[roller, hub, all]

function select(vector, indices) = [ for (index = indices) vector[index] ];
$fn=120;
subAssemblyPivotAngle = 45;
subAssemblyCount = 8;


internalSubAssemblyPivotAngle = subAssemblyPivotAngle * (handedness=="left"?1:-1);




module roller(profile, length, padding=0){
    union(){
        for(index = [0:len(profile)-1]){
            spacing = length / len(profile);
            diameter = profile[index];
            hull(){
                translate([0,0,spacing*index])
                    cylinder(h=0.1, d=diameter+padding);
                if(profile[index+1]){
                    translate([0,0,spacing*(index+1)])
                        cylinder(h=0.1, d=profile[index+1]+padding);
                }
            }
        }
    }
}



module singleRotationalAssembly(profile, length, padding=0,withOrWithoutBearing="without"){
    echo(str("Profile=", profile, " Length=", length, " Padding=", padding, withOrWithoutBearing=="with"? " including":" excluding", " the bearing + shaft"));
    if(withOrWithoutBearing == "with"){
        mirrorCopy()
            rotate([0,-90,0])
                translate([0,0,6/2])
                    roller(profile=profile, length=length, padding=padding);
        rotate([0,90,0]){
            metricCapheadAndBolt(6, 40, recessNut=0, recessCap=0, chamfer=false);
            bearing_626(labels=false);
        }
    }else{
        difference(){
            mirrorCopy()
                rotate([0,-90,0])
                    translate([0,0,6/2])
                        roller(profile=profile, length=length, padding=padding);
            rotate([0,90,0]){
                metricCapheadAndBolt(6, 40, recessNut=100, recessCap=100, chamfer=false);
                bearing_626(labels=false);
            }
        }
    }
}
    
module rotationalAssembly(outerDiameterMM, padding=0,withOrWithoutBearing="without"){
    centerOfRotationalAssemblyHubsFromCenterOfWheel = (outerDiameterMM/2)-(max(rollerProfile)/2);

    for(i = [1:subAssemblyCount]){
        rotate([360/subAssemblyCount*i,0,0]){
            rotate([0,0,internalSubAssemblyPivotAngle]){
                translate([0,0,centerOfRotationalAssemblyHubsFromCenterOfWheel]){
                    singleRotationalAssembly(rollerProfile, rollerLength, padding, withOrWithoutBearing=withOrWithoutBearing);
                }
            }
        }
    }
}


module hubAssemblyRawShape(outerDiameterMM){
    centerOfRotationalAssemblyHubsFromCenterOfWheel = (outerDiameterMM/2)-(max(rollerProfile)/2);

    difference(){
        hull(){
            translate([0,0,centerOfRotationalAssemblyHubsFromCenterOfWheel])
                rotate([0,90,internalSubAssemblyPivotAngle])
                    cylinder(h=6,d=max(rollerProfile)-1.5, center=true);
            rotate([0,90,0])
                cylinder(h=hubWidth,d=outerDiameterMM/2, center=true);
        }
    }
}

module hubAssembly(outerDiameterMM){
    difference(){
        union(){
            for(i = [1:subAssemblyCount]){
                rotate([360/subAssemblyCount*i,0,0])
                    hubAssemblyRawShape(outerDiameterMM);
            }
        }
        rotationalAssembly(outerDiameterMM,padding=rollerClearanceMM, withOrWithoutBearing="with");
    }
}

module omniwheel(outerDiameterMM=120){
    color("lightblue")hubAssembly(outerDiameterMM);
    color("lightgreen")rotationalAssembly(outerDiameterMM);
    // Outline limit
    if($preview){
        color("lightblue",0.1){
            rotate([0,90,0]){
                difference(){
                    cylinder(h=0.1,d=outerDiameterMM, center=true);
                    cylinder(h=0.1+0.1,d=outerDiameterMM-1, center=true);
                }
            }
        }
    }

}

if(part=="all"){
    omniwheel(outerDiameterMM=120);
}else if(part == "hub"){
    part_omniwheel_hub(outerDiameterMM=120);

}else if(part == "roller"){
    part_rollers(outerDiameterMM=120);
}

module part_omniwheel_hub(outerDiameterMM){
    color("lightblue")hubAssembly(outerDiameterMM);
}
module part_rollers(outerDiameterMM){
    //rotationalAssembly(outerDiameterMM=outerDiameterMM);
    difference(){
        union(){
            rotate([0,90,0])
                translate([0,max(rollerProfile),0])
                    singleRotationalAssembly(profile=rollerProfile, length=rollerLength);
            rotate([0,-90,0])
                translate([0,-max(rollerProfile),0])
                    singleRotationalAssembly(profile=rollerProfile, length=rollerLength);
        }
        translate([0,0,(rollerLength+1)/-2])
            cube([max(rollerProfile),max(rollerProfile)*3,rollerLength+1], center=true);
    }
}