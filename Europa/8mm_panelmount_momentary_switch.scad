module 8mm_panelmount_button(){
    translate([0,0,12.8/2])
        cylinder(h=12.8,d=8, center=true);
    translate([0,0,12.8+(3.3/2)])
        cylinder(h=3.3+0.01,d=12, center=true);
    color("green")
        translate([0,0,12.8-1])
            cylinder(h=2,d=10, center=true);
    color("red")
        translate([0,0,7])
            cylinder(h=2,d=12, center=true, $fn=6);
    color("lightblue",0.33)
        translate([0,0,4])
            cylinder(h=8,d=14, center=true);
}

8mm_panelmount_button();