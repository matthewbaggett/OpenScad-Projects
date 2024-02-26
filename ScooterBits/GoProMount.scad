use <../Lib/metric_bolts.scad>
use <../Lib/mirrorcopy.scad>

$fn = 90;
// Original bolt:
// metricSocketScrew(6, 12);

offsetX=-12;
offsetY= 10;
spaceBetweenMountHoles = 70;
mSize = 6;
mountStemThickness = mSize*2.2;
module holes(){
    mirrorCopy(){
        translate([spaceBetweenMountHoles/2,0,offsetX]){
            metricSocketScrew(mSize, 20,recessCap=50);
        }
    }
}

module plastic(){
    
    hull(){
        mirrorCopy()translate([spaceBetweenMountHoles/2,0,10]){
            cylinder(d=mountStemThickness, h=5);
        }
        translate([offsetX,offsetY,25])rotate([0,90,0])cylinder(h=20,d=15, center=true);
    }
        
    mirrorCopy(){
        translate([70/2,0,0]){
            cylinder(d=mountStemThickness, h=15);
        }
    }
    //translate([0,0,15-5/2])cube([70,12.5,5], center=true);
    
    mirrorCopy()hull(){
        translate([spaceBetweenMountHoles/2,0,10-2]){
                cylinder(d=mountStemThickness, h=2);
        }
        translate([(spaceBetweenMountHoles/2)-(mountStemThickness),0,10+1]){
            cube([mountStemThickness,mountStemThickness,2], center=true);
        }
    }
}

module goproHoles(){
    rotate([0,90,0]){
        cylinder(h=50,d=5.5, center=true);
        translate([0,0,((3.18/2)+3.14+4+(50/2)-2)*-1])
            cylinder(h=50,d=9, $fn=6,center=true);
        translate([0,0,((3.18/2)+3.14+4+(50/2))*-1])
            cylinder(h=50,d=13, center=true);
        translate([0,0,(3.18/2)+3.14+4+(50/2)])
            cylinder(h=50,d=13, center=true);
        
        translate([0,0,(3.18/2)+3.14+4+(50/2)+22])
            cylinder(h=50,d=18, center=true);
    }
    
    mirrorCopy()translate([(3.18+3.14)/2,0,0]){
        rotate([0,90,0])cylinder(h=3.14,d=20, center=true);
        translate([0,10,0])cube([3.14,20,20], center=true);
        translate([0,0,10])cube([3.14,20,20], center=true);
    }
}

module goproMount(){
    difference(){
        union(){
            plastic();
            
        }
        holes();
        translate([offsetX,offsetY,25])#goproHoles();
    }
}

//goproHoles();
goproMount();




/**/