use <../Lib/mattlib.scad>
$fn=$preview?30:360;

boltPos1=[25,-4,0];
boltPos2=[0,0,0];
difference(){
    render()union(){
        
            translate([-80,-45,30])
                rotate([0,90,0])
                    import("ella_oc_a015R.stl");
        
            

        translate(boltPos1){
            color("blue")
            translate([0,0,3])
                cylinder(h=20, d=12, center=true);
        }
        
        translate(boltPos2){
            color("blue")
            translate([0,0,3])
                cylinder(h=20, d=12, center=true);
        }
    }

    translate(boltPos1){
        translate([0,0,6.25])
            metricCapheadAndBolt(6, 20, recessNut=20, recessCap=20, chamfer=true);
    }
    
    translate(boltPos2){
        translate([0,0,6.25])
            metricCapheadAndBolt(6, 20, recessNut=20, recessCap=20, chamfer=true);
    }
}