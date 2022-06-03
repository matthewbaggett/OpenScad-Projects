use <generic_3v_motor.scad>
use <mirrorcopy.scad>;

$fn=60;

module dollatek_gearbox(cutouts=false){
    // Motor
    translate([1,0,39])generic3vMotor();    
    
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
        translate([-10.2,0,0.5+10])rotate([0,90,0])cylinder(d=4,h=1.3, center=true);
        
        // Body
        difference(){
            hull(){
                // Bottom radius corners
                mirrorCopy([0,1,0])translate([0,6,2.5-8.5])rotate([0,90,0])cylinder(h=19, r=5, center=true);
                // Top ledge before motor hole
                translate([0,0,-10.5+37-1])cube([19,22,1], center=true);
            }
            // Holes
            mirrorCopy([0,1,0])translate([0,(20.5-3)/2,24.5-5.3])rotate([0,90,0])cylinder(d=3,h=25, center=true);
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
                    cube([17,22,12+0.01], center=true);
                    cylinder(d=22,h=11, center=true);
                }
                generic3vMotor();    
            }
            // Motor-Strap retention hooks
            mirrorCopy([1,0,0])translate([9.5,0,4-2.4])cube([2.1,5,3], center=true);
        }
        
        if(cutouts){
            // Main Holes
            mirrorCopy([0,1,0])translate([0,(20.5-3)/2,24.5-5.3])rotate([0,90,0])cylinder(d=3,h=50, center=true);
            // Area around the motor
            hull()translate([1,0,31.5])mirrorCopy([1,0,0])translate([9.5,0,10])cube([2.1,22,35], center=true);
            
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
        difference(){
            // Shaft body
            rotate([0,90,0])cylinder(h=36.5,d=5, center=true);
            // Flats
            mirrorCopy([1,0,0])mirrorCopy([0,0,1])translate([(36.5-7.5)/2,0,3.6])cube([7.5+0.01,5,3.6], center=true);
            
        }
        // Center hole
        rotate([0,90,0])cylinder(h=screwHoleCutoutMM,d=2, center=true);
    }
}

dollatek_gearbox();

translate([0,20,0])dollatek_gearbox_cutout_shaft();

translate([0,40,0])dollatek_gearbox(cutouts=true);