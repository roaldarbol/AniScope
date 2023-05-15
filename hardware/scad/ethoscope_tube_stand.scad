use <misc.scad>;
use <ethoscope_modules.scad>;

// ========================================= //
// ============ TEST TUBE MOUNT ============ //
// ========================================= //

// Here's some documentation of what the holder is, and what it's used for..
// Maybe a brief licensing bit?


// Generate the damn thing
//rack only
//horizontal_tube_rack(tube_diam, beam_width, rack_length, insert = true);

//separator only
//tube_separators(sep_length, sep_width, sep_height);

// ========================================= //
// ================ Specs ================== //
// ========================================= //

// Current specs fit these tubes from Amazon (https://amzn.to/3n3Qyw3) 
// with these O-rings (https://amzn.to/30EqjF5)

// General specs
////$fn = 30;
wall_thick = 2;
bolt = 3.2;
bolt_diameter = 0.0; 
makerbeam = 10;


// O-ring specs
outer_diam = 22;
ring_diam = 2.2;


// Tube rack specs
tube_diam = 20.5; //18.5
beam_width = 10;
rack_length = 170;

// Specs Tube separator insert
sep_length = 137;
sep_width = 1;
sep_height = 45;

// For standing
standing = 1;


            

// ========================================= //
// ================ Modules ================ //
// ========================================= //


// === Module: O-ring === //
module o_ring(outer_diam, ring_diam) {
    outer_diam = outer_diam + 1;
    rotate([0,0,0])
    rotate_extrude(angle=360) {
        translate([(outer_diam-ring_diam/2)/2, 0])
        circle(d=ring_diam); 
        } // rotate_extrude
    cylinder(d=outer_diam-ring_diam/2, h=ring_diam, center=true);
}
            

// === Module: Test tube rack === //
module horizontal_tube_rack(
    tube_diam, 
    beam_width, 
    rack_length, 
    magnet_size,
    insert=false
) {
    
    tube_diam = tube_diam + 0.1;
    min_space_between = 3;
    space_above = 5;
    beam_width = beam_width + 0.2;
    rack_width = (4*wall_thick)+ring_diam;
    rack_height = space_above+tube_diam/2;
    end_space = 2 * (beam_width+wall_thick);
    
    // Calculate the max number of tubes and their spacing
    func_tube = tube_diam+min_space_between;
    n_tubes = floor((rack_length)/(tube_diam+min_space_between));
    shift = (rack_length - (n_tubes*tube_diam + (n_tubes-1)*min_space_between)) / 2;
    
    union(){
        difference(){
            rounded_cube([rack_width, rack_length, rack_height], radius=makerbeam/2, outside=true);
            
            // Inserts for tubes
            rotate([0,90,0])
            translate([-rack_height/2,-(rack_length-tube_diam)/2+shift,0])
            for (i=[0:1:n_tubes-1]){
                translate([0,i*(tube_diam+min_space_between),0]){
                    cylinder(d=tube_diam, h=beam_width, center=true);
                    o_ring(outer_diam,ring_diam);
                }
            }

            // Inserts for separators
            if (insert == true){
                rotate([0,90,0])
                translate([-rack_height/2,-(rack_length-tube_diam)/2-shift*0.9,0])
                for (i=[0:1:n_tubes]){
                    translate([0,i*(tube_diam+min_space_between),0]){
                        cube([rack_length, sep_width+0.25, rack_height], center=true);
                    }
                }
            }

            // Inserts for magnets
            #translate([0,-(rack_length-tube_diam)/2+shift,-rack_height/2+magnet_size[1]-1])
            for (i=[0:1:n_tubes-1]){
                translate([0,i*(tube_diam+min_space_between),0])
                cylinder(d=magnet_size[0], h=magnet_size[1]+0.5);
            }
            
            // Standing rack
            if (standing > 0.5){
                end_length = 2*beam_width;
                bolt_rad= (bolt_diameter+1)/2;
            }
        }
    }
}

