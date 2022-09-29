use <ethoscope_top.scad>;
use <ethoscope_cam.scad>;
use <ethoscope_arenas.scad>;
use <ethoscope_arena_empty.scad>;

$fn = 30;

/* [General:] */
// combo box for number
wall_thick = 3;
primary_bolt = 3;
secondary_bolt = 2;
makerbeam = 10;
magnet_size = [6.2,3]; // diameter, height
wellplate_dims = [127.63,85.47,2]; 
target_diam = 7;

// Dimensions
dims = [160,160,15]; //normal length
magnet_dims = [dims[0]-25,dims[1],magnet_size[1]*2+wall_thick];
light_chamber_dims = [dims[0],dims[1],50];
arena_dims = [dims[0],dims[1],2];

// [diameter, height, gap width]
chamber_dims = [40,60]; // [
beam_height = 300;

// Camera specs
cam_dims = [40, 40]; // USB: [40,40] - RPi: [30, 25]
lens_diam = 25; // lens hole diameter
standoff_dims = [34,34,10]; // USB: [34,34,10] - RPi: [21,13.5,6];

arena_metabolic_chamber_vertical(
    arena_dims, 
    magnet_dims, 
    chamber_dims,
    magnet_size, 
    makerbeam
);

module arena_metabolic_chamber_vertical(
    dims, 
    magnet_dims, 
    chamber_dims,
    magnet_size, 
    makerbeam,
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
                rotate([90,0,0])
                cylinder(d=chamber_d+2*wall_thickness, h=chamber_h, center=true);
            }
        }
    }
        
}