use <Lib/mattlib.scad>;
$fn=90;
module fantec_4_drive_caddy(){
    color("orange"){
        cube([205,125,170], center=true);
        translate([-110,0,37.5-13])cube([15,95,95], center=true);
        translate([-100+12.5-15,77,-55])cube([60,30,60], center=true);
    }
}

module power_supply(){
    color("green"){
        cube([61,109,33], center=true);
        translate([-16.5+7,100/2+109/2,0])cube([28,100,21], center=true);
        translate([(61/2)-(15/2)-10,(20/2+109/2)*-1,0])rotate([90,0,0])cylinder(d=15,h=20, center=true);
    }
}
rotate([0,0,-90])fantec_4_drive_caddy();
translate([80,90,30])rotate([0,90,0])power_supply();

hull(){
mirrorCopy([1,0,0],[0,0,1])
    translate([90,0,90])
        rotate([0,90,90])
            #cylinder(d=50,h=10, center=true);
}
#hull(){
    translate([0,0,90+25])
        rotate([0,90,90])
            scale([.3,.8,1])
                cylinder(d=100, h=10, center=true);
    mirrorCopy([1,0,0])
        translate([90-11,0,90+50-1])
            rotate([0,90,90])
                cylinder(d=50,h=10, center=true);
}