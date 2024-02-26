use <../Lib/mattlib.scad>
$fn=10;
inch = 25.4;
monitorOuterDims = [11.71*inch, 10.1*inch];
monitorBrimThickness = 5;
monitorCornerRadius = inch;
monitorMidbulgeRatio = 1.02;
monitorChunkDepth = 5*inch;

screenDims = [8.7*inch,6.8*inch];
screenTaper = 5;
screenCornerRadius = inch*.7;

chinHeight = 3.5*inch;
chinWidth = 8.8*inch;

module monitorOuterFront(){
    hull()
        mirrorCopy([1,0,0])mirrorCopy([0,0,1])
            translate([(monitorOuterDims.x-monitorCornerRadius)/-2,0,(monitorOuterDims.y-monitorCornerRadius)/2])
                rotate([90,0,0])
                    cylinder(h=1, d=monitorCornerRadius, center=true);
}

module monitorOuterMiddle(){
    translate([0,monitorChunkDepth/2,0])
    hull()
        mirrorCopy([1,0,0])mirrorCopy([0,0,1])
            translate([(monitorOuterDims.x-monitorCornerRadius)/-2*monitorMidbulgeRatio,0,(monitorOuterDims.y-monitorCornerRadius)/2*monitorMidbulgeRatio])
                rotate([90,0,0])
                    cylinder(h=1, d=monitorCornerRadius, center=true);
}

module monitorOuterRear(){
    translate([0,monitorChunkDepth,0])
    hull()
        mirrorCopy([1,0,0])mirrorCopy([0,0,1])
            translate([(monitorOuterDims.x-monitorCornerRadius)/-2,monitorCornerRadius/-2,(monitorOuterDims.y-monitorCornerRadius)/2])
                rotate([90,0,0])
                    sphere(d=monitorCornerRadius);
}
module monitorInsideBrim(){
    hull()
        mirrorCopy([1,0,0])mirrorCopy([0,0,1])
            translate([((monitorOuterDims.x-monitorCornerRadius)/-2)+monitorBrimThickness,0,((monitorOuterDims.y-monitorCornerRadius)/2)-monitorBrimThickness])
                rotate([90,0,0])
                    cylinder(h=1, d=monitorCornerRadius, center=true);
}

module screenCutout(){
    hull()
        mirrorCopy([1,0,0])mirrorCopy([0,0,1])
            translate([((screenDims.x-screenCornerRadius)/-2),((0.5*inch)/2)-1,((screenDims.y-screenCornerRadius)/2)])
                rotate([90,0,0])
                    cylinder(h=0.5*inch, d2=screenCornerRadius, d1=screenCornerRadius-screenTaper, center=true);
}

module chin(){
    hull(){
        translate([0,(monitorChunkDepth/2)-(monitorChunkDepth/8),5])
            cube([chinWidth,monitorChunkDepth/4,1], center=true);
        mirrorCopy([1,0,0])
            translate([(chinWidth-monitorCornerRadius)/2,(monitorChunkDepth/2)-(monitorChunkDepth/8),(monitorCornerRadius/2)-chinHeight])
                rotate([90,0,0])
                    cylinder(h=monitorChunkDepth/4, d=monitorCornerRadius, center=true);
    }
}


module face(){
    rotate([-7.5,0,0]){
        translate([0,0,monitorOuterDims.y/2]){
            hull(){
                monitorOuterRear();
                monitorOuterMiddle();
                monitorOuterFront();
                
            }

            monitorInsideBrim();
            #screenCutout();
        }
        chin();
    }
}

face();