use <Lib/mattlib.scad>
use <m93p_bracket.scad>
use <lenovo-45w-bracket.scad>
use <carry_handle.scad>
m93=[154+25,104.2+77.7,34.5];   // Dimensons of a Lenovo M93p SFF PC
lenovo_psu=[29.5,108,46.1];     // Dimensions of a Lenovo 45w PSU
interModuleOffset = 25;         // Gap between each node
topBottomOffset = -10;          // How much more or less to offset the top and bottom nodes
nodeCount = 7;                  // How many nodes are in the cluster
interPsuOffset = (280-(lenovo_psu.x*nodeCount))/(nodeCount-1); // Gap between the PSUs in use
cubeNominalSize = 330;          // Nominal maximal cube size
edgeWall = 20;                  // Edge wall thickness for the blueprinting squares
bevel=20;                       // Radius of the bevelled edges
fanSize = [120,120,30];         // Size of the cooling fan to use
frontEdge = -60;                // How far from 0,0,0 is the front edge of the machine, allowing for some CPU stickthrough


module clusterCube_dimensions(){
    // Dimensional squares
    color("yellow",0.2)rotate([90,0,0])square([cubeNominalSize,cubeNominalSize], center=true);
    color("yellow",0.2)translate([0,75,0])rotate([0,0,0])square([cubeNominalSize,cubeNominalSize], center=true);
    color("yellow",0.2)translate([0,75,0])rotate([0,90,0])square([cubeNominalSize,cubeNominalSize], center=true);
    color("green",0.2)translate([0,60+((cubeNominalSize-300)/2),10])rotate([0,0,0])square([cubeNominalSize-edgeWall,cubeNominalSize-edgeWall], center=true);
    color("green",0.2)translate([-10,60+((cubeNominalSize-300)/2),0])rotate([0,90,0])square([cubeNominalSize-edgeWall,cubeNominalSize-edgeWall], center=true);
    color("lightblue",0.4)translate([-75,162+15,75])rotate([-45,-45,0])cube(fanSize, center=true);
}
module clusterCube_cutouts(){

    // CPU Units
    for(i = [-2:2]){
        color("grey")translate([(m93.z+interModuleOffset)*-i,0,0])rotate([180,180,0])m93_body();
    }
    mirrorCopy([0,0,1]){
        translate([0,0,((154+25)/2)+(m93.z/2)+interModuleOffset+topBottomOffset])rotate([180,180+90,0])m93_body();
    }

    // PSU Units
    for(i = [-3:3]){
        translate([(lenovo_psu.x+interPsuOffset)*i,187+30-10-((i+3)*-10)-60,-30+((i+3)*15)]){
            rotate([90,i*3.3-10,90]){
                lenovo_psu_body();
            }
        }
    }
}

module clusterCube_hull(){
    // Casing
    color("grey",0.3)hull()
    union(){
        // Front edges
        /*mirrorCopy([1,0,0])mirrorCopy([0,0,1]){
            translate([m93.y/2,frontEdge,140])sphere(d=bevel);
            translate([136.5,frontEdge,m93.y/2])sphere(d=bevel);
        }*/
        mirrorCopy([1,0,1]){
            translate([m93.y/2,frontEdge+40,140])sphere(d=bevel);
            translate([136.5,frontEdge+40,m93.y/2])sphere(d=bevel);
        }
        rotate([0,90,0])mirrorCopy([1,0,1]){
            translate([m93.y/2,frontEdge,140])sphere(d=bevel);
            translate([136.5,frontEdge,m93.y/2])sphere(d=bevel);
        }
        // Fan corners
        translate([-75,162+15,75])rotate([-45,-45,0])mirrorCopy([1,0,0])mirrorCopy([0,1,0])translate([fanSize.x/2, fanSize.y/2, fanSize.z/2])sphere(d=bevel);

        // Rear corners
        //translate([155,230,-155])sphere(d=bevel);
        mirrorCopy([-1,0,-1])translate([-140,230,-140])sphere(d=bevel);
        mirror([0,0,1])translate([m93.y/2,130,140])sphere(d=bevel);
        mirror([0,0,1])translate([136.5,130,m93.y/2])sphere(d=bevel);
        mirror([0,0,1])translate([m93.y/4,230,140])sphere(d=bevel);
        mirror([0,0,1])translate([136.5,230,m93.y/4])sphere(d=bevel);
        
        // Rear bulge
        translate([0,230,0])sphere(d=bevel*4);
    }
    // Handle
    rotate([0,-45,0])translate([0,0,190])carry_handle();

}
module clusterCube(){
    

}

if(!$preview){
    translate([0,0,150])rotate([-45,45,$t*360]){
        difference(){
            clusterCube_hull();
            clusterCube_cutouts();
        }
    }
}else{
    clusterCube_dimensions();
    clusterCube_hull();
    clusterCube_cutouts();

}