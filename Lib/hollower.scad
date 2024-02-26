module hollower(wallThickness=1, box=300, bottomLift=0){
    difference() {
        children();
        translate([0,0,-box/2]) cube(box,center=true);
        difference() {
            translate([0,0,(box/2)-0.001+bottomLift]) cube(box,center=true);
            minkowski() {
                translate([0,0,0])cube(2*wallThickness,center=true);  
                difference() {
                    translate([0,0,(box/2)+bottomLift]) cube(box,center=true);
                    children();
                }
            }
        }
    }
}