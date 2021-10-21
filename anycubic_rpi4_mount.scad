use <Lib/mattlib.scad>;

module bottom_hex_sm(){
    translate([45.2,2.7,5.2])
        import("../3d/+snap+fit++customizable+Raspberry+Pi+4+Case+&+Stands/files/Bottom_Hex_SM.stl");

    translate([10,10,0])
        cube([70,40,2.2]);
}

module extrusionPiece(){
    translate([0,30.75,-10])rotate([-90,0,-90])extrusion40x20(100);
}
//color("green")bottom_hex_sm();
//extrusionPiece();

module mount(){
    translate([0,0,-5])
    difference(){
        union(){
            //translate([10,15,-1.7])cube([70,30,1.7]);
            translate([10,15,-20])cube([70,30,1.7]);

        }
        extrusionPiece();
    }


    difference(){
        union(){
            bottom_hex_sm();
            translate([0,0,-98])
            scale([1,1,50])
            difference(){
                bottom_hex_sm();
                translate([-1,-1,2])cube([100,65,20]);
            }
        }
        translate([-1,10.75-.25,-20-5])cube([100,40+.5,20+.5]);
        translate([-1,-1,-100-25-5])cube([92,63,100]);
        
        // Bolt holes
        translate([45,31,0])
        mirrorCopy([0,1,0])
        mirrorCopy([1,0,0])
        translate([30,48/2,-20-2.5])
            metricCapheadAndBolt(3, 20, recessCap=3, recessNut=8, chamfer=false);

    }
}


//if($preview)translate([0,0,-5])extrusionPiece();


/*
mount();
/**/
/**/
partSplitter(maxSize=200, height=-5,top=true, bottom=true)
    mount();
/**/
/*
difference(){
    mount();
    translate([-1,-1,-23.25+3])cube([100,100,100]);
    translate([-1,-1,-23.25-100-3])cube([100,100,100]);
    translate([50+3,-1,-23.25-50-3])cube([100,100,100]);
    translate([-50-3,-1,-23.25-50-3])cube([100,100,100]);
}
/**/