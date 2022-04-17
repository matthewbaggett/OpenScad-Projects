$fn=120;

girth=9;
height=girth*3;
thin=6;
rotate([0,180,0]){
    translate([0,0,-height+25])cylinder(h=height,d1=thin,d=girth, center=true);
    translate([0,0,-height+11.5])sphere(d=thin);
    translate([0,0,10]){
        rotate([0,90,0]){
            hull(){
                translate([(girth/2.5)*-1,0,0])cube([2.5,girth,20], center=true);
                cylinder(h=20,d=girth, center=true);
                
            }
            
            
        }
    }/**/
}