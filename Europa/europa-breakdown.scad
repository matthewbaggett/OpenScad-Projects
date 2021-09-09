include <mattlib.scad>

module Europa(){
    translate([1,200,0])
    rotate(180)
    color("grey")
    import("europa-solid_fixed.stl");
}

module M6Bolt(){
    // Main bore
    translate([0,0,143])
    cylinder(h=35,d=6.2);

    // Recess bore hole
    cylinder(h=143,d=12);
    
    // Captive M6 bolt
    translate([0,0,143+35+7.5])
    cylinder(h=7.5*2,d=11.55, $fn=6);
}
module M6BoltShaftHalf(){
    translate([0,0,5])
    cylinder(h=180,d=20);
    translate([-10,-10,5])
    cube([20,10,180]);
}
module M6BoltShaftThreeQuarter(){
    translate([0,0,5])
    cylinder(h=180,d=20);
    translate([-10,-10,5])
    cube([20,10,180]);
    translate([0,-10,5])
    cube([10,20,180]);
}

module M6HorizontalClamp(){
    translate([0,0,0])
    cylinder(h=26,d=20);
    translate([-10,-10,0])
    cube([20,10,26]);
}

module M6HorizontalClampBolt(){
    // Main bore
    translate([0,0,6])
    cylinder(h=15,d=6.2);

    // Recess bore hole
    cylinder(h=6,d=12);
    
    // Captive M6 bolt
    translate([0,0,15+6])
    cylinder(h=7.5,d=11.55, $fn=6);
}

module m6Bores(){
    // Rear M6 bores
    mirrorCopy([1,0,0]){
        color("green")
        translate([101,228,0])
        rotate(90)
        M6BoltShaftThreeQuarter();
    }

    // Front M6 bores
    mirrorCopy([1,0,0]){
        translate([101,65,0])
        rotate(90)
        M6BoltShaftHalf();
    }
}

module clamps(){
    mirrorCopy(){
        translate([90,127,100])
        rotate([0,90,90])
        M6HorizontalClamp();
        translate([90,127,250])
        rotate([0,90,90])
        M6HorizontalClamp();
    }
}

module clampBoltHoles(){
    mirrorCopy(){
        translate([90,127,100])
        rotate([0,90,90])
        M6HorizontalClampBolt();
        translate([90,127,250])
        rotate([0,90,90])
        M6HorizontalClampBolt();
    }
}

module psuRetentionStrap(){
    //PSU retaining strap
    color("orange")
    translate([-113.695,151,15])
    cube([95,10,40]);
}

module floppySupportPillar(){
    color("pink")
    translate([-19,131,15])
    cube([10,30,57]);
}

module rearITXNotchForClearance(){
    // Rear itx notch-out
    translate([(182/2)*-1,215,15])
    cube([182,30,200]);
}

module m6BoltHoles(){
    // Front M6Bolt holes
    mirrorCopy([1,0,0]){
        translate([101,65,0])
        rotate(90)
        M6Bolt();
    }
    // Rear M6Bolt holes
    mirrorCopy([1,0,0]){
        translate([101,228,0])
        rotate(90)
        M6Bolt();
    }
}

module floppyDiskClearancer(){
    // Front Floppydisk clearancer
    // This shaves a couple of mill off the right hand upright to clear the floppy drive.
    translate([84.553,55,15])
    cube([10,20,200]);
}

module undersideFootRecesses(){ 
    mirrorCopy([1,0,0]){
        translate([80,65,0])
        cylinder(h=1,d=25.4);
        translate([80,225,0])
        cylinder(h=1,d=25.4);
    }
}
    
module sliceableEuropa(){
    difference(){
        union(){
            Europa();
            m6Bores();
            clamps();
            psuRetentionStrap();
            floppySupportPillar();
            
        }
        union(){
            rearITXNotchForClearance();
            m6BoltHoles();
            floppyDiskClearancer();
            undersideFootRecesses();
            clampBoltHoles();
        }
    }
}


module itxMotherboardTray(trayThickness=5,sideOverhang=0, radius=15){
    translate([(175/2)*-1,200,110])
    rotate([0, -20,270])

    difference(){
        translate([0,0-sideOverhang,0])
        cube([170,170+(sideOverhang*2),trayThickness]);

        translate([10.16,6.35,-1])
        cylinder(h=trayThickness+2,d=3.81+0.2);
        translate([165.1,6.35,-1])
        cylinder(h=trayThickness+2,d=3.81+0.2);
        translate([165.1,163.83,-1])
        cylinder(h=trayThickness+2,d=3.81+0.2);
        translate([33.02,163.83,-1])
        cylinder(h=trayThickness+2,d=3.81+0.2);
        
        hull(){
            translate([0,25,-1])
            cylinder(h=trayThickness+2,d=radius);
            translate([0,145,-1])
            cylinder(h=trayThickness+2,d=radius);
            translate([190,25,-1])
            cylinder(h=trayThickness+2,d=radius);
            
            translate([190,145,-1])
            cylinder(h=trayThickness+2,d=radius);
        }
    }
}

module plastic(){
    sliceableEuropa();
    itxMotherboardTray(sideOverhang=20);
}

module usbPanelMount(){
    // Center rectangle cutout of USB socket
    translate([0,0,3])
    color("silver")
    cube([13,5,6], center=true);
    
    // M3 holes for retaining bolt
    color("silver")
    mirrorCopy(){
        translate([14,0,1.5])
        cylinder(d=3.2,h=3, center=true);
    }
    color("silver")
    mirrorCopy(){
        translate([14,0,4.5])
        cylinder(d=6,h=3, center=true);
    }
    // Cable Keepout
    color("orange")
    hull(){
        mirrorCopy(){
            translate([14,0,-15])
            cylinder(d=12,h=30, center=true);
        }
    }
}

module powerSupplyCutout(){
    color("blue")
    cube([51,130,31.2]);
    color("blue")
    translate([4.2,130,6])
    cube([24,24,20]);
}

module holes(){
    // Front panel USB
    mirrorCopy(){
        translate([70,43.5,35])
        rotate([90,0,0])
        usbPanelMount();
    }
    
    // Rear panel USB
    translate([67,244,40])
    rotate([270,90,0])
    usbPanelMount();
    translate([84,244,40])
    rotate([270,90,0])
    usbPanelMount();
    
    //Rear panel recess
    translate([-95,249,10])
    cube([190,1,60]);
    
    //Safety sticker
    translate([-30,249,165])
    cube([60,1,60]);
    
    // Power Supply
    translate([-90,118,15])
    powerSupplyCutout();
}

//holes();



difference(){
    plastic();
    holes();
}/**/