module partSplitter(height=0,maxSize=200, spread=10, top=true, bottom=true){
    if($preview){
        children();
        translate([0,0,height])
            #cube([maxSize,maxSize,0.01], center=true);
    }else{
        if(top){
            color("red")
                translate([0,0,(spread/2)])
                    difference(){
                        children();
                        translate([0,0,((maxSize/2)*-1)+height])
                            cube([maxSize,maxSize,maxSize], center=true);
                    }
        }
        if(bottom){
            color("green")
                translate([0,0,(spread/2)*-1])
                    difference(){
                        children();
                        translate([0,0,(maxSize/2)+height])
                            cube([maxSize,maxSize,maxSize], center=true);
                    }
        }
    }
} 


