// ----------------------------------------- //
// ---------------- Tubes ------------------ //
// ----------------------------------------- //

use <platform_empty.scad>;
use <../core/core.scad>;

module platform_petri(
    dims, 
    magnet_dims, 
    magnet_size, 
    tube_dims,
    o_ring_dims,
    makerbeam
) {
    union(){
        difference(){
            // platform base
            platform_empty(
                dims = dims, 
                magnet_dims = magnet_dims,
                magnet_size = magnet_size, 
                makerbeam = makerbeam
            );
            // Remove outer edges
            removal = 20;
            translate([((dims[0]+removal/2)/2)-0.4,0,0])
            cube([removal,dims[1],makerbeam], center=true);
            translate([((-dims[0]-removal/2)/2)+0.4,0,0])
            cube([removal,dims[1],makerbeam], center=true);
        }
        
        tube_disp = (tube_dims[2]-15) / 2;
        
        translate([0,0,tube_dims[0]/4+dims[2]])
        for (i=[-1,1]){
            translate([i*tube_disp,0,0])
            horizontal_tube_rack(
                tube_diam = tube_dims[0], 
                beam_width = makerbeam, 
                rack_length = 170, 
                magnet_size = magnet_size,
                o_ring_dims = o_ring_dims,
                insert = false);
        }
    }
}

// === Module: Test tube rack === //
module horizontal_tube_rack(
    tube_diam, 
    beam_width, 
    rack_length, 
    magnet_size,
    o_ring_dims,
    insert=false
) {
    
    tube_diam = tube_diam + 0.1;
    min_space_between = 3;
    space_above = 5;
    beam_width = beam_width + 0.2;
    rack_width = (4*wall_thick)+o_ring_dims[1];
    echo(rack_width);
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
                    cylinder(d=tube_diam, h=beam_width+10, center=true);
                    o_ring(o_ring_dims[0],o_ring_dims[1]);
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
            translate([0,-(rack_length-tube_diam)/2+shift,-rack_height/2+magnet_size[1]-1])
            for (i=[0:1:n_tubes-1]){
                translate([0,i*(tube_diam+min_space_between),0])
                cylinder(d=magnet_size[0], h=magnet_size[1]+0.5);
            }
            
            // Standing rack
            // if (standing > 0.5){
            //     end_length = 2*beam_width;
            //     bolt_rad= (bolt_diameter+1)/2;
            // }
        }
    }
}