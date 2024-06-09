use <Lib/mattlib.scad>;
$fn=90;
hollowerFn = 10;
width=180;
height=180;
length=300;
radius=25;
scalopRatio = [.4,.8,1];

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
        translate([-16.5+7,100/2+109/2,0])
            cube([28,100,21], center=true);
        translate([(61/2)-(15/2)-10,(20/2+109/2)*-1,0])
            rotate([90,0,0])
                cylinder(d=15,h=20, center=true);
    }
}

module bodyShell(){
    // Shell
    hull(){
    mirrorCopy([1,0,0],[0,0,1])
        translate([width/2,0,height/2])
            rotate([0,90,90])
                cylinder(r=radius,h=length, center=true);
    }
}
module scalops(){
    // Top/Bottom Scalop
    mirrorCopy([0,0,1])
    hull(){
        translate([0,0,(height/2)+radius+5])
            rotate([0,90,90])
                scale([scalopRatio.x,scalopRatio.y,scalopRatio.z])
                    cylinder(d=100, h=length*1.2, center=true);

        mirrorCopy([1,0,0])
            translate([(width/2)-11,0,(height/2)+(radius*2)-1])
                rotate([0,90,90])
                    cylinder(r=radius,h=length*1.2, center=true);
    }
    // Left Right Scalop
    mirrorCopy([1,0,0])
    hull(){
        translate([(width/2)+radius+5,0,0])
            rotate([0,90,90])
                scale([scalopRatio.y,scalopRatio.x,scalopRatio.z])
                    cylinder(d=100, h=length*1.2, center=true);
        
        mirrorCopy([0,0,1])
            translate([(width/2)+(radius*2)-1,0,(height/2)-11])
                rotate([0,90,90])
                    cylinder(r=radius,h=length*1.2, center=true);
    }
}

module parts(){
    translate([-15-8.6,0,0])
        rotate([0,0,-90])
            fantec_4_drive_caddy();
    
    translate([-15+80+4.5,90,30])
        rotate([0,90,0])
            power_supply();
}

module brackets(){
    color("green"){
        // PSU Bracket Forward
        translate([60+27-10,30,0])
            cube([65,20,height+30], center=true);
        // PSU Bracker Rear
        translate([77,145,0])
            cube([65,20,height+30], center=true);
        // Caddy Rear
        translate([-77+45,110,0])
            cube([155,20,height+30], center=true);
        // Caddy Front
        translate([-77+45,-806,0])
            cube([155,20,height+30], center=true);
    }    
}
module facia(){
    mirrorCopy([0,0,1],[1,0,0],[0,1,0])
    hull(){
        translate([width/2,length/2,height/2])
            sphere(r=radius);
        translate([0,length/2,0])
            scale([(width/radius/2)+0.4,0.1,(height/radius/2)+0.4])
                sphere(r=radius);
    }
}
difference(){
    union(){
        difference(){
            union(){
                difference(){
                    union(){
                        bodyShell();
                        facia();
                    }
                    scalops();
                }
                footPedistal();
                
            }
            parts();
            footHole();
            hollower();
        }
        difference(){
            brackets();
            scalops();
        }
    }
        
    // Show bottom half
    translate([0,0,250])cube([500,500,500], center=true);
    // Show Front half
    //translate([0,250,0])cube([500,500,500], center=true);
    // Show Back half
    translate([0,-250,0])cube([500,500,500], center=true);
}
#parts();

module footPedistal(){
    mirrorCopy([1,0,0],[0,1,0])
        translate([width/2,(length-50)/2,0])
    translate([0,0,-110]){
            cylinder(d=25.5+4, h=10, center=true);
    }
}
module footHole(){
    mirrorCopy([1,0,0],[0,1,0])
        translate([width/2,(length-50)/2,0])
    translate([0,0,-110])
    translate([0,0,(3+10)/-2+1])
        cylinder(d=25.5, h=3, center=true);
}

module hollower(){
    mirrorCopy([1,0,0],[0,0,1]){
        hull(){
            mirrorCopy([0,1,0]){
                translate([0,(length/2)-(radius/2),0]){
                    hull(){
                        translate([width/2,0,height/2])
                            sphere(r=radius/2, $fn=hollowerFn);
                        scale([1,(1/height)*radius,1])
                            sphere(d=min(width,height), $fn=hollowerFn);
                    }
                }
            }
        }
    }
}

