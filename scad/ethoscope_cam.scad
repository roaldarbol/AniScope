use <misc.scad>;
use <ethoscope_modules.scad>;

module ethoscope_x_mount(
    dims,
    makerbeam=10,
    wall_thick=3, 
    magnet_size, 
    standoff_dims, 
    bolt_diam, 
    cam_dims, 
    lens_diam
 ) {
 
    level = -magnet_size[1]/2;
    
        union(){
            difference(){
                union(){
                    corners(standoff_dims, makerbeam); // Central magnets
                    mirror([1,0,0]) corners(standoff_dims, makerbeam); // Central magnets
                    corners(dims, makerbeam); // Peripheral magnets
                    mirror([1,0,0]) corners(dims, makerbeam); // Peripheral magnets
                    cross_top(dims, makerbeam, magnet_size, wall_thick);
                    rounded_cube([62,62,magnet_size[1]+wall_thick]);
                }
          
                // Top center magnets
                translate([0,0,-magnet_size[1]*0.5]){
                  magnets(standoff_dims, magnet_size, wall_thick);
                  mirror([1,0,0]) magnets(standoff_dims, magnet_size, wall_thick);
                }

                // Bottom center magnets
                translate([0,0,magnet_size[1]*1.5]){
                magnets(standoff_dims, magnet_size, wall_thick);
                mirror([1,0,0]) magnets(standoff_dims, magnet_size, wall_thick);
                }

                // Top peripheral magnets
                translate([0,0,-magnet_size[1]*0.5]){
                  magnets(dims, magnet_size, wall_thick);
                  mirror([1,0,0]) magnets(dims, magnet_size, wall_thick);
                }
          
                // Bottom peripheral magnets
                translate([0,0,magnet_size[1]*1.5]){
                    magnets(dims, magnet_size, wall_thick);
                    mirror([1,0,0]) magnets(dims, magnet_size, wall_thick);
                }
                
                rounded_cube([40,40,dims[2]]);
            }
        }
}