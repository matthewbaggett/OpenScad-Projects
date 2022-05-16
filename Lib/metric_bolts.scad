capSizeMSizeMultiplier = 1.66*1.01;
printingKerfMM = 0.6;
circleFacets = 60;
boltColour = "LightSkyBlue";
boltClearanceColour = "LightSteelBlue";
boltClearanceTransparency = 0.3;

module metricBoltHex(mSize, structural=false, recessNut=0, recessNutIsCircleMM=false, chamfer=false){
    // Hex diameter = mSize * 1.8, (or 2.0 if structural
    // We add 1% to make the hex slip in better
    hexDiameter = (mSize * (structural?2.0:1.8) * 1.01) + printingKerfMM;

    color(boltColour)
    translate([0,0,(mSize*0.7)/2])
    cylinder(d=hexDiameter,h=mSize * 0.7, $fn=6, center=true);
    
    if(recessNut > 0){
        if(recessNutIsCircleMM==false){
            color(boltClearanceColour, boltClearanceTransparency)
                translate([0,0,(recessNut/2)*-1+0.1])
                    cylinder(d=hexDiameter,h=recessNut+0.1, $fn=6, center=true);
        }else{
            color(boltClearanceColour, boltClearanceTransparency)
                translate([0,0,(recessNut/2)*-1+0.1])
                    cylinder(d=recessNutIsCircleMM>hexDiameter?recessNutIsCircleMM:hexDiameter,h=recessNut+0.1, $fn=circleFacets, center=true);
        }
    }
    if(chamfer){
        chamferHeight = mSize*1.5*0.595;
        color(boltClearanceColour, boltClearanceTransparency)
            translate([0,0,(mSize * 0.7)+(chamferHeight/2)])
                cylinder(d1=hexDiameter,d2=0,h=chamferHeight, center=true, $fn=6);
    }
}

module metricSocketCap(mSize, length, structural=false,recessCap=0, chamfer=false, overrideCapSize=0){
    //cap size = M number * 1.5.
    // We add 1% to make the cap head spin nicely in the hole.
    capSize = overrideCapSize > 0 ? overrideCapSize : (mSize * capSizeMSizeMultiplier) + printingKerfMM;
    
    color(boltColour)
        translate([0,0,(length + ((mSize*1.25)/2))])
            cylinder(d=capSize,h=mSize*1.25, center=true, $fn=circleFacets);
    //echo (str("cap size is ", capSize));
    if(recessCap > 0){
        color(boltClearanceColour, boltClearanceTransparency)
        translate([0,0,(length + ((recessCap/2)+(mSize*1.25)))])
        cylinder(d=capSize,h=recessCap, center=true, $fn=circleFacets);
    }
    if(chamfer){
        color(boltClearanceColour, boltClearanceTransparency)
        translate([0,0,(length-((mSize*1.5*0.595)/2))])
        cylinder(d2=capSize,d1=0,h=mSize*1.5*0.595, center=true, $fn=circleFacets);
    }
}

module metricShaft(mSize, length, structural=false){
    color(boltColour)
        translate([0,0,(length/2)])
            cylinder(d=mSize+printingKerfMM, h=length+0.01, center=true, $fn=circleFacets);
}

module metricSocketScrew(mSize, length, structural=false, recessCap=0, chamfer=false, overrideCapSize=0){
    metricSocketCap(mSize, length, structural=structural, recessCap=recessCap, chamfer=chamfer, overrideCapSize=overrideCapSize);
    metricShaft(mSize, length, structural=structural);
}

module metricCapheadAndBolt(mSize, length=40, structural=false, recessCap=0, recessNut=0, recessNutIsCircleMM=false, chamfer=false, overrideCapSize=0){
    capSize = overrideCapSize > 0 ? overrideCapSize : (mSize * capSizeMSizeMultiplier) + printingKerfMM;

    /*echo (str("Creating a M",mSize, " size, ", length, "mm long bolt with a ", capSize, "mm wide caphead and bolt ", chamfer?"with":"without", " chamfering."));
    if(recessCap){
        echo (str("It has a ", recessCap, "mm recessed cap"));
    }
    if(recessNut){
        echo (str("It has a ", recessCap, "mm recessed nut"));
    }/**/
    translate([0,0,((length/2)+((mSize*1.25)/2))*-1])
    union(){
        translate([0, 0, 0])
        metricSocketScrew(mSize, length, structural=structural, recessCap=recessCap, chamfer=chamfer, overrideCapSize=overrideCapSize);
        metricBoltHex(mSize,structural, recessNut=recessNut, recessNutIsCircleMM=recessNutIsCircleMM, chamfer=chamfer);
    }
}

/**/
translate([0,10,0])
metricCapheadAndBolt(6, 40);

translate([0,10,0])
metricCapheadAndBolt(6, 40, recessNut=20, recessNutIsCircleMM=20);

translate([20,10,0])
metricCapheadAndBolt(6, 40, recessNut=1, recessCap=1, chamfer=true);
/**/
/*
translate([0,10,0])
metricCapheadAndBolt(6, 20, recessNut=10, recessCap=10);
/*
translate([0,20,0])
metricCapheadAndBolt(6, 20, chamfer=true);

translate([20,0,0])
metricCapheadAndBolt(10, 40);

translate([20,20,0])
metricCapheadAndBolt(10, 40, recessNut=10, recessCap=10);

translate([20,40,0])
metricCapheadAndBolt(10, 40, chamfer=true);
*/