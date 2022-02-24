 use <Lib/mattlib.scad>
holeSpacing = [86,62,0] + [0,0,0];
$fn=120;

module extant_foot(){
       
        cylinder(h=26+0.1, d=10+0.2, center=true);
        translate([0,0,-26/2+1.5+1])cylinder(h=3, d=21, center=true);
        translate([0,0,-26/2+1.5+3+1])cylinder(h=3, d=21, center=true);
        translate([0,0,-26/2-(12-3)])cylinder(h=12-3, d2=15, d1=56);
        translate([0,0,-26/2-(12-3)-3])cylinder(h=3, d=56);
        translate([0,0,-26/2-(12-3)-3-30])cylinder(h=30, d=56);
    
}

module holes(){

    union(){
        // Feet holes
        color("green")
        mirrorCopy([1,0,0])
        mirrorCopy([0,1,0])
        translate(holeSpacing/2 + [0,0,-1.2-1.7])
        rotate([0,0,90])
        metricCapheadAndBolt(8,40,recessCap=15);

        // Desk rail
        color("blue")
        translate([0,0,19+1.5+1])
        rotate([90,90,0])
        cylinder(h=200,d=51, center=true);

        // Clamshell bolts
        /*
        color("orange")
        mirrorCopy()
        translate([holeSpacing.x/2,0,-18])
        rotate([0,0,90])
        metricCapheadAndBolt(8,40,recessCap=20,recessNut=3);
        */
        
        translate([0,0,5])extant_foot();

    }
}
//extant_foot();


module bodyBase(){
   hull(){
        mirrorCopy([1,0,0])
        mirrorCopy([0,1,0])
        translate((holeSpacing/2) + [1,1,-20])
        cylinder(h=1,d=20, center=true);
    }
}

module body(){
   
    mirrorCopy([0,1,0])
    mirrorCopy([1,0,0])
    hull(){
        
        translate((holeSpacing/2) + [-4,-4,-20])
            cylinder(h=1,d=30, center=true);
        translate([(holeSpacing.x/2),(holeSpacing.y/2),25.5])
            cylinder(h=1,d=18, center=true);
        translate([0,-0,50])
            cylinder(h=1,d=25, center=true);
        translate((holeSpacing/2) + [1,1,-20])
            cylinder(h=1,d=20, center=true);
    }
    
    hull(){
        translate([0,-10,45])
            cylinder(h=1,d=32, center=true);
        
        bodyBase();
    }
    

    hull(){
        difference(){
            // Main Body Loop
            translate([0,0,8])
                rotate([90,90,0])
                    cylinder(h=50,d=90, center=true);
            // Truncate main body
            translate([0,0,-10-20])
                cube([100,100,20], center=true);
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
   translate([0,50,0])
   difference(){
        complete();
        translate([0,0,-50])
        cube([200,200,100], center=true);
    }

    translate([0,-50,25.5])
    difference(){
        complete();
        translate([0,0,50])
        cube([200,200,100], center=true);
    }
}
