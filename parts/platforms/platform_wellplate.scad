// -------------------------------- //
// ----------- Wellplate ---------- //
// -------------------------------- //

use <platform_empty.scad>;
use <../core/core.scad>;

module platform_wellplate(
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
            platform_empty(dims = dims, 
                        magnet_dims = magnet_dims,
                        magnet_size = magnet_size,
                        makerbeam = makerbeam);
            
            // Wellplate surround
            rotate([0,0,90])
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