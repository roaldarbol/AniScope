use <misc.scad>;
use <ethoscope_modules.scad>;
use <ethoscope_render.scad>;


module arena_empty(
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
}