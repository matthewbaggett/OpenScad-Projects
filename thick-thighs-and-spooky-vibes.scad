module coffin(){
    hull(){
        translate([0,10,0])
            cube([15,1,2], center=true);
        translate([0,0,0])
            cube([25,0.1,2], center=true);
        translate([0,-23,0])
            cube([15,1,2], center=true);
    }
}

$fn=30;
module rounded_coffin(){
    hull(){
        #translate([6.85,9.5,0])cylinder(h=2,d=2);
        #translate([-6.85,9.5,0])cylinder(h=2,d=2);
        #translate([11.75,0,0])cylinder(h=2,d=2);
        #translate([-11.75,0,0])cylinder(h=2,d=2);
        #translate([6.85,-22.5,0])cylinder(h=2,d=2);
        #translate([-6.85,-22.5,0])cylinder(h=2,d=2);
    }
}


module words(){
    #translate([0,0,.5]){
       translate([0,0,0])text("THICK", 3, "FreeSerif:style=Bold", halign="center");
       translate([0,-4,0])text("THIGHS", 3, "FreeSerif:style=Bold", halign="center");
       translate([0,-5-4,0])text("AND", 3, "FreeSerif:style=Bold", halign="center");
       translate([0,-5-5-4,0])text("SPOOKY", 3, "FreeSerif:style=Bold", halign="center");
       translate([0,-5-5-5-4,0])text("VIBES", 3, "FreeSerif:style=Bold", halign="center");
    }
}


difference(){
    coffin();
    linear_extrude(1.1)words();
    translate([0,6.5,0])cylinder(h=10, d=3, center=true, $fn=60);
}