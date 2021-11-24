use <../Lib/mattlib.scad>
//if($preview){
//    color("lightgreen",0.1)import("FLSUN_QQ_S_improved_Tool_Holder.stl");
//}
$fn=180;
module clasp(){
    height = 15;
    difference(){
        union(){
            difference(){
                translate([0,40,height/2])
                    scale([1.08,1,1])
                        cylinder(h=height,d=88, $fn=180, center=true);
                translate([0,40,height/2])
                    scale([1.08,1,1])
                        cylinder(h=height+1,d=80, $fn=180, center=true);  
            }
            mirrorCopy()
                translate([42.25,33,height/2])
                    rotate(-15)
                        translate([2.2/2,1,0])
                            cube([5+2.2,12,height], center=true);

        }
        union(){
            translate([0,90,height/2])
               cube([100,100,height+1], center=true);
            mirrorCopy()
                translate([53.75,34,height/2])
                    rotate(15)
                        cube([20,20,height+1], center=true);
        }
    }
    
    translate([0,0,0])
        rotate(-60)
    translate([-80.5,-22.25,height/2]){
        difference(){
            cube([70,7.5,height], center=true);
            translate([-30,0,-6.25]){
                translate([0,0,2.75+6.5])cylinder(d1=3.5,d2=6,h=10, center=true);
                translate([0,0,2.75])cylinder(d=2.2,h=3, center=true);
                cube([5.5,5.5,2.5], center=true);
            }
        }
    }
    
}

if($preview){
tri = 330;
color("grey",0.33)
    translate([0,((sqrt(3)/2)*tri)/2*-1,0])
        hull(){
            translate([tri/2,0,0])
                cylinder(h=10, d=1, center=true);
            translate([tri/2*-1,0,0])
                cylinder(h=10, d=1, center=true);
            translate([0,(sqrt(3)/2)*tri,0])
                cylinder(h=10, d=1, center=true);
        }
        

mirrorCopy()
    translate([tri/2,((sqrt(3)/2)*tri)/2*-1,0])
        rotate(60)
        translate([0,-25,0])
            clasp();
        
}else{
    clasp();
}