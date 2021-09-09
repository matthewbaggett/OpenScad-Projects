$fn=360;
center=true;
platform=[41,36.5,2];
bolt_position=[17,-14.75,0];
edgeRadius=3;
deckFromBed=12;
deckThickness=6.67;
angleTiltDown = 20;
cameraBore=5.5+0.2;

module mirrorCopy(vec=[1,0,0]){
    children();
    mirror(vec) children();
} 

module cornerRadiuser(radius=6){
    difference(){
        translate([radius/2,radius/2,0])
        cube([radius,radius,radius*2], center=true);
        cylinder(h=(radius*2)+2,r=radius, center=true);
    }
}

module halfDeck(){
    hull(){
        translate([(platform.x/2)-edgeRadius,((platform.y/2)-edgeRadius)*-1,0])
        cylinder(h=2,d=edgeRadius*2);
        translate([(platform.x/2)-edgeRadius-1,((platform.y/2)-edgeRadius)*-1,0])
        cylinder(h=2,d=edgeRadius*2);
        translate([(platform.x/2)-edgeRadius-5,((platform.y/2)-edgeRadius)*1,0])
        cylinder(h=2,d=edgeRadius*2);
        translate([0,-36.5/2,0])
        cube([5,36.5,2]);
    }
}

module cutoutDeck(){
    // Cutout main body box
    translate([0,((platform.y/2))*-1,-1])
    cube([21/2,6.5,4]);
    translate([0,((platform.y/2))*-1,-1])
    cube([27/2,3.5,4]);
    translate([((27/2)-edgeRadius),((platform.y/2)-(3.5))*-1,-1])
    cylinder(h=4,d=edgeRadius*2);
    // Inner champhered corners
    rotate(180)
    translate([((27/2)+3)*-1,((platform.y/2)-3),0])
    cornerRadiuser(3);
}

module bracket(){
    // Support rail
    translate([0,((platform.y/2)-3),platform.z])
    cube([10,3,deckThickness]);
    // Catch
    translate([0,((platform.y/2)-6),platform.z+deckThickness])
    cube([10,6,3.33]);
}

module boltHoles(){
    mirrorCopy(){
        
            // Bolt holes for mounting
            translate([bolt_position.x,bolt_position.y,-1])
            cylinder(h=4,d=3);
    }
}
module fullDeck(){
    mirrorCopy(){
        difference(){
            halfDeck();
            cutoutDeck();
            boltHoles();
        }
        bracket();
    }
}    

module cameraHolder(bore=5.7, angleTiltDown=20, zOffset=0.5,width=15){
    difference(){
        translate([(width/2)*-1,((platform.y/2)-3),0])
        cube([width,10,deckFromBed+12]);
   
        // Camera bore
        translate([0,30,deckFromBed-zOffset])
        rotate([-90+angleTiltDown,0,0])
        cylinder(40,d=bore,center=true);
    }
}

module extension120degrees(){
    
    difference(){
        union(){
            translate([17,-14.75,1])
            rotate(120)
            translate([9,-12+4,0])
            cube([33,8,2], center=true);
            
            translate([17,-14.75,1])
            rotate(120)
            translate([0,-12+1.5+6,0])
            cube([12,12,2], center=true);
            
            // Bracket
            hull(){
                translate([17,-14.75,(platform.z/2)+(deckThickness/2)+1.5])
                rotate(120)
                translate([2.5,-12-1.5-0.125,])
                cube([10,2.75,2+deckThickness+3], center=true);
                
                
                translate([17,-14.75,0])
                rotate(120)
                translate([18,-13.45,0])
                cube([0.5,0.2,2], center=true);
            }
           
            // Bracket Catch
            translate([17,-14.75,(platform.z/2)+(deckThickness/2)])
            rotate(120)
            translate([2.5,-12,5.83])
            cube([10,6,3], center=true);
            
            // Camera stickout
            hull(){
                translate([17,-14.75,0])
                rotate(120)
                translate([2.5,-12-1.5,(deckFromBed/2)-deckFromBed+1.5])
                cube([10,3,13], center=true);
            
                translate([17,-14.75,0])
                rotate(120)
                translate([2.5,-12+1.5,1])
                cube([10,3,2], center=true);
                
                translate([17,-14.75,1])
                rotate(120)
                translate([30,-11,0])
                cube([0.5,2,2], center=true);
            }
            
        }
        union(){
            mirror([1,0,0]){
                translate([((platform.x/2)-3)*-1,((platform.y/2)-3)*-1,1])
                rotate(180)
                resize([0,0,4])
                cornerRadiuser(3);
                translate([((platform.x/2)+20)*-1,((platform.y/2))*-1,-1])
                cube([20,3,4]);    
                translate([((platform.x/2)+15)*-1,((platform.y/2)+10)*-1,-1])
                cube([20,10,4]);    
            }
            
            boltHoles();
            
            // Clean off the corner
            translate([((platform.x/2)-3)+6.15,((platform.y/2)-8)*-1,1])
            rotate(-90)
            resize([0,0,4])
            cornerRadiuser(5);
            translate([((platform.x/2)-3)+11.15,((platform.y/2)-2.3)*-1,-1])
            cube([5,5,4]);
            
            // Camera borehole
            rotate(120)
            translate([-18.5,-19.5,-5])
            rotate([+90+angleTiltDown,180,0])
            cylinder(30,d=cameraBore,center=true);
        }
    }
}
    

difference(){
    union(){
        translate([0,0,deckFromBed]) fullDeck();
        translate([0,0,deckFromBed]) extension120degrees();
    }

    hull(){
        translate([20.5,-16.25,deckFromBed+platform.z-1])
        cylinder(platform.z+2,d=2, center=true);
        translate([20.5,-18,deckFromBed+platform.z-1])
        cylinder(platform.z+2,d=2, center=true);
    }
    hull(){
        translate([-20.5,-8.25,deckFromBed+platform.z-1])
        cylinder(platform.z+2,d=2, center=true);
        translate([-20.5,-18,deckFromBed+platform.z-1])
        cylinder(platform.z+2,d=2, center=true);
    }
}