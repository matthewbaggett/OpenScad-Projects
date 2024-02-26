module renamon(){
    heightOriginalMM = 18;
    //heightRealMM = 2490;
    heightRealMM = 300;
    prescale = (1.0/18) * heightRealMM;
    scale([prescale,prescale,prescale])
        rotate([90,0,0])
            translate([-4,4.75,-4])
                import("STL/furry_trash.stl");
                
}
    //renamon();

intersection(){
    renamon();
    translate([0,10,250])
        translate([0,0,50/2])
            color("red")
                cube([100,100,50], center=true);

}