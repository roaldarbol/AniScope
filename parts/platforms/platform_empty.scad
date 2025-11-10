use <../core/core.scad>;

module platform_empty(
    dims, 
    magnet_dims,
    magnet_size,
    makerbeam,
    top_magnets=false,
) {
    corner_height = magnet_size[1] + 3;
    magnet_dims = [magnet_dims[0], magnet_dims[1], corner_height];
    
    dimsA = [dims[0]-makerbeam-1, dims[1]+makerbeam, dims[2]];
    dimsB = [dims[0]+makerbeam, dims[1]-makerbeam-1, dims[2]];
    difference(){
        union(){
            
            // Plate base + magnet holders
            rounded_cube(dimsA, makerbeam/2, true);
            // rounded_cube(dimsB, makerbeam/2, true);
            translate([0,0,magnet_dims[2]/2-dims[2]/2]){
                corners(magnet_dims, makerbeam); // Corners
                mirror([1,0,0]) corners(magnet_dims, makerbeam); // Corners
            }
        }
               
        // Bottom magnets
        translate([0,0,-dims[2]/2]){
            magnets2([magnet_dims[0], magnet_dims[1], magnet_size[1]+2], magnet_size, 3);
            mirror([1,0,0]) magnets2([magnet_dims[0], magnet_dims[1], magnet_size[1]+2], magnet_size, 3);
        }
        if (top_magnets == true){
            // Bottom magnets
            translate([0,0,corner_height-dims[2]/2]){
                magnets2(magnet_dims, magnet_size, 3);
                mirror([1,0,0]) magnets2(magnet_dims, magnet_size, 3);
        }
    }
  }
}