use <../Lib/mirrorcopy.scad>
$fn = 30;
basePlateDims = [150,121.2+4+129.7,1.5];
snootHolesDia = 3.0;
sideHolesDia = 3.5;

module wheelCutouts(){
    mirrorCopy([0,1,0])mirrorCopy([1,0,0])
        translate([((basePlateDims.x+35)/2)-27,40+(27/2),0])
            cube([35,80,basePlateDims.z+1], center=true);
}
module wingHoles(){
    mirrorCopy([1,0,0])
    translate([(basePlateDims.x/2)-(16.2+(sideHolesDia/2)),0,0])
        #cylinder(h=basePlateDims.z+1, d=sideHolesDia, center=true);
    mirrorCopy([0,1,0])mirrorCopy([1,0,0])
        translate([(basePlateDims.x/2)-(2.8+(sideHolesDia/2)),(10+sideHolesDia)/2,0])
            #cylinder(h=basePlateDims.z+1, d=sideHolesDia, center=true);
}
module snootHoles(){
    mirrorCopy([0,1,0])mirrorCopy([1,0,0])
        translate([(10.7+snootHolesDia)/2,basePlateDims.y/2-(.8+(snootHolesDia/2)),0])
            #cylinder(h=basePlateDims.z+1, d=snootHolesDia, center=true);
}

difference(){
    union(){
        translate([0,0,basePlateDims.z/2]){
            // Base plate
            cube(basePlateDims, center=true);
        }
    }
    union(){
        translate([0,0,basePlateDims.z/2]){
            wheelCutouts();
            wingHoles();
snootHoles();

        }
    }
}
    
color("green")translate([0,0,0])cube([27,27,5], center=true);