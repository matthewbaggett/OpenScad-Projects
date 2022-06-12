
module o_ring(id=20,girth=2.5,$fn=180){
    rotate_extrude(angle=360,$fn=$fn)translate([(id+girth)/2,0])circle(d=girth);
    //cylinder(d=id,h=0.1, center=true);    
}

//o_ring(id=40, girth=5);


module o_ring_groove(girth=3,length = 50, height = 100, radius = 15){
    translate([radius+(girth/2),radius+(girth/2),0]){
        difference(){
            o_ring(id=radius*2,girth=girth, $fn=$fn);
            translate([15,0,0])cube([30,40,6], center=true);
            translate([0,15,0])cube([40,30,6], center=true);
        }

        translate([-radius-(girth/2),length/2,0])
            rotate([90,0,0])
                cylinder(h=length+0.01,d=girth, center=true);

        translate([height/2,-radius-(girth/2),0])
            rotate([0,90,0])
                cylinder(h=height+0.01,d=girth, center=true);
    }
}

o_ring_groove();