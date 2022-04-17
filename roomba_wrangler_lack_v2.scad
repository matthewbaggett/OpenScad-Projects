$fn = $preview ? 60 : 360;

retainerThickness=6;
lackThickness = 4;
height=5;
lackLegGirth=50.5;

baseStationAngle = 5;
legTranslation = [-120,0,0];

module mirrorCopy(vec=[1,0,0]){
    children();
    mirror(vec) children();
}


difference(){
    hull(){
        // Main base station body
            rotate([0,0,baseStationAngle]){
        mirrorCopy(){
                    
            translate([(120/2)-45/2,0,0]){
            
                    cylinder(h=height,d1=45+retainerThickness,d2=45.5+retainerThickness, center=true);
                }
            }
        }
        

        // Table leg body
        translate(legTranslation){
            cube([lackLegGirth+(lackThickness*2),50+(lackThickness*2),height], center=true);
        }
        
    }

    // Base station cutout
    hull(){
        rotate([0,0,baseStationAngle]){
            mirrorCopy(){
                translate([(120/2)-45/2,0,0]){
                    cylinder(h=height+1,d=45, center=true);
                }
            }
        }
    }
    
    // table leg cutout
    translate(legTranslation){
        cube([lackLegGirth,lackLegGirth,height+1], center=true);
    }
    
    // Plastic saver
    translate(legTranslation){
        difference(){
            union(){
                hull(){
                    translate([35,20,0])cylinder(d=10, h=height+1, center=true);
                    translate([60,20,0])cylinder(d=10, h=height+1, center=true);
                    translate([55,0,0])cylinder(d=10, h=height+1, center=true);
                    translate([35,-20,0])cylinder(d=10, h=height+1, center=true);
                }
                hull(){
                    translate([35,-20,0])cylinder(d=10, h=height+1, center=true);
                    translate([55,-20,0])cylinder(d=10, h=height+1, center=true);
                    translate([55,0,0])cylinder(d=10, h=height+1, center=true);
                    translate([35,20,0])cylinder(d=10, h=height+1, center=true);
                }
            };
            translate([102,-5,0])cylinder(d=90, h=height+2, center=true);
        }
        
    }


}/**/
