$fn = $preview ? 60 : 360;

retainerThickness=4;
height=5;
lackLegGirth=50.5;

module mirrorCopy(vec=[1,0,0]){
    children();
    mirror(vec) children();
}

difference(){
    hull(){
        // Main base station body
        mirrorCopy(){
            translate([(120/2)-45/2,-20,0]){
                cylinder(h=height,d1=45+retainerThickness,d2=45.5+retainerThickness, center=true);
            }
        }

        // Table leg body
        translate([0,60,0]){
            rotate(45)
                cube([lackLegGirth+(retainerThickness*2),50+(retainerThickness*2),height], center=true);
        }
    }

    // Base station cutout
    hull(){
        mirrorCopy(){
            translate([(120/2)-45/2,-20,0]){
                cylinder(h=height+1,d=45, center=true);
            }
        }
    }
    
    // table leg cutout
    translate([0,60,0])
        rotate(45)
            cube([lackLegGirth,lackLegGirth,height+1], center=true);
    
    // Plastic saving cutouts
    mirrorCopy(){
        hull(){
            translate([7.5,12,0])
                cylinder(h=height+1, d=10, center=true);
            translate([35,45,0])
                cylinder(h=height+1, d=10, center=true);
            translate([45,12,0])
                cylinder(h=height+1, d=10, center=true);
        }
    }
}
