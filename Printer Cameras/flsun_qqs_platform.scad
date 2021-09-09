include <mattlib.scad>

module holes(){
    translate([0,270,0])
    cylinder(d=4,h=2, center=true);
    mirrorCopy(){
        translate([97/2,270-14,0])
        cylinder(d=5,h=2, center=true);
    }
}

module sheet(){
    translate([0,270,0])
    scale([1,0.7777,1])
    cylinder(r=45,h=1, center=true);
    mirrorCopy(){
        translate([97/2,270-14,0])
        cylinder(r=7,h=1, center=true);
    }
}

difference(){
    hull(){
        for (i=[0,120,240]) rotate(i) sheet();
    }   
    for (i=[0,120,240]) rotate(i) holes();
}
