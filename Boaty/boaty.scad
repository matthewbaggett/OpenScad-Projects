use <../Lib/mattlib.scad>
targetDimsMeters = [90,18.45,6.7] + [0,0,3];
targetDimsMM = targetDimsMeters *1000;
targetDimsScale = 123/2;
targetDimsScaled = targetDimsMM / targetDimsScale;
//$fn=$preview?30:180;
$fn=60;

module keelSection(keelSpread = 30,hullCornerRad = 5){

    // Keel
    #mirrorCopy([0,1,0])
        translate([0,keelSpread/2,hullCornerRad])
            rotate([0,90,0])
                cylinder(h=1, r=hullCornerRad, center=true);
    // Bottom Corners
    mirrorCopy([0,1,0])
        translate([0,(targetDimsScaled.y/2)-hullCornerRad,hullCornerRad+5])
            rotate([0,90,0])
                cylinder(h=1, r=hullCornerRad, center=true);
    // Top Corners
    mirrorCopy([0,1,0])
        #translate([0,(targetDimsScaled.y/2)-hullCornerRad,targetDimsScaled.z])
            cube([1,hullCornerRad*2,1], center=true);
        
}
module frontSection(){
    translate([(targetDimsScaled.x/2)-400,0,0])
        keelSection(keelSpread=55, hullCornerRad=30);
}
module midSection(){
    translate([0,0,0])
        keelSection(keelSpread=150, hullCornerRad=30);
}
module rearSection(){
    translate([(targetDimsScaled.x/-2)+200,0,0])
        keelSection(keelSpread=55, hullCornerRad=30);
}

module mainBody(){
    hull(){
        frontSection();
        midSection();
        rearSection();
    }
}

module chin(chinLift, chinRadius){
    hull(){
        frontSection();
        translate([(targetDimsScaled.x/2)-48,0,chinRadius+chinLift])
            sphere(r=chinRadius);
        
    }
}
module bowDeck(){
    translate([(targetDimsScaled.x/2),0,targetDimsScaled.z])
        scale([2.0,1,1])
            translate([(targetDimsScaled.y/2)-targetDimsScaled.y+10,0,0]){
                intersection(){
                    cylinder(h=1,d=targetDimsScaled.y);
                    translate([targetDimsScaled.y/4,0,0])
                        cube([targetDimsScaled.y/2,targetDimsScaled.y,1.01], center=true);
                }
            }
}

module sternDeck(){
    translate([targetDimsScaled.x/-2,0,targetDimsScaled.z])
        cube([1,targetDimsScaled.y,1], center=true);
}

module stern(){
    hull(){
        sternDeck();
        rearSection();
        translate([(targetDimsScaled.x/-2)+75,0,5])
            rotate([0,90,0])
                cylinder(h=1, r=5, center=true);
        
    }
}
module bow(){
    hull(){
        frontSection();
        bowDeck();
        translate([(targetDimsScaled.x/2),0,0]){
            intersection(){
                translate([0,0,targetDimsScaled.z])
                    sphere(d=20);
                translate([0,0,targetDimsScaled.z-10])
                    cube(20, center=true);
            }
        }    
    }
}

module bowShield(){
    hull(){
        translate([0,0,0])
            bowDeck();
        rotate([0,-5,0])
            translate([10,0,20])
                bowDeck();
        translate([150,0,0])
            midSection();
    }
}

/*if($preview){
    color("grey",0.2)
        square([targetDimsScaled.x, targetDimsScaled.y], center=true);
}/**/
module splitter(size=100){
    difference(){
        children();
        translate([0,size/4,size/2])
            cube([size,size/2,size] + [0.1,0.1,0.1], center=true);
    }
}

maxDim = max(targetDimsScaled)+100;

//splitter(size=maxDim)
    hollower(wallThickness=10,box=maxDim,bottomLift=10)
        union(){
            mainBody();
            stern();
            bow();
            bowShield();
            chin(chinLift=15, chinRadius=25);
        }
    
