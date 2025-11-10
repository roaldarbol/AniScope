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
            // Remove outer edges
            removal = 20;
            translate([((dims[0]+removal/2)/2)-0.4,0,0])
            cube([removal,dims[1],makerbeam], center=true);
            translate([((-dims[0]-removal/2)/2)+0.4,0,0])
            cube([removal,dims[1],makerbeam], center=true);
        }
    }
}