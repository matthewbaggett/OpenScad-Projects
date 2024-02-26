use <Lib/steppers.scad>;
$fn = $preview?30:120;
module stepper(){
    stepper28BYJ48();
    translate([0,0,8])scale([1,1,10])stepper28BYJ48_cutouts();
}
module gauge(labels, labelRadius = 180, gRadius=80){
    
    #stepper();
    //cube([280,180,3], center=true);

    translate([0,0,8])
    union(){
        translate([0,0,-3])cylinder(h=3,d=(gRadius/80)*25, center=true);
        hull(){
            translate([0,0,0])cylinder(h=3,d=25, center=true);
            translate([0,gRadius/4,0])cylinder(h=3,d=6, center=true);
        }
        hull(){
            translate([0,gRadius/4,0])cylinder(h=3,d=6, center=true);
            translate([0,gRadius-1,0])cylinder(h=3,d=2, center=true);
        }
    }
    
    //circle(r=gRadius);
    
    degreesPerLabel = labelRadius / (len(labels)-1);
    
    translate([0,0,2]){
        for(label = labels){
            offsetIndex = search([label], labels)[0];
            offsetDegrees = (offsetIndex * degreesPerLabel);
            rotate((labelRadius/2) - offsetDegrees)
                translate([0,gRadius,0])
                    linear_extrude(1)
                        text(label, halign="center", valign="baseline");
            
        }
        difference(){
            cylinder(r=gRadius,h=1);
            translate([0,0,-0.1])cylinder(r=gRadius-1,h=1+0.2);
        }
    }

}

gauge(labels = ["Slow", "Medium", "Fast"]);