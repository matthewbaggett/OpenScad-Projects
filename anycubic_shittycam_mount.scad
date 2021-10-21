use <Lib/mattlib.scad>;
$fn = 60;

module cheapcam_bolt(){
    color("orange")
    rotate([0,90,0]){
        // Hex
        translate([0,0,((32/2)+(1.3/2))*-1])cylinder(h=1.3,d=7.77, center=true, $fn=6);
        // Hex Extension
        translate([0,0,((32/2)+(1.3/2)+1.3)*-1])cylinder(h=1.3,d=7.77, center=true, $fn=6);
        // Cap
        translate([0,0,(32/2)+(1.2/2)])cylinder(h=1.2,d=8.2, center=true);
        // cap Extension
        translate([0,0,(32/2)+(1.2/2)+1.2])cylinder(h=1.2,d=8.2, center=true);
        // Shaft
        cylinder(h=32,d=3.75, center=true);
    }
}

if($preview){
    translate([-50,0,0])
        rotate([0,90,0])
            extrusion20x20(100);
}

module cameraMount(extensionLength){
    difference(){
        union(){
            hull(){
            mirrorCopy([0,1,0])
                mirrorCopy([0,0,1])
                translate([0,15,15])
                    rotate([0,90,0])
                        cylinder(h=34, d=10, center=true);
            }
            hull(){
                translate([0,extensionLength,0])
                    rotate([0,90,0])
                        cylinder(h=32+1.2+1.2,d=15, center=true);

                mirrorCopy([1,0,0])
                    translate([8,19.5,0])
                        rotate([90,0,0])
                            cylinder(h=1,d=18, center=true);
            }
        }
        translate([0,extensionLength,0])
            cheapcam_bolt();  
        
        scale([1,1,1.07])
            translate([0,extensionLength-(15),0])
                difference(){
                    translate([0,(15/2)+7.5,0])
                        cube([19.5,30,15+2], center=true);
                    translate([0,0,0])
                        rotate([0,90,0])
                            cylinder(h=19.5,d=15, center=true);
                }
                
        // Extrusion clearance
        cube([50,20,20], center=true);
        
        // Bolt holes
        mirrorCopy([0,0,1])
        translate([0,-1.75,14])
            rotate([90,0,0])
                metricCapheadAndBolt(6, 30, recessNut=10, recessCap=10, chamfer=false);

    }
}

/**0
translate([0,10,0])
difference(){
    cameraMount(50);
    translate([0,-150+10,0])cube([300,300,300], center=true);
}
/**/
translate([0,-10,0])
difference(){
    cameraMount(50);
    translate([0,150+10,0])cube([300,300,300], center=true);
}
/**/