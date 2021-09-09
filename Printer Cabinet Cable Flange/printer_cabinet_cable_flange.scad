$fn=360;
difference(){
    union(){
        difference(){
            translate([0,0,1.5])
            cylinder(d=30,h=3, center=true);

            translate([0,0,2.5])
            cylinder(d=26,h=3, center=true);
        }

        translate([0,0,10/2])
        cylinder(d=19.7,h=10, center=true);
    }
    translate([0,0,(12/2)-1])
    cylinder(d=17,h=12, center=true);
}




