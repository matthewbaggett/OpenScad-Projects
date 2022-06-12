module pcd(degrees, totalDegrees=360){
    count=totalDegrees/degrees;
    for(i=[1 : count]){
        rotate(degrees*i)
        children();
    }
}

module pcdAtFixedDegrees(degrees){
    for(degree=degrees){
        rotate(degree)
        children();
    }
}

pcd(30)
    translate([30,0,0])
        cylinder(h=10,d=5, center=true, $fn=30);