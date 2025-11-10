use <../core/core.scad>;

module x_mount(
    dims,
    makerbeam=10,
    wall_thick=3, 
    magnet_size, 
    adapter_magnet_dims
 ) {
 
    level = -magnet_size[1]/2;
    
        union(){
            difference(){
                union(){
                    corners(dims, makerbeam); // Central magnets
                    mirror([1,0,0]) corners(dims, makerbeam); // Central magnets
                    corners(dims, makerbeam); // Peripheral magnets
                    mirror([1,0,0]) corners(dims, makerbeam); // Peripheral magnets
                    cross(dims, makerbeam);
                    rounded_cube([62,62,dims[2]]);
                }
          
                // Top center magnets
                #for (i = [0,90]){
                    rotate([0,0,i])
                    translate([0,0,(-magnet_size[1]) + dims[2]/2]){ // Magnets
                    magnets2(adapter_magnet_dims, magnet_size, wall_thick);
                    mirror([1,0,0]) magnets2(adapter_magnet_dims, magnet_size, wall_thick);
                    }
                }

                // Bottom center magnets
                for (i = [0,90]){
                    rotate([0,0,i])
                    translate([0,0, -dims[2]/2]){ // Magnets
                    magnets2(adapter_magnet_dims, magnet_size, wall_thick);
                    mirror([1,0,0]) magnets2(adapter_magnet_dims, magnet_size, wall_thick);
                    }
                }

                // Top peripheral magnets
                for (i = [0,90]){
                    translate([0,0,(-magnet_size[1]) + dims[2]/2]){ // Magnets
                    magnets2(dims, magnet_size, wall_thick);
                    mirror([1,0,0]) magnets2(dims, magnet_size, wall_thick);
                    }
                }
          
                // Bottom peripheral magnets
                for (i = [0,90]){
                    translate([0,0, -dims[2]/2]){ // Magnets
                    magnets2(dims, magnet_size, wall_thick);
                    mirror([1,0,0]) magnets2(dims, magnet_size, wall_thick);
                    }
                }
                
                rounded_cube([40,40,dims[2]]);
            }
        }
}