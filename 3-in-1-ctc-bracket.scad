use <Lib/mattlib.scad>
bedHeight = (17.5+8) * -1;
$fn=360;

module head(){
    translate([0,0,-16.5])
    {
        // Holes for m3 retainer screws
        color("goldenrod")
        pcd(120)
        translate([0,-11,68-1])
        cylinder(h=10+2,d=3);

        // Holes for bowden feeds
        color("goldenrod")
        pcd(120)
        translate([0,15.5/2,68-1])
        cylinder(h=10+2,d=11);


        // Extruder Nozzle
        color("goldenrod")
        translate([0,0,68-76])
        cylinder(h=76-68,d=8, $fn=6);

        // Main body
        cylinder(h=68,d=28);
    }
}


module carriage(){
        difference(){
            translate([(86.2/-2),90/-2,-17.5+3])
            cube([86.2,90,17.5]);
            {
                mirrorCopy()
                color("red")
                translate([73/2,0,-10-1])
                cylinder(h=12, d=3);
            
                color("green")
                translate([-50,-15/2,0])
                cube([100,15,13]);
                
                color("blue")
                translate([-50,-50/2,0-9-10])
                cube([100,50,10]);
                
                color("orange")
                translate([61/-2,-20,30/-2])
                cube([61, 36.5,30]);
            }
        }
    
}
module mount(){
    mountKeepout = 9;
    
    difference(){
        union(){
            mirrorCopy([0,1,0]){
                hull(){
                    difference(){
                        translate([0,0,68-16.5])
                        cylinder(d=35,h=3, $fn=60);
                        translate([35/-2,mountKeepout*-1,68-16.5-1])
                        cube([35,35,5]);
                    }
                
                    translate([-40,-5-(70/2),3])
                    cube([80,10,1]);
                }
            }
            translate([0,0,68-16.5])
            cylinder(d=35,h=3, $fn=60);
        }
        {
            cylinder(d1=50,d2=30,h=68-16.5, $fn=60);
            head();
        }
    }
}


color("orange")
head();

color("green")
translate([-25,-25,bedHeight])
cube([50,50,1]);

color("dimgrey")
carriage();

mount();
