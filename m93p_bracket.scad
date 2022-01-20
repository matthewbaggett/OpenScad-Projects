use <Lib/mattlib.scad>
$fn=$preview?30:360;
m93=[154+25,104.2+77.7,34.5];

module m93_body(){
    color("grey")
    rotate([0,90,0])
        difference(){
            cube(m93, center=true);
            translate([0,m93.y/2-1,0])
                rotate([90,0,180])
                    linear_extrude(1.1)
                        text("Lenovo M93P Front",halign="center", valign="center");
    }
}

module bracket(){
        
    difference(){
        // Plastic body
        hull(){
            // Top
            mirrorCopy([0,1,0])
                translate([0,10,m93.y+30])
                    rotate([90,0,0])
                        sphere(d=m93.z+8);
            
            // Middle
            mirrorCopy([0,1,0])
                translate([0,45,15])
                    rotate([0,90,0])
                        cylinder(h=m93.z+20,d=10, center=true);
            // Bottom
            mirrorCopy([0,1,0])
                translate([0,(70/2)-5,-10])
                    rotate([0,90,0])
                        #cylinder(h=m93.z+10,d=10, center=true);
            
        }

        // Top Bolts
        translate([0,0,m93.y+30+5])
            rotate([0,90,0])
                rotate(30)
                    metricCapheadAndBolt(6, 20, recessNut=20, recessCap=20);

        // Bottom bolts
        mirrorCopy([0,1,0])
            translate([0,35,20])
                rotate([0,90,0])
                    rotate(30)  
                        metricCapheadAndBolt(6, 20, recessNut=20, recessCap=20);
        
        // Extrusion cutout
        rotate([90,0,0])
            extrusion40x20(m93.y*1.1, center=true);

        // Computer cutout
        translate([0,0,m93.y/2+30])
            m93_body();

    }
}
if($preview){
    // Extrusion cutout
    rotate([90,0,0])
        extrusion40x20(m93.y*1.1, center=true);

    // Computer cutout
    translate([0,0,m93.y/2+30])
        m93_body();
    
    bracket();
}else{
    if (part == undef || part == "left") {
        rotate([0,90,0])
            translate([0,60,0])
                difference(){
                    bracket();
                    translate([25,0,100])cube([50,200,300], center=true);
                }
    }
    
    if (part == undef || part == "right") {
        rotate([180,-90,0])
            translate([0,60,0])
                difference(){
                    bracket();
                    translate([-25,0,100])cube([50,200,300], center=true);
                }
    }
    
}