use <misc.scad>;
use <ethoscope_modules.scad>;
use <ethoscope_render.scad>;
use <tube_stand_2.scad>;


        //// ARENA SPECS

dims = [155,150,15]; //normal length
wall_thick = 3;
magnet_size = [6.2,3]; // diameter, height
magnet_dims = [dims[0]-25,dims[1],magnet_size[1]*2+wall_thick];
arena_dims = [dims[0],dims[1],2];
makerbeam = 10;

        //// TUBES SPECS
// O-ring specs
outer_diam = 22;
ring_diam = 2.2;

// Tube rack specs
tube_diam = 20.5; //18.5
beam_width = 10;
rack_length = 165;
tube_length = 150;

// For standing
standing = 1;


arena_tubes(
    dims = arena_dims, 
    magnet_dims = magnet_dims,
    magnet_size = magnet_size, 
    makerbeam = makerbeam
);


module arena_tubes(
    dims, 
    magnet_dims,
    magnet_size, 
    makerbeam
) {
        
    magnet_dims = [magnet_dims[0], magnet_dims[1], magnet_size[1]+2];
    
    dimsA = [dims[0]-makerbeam-1, dims[1]+makerbeam, dims[2]];
    dimsB = [dims[0]+makerbeam, dims[1]-makerbeam-1, dims[2]];
    
    difference(){
        union(){
            
            // Plate base + magnet holders
            rounded_cube(dimsA, makerbeam/2, true);
            rounded_cube(dimsB, makerbeam/2, true);
            translate([0,0,magnet_dims[2]/2-dims[2]/2]){
                corners(magnet_dims, makerbeam); // Magnets
                mirror([1,0,0]) corners(magnet_dims, makerbeam); // Magnets
            }
        }
               
            // Bottom magnets
        translate([0,0,dims[2]]){
            magnets(magnet_dims, magnet_size, 3);
            mirror([1,0,0]) magnets(magnet_dims, magnet_size, 3);
        }
  }
  
  translate([0,-64.4,8])
rotate([0,0,90])
horizontal_tube_rack(
    tube_diam = tube_diam,
    beam_width = beam_width,
    rack_length = rack_length,
  insert = false);

translate([0,64.4,8])
rotate([0,0,90])
horizontal_tube_rack(
    tube_diam = tube_diam,
    beam_width = beam_width,
    rack_length = rack_length,
  insert=false);
}




            