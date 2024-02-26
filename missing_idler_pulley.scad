use <Lib/mattlib.scad>
$fn=180;
fudge = .7+.1;
dia=15+4;
flange=3;
difference(){
    translate([0,0,0])union(){
        //mirrorCopy([0,0,1])
            translate([0,0,-6.5])cylinder(h=2, d=dia+flange, center=true);
        

        translate([0,0,0])cylinder(h=15., d=dia, center=true);
    }

    
    
    #cylinder(h=20, d=12.5+fudge, center=true);
    #cylinder(h=20, d=9.6, center=true);
}