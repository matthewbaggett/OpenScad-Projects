use <Lib/mattlib.scad>

module carry_handle_hole(){
    hull()mirrorCopy([0,1,0])translate([0,50,0])rotate([0,90,0])cylinder(h=55, d=35, center=true);
    mirrorCopy([0,1,0])translate([0,95,0])rotate([0,90,0])cylinder(h=55, d=35, center=true);
    mirrorCopy([0,1,0])translate([0,95,10])rotate([0,90,0])cube([20,35,55], center=true);
    mirrorCopy([0,1,0])translate([0,120,10])rotate([0,90,0])cube([55,50,55], center=true);
}
module carry_handle_plastic(){
    
    mirrorCopy([0,1,0])translate([0,75,-12.5])cube([50,60,30], center=true);
    hull()mirrorCopy([0,1,0])translate([0,50,0])rotate([0,90,0])cylinder(h=50, d=55, center=true);
}

module carry_handle(){
    difference(){
        carry_handle_plastic();
        carry_handle_hole();
    }
}
carry_handle();