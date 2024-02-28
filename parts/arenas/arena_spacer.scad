// -------------------------------- //
// ------------ Spacer ------------ //
// -------------------------------- //

use <arena_empty.scad>;

module arena_spacer(
    dims,
    magnet_dims,
    magnet_size,
    makerbeam,
    corner_height
) {
    
    arena_empty(
            dims = dims, 
            magnet_dims = magnet_dims,
            magnet_size = magnet_size, 
            makerbeam = makerbeam,
            corner_height=20,
            top_magnets = true
        );
}