use <../Lib/mattlib.scad>;

module power_supply_cutout(){
    translate([0,0,0]){
        translate([(-51/2)+(24/2)+5,(126/2)+(20/2),0]){
            cube([24,20+0.1,20], center=true);
        }
        cube([51,126,31], center=true);
    }
}
difference(){
    translate([0,0,4])#cube([55,35,10], center=true);
    translate([0,0,63])rotate([-90,0,0])power_supply_cutout();
    
}