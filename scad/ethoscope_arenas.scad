use <misc.scad>;
use <ethoscope_modules.scad>;
use <ethoscope_render.scad>;
use <ethoscope_arena_empty.scad>;
use <ethoscope_tube_stand.scad>;

// ----------------------------------------- //
// -------- Metabolic rate chamber --------- //
// ----------------------------------------- //

module arena_metabolic_chamber(
    dims, 
    magnet_dims, 
    chamber_dims,
    magnet_size, 
    makerbeam
) {
    
    chamber_d = chamber_dims[0]+2;
    chamber_h = chamber_dims[1];
    wall_thickness = 4;
    rubber_r = 1;
    
    union(){
        // Arena base
        arena_empty(
            dims = dims, 
            magnet_dims = magnet_dims,
            magnet_size = magnet_size, 
            makerbeam = makerbeam
        );
        
        // Translate other stuff on top
        translate([0,0,(chamber_dims[1]+dims[2])/2]){
            // Other stuff
            difference(){
                cylinder(d=chamber_d+2*wall_thickness, h=chamber_h, center=true);
                cylinder(d=chamber_d, h=chamber_h+1, center=true);
                cube([200,90,chamber_h+1], center=true);
                cube([chamber_dims[2],200,chamber_h+1], center=true);
                rotate_extrude(convexity = 10)
                translate([(chamber_dims[0]+2*wall_thickness + rubber_r)/2, 0, 0])
                circle(r = 1, $fn = 100);
            }
        }
    }
        
}


// -------------------------------- //
// ----------- Wellplate ---------- //
// -------------------------------- //

module arena_wellplate(
    dims, 
    magnet_dims, 
    wellplate_dims,
    magnet_size, 
    makerbeam,
    target_diam
) {
    
    magnet_dims = [magnet_dims[0], magnet_dims[1], magnet_size[1]+2];
    
    dimsA = [dims[0]-makerbeam-1, dims[1]+makerbeam, dims[2]];
    dimsB = [dims[0]+makerbeam, dims[1]-makerbeam-1, dims[2]];
    
    wp_outer = [wellplate_dims[0]+2, wellplate_dims[1]+2, wellplate_dims[2]];
    difference(){
        union(){
            // Plate base + magnet holders
            rounded_cube(dimsA, makerbeam/2, true);
            rounded_cube(dimsB, makerbeam/2, true);
            translate([0,0,magnet_dims[2]/2-dims[2]/2]){
                corners(magnet_dims, makerbeam); // Magnets
                mirror([1,0,0]) corners(magnet_dims, makerbeam); // Magnets
            }
            
            // Wellplate surround
            difference(){
                translate([0,0,dims[2]]) cube(wp_outer, center=true);
                translate([0,0,dims[2]]) cube(wellplate_dims, center=true);
            }
            
            // Make targets
            translate([0,0,dims[2]])
            for (i=[-1,1]){
                for (j=[-1,1]){
                    if (i > 0 && j > 0){ // Blank out to only make 3 targets
                        } else {
                            translate([i*dimsA[0]/2-20*i,j*wp_outer[1]/2+j*(dims[1]-wp_outer[1])/4,0])
                            cylinder(d=target_diam, h=dimsA[2], center=true);
                        }
                }
            }
        }

          
      // Bottom magnets
      translate([0,0,dims[2]]){
        magnets(magnet_dims, magnet_size, 3);
        mirror([1,0,0]) magnets(magnet_dims, magnet_size, 3);
      }
  }
}

module arena_tubes(
    dims, 
    magnet_dims, 
    magnet_size, 
    tube_dims,
    makerbeam
) {


    union(){
        // Arena base
        arena_empty(
            dims = dims, 
            magnet_dims = magnet_dims,
            magnet_size = magnet_size, 
            makerbeam = makerbeam
        );
        
        tube_disp = (tube_dims[1]-15) / 2;
        
        translate([0,0,tube_dims[0]/4+dims[2]])
        for (i=[-1,1]){
            translate([i*tube_disp,0,0])
            horizontal_tube_rack(
                tube_diam = tube_dims[0], 
                beam_width = makerbeam, 
                rack_length = 170, 
                insert = false);
        }
    }
}