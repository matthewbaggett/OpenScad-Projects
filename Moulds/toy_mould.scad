model = "rad"; // [rad, david]
targetLengthMM = 190;
girthRatioPercentage = 65;
part = "part3"; // [all, part1, part2, part3]
renderForPrint = "yes"; // [yes, no]
boltIntervalMM = 50;
use <../Lib/mattlib.scad>;
hundredMMScaleDavid = 54.7;
hundredMMScaleRad = 2.74;
scaleFactorDavid = (targetLengthMM/100) * hundredMMScaleDavid;
scaleFactorRad = (targetLengthMM/100) * hundredMMScaleRad;
$fn = $preview?60:360;
mouldOverSize = 1.2;
module cavityShapeDavid(){
    scale(scaleFactorDavid)
        translate([0,0,0])
            rotate([90,0,0])
                import("david.stl");
}
module cavityShapeRad(){
    scale(scaleFactorRad)
        translate([0,58,-51.5])    
            rotate([36,0,180])
                import("rad-dong.stl");
}
module cavityShape(){
    if(model == "david"){
        cavityShapeDavid();
    }else if(model == "rad"){
        cavityShapeRad();
    }
}
//cavityShapeRad();#cavityShapeDavid();/*
mouldZOffset = targetLengthMM*-((mouldOverSize-1)/2)+((targetLengthMM*mouldOverSize)/2);
mouldHeight = targetLengthMM*mouldOverSize;
mouldDiameter = targetLengthMM*(girthRatioPercentage/100);
echo(str("Mould is ",mouldHeight,"mm tall x ",mouldDiameter,"mm wide"));
module arrow(){
    scale([1.5,1.5,1]){
        translate([+5,0,0])cylinder(h=5, d=20, $fn=3, center=true);
        translate([-5,0,0])cube([10+0.01,5,5], center=true);
    }
}

module gasket(){
    for(i=[-1:0]){
        rotate(i*120+180)
            translate([
                (mouldDiameter/-2)+(mouldDiameter*.1),
                0,
                (mouldHeight*-.085)+(mouldHeight*.93)
            ])
                rotate([90,90,0])
                    o_ring_groove(
                        length=(mouldDiameter*.5), 
                        height=mouldHeight
                    );
    }
}

module mouldBody(rotation){
    difference(){
        hull(){
            translate([0,0,mouldZOffset])
                cylinder(h=mouldHeight, d=mouldDiameter, center=true);
            rotate(rotation){
                translate([-(mouldDiameter/2)*1.3,0,mouldZOffset])
                    cube([1,mouldDiameter/2,mouldHeight*0.8], center=true);
            }
        };
        translate([0,0,mouldHeight*.925])scale([targetLengthMM/100,targetLengthMM/100,1])arrow();    
    }
    
}

cutoutCubeSize = targetLengthMM*mouldOverSize*1.1;
module slicePortion(){
    translate([0,cutoutCubeSize/2,mouldZOffset])
        cube([cutoutCubeSize,cutoutCubeSize,cutoutCubeSize], center=true);
}
module slicer(){
    rotate(0)slicePortion();
    rotate(60)slicePortion();
}

module bolts(){
    boltTotal_onZ = floor(mouldHeight/boltIntervalMM); 
    boltTotal_onY = floor(mouldDiameter/boltIntervalMM);
    echo(str("BoltTotalOnY: ", boltTotal_onY));
    rotate(30)
    union()
        for(r = [0:2])
            rotate(r*120)
                for(i = [0:boltTotal_onZ])
                    translate([0,(mouldDiameter/2)-7,i*((mouldHeight-(mouldHeight*0.2))/boltTotal_onZ)])
                        rotate([0,90,0])
                            metricCapheadAndBolt(6, 20, recessNut=cutoutCubeSize/4, recessCap=cutoutCubeSize/4, recessNutIsCircleMM=true);
    union()            
        for(r = [0:2])
            rotate(r*120)
                rotate([90,90,0])
                    for(d = [0:boltTotal_onY-1])
                        translate([(mouldHeight*-0.88),(d+0.5)*((mouldDiameter/2)/boltTotal_onY),0])
                            metricCapheadAndBolt(6, 20, recessNut=cutoutCubeSize/4, recessCap=cutoutCubeSize/4, recessNutIsCircleMM=true);
    
}

module mouldFillHole(){
    translate([0,0,0])
        cylinder(h=mouldHeight*.2,d=15, center=true);
}
//#mouldFillHole();

module wholeThing(rotation=0){
    difference(){
        mouldBody(rotation);
        cavityShape();
        bolts();
        mouldFillHole();
    }
}

module part1(){
    difference(){
        wholeThing(120);
        rotate(0){
            slicer();
            gasket();
        }
    }
    
}
module part2(){
    difference(){
        wholeThing(-120);
        rotate(120){
            slicer();
            gasket();
        }
    }
}
module part3(){
    difference(){
        wholeThing(0);
        rotate(-120){
            slicer();
            gasket();
        }
    }
}
  
if(renderForPrint=="yes"){
    translate([0,0,targetLengthMM*1.1]){
        rotate([0,180,0]){
            if(part=="part1" || part=="all"){
                color("pink")
                    translate([mouldDiameter,0,mouldDiameter])
                        rotate([-90,-30,0])
                            part1();
            }
            if(part=="part2" || part=="all"){
                color("lightgreen")
                    translate([0,0,mouldDiameter])
                        rotate([-90,-30-120,0])
                            part2();
            }
            if(part=="part3" || part=="all"){
                color("lightblue")
                    translate([-mouldDiameter,0,mouldDiameter])
                        rotate([-90,-30+120,0])
                            part3(); 
            }
        }
    }
}else{
    translate([0,0,targetLengthMM*1.1])rotate([0,0,0]){
        if(part=="part1" || part=="all"){
            color("pink")part1();
        }
        if(part=="part2" || part=="all"){
            color("lightgreen")part2();
        }
        if(part=="part3" || part=="all"){
            color("lightblue")part3(); 
        }
    }
}
/**/