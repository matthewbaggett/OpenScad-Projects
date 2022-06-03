
upsFootprint = [98,300,150];

barThickness = 22.5;

module bars(){
    translate([-110,0,(barThickness/-2)-5])rotate(45){
        cube([600,barThickness,barThickness], center=true);
        rotate(90)cube([600,barThickness,barThickness], center=true);
    }
}

//bars();

difference(){
    translate([0,0,-2.5])cube([upsFootprint.x,upsFootprint.y,15]+[10,10,0], center=true);
    translate([0,0,upsFootprint.z/2])cube(upsFootprint, center=true);
        bars();
}


if($preview){
    #bars();
}