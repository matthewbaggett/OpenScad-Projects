baseboardSize = [3000,800,10];
realBoardSize = [3050,800,18];
use <../Lib/mattlib.scad>

module track(){
    color("green",0.3)
    translate([0,0,70])
    scale([1000,1000,1000])
        translate([-1.5,.4])
            rotate([90,0,0])
                import("300x80.stl", convexity=3);
}

module clearance(){
    zHeight = 70;
    iterations = zHeight/3;
    zPerIter=zHeight/iterations;
    
    difference(){
        union(){
            for(i=[0:iterations]){
                translate([0,0,zPerIter*i])track();
            }
        }
        color("red")translate([0,0,zHeight+1])track();
    }
}

//clearance();


module frame(){
    // Baseboard made of 2x  https://www.praxis.nl/bouwmaterialen/hout/meubelpanelen/meubelpaneel-wit-18mm-305-x-40cm/5281051
    translate([0,0,1]){
        translate([0,200,0])
            cube([3050,400,18], center=true);
        translate([0,-200,0])
            cube([3050,400,18], center=true);
    }
    translate([0,0,-28]){
        mirrorCopy([0,1,0])
            color("brown")
                translate([0,400-20,0])
                    cube([3050,40,40], center=true);

            color("brown")
                    cube([3050-(40*2),40,40], center=true);
        
        mirrorCopy([1,0,0])
            color("blue")
                translate([(3050/2)-(40/2),0,0])
                    cube([40,800-(40*2),40], center=true);
        mirrorCopy([0,1,0])
            color("green")
                translate([0,(800/4)-10,0])
                    cube([40,(800/2)-(40*1.5),40], center=true);
        mirrorCopy([1,0,0])
        mirrorCopy([0,1,0])
            color("green")
                translate([3050/4,(800/4)-10,0])
                    cube([40,(800/2)-(40*1.5),40], center=true);

    }
}

translate([0,0,0])
    track();

translate([0,0,-10])frame();
stationPillars = [
    [700,300],
    [725,275],
    [300,300],
    [390,-40],
    [-700,-300],
    [-725,-275],
    [-310,-300],
    [-420,+40],
];
color("orange")hull(){
    for (coord = stationPillars){
            translate([coord.x,coord.y,0])
                translate([0,0,(70/2)])
                    #cylinder(h=70,d=30, center=true);

    }
}