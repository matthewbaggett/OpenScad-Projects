
module selfTappingScrew(mSize=3, length=30, recessCap=0.1){
dk = mSize*2;
d = mSize;
    k = (1.86/3)*mSize;
    color("lightblue"){
        // Shaft
        cylinder(d=d, h=length, center=true);
        // Cap
        translate([0,0,(length-k)/2])
            cylinder(d2=dk,d1=d, h=k, center=true);
    }
    
    // Recess
    color("lightblue",0.2){
        if(recessCap){
            translate([0,0,(length+recessCap)/2])
                cylinder(d=dk,h=recessCap, center=true);
        }
    }
}

translate([0,0,0])selfTappingScrew(mSize=3, length=30);
translate([0,20,0])selfTappingScrew(mSize=5, length=20);
translate([0,40,0])selfTappingScrew(mSize=3, length=20, recessCap=10);
