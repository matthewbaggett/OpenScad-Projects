use <Lib/metric_bolts.scad>
$fn=90;
cutterKerf=0.2;

module label(label){
    translate([9,0,(50/2-1.9)*-1])
        rotate([180,0,90])
            linear_extrude(2)
                text(text=label, size=4.5,halign="center", valign="center", spacing=1.1);
}
module test_part(){
    difference(){
        
        cube([30,90,49.4], center=true);
        translate([0,-30,0]){
            metricCapheadAndNutsert(6, 40, 13, mSizeRatio=1.35,recessCap=1, chamfer=true);
            label("1.35");
        }
        translate([0,-15,0]){
            metricCapheadAndNutsert(6, 40, 13, mSizeRatio=1.34,recessCap=1, chamfer=true);
            label("1.34");
        }
        translate([0,-0,0]){
            metricCapheadAndNutsert(6, 40, 13, mSizeRatio=1.33,recessCap=1, chamfer=true);
            label("1.33");
        }
        translate([0,+15,0]){
            metricCapheadAndNutsert(6, 40, 13, mSizeRatio=1.32,recessCap=1, chamfer=true);
            label("1.32");
        }
        translate([0,+30,0]){
            metricCapheadAndNutsert(6, 40, 13, mSizeRatio=1.31,recessCap=1, chamfer=true);
            label("1.31");
        }
    }
}

        

module cutter(extraNarrow=0){
    translate([0,0,-50])cube([100,100,100], center=true);
    cube([40,10-extraNarrow,10], center=true);
    cube([10-extraNarrow,100,10], center=true);
}



if($preview){
    test_part();
}else{
    translate([-20,0,0])intersection(){
        test_part();
        cutter(cutterKerf);
        translate([0,0,-50-10])cube([100,100,100], center=true);
    }

    /*translate([20,0,0])rotate([0,180,0])difference(){
        test_part();
        cutter();
    }/**/
}

/**/