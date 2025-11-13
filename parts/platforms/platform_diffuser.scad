// ----------------------------------------- //
// ---------------- Tubes ------------------ //
// ----------------------------------------- //

use <platform_empty.scad>;
use <../core/core.scad>;

module platform_diffuser(
    dims, 
    magnet_dims, 
    magnet_size, 
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
        }
    }
}