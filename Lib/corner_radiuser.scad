
module cornerRadiuser(radius=6){
    difference(){
        translate([radius/2,radius/2,0])
        cube([radius,radius,radius*2], center=true);
        cylinder(h=(radius*2)+2,r=radius, center=true);
    }
}
