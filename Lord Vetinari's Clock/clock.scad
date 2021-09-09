use <../Lib/mattlib.scad>;
$useMcMaster = false;
showBearings = true;
clockFaceSizeMM=180;

module secondsHand(){
    color("orchid")
    difference(){
        translate([0,0,10])
        cylinder(h=20,d=12, center=true);
        bearing_6800(labels=false);
    }
    if(showBearings)bearing_6800();
}
module minutesHand(){
    color("palevioletred")
    difference(){
        translate([0,0,8])
        cylinder(h=16,d=25, center=true);
        translate([0,0,8-0.5])
        cylinder(h=17,d=17, center=true);
        bearing_6800(labels=false);
        bearing_6804(labels=false);
    }
    if(showBearings)bearing_6804();
    
}
module hoursHand(){
    color("plum")
    difference(){
        translate([0,0,6.5])
        cylinder(h=13,d=40, center=true);
        translate([0,0,6.5-0.5])
        cylinder(h=14,d=26, center=true);
        bearing_6804(labels=false);
        bearing_6907(labels=false);
    }
    if(showBearings)bearing_6907();
}

module clockface(){
    color("#966F33")
    difference(){
        translate([0,0,1.5+5])
        cylinder(h=3,d=clockFaceSizeMM, center=true);
        translate([0,0,1.5+5])
        cylinder(h=4,d=42, center=true);
    }
    
}
secondsHand();
minutesHand();
hoursHand();
clockface();

