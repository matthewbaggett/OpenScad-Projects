module metricBoltHex(mSize, structural=false, recessNut=0, chamfer=false){
    // Hex diameter = mSize * 1.8, (or 2.0 if structural
    // We add 1% to make the hex slip in better
    hexDiameter = mSize * (structural?2.0:1.8) * 1.01;

    translate([0,0,(mSize*0.7)/2])
    cylinder(d=hexDiameter,h=mSize * 0.7, $fn=6, center=true);
    
    if(recessNut > 0){
        translate([0,0,(recessNut/2)*-1])
        cylinder(d=mSize * (structural?2.0:1.8),h=recessNut, $fn=6, center=true);
    }
    if(chamfer){
        chamferHeight = mSize*1.5*0.595;
        translate([0,0,(mSize * 0.7)+(chamferHeight/2)])
        cylinder(d1=hexDiameter,d2=0,h=chamferHeight, center=true, $fn=6);
    }
}

module metricSocketCap(mSize, length, structural=false,recessCap=0, chamfer=false){
    //cap size = M number * 1.5.
    // We add 1% to make the cap head spin nicely in the hole.
    capSize = mSize * 1.5 * 1.01;

    translate([0,0,(length + ((mSize*1.25)/2))])
    cylinder(d=capSize,h=mSize*1.25, center=true, $fn=360);
    if(recessCap > 0){
        translate([0,0,(length + ((recessCap/2)+(mSize*1.25)))])
        cylinder(d=mSize*1.5,h=recessCap, center=true, $fn=360);
    }
    if(chamfer){
        translate([0,0,(length-((mSize*1.5*0.595)/2))])
        cylinder(d2=mSize*1.5,d1=0,h=mSize*1.5*0.595, center=true, $fn=360);
    }
}

module metricShaft(mSize, length, structural=false){
    translate([0,0,(length/2)])
    cylinder(d=mSize, h=length+0.01, center=true, $fn=360);
}

module metricSocketScrew(mSize, length, structural=false, recessCap=0, chamfer=false){
    metricSocketCap(mSize, length, structural=structural, recessCap=recessCap, chamfer=chamfer);
    metricShaft(mSize, length, structural=structural);
}

module metricCapheadAndBolt(mSize, length=40, structural=false, recessCap=0, recessNut=0, chamfer=false){
    echo (str("Creating a M",mSize, " size, ", length, "mm long caphead and bolt ", chamfer?"with":"without", " chamfering."));
    if(recessCap){
        echo (str("It has a ", recessCap, "mm recessed cap"));
    }
    if(recessNut){
        echo (str("It has a ", recessCap, "mm recessed nut"));
    }
    translate([0, 0, 0])
    metricSocketScrew(mSize, length, structural=structural, recessCap=recessCap, chamfer=chamfer);
    metricBoltHex(mSize,structural, recessNut=recessNut, chamfer=chamfer);
}


translate([0,0,0])
metricCapheadAndBolt(8, 40);
translate([10,0,0])
cylinder(h=40,d=1);
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