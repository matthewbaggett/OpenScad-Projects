use <Lib/mattlib.scad>;
core = [94.44,145.8,2.5];
module deck(){
    difference(){
        union(){
            // Meat.
            translate([0,0,2.5/2])
                cube(core, center=true);
            // Sump
            translate([0,-4,0])
                hull()mirrorCopy([1,0,0])mirrorCopy([0,1,0])
                    translate([(80/2)-(6),(118/2)-(6),(8/-2)])
                        cylinder(h=8,d=6, center=true);
        }
        
        // Long side recess
        mirrorCopy([1,0,0])
            translate([(core.x/-2)+(1.75/2),0,core.z/2])
                cube([1.75,100,core.z+1], center=true);
        
        // Short side recess
        mirrorCopy([0,1,0])
            translate([0,(core.y/-2)+(1.75/2),core.z/2])
                cube([56.8,1.75,core.z+1], center=true);
        
        // Corner bevel    
        mirrorCopy([1,0,0])mirrorCopy([0,1,0])
            translate([core.x/2,core.y/2,core.z/2] + [2.47,2.47,0])
                rotate(45)
                    cube([20,20,core.z+1], center=true);
        
        // top notch
        translate([0,(core.y/2)-1.75-0.5,0])
            hull(){
                translate([0,0,core.z/2])
                    cube([45.75,1,core.z+1], center=true);
                translate([0,-13,core.z/2])
                    cube([34,1,core.z+1], center=true);
            }
        
        // Latch notch    
        translate([(core.x/2)-(7.4/2)-1.6,0,core.z/2])
            cube([7.4,33,core.z+1], center=true);
            
        // Holes
        translate([0,-5,0])
            bitHoles();
    }
    
    
}

module tab(){
    difference(){
        cube([3.45,9.6,1.6], center=true);
        translate([3.45/2,0,1.6/-2])
            rotate([0,-45,0])
                cube([3.45,9.6+0.1,1.6], center=true);
    }
}

module post(){
    difference(){
        cylinder(h=14.4,d=6, center=true);
        cylinder(h=14.4+0.1,d=3, center=true);
    }
}
module bitHole(){
    cylinder(h=20, d=4.00+(4.0-2.8)+0.2, center=true, $fn=6);
}
module bitHoles(){
    translate([0,0,-4.5+0.1])
    for(x=[-4:4])
        for(y=[-6:6])
            translate([x*7.5,y*7.5,0])
                rotate([-30,0,0])
                    bitHole();
}

module part(){
    deck();
    mirrorCopy([1,0,0])mirrorCopy([0,1,0])
        translate([(92.5/2)-3.45,(88.8/2)-9.6,0])
            translate([3.45/2,9.6/2, -core.z/2-(1.6/-2)])
                tab();

    mirrorCopy([1,0,0])mirrorCopy([0,1,0])
        translate([(78.6/2)-(6),(136.4/2)-(6),(14/-2)])
            post();
}

if($preview){
    part();
}else{
    rotate([0,180,0])
    part();
}