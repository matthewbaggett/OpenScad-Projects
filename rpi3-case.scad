/*
 * Raspberry Pi3 case for Prusa MK3

 * Originally not intended for use with the Prusa MK3; I just wanted a openscad code base to work with to make future cases.
 * I have borrowed the standoff design and the supports at the ports from https://www.thingiverse.com/thing:1325370
 
*/

/* [Main] */

// Which part to render
part = "both"; // [ lid: Lid, base: Base, both: Box ]

// Make slot for the camera cable
camera_slot = "true"; // [ true: Yes, false: No ]

// Make slot for the video cable
video_slot = "true"; // [ true: Yes, false: No ]

// Make slot for the gpio_connector (not implemented)
gpio_slot = "true"; // [ true: Yes, false: No ]

// Prusa i3 Mk3 mount
mk3_mount = "false"; // [ true: Yes, false: No ]

// Cover holes with single layer, helps some screw hole avoid need for supports, requires to be punched through afterwards ( thanks Angus for the tip )
hole_covers = "true"; // [ true: Yes, false: No ]

/* [Hidden] */

board = [85, 56 , 1.3 ];  //dimension of rasp pi
t     = 1.40;             //Thickness of rasp pi board
p     = 3;              //Thickness of plastic case

_t_wall    = 2;              // Thickness of outer walls
_t_b  = 2;              // Thickness of top and bottom
_rpi_w = 56;
_rpi_l = 85;
_rpi_padding = 0.2;
_rpi_t = 1.4;
_rpi_hole_l_offset = 58;

_inner_h = 12.8; // Just guessing here

_h_rpi_offset = 4 + _t_b;

// This cannot be fiddle with too much as it will break the stereo jack hole
_split_offset = 10;

_hole_offset = 3.5;

_outer_l = _t_wall*2 + _rpi_padding*2 + _rpi_l;
_outer_w = _t_wall*2 + _rpi_padding*2 + _rpi_w;
_outer_h = _t_b*2+_inner_h+_h_rpi_offset;

// translate([_t_wall+_rpi_padding,_t_wall+_rpi_padding,_h_rpi_offset]) rpi();

$fn=20;

//base();
//lid();
//box();

show();

module show() {
    if (part == "lid") {
        rotate([0,180,0]) translate([1,0,-_outer_h]) lid();
    } else if (part == "base") {
        base();
    } else {
        lid();
        base();
    }
}

module rpi() {
    difference() {
        union() {
            cube([_rpi_w,_rpi_l,_rpi_t]);


            // SD card
            _sd_width = 11;
            _sd_depth = 3;
            translate([_rpi_w/2-_sd_width/2,_rpi_l-_t_wall,-_rpi_t-1])
                cube([_sd_width,_sd_depth+_rpi_padding+_t_wall,1]);

            // USB 1
            //usb1  =  [[70   ,21.4 ,0] ,[17.4 ,15.3  , 17.4] ,[0,   -2,    0] , [0,   4, 10  ]];
            // 14.7 is the outer edge, the main module is 13.14
            translate([40.43,-2,_rpi_t]) {
                usb(padding=0);
            }


            // USB 2
            //usb2  =  [[70   ,39   ,0] ,[17.4 ,15.3  , 17.4] ,[0,   -2,    0] , [0,   4, 10  ]];
            translate([22.43,-2,_rpi_t]) {
                usb(padding=0);
            }


            // Ethernet
            translate([2.5,-2,_rpi_t])
                ether(padding=0);

            // Audio
            translate([0,31,_rpi_t])
                audio(padding=0);

            // HDMI
            translate([0,45.75,_rpi_t])
                hdmi(padding=0);

             // Micro USB
            translate([0,70.5,_rpi_t])
                musb(padding=0);

            // Camera
            translate([0,38.6,_rpi_t])
                cube([22.5,2.95,5.7]);

            // Video
            translate([_rpi_w/2-22.5/2,79.55,_rpi_t])
                cube([22.5,2.95,5.7]);

       }


        // holes
        translate([_hole_offset,_rpi_l-_hole_offset,-1]) cylinder(r=2.75/2,h=_rpi_t+2);
        translate([_rpi_w-_hole_offset,_rpi_l-_hole_offset,-1]) cylinder(r=2.75/2,h=_rpi_t+2);
        translate([_hole_offset,_rpi_l-3.5-_rpi_hole_l_offset,-1]) cylinder(r=2.75/2,h=_rpi_t+2);
        translate([_rpi_w-_hole_offset,_rpi_l-_hole_offset-_rpi_hole_l_offset,-1]) cylinder(r=2.75/2,h=_rpi_t+2);
    }
}

module usb(padding=0.2,extends=0.2) {
    _extra_width = (14.7-13.14);
    cube([13.14+2*padding,17.4+2*padding,15.3+padding]);
    translate([-(14.7+2*padding-13.14-2*padding)/2,-extends+0.2,-_extra_width/2]) cube([14.7+2*padding,extends,15.3+padding+_extra_width]);
}

module ether(padding=0.2,extends=0) {
    translate([0,-extends,0])
    cube([15.51+2*padding,21.45+extends,13.9+padding]);
}

module audio(padding=0.4,extends=0,hole=true) {
    $fn=20;
    difference() {
        union() {
            translate([0,0,3]) rotate([0,-90,0]) cylinder(r=3+padding,h=2+extends);
            translate([0,-3,0]) cube([11,6,6]);
        }
        if (hole) {
            translate([5,0,3]) rotate([0,-90,0]) cylinder(r=1.5,h=11);
        }
    }
}

module hdmi() {
    difference() {
        union() {
            translate([1,0,0]) cube([10.7,14.5,6.4]);
            hull() {
                translate([-1,0,2]) cube([10.7,14.5,4.4]);
                translate([-1,1,1]) cube([10.7,12.5,5.4]);
            }
        }
        hull() {
            translate([-2,0.5,2.3]) cube([10.7,13.5,3.6]);
            translate([-2,1.6,1.5]) cube([10.7,11.7,2]);
        }
    }
}

module hdmi_hole(padding=0.6,extends=5,outer_padding=2) {
    union() {
        translate([-1-0.1,-padding,-padding])
            cube([10.7+0.1,14.5+padding*2,6.4+padding*2]);

        translate([-1-extends,-outer_padding,-outer_padding])
            cube([extends,14.5+outer_padding*2,6.4+outer_padding*2]);
    }
}

module musb() {
    difference() {
        union() {
            translate([1,0,0]) cube([5.7,7.5,3]);
            hull() {
                translate([-1,0,1]) cube([5.7,7.5,2]);
                translate([-1,1,0.5]) cube([5.7,5.5,2]);
            }
        }
        hull() {
            translate([-1.1,0.2,1.2]) cube([5.7,7.1,1.6]);
            translate([-1.1,1.2,0.7]) cube([5.7,5.1,2]);
        }
    }
}

module musb_hole(padding=0.6,extends=5,outer_padding=2) {
    union() {
        translate([-1-0.1,-padding,-padding])
            cube([5.7+0.1,7.5+padding*2,3+padding*2]);

        translate([-1-extends,-outer_padding,-outer_padding])
            cube([extends,7.5+outer_padding*2,3+outer_padding*2]);
    }
}


module box() {
    
    _sd_width = 12;
    _sd_depth = 3;
    _sd_inset = 4;

    difference() {

        cube([_t_wall*2+_rpi_padding*2+_rpi_w,_t_wall*2+_rpi_padding*2+_rpi_l,_outer_h]);

        difference() {
            translate([_t_wall,_t_wall,_t_b])
                cube([_rpi_padding*2+_rpi_w,_rpi_padding*2+_rpi_l,_outer_h-2*_t_b]);

            translate([0,_t_wall,_outer_h-_t_b])
            rotate([0,90,0])
            linear_extrude(height=_outer_w)
                polygon([[0,0],[0,(_outer_h-_split_offset-_t_b)*0.8],[_outer_h-_split_offset-_t_b,0]]);

        }


        _hole_padding=0.2;

        // SD card slot
        // We assume the slot is "almost" centered
        translate([_t_wall + _rpi_padding + _rpi_w/2 - _sd_width/2, _outer_l-_t_wall-_rpi_padding-_sd_inset,-1])
            cube([_sd_width,_sd_depth+_rpi_padding+_t_wall+_sd_inset+1,_h_rpi_offset+1]);

        translate([_t_wall+_rpi_padding,_t_wall+_rpi_padding,_h_rpi_offset+_rpi_t]) {

            // USB 1
            translate([40.43-_hole_padding/2,-2,0]) {
                usb(padding=_hole_padding,extends=_t_wall);
            }

            // USB 2
            translate([22.43-_hole_padding/2,-2,0]) {
                usb(padding=_hole_padding,extends=_t_wall);
            }

            // Ether
            _ether_padding = _hole_padding + 0.2;
            translate([2.5-_ether_padding/2,-2,0])
                ether(padding=_ether_padding,extends=_t_wall);

            // Audio
            translate([0,31,0])
                audio(padding=0.5,extends=2,hole=false);

            // HDMI
            translate([0.1,45.75,0])
                hdmi_hole(extends=_t_wall*2);

            // Micro USB
            translate([0.1,70.5,0])
                musb_hole();

        }

        // Camera
        if (camera_slot == "true") {
            translate([_t_wall+_rpi_padding,_t_wall+_rpi_padding+38.6,_t_b+_inner_h])
                rounded_slot(22.5,2.95,20);
        }

        if (video_slot == "true") {
            // Video
            translate([_t_wall+_rpi_padding+_rpi_w/2-22.5/2,_t_wall+_rpi_padding+79.55,,_t_b+_inner_h])
                rounded_slot(22.5,2.95,20);
        }

        if (gpio_slot == "true") {
            translate([_t_wall+_rpi_padding+49.9,_t_wall+_rpi_padding+27,5]) cube([5.1,51,20]);
        }

        // Cooling
        translate([_t_wall+_rpi_padding+16,_t_wall+_rpi_padding+20,_t_b+_inner_h]) {
            translate([0,0,0]) rotate([0,0,45]) rounded_slot(22.5,2.95,20);
            translate([8,0,0]) rotate([0,0,45]) rounded_slot(22.5,2.95,20);
            translate([16,0,0]) rotate([0,0,45]) rounded_slot(22.5,2.95,20);
            if (gpio_slot == "true") {
               translate([24,0,0]) rotate([0,0,45]) rounded_slot(22.5/2,2.95,20);
            } else {
               translate([24,0,0]) rotate([0,0,45]) rounded_slot(22.5,2.95,20);
            }

        }

        translate([_t_wall+_rpi_padding+18,_t_wall+_rpi_padding+50,_t_b+_inner_h]) {
            translate([0,0,0]) rotate([0,0,125]) rounded_slot(22.5,2.95,20);
            translate([8,0,0]) rotate([0,0,125]) rounded_slot(22.5,2.95,20);
            translate([16,0,0]) rotate([0,0,125]) rounded_slot(22.5,2.95,20);
            translate([24,0,0]) rotate([0,0,125]) rounded_slot(22.5,2.95,20);
            if (gpio_slot == "true") {
                translate([32,0,0]) rotate([0,0,125]) translate([22.5/2,0,0]) rounded_slot(22.5/2,2.95,20);
            } else {
                translate([32,0,0]) rotate([0,0,125]) rounded_slot(22.5,2.95,20);
            }
        }

    }
    
    // SD card slot support
    // We assume the slot is "almost" centered
    
    translate([_t_wall + _rpi_padding + _rpi_w/2 - _sd_width/2, _outer_l-_t_wall-_rpi_padding-11-_sd_inset,0])
        cube([_sd_width,11,_h_rpi_offset-2]);



}

module rounded_slot(l,t,h) {
    translate([t/2,t/2,0])
    hull() {
        cylinder(r=t/2,h=h);
        translate([l-t,0,0]) cylinder(r=t/2,h=h);
    }
}


module lid_cut() {
    difference() {
        box();
        translate([-1,-1,_split_offset-200])
            cube([_rpi_w*2,_rpi_l*2,200]);
    }
}

module lid() {




    _standoff_r=3.5;
    // Screw standoffs
    _height_start = _h_rpi_offset+_rpi_t+0.5;
    _height = _outer_h - _height_start;
    _hole_inset_r=3;

    difference() {
        union() {
            lid_cut();

            // Flap out for the SD card
            _sd_width = 11;
            _sd_depth = 3;
            translate([_t_wall + _rpi_padding + _rpi_w/2 - _sd_width/2, _t_wall+_rpi_padding*2 + _rpi_l,_h_rpi_offset])
                cube([_sd_width,_t_wall,_h_rpi_offset+1]);

            // Standoffs
            translate([0,0,_h_rpi_offset+_rpi_t+0.5]) {
                translate([_t_wall+_rpi_padding+_hole_offset,_t_wall+_rpi_padding+_rpi_l-_hole_offset,0])
                {
                    hull() {
                        cylinder(r=_standoff_r,h=_height);
                        translate([-_standoff_r,_hole_offset+_rpi_padding-1,0]) cube([_standoff_r*2,1,_height]);
                        translate([-_hole_offset-_rpi_padding,-_standoff_r,0]) cube([1,_standoff_r*2,_height]);
                        translate([-_rpi_padding-_hole_offset,0,0])  cube([_rpi_padding+_hole_offset,_rpi_padding+_hole_offset,_height]);
                    }
                }


                translate([_t_wall+_rpi_padding+_rpi_w-_hole_offset,_t_wall+_rpi_padding+_rpi_l-_hole_offset,0])
                {
                    hull() {
                        cylinder(r=_standoff_r,h=_height);
                        translate([-_standoff_r,_hole_offset+_rpi_padding-1,0]) cube([_standoff_r*2,1,_height]);
                        translate([_hole_offset+_rpi_padding-1,-_standoff_r,0]) cube([1,_standoff_r*2,_height]);
                        translate([0,0,0])  cube([_rpi_padding+_hole_offset,_rpi_padding+_hole_offset,_height]);
                    }
                }

                translate([_t_wall+_rpi_padding+_hole_offset,_t_wall+_rpi_padding+_rpi_l-_hole_offset-_rpi_hole_l_offset,0])
                {
                    hull() {
                        cylinder(r=_standoff_r,h=_height);
                        translate([-_hole_offset-_rpi_padding,-_standoff_r,0]) cube([1,_standoff_r*2,_height]);
                    }
                }

                translate([_t_wall+_rpi_padding+_rpi_w-_hole_offset,_t_wall+_rpi_padding+_rpi_l-_hole_offset-_rpi_hole_l_offset,0])
                {
                    hull() {
                        cylinder(r=_standoff_r,h=_height);
                        translate([_hole_offset+_rpi_padding-1,-_standoff_r,0]) cube([1,_standoff_r*2,_height]);
                    }
                }
            }
        }

        // Screw holes

        _standoff_hole_r=1.7;
        translate([_t_wall+_rpi_padding,_t_wall+_rpi_padding,0]) {
            translate([_hole_offset,_rpi_l-_hole_offset,0])
            {
               translate([0,0,-1]) cylinder(r=_standoff_hole_r,h=_height*2);
               translate([0,0,_outer_h-3]) cylinder(r=_hole_inset_r,h=4);
            }

            translate([_rpi_w-_hole_offset,_rpi_l-_hole_offset,0])
            {
               translate([0,0,-1]) cylinder(r=_standoff_hole_r,h=_height*2);
                translate([0,0,_outer_h-3]) cylinder(r=_hole_inset_r,h=4);
            }

            translate([_hole_offset,_rpi_l-_hole_offset-_rpi_hole_l_offset,0])
            {
               translate([0,0,-1]) cylinder(r=_standoff_hole_r,h=_height*2);
               translate([0,0,_outer_h-3]) cylinder(r=_hole_inset_r,h=4);
            }

            translate([_rpi_w-_hole_offset,_rpi_l-_hole_offset-_rpi_hole_l_offset,0])
            {
                translate([0,0,-1]) cylinder(r=_standoff_hole_r,h=_height*2);
                translate([0,0,_outer_h-3]) cylinder(r=_hole_inset_r,h=4);
            }
        }


    }

    if (hole_covers == "true") {
        translate([_t_wall+_rpi_padding,_t_wall+_rpi_padding,_outer_h-3]) {

            translate([_hole_offset,_rpi_l-_hole_offset,0])
            {
               cylinder(r=_hole_inset_r+0.1,h=0.2);
            }

            translate([_rpi_w-_hole_offset,_rpi_l-_hole_offset,0])
            {
                cylinder(r=_hole_inset_r+0.1,h=0.2);
            }

            translate([_hole_offset,_rpi_l-_hole_offset-_rpi_hole_l_offset,0])
            {
                cylinder(r=_hole_inset_r+0.1,h=0.2);
            }

            translate([_rpi_w-_hole_offset,_rpi_l-_hole_offset-_rpi_hole_l_offset,0])
            {
                cylinder(r=_hole_inset_r+0.1,h=0.2);
            }

        }
    }

}

module base_cut() {
    difference() {
        box();
        translate([-1,-1,_split_offset])
            cube([_rpi_w*2,_rpi_l*2,(_inner_h+_h_rpi_offset)*2]);
    }
}

module base() {

    difference() {

        union() {

            base_cut();

            _standoff_r=3.5;
            _standoff_hole_r=1.5;


            // Screw standoffs
            translate([_t_wall+_rpi_padding+_hole_offset,_t_wall+_rpi_padding+_rpi_l-_hole_offset,0])
            {
                difference() {
                    hull() {
                        cylinder(r=_standoff_r,h=_h_rpi_offset);
                        translate([-_standoff_r,_hole_offset+_rpi_padding-1,0]) cube([_standoff_r*2,1,_h_rpi_offset]);
                        translate([-_hole_offset-_rpi_padding,-_standoff_r,0]) cube([1,_standoff_r*2,_h_rpi_offset]);
                        translate([-_rpi_padding-_hole_offset,0,0])  cube([_rpi_padding+_hole_offset,_rpi_padding+_hole_offset,_h_rpi_offset]);
                    }
                    translate([0,0,_t_b]) cylinder(r=_standoff_hole_r,h=_h_rpi_offset);
                }
            }


            translate([_t_wall+_rpi_padding+_rpi_w-_hole_offset,_t_wall+_rpi_padding+_rpi_l-_hole_offset,0])
            {
                difference() {
                    hull() {
                        cylinder(r=_standoff_r,h=_h_rpi_offset);
                        translate([-_standoff_r,_hole_offset+_rpi_padding-1,0]) cube([_standoff_r*2,1,_h_rpi_offset]);
                        translate([_hole_offset+_rpi_padding,-_standoff_r,0]) cube([1,_standoff_r*2,_h_rpi_offset]);
                        translate([0,0,0])  cube([_rpi_padding+_hole_offset,_rpi_padding+_hole_offset,_h_rpi_offset]);
                    }
                    translate([0,0,_t_b]) cylinder(r=_standoff_hole_r,h=_h_rpi_offset);
                }
            }

            translate([_t_wall+_rpi_padding+_hole_offset,_t_wall+_rpi_padding+_rpi_l-_hole_offset-_rpi_hole_l_offset,0])
            {
                difference() {
                    hull() {
                        cylinder(r=_standoff_r,h=_h_rpi_offset);
                        translate([-_hole_offset-_rpi_padding,-_standoff_r,0]) cube([1,_standoff_r*2,_h_rpi_offset]);
                    }
                    translate([0,0,_t_b]) cylinder(r=_standoff_hole_r,h=_h_rpi_offset);
                }
            }

            translate([_t_wall+_rpi_padding+_rpi_w-_hole_offset,_t_wall+_rpi_padding+_rpi_l-_hole_offset-_rpi_hole_l_offset,0])
            {
                difference() {
                    hull() {
                        cylinder(r=_standoff_r,h=_h_rpi_offset);
                        translate([_hole_offset+_rpi_padding,-_standoff_r,0]) cube([1,_standoff_r*2,_h_rpi_offset]);
                    }
                    translate([0,0,_t_b]) cylinder(r=_standoff_hole_r,h=_h_rpi_offset);
                }
            }
        }

        // Cut out for the SD card
        _sd_width = 12;
        _sd_depth = 3;
        translate([_t_wall + _rpi_padding + _rpi_w/2 - _sd_width/2, _outer_l-_t_wall-_rpi_padding,4])
            cube([_sd_width,_sd_depth+_rpi_padding+_t_wall+1,_h_rpi_offset+1]);

    }


    if (mk3_mount == "true") {

        translate([_outer_w,_outer_l,0])
        difference() {
            union() {
                rotate([0,-90,0])
                linear_extrude(height=4)
                    polygon([[0,-1],[_split_offset,-1],[_split_offset,0.5],[50,0.5],[50,20],[0,20]]);

                linear_extrude(height=_split_offset)
                    polygon([[-24,-1],[-4,20],[-4,20-2],[-22,-1]]);
            }

            translate([-5,10,4]) rotate([0,90,0]) cylinder(r=1.5,h=6);
            translate([-20,10,4]) rotate([0,90,0]) cylinder(r=3,h=12);
            translate([-5,10,50-3]) rotate([0,90,0]) cylinder(r=1.5,h=6);

        }
    }

}
