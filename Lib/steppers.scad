/**
 * Implementation of a model of a 28BYJ-48 type cheapo stepper motor
 */
module stepper28BYJ48(){
    color("light grey"){
        translate([0,-8,0]){
            // Motor body
            translate([0,0,(19/2)*-1]){
                cylinder(d=28,h=19, center=true);
            }

            // Motor snooter
            translate([0,8,0]){
                translate([0,0,(1.5/2)])cylinder(d=9,h=1.5, center=true);
                difference(){
                    translate([0,0,(5/2)+2])cylinder(d=5,h=6, center=true);
                    mirrorCopy([0,1,0]){
                        translate([0,4,(5/2)+2.1])cube([5,5,6.2], center=true);
                    }
                }
            }
            
            // cable gland
            translate([0,(17/2)*-1,(19/2)*-1]){
                cube([14.8,17,19], center=true);
            }
            
            // Attachment crossbar
            difference(){
                hull(){
                    mirrorCopy([1,-0,0]){
                        translate([(35/2),0,(1/2)*-1]){
                            cylinder(h=1,d=7, center=true);
                        }
                    }
                }
                mirrorCopy([1,-0,0]){
                    translate([(35/2),0,(1/2)*-1]){
                        cylinder(h=1+0.01,d=4.2, center=true);
                    }
                }
            }
        }
    }
}


module stepper28BYJ48_cutouts(){
    color("orange"){
        translate([0,-8,0]){
            mirrorCopy([1,-0,0]){
                translate([(35/2),0,(1/2)*-1]){
                    cylinder(h=1+0.01,d=4.2, center=true);
                }
            }
        }
    }
}

