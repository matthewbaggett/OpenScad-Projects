show_spacer = true;
show_arm = false;
vesa_spacing_mm = 100;
vesa_hole_mm = 4.5;
vesa_hole_shoulders_mm = 30;
spacer_thickness_mm = 40;
microphone_hole_dia_mm = 16.25;
$fn = $preview?30:120;
use <Lib/mirrorcopy.scad>;
use <Lib/metric_bolts.scad>;
module bolt(){
    translate([0,25/2,+1.5])
    metricCapheadAndBolt(5, 30, recessNut=10, recessCap=10, chamfer=true);
}
   
module mount_plug(){
    translate([32.5,0,0])rotate([0,90,0])
    difference(){
        hull(){
            translate([0,0,2])cylinder(h=0.001, d=15, center=true);
            translate([0,0,25])scale([1,1.15,1])cylinder(h=0.001, d=25, center=true);
        }

        translate([0,-1.5,25/2])
            rotate([90,90,0])metricCapheadAndBolt(5, 30, recessNut=10, recessCap=10, chamfer=true);
    }
}

module mount_speaker_screws(){
    rotate([90,0,0])mirrorCopy()translate([15,0,0]){
        union(){
            cylinder(d=3.2,h=2.5, center=true);
            translate([0,0,5+2.5/2])cylinder(d=7.5,h=10, center=true);
        }
    }
}
module mount_speaker_screw_end(){
    hull()
    mirrorCopy()translate([15,0,0]){
        translate([0,1,0])rotate([90,0,0])cylinder(h=0.1,d=20, center=true);
        translate([0,-5,0])scale([1,.8,1])sphere(d=15);
    }
}
module mount_arm(){
    hull()
    union(){
        
        hull()translate([32.5,0,0])rotate([0,90,0]){
            translate([0,0,25])scale([1,1.15,1])cylinder(h=0.001, d=25, center=true);
            // For a flat side:
            //#translate([-15,13.72,25+12.5])scale([1,1.15,1])rotate([90,0,0])cylinder(h=1, d=10, center=true);
            // For a ball at the mount joint:
            translate([0,0,25+8])scale([1,1.15,1])sphere(d=25);
        }
        hull(){
            translate([425/2,13.3,220]){
                translate([-15,1,0])rotate([90,0,0])cylinder(h=0.1,d=20, center=true);
                translate([-15,-5,0])scale([1,.8,1])sphere(d=15);
            }
        }
    }
}


module mount_complete(){
    difference(){
        union(){
            mount_plug();            
            translate([425/2,13.3,220])mount_speaker_screw_end();
            mount_arm();
        }
        translate([425/2,13.3,220])color("red")mount_speaker_screws();
    }
    // Stupid fucking foot to make it possible to print standing up
    hull(){
        translate([32.5,0,0])rotate([0,90,0])translate([0,0,25+8])scale([1,1.15,1])sphere(d=25);
        difference(){
            translate([65,0,0])rotate([0,13,0])translate([0,0,-13.3])#cylinder(h=1,d=30,center=true);
            translate([32.5,0,0])cube([50,50,50], center=true);
        }
    }
}

if($preview && 1==2){
    mirrorCopy(){
        mount_complete();
    }
}else{
    mount_complete();
}