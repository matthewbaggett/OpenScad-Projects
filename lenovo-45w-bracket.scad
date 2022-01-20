use <Lib/mattlib.scad>
$fn=$preview?30:360;
lenovo_psu=[29.5,108,46.1];

module lenovo_psu_body(){
    color("grey",0.3)
    rotate([0,90,0])
        difference(){
            cube(lenovo_psu, center=true);
            translate([0,lenovo_psu.y/2-1,0])
                rotate([90,0,180])
                    scale([0.3,0.3,1])
                        linear_extrude(1.1)
                            text("Lenovo PSU Front",halign="center", valign="center");
    }
}

module bracket(){
        
    difference(){
        // Plastic body
        hull(){
            // Top
            mirrorCopy([1,0,0])mirrorCopy([0,1,0])
                translate([19,25,lenovo_psu.x+25])
                    sphere(d=15);
            
            // Middle
            mirrorCopy([1,0,0])mirrorCopy([0,1,0])
                translate([22,45,15])
                    sphere(d=15);
            
            // Bottom
            mirrorCopy([1,0,0])mirrorCopy([0,1,0])
                translate([15,25,-10+3])
                    sphere(d=15);
            
        }

        // Bottom bolts
        mirrorCopy([0,1,0])
            translate([0,35,16])
                rotate([0,90,0])
                    rotate(30)  
                        metricCapheadAndBolt(6, 20, recessNut=50, recessCap=50);
        
        // Extrusion cutout
        rotate([90,0,0])
            extrusion40x20(lenovo_psu.y*1.1, center=true);

        // PSU cutout
        translate([0,0,lenovo_psu.x/2+22])
            lenovo_psu_body();

    }
}
if($preview){
    translate([50,50,10+25])
        color("red")
            cube([10,10,50], center=true);
    
    // Extrusion cutout
    rotate([90,0,0])
        extrusion40x20(lenovo_psu.y*1.1, center=true);

    // Computer cutout
    translate([0,0,lenovo_psu.x/2+22])
        lenovo_psu_body();
    
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