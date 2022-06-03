module mirrorCopy(vec=[1,0,0], vec2=[0,0,0], vec3=[0,0,0]){
    
    //echo(str("Vec1=",vec," Vec2=", vec2, " Vec3=", vec3));
    children();
    mirror(vec) children();

    if(vec2){    
        mirror(vec2){
            children();
            mirror(vec) children();
        }
    }

    if(vec3){
        mirror(vec3){
            children();
            mirror(vec) children();
            mirror(vec2){
                children();
                mirror(vec) children();
            }
        }
    }
    
} 

mirrorCopy([1,0,0])color("green")translate([5,10,0])cylinder(h=1,d=5,center=true);
mirrorCopy([1,0,0],[0,1,0])color("blue")translate([10,5,0])cylinder(h=1,d=5,center=true);
mirrorCopy([1,0,0],[0,1,0],[0,0,1])color("red")translate([15,10,5])cylinder(h=1,d=5,center=true);