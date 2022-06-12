use <generic_3v_motor.scad>
use <mirrorcopy.scad>;

dollatek_gearbox_boltHole_location = [0,(20.5-3)/2,24.5-5.3+1];
dollatek_gearbox_body_box_dimensions = [19,23,0];
dollatek_gearbox_body_box_radius = 5;

module dollatek_gearbox(cutouts=false){
    // Motor
    translate([1,0,39])
        generic3vMotor();    
    
    color("white"){
        // Output Shaft
        difference(){
            // Shaft body
            rotate([0,90,0])cylinder(h=cutouts?50:36.5,d=5, center=true);
            if(!cutouts){
                // Flats
                mirrorCopy([1,0,0])mirrorCopy([0,0,1])translate([(36.5-7.5)/2,0,3.6])cube([7.5+0.01,5,3.6], center=true);
                // Center hole
                rotate([0,90,0])cylinder(h=36.5+0.01,d=2, center=true);
            }
        }
    }
    color("gold"){
        // Zit
        translate([-10.2,0,0.5+10])
            rotate([0,90,0])
                cylinder(d=4,h=1.3, center=true);
        
        // Body
        difference(){
            hull(){
                // Bottom radius corners
                mirrorCopy([0,1,0])
                    translate([0,(dollatek_gearbox_body_box_dimensions.y/2)-dollatek_gearbox_body_box_radius,2.5-8.5])
                        rotate([0,90,0])
                            cylinder(h=dollatek_gearbox_body_box_dimensions.x, r=dollatek_gearbox_body_box_radius, center=true);
                // Top ledge before motor hole
                translate([0,0,-10.5+37-1])
                    cube([dollatek_gearbox_body_box_dimensions.x,dollatek_gearbox_body_box_dimensions.y,1], center=true);
            }
            // Holes
            mirrorCopy([0,1,0])
                translate(dollatek_gearbox_boltHole_location)
                    rotate([0,90,0])
                        cylinder(d=3,h=25, center=true);
        }
        
        // Keychain-like hole?
        translate([-8.3+8.6,0,-13.5]){
            difference(){
                cube([2.5,5,5], center=true);
                rotate([0,90,0])cylinder(d=3,h=10,center=true);
            }
        }
        
        // Motor Retainer
        translate([1,0,31.5]){
            difference(){
                intersection(){
                    cube([dollatek_gearbox_body_box_dimensions.x-2,dollatek_gearbox_body_box_dimensions.y,12+0.01], center=true);
                    cylinder(d=dollatek_gearbox_body_box_dimensions.y,h=11, center=true);
                }
                generic3vMotor();    
            }
            // Motor-Strap retention hooks
            mirrorCopy([1,0,0])
                translate([9.5,0,4-2.4])
                    cube([2.1,5,3], center=true);
        }
        
        if(cutouts){
            // Main Holes
            mirrorCopy([0,1,0])
                translate(dollatek_gearbox_boltHole_location)
                    rotate([0,90,0])
                        cylinder(d=3,h=50, center=true);
            
            // Area around the motor
            hull()
                translate([1,0,31.5])
                    mirrorCopy([1,0,0])
                        translate([9.5,0,10])
                            cube([2.1,22,35], center=true);
            
            // Lower hole
            translate([-8.3+8.6,0,-13.5]){
                    cube([3,5.5,5.5], center=true);
                    rotate([0,90,0])cylinder(d=3,h=50,center=true);
            }
        }
    }
}

module dollatek_gearbox_cutout_shaft(screwHoleCutoutMM=50){
    color("red"){
        // Output Shaft
        // Shaft body
        rotate([0,90,0])
            cylinder(h=36.5,d=6, center=true);
        // Center hole
        rotate([0,90,0])
            cylinder(h=screwHoleCutoutMM,d=2, center=true);
    }
}


if($preview){
    dollatek_gearbox();
    
    translate([0,20,0])dollatek_gearbox_cutout_shaft();

    translate([0,40,0])dollatek_gearbox(cutouts=true);
}
translate([0,100,0]){
    difference(){
        translate([10-2.5,0,5]){
            hull()
                mirrorCopy([0,1,0])mirrorCopy([0,0,1])
                    translate([0,(30-5)/2,(50-5)/2])
                        rotate([0,90,0])
                           cylinder(h=15,d=5, center=true);
        }
        dollatek_gearbox(cutouts=true);
        dollatek_gearbox_cutout_shaft();
    }
}