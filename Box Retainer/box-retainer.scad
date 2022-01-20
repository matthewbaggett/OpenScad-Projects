use <../Lib/mattlib.scad>;
desk_thickness = 22.55;
fudge_factor_percent = 2;
$fn=180;

module original_part(){
    render()
        translate([-135+(0.63/2),-135,0])
            import("BIG_BOX_ONE.stl");
}

module scaled_part(){
    scale(1.6,1.6,1.6)
        original_part();
}
module processed_part(){

    render()difference(){
        translate([0,0,-111+5])
            scaled_part();
        translate([0,0,-120/2])
            cube([300,300,120], center=true);
    }

    mirrorCopy(){
        translate([-.5,11,0.5])cube([122,149,1], center=true);
        translate([-47,67,0.5])cube([38,45,1], center=true);
        translate([-5,67+1.88456+1.6,0.5])cube([100,45,1], center=true);
        translate([-60,45,0.5])rotate(45)cube([10,10,1], center=true);
        translate([-28,83,0.5])rotate(45)cube([10,10,1], center=true);
        translate([-60,-45,0.5])rotate(45)cube([10,10,1], center=true);
        translate([-57,-53.5,0.5])cube([20,20,1], center=true);
        translate([-57+40-0.235,-58.3,0.5])cube([100,20,1], center=true);
    }
    thickness = desk_thickness * (1+(fudge_factor_percent/100));

    bottomz=-thickness-(1.6/2);
    rearthicness = 1.6*2;
    mirrorCopy(){
        difference(){
            union(){
                translate([47.2,89.885+(rearthicness/2)-.1,-thickness/2+2.5])
                    cube([39,rearthicness,thickness+5], center=true);
                translate([47.2-39,89.885+(rearthicness/2)-.1,-thickness/2+2.5])
                    cube([39,rearthicness,thickness+5], center=true);
                

                hull(){
                    translate([47.2,89.885+(rearthicness/2)-.1,-thickness-(rearthicness/2)])
                        cube([39,rearthicness,rearthicness], center=true);    
                    translate([47.2-39,89.885+(rearthicness/2)-.1,-thickness-(rearthicness/2)])
                        cube([39,rearthicness,rearthicness], center=true);    
                    
                    translate([38,70,bottomz])
                        cylinder(h=1.6,d=20, center=true);
                    translate([38,70,-28.5])
                        cylinder(d1=15,d2=20,h=8,center=true);
                }
                
            }
            translate([38,70,-19.])
                rotate([0,180,0])
                    screw();
        }
    }
    
}

module screw(){
    cylinder(d=5, h=23, center=true);
    translate([0,0,(23/2)])cylinder(d2=7.1, d1=5, h=2);
    translate([0,0,(23/2)+2])cylinder(d2=7.1, d1=5, h=2);
    translate([0,0,(23/2)+2])cylinder(d=7.1, h=2);
}


if($preview){
    processed_part();
}else{
    rotate([-90,0,0])
        processed_part();
}