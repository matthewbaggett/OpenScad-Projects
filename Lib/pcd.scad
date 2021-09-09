module pcd(degrees){
    count=360/degrees;
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