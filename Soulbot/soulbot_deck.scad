include <mattlib.scad>
footprint=[58,181.6,3];
front_tooth_height=10;
front_tooth_depth=15;
rear_tooth_height=7;
rear_tooth_depth=7;
interior_cutout_margin = 2;
rear_panel_thickness=1.5;
pcb_drillholes_spacing=[40,60];

module prism(l, w, h){
   polyhedron(
           points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
           faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
           );
}

module hex(diameter, height){
    cylinder(d=diameter, h=height, $fn=6);
}

module recessed_support(total_height, screw_bore, inner_diameter=8, outer_diameter=10, recess=2){
    screw_hex_height_to_diameter_ratio=.8;
    screw_bore_rattle_fit_ratio=1.06;
    difference(){
        cylinder(h=total_height,d=outer_diameter);
        translate([0,0,-.5])
        cylinder(h=recess,d=inner_diameter);
        translate([0,0,-.5])
        cylinder(h=total_height+1,d=screw_bore*screw_bore_rattle_fit_ratio);
        translate([0,0,total_height-(screw_bore*screw_hex_height_to_diameter_ratio)])
        rotate(90)
        hex(screw_bore*1.8, screw_bore*screw_hex_height_to_diameter_ratio*2);
    }
}

union(){
    difference(){
        union(){
            // Base platform
            translate([0,0,front_tooth_height])
            cube(footprint);

            // Front "tooth"
            difference(){
                translate([0,front_tooth_depth,front_tooth_height])
                prism(footprint.x, front_tooth_depth * -1, front_tooth_height * -1);
                translate([2.5,2.5,0])
                cube([footprint.x-5,front_tooth_depth,front_tooth_height]);
            }
            
             // axial alignment bars
            difference(){
                color("grey")
                translate([(58-55)/2, 0,front_tooth_height-2])
                union(){
                    cube([1,footprint.y,2]);
                    translate([55-1,0,0])
                    cube([1,footprint.y,2]);
                }
                translate([0,88,0])
                cube([20,30,20]);
                
            }
        }
        
        // Interior cutout
        //translate([interior_cutout_margin/2,interior_cutout_margin/2,0])
        //cube([footprint.x-interior_cutout_margin, footprint.y-2-interior_cutout_margin, front_tooth_height+(interior_cutout_margin/2)]);
        
        // Cutouts for the chassis support pieces
        translate([footprint.x/2,19,0])
        cylinder(h=13,d=10);
        translate([footprint.x/2,19+145.8,0])
        cylinder(h=13,d=10);
        
        // Cutouts for the PCB supports
        translate([(footprint.x/2)-(pcb_drillholes_spacing.x/2),22,front_tooth_height+footprint.z+1])
        rotate([180,0,0])
        cylinder(h=13,d=10);
        translate([(footprint.x/2)+(pcb_drillholes_spacing.x/2),22,front_tooth_height+footprint.z+1])
        rotate([180,0,0])
        cylinder(h=13,d=10);
        translate([(footprint.x/2)-(pcb_drillholes_spacing.x/2),22+(pcb_drillholes_spacing.y),front_tooth_height+footprint.z+1])
        rotate([180,0,0])
        cylinder(h=13,d=10);
        translate([(footprint.x/2)+(pcb_drillholes_spacing.x/2),22+(pcb_drillholes_spacing.y),front_tooth_height+footprint.z+1])
        rotate([180,0,0])
        cylinder(h=13,d=10);
        
        // Engine cutout
        translate([2,88,0])
        cube([footprint.x-4-5,62,30]);
        
        // Hole for protruding standoff
        translate([12.5,61,front_tooth_height-1])
        cylinder(h=footprint.z+2,d=7);
    }
    
    // Chassis support pieces
    translate([footprint.x/2,19,-2])
    recessed_support(15,3.1);
    translate([footprint.x/2,19+145.8,-2])
    recessed_support(15,3.1);
    
    // PCB standoffs
    translate([(footprint.x/2)-(pcb_drillholes_spacing.x/2),22,front_tooth_height+footprint.z])
    rotate([180,0,0])
    recessed_support(5,3.2,recess=0);
    translate([(footprint.x/2)+(pcb_drillholes_spacing.x/2),22,front_tooth_height+footprint.z])
    rotate([180,0,0])
    recessed_support(5,3.2,recess=0);
    translate([(footprint.x/2)-(pcb_drillholes_spacing.x/2),22+(pcb_drillholes_spacing.y),front_tooth_height+footprint.z])
    rotate([180,0,0])
    recessed_support(5,3.2,recess=0);
    translate([(footprint.x/2)+(pcb_drillholes_spacing.x/2),22+(pcb_drillholes_spacing.y),front_tooth_height+footprint.z])
    rotate([180,0,0])
    recessed_support(5,3.2,recess=0);
    
    // Rear cover
    difference(){
        union(){
            translate([0,footprint.y-rear_panel_thickness,-2-3])
            cube([footprint.x,rear_panel_thickness,14+3]);
            // Rear "tooth"
            difference(){
                translate([0,footprint.y-rear_panel_thickness-rear_tooth_depth,front_tooth_height])
                prism(footprint.x, rear_tooth_depth,rear_tooth_height*-1);
                translate([2.5,footprint.y-2.5-rear_tooth_depth,front_tooth_height-rear_tooth_height])
                cube([footprint.x-5,rear_tooth_depth+1,rear_tooth_height]);
            }

        }
        
        // Charging hole
        translate([11,footprint.y-3,-2+4.8])
        rotate([-90,0,0])
        cylinder(h=rear_panel_thickness+2,d=4.8);
    }
    
    // Little plastic protrusion to push down the charger socket
    translate([11,footprint.y-6,front_tooth_height-4.8,])
    cylinder(h=4.8,d=4.8);
    
   
}
/**/