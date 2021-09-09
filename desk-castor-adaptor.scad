 use <Lib/mattlib.scad>
holeSpacing = [58,42,0] + [1,1,0];
$fn=360;

module holes(){

    union(){
        // Feet holes
        color("green")
        mirrorCopy([1,0,0])
        mirrorCopy([0,1,0])
        translate(holeSpacing/2 + [0,0,-26])
        rotate([0,0,90])
        metricCapheadAndBolt(8,40+2,recessCap=15);

        // Desk rail
        color("blue")
        translate([0,0,6])
        rotate([90,90,0])
        cylinder(h=200,d=50, center=true, $fn=360);

        // Clamshell bolts
        /*
        color("orange")
        mirrorCopy()
        translate([holeSpacing.x/2,0,-18])
        rotate([0,0,90])
        metricCapheadAndBolt(8,40,recessCap=20,recessNut=3);
        */
    }
}

module bodyBase(){
   hull(){
        mirrorCopy([1,0,0])
        mirrorCopy([0,1,0])
        translate((holeSpacing/2) + [1,1,-20])
        cylinder(h=1,d=20, center=true, $fn=360);
    }
}

module body(){
   
    mirrorCopy([0,1,0])
    mirrorCopy([1,0,0])
    hull(){
        
        translate((holeSpacing/2) + [-4,-4,-20])
        cylinder(h=1,d=30, center=true, $fn=360);
        
        translate([(holeSpacing.x/2),(holeSpacing.y/2),25.5])
        cylinder(h=1,d=15, center=true, $fn=360);
        translate([0,-25,1])
        cylinder(h=1,d=25, center=true, $fn=360);
    }
    
    hull(){
        translate([0,-10,10])
        cylinder(h=1,d=17, center=true, $fn=360);
        bodyBase();
    }
    

    hull(){
        difference(){
            // Main Body Loop
            translate([0,0,5])
            rotate([90,90,0])
            cylinder(h=50,d=70, center=true, $fn=360);
            // Truncate main body
            translate([0,0,-10-20])
            cube([100,100,20], center=true, $fn=360);
        }
        bodyBase();
    }
    /**/
}

module complete(){
    translate([0,0,-5])
    difference(){
        body();
        holes();
    }
}

if($preview){
    complete();
}else{
   translate([0,0,+5])
    
   difference(){
        complete();
        translate([0,0,-50])
        cube([100,100,100], center=true);
    }
/*
    translate([0,0,-5])
    difference(){
        complete();
        translate([0,0,50])
        cube([100,100,100], center=true);
    }*/
}