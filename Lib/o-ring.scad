
module o_ring(id=20,girth=2.5){
    rotate_extrude(angle=360)translate([(id+girth)/2,0])circle(d=girth);
    //cylinder(d=id,h=0.1, center=true);    
}

o_ring(id=40, girth=5);