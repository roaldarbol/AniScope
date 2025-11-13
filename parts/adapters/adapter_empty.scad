use <../core/core.scad>;

module adapter_empty(
    n=1,
    dims,
    makerbeam=10,
    wall_thick=3,
    magnet_pos="bottom",
    magnet_size, 
    adapter_magnet_dims, 
) {
    adapter_magnet_dims_low = [adapter_magnet_dims[0],adapter_magnet_dims[1], magnet_size[1]];
   
    difference(){
        union(){
            rounded_cube([(n*adapter_magnet_dims[0])+12.5,adapter_magnet_dims[1]+12.5,magnet_size[1]+wall_thick]);
        }
        
        if (magnet_pos=="bottom"){
            translate([0,0,-(magnet_size[1]/2+wall_thick/2)]){
                // Bottom center magnets
                magnets2(adapter_magnet_dims, magnet_size, wall_thick);
                mirror([1,0,0]) magnets2(adapter_magnet_dims, magnet_size, wall_thick);
            }
        }
        
        if (magnet_pos=="top"){
            // Top center magnets
            translate([0,0,-(magnet_size[1]-wall_thick)/2]){
                magnets2(adapter_magnet_dims, magnet_size, wall_thick);
                mirror([1,0,0]) magnets2(adapter_magnet_dims, magnet_size, wall_thick);
            }
        }
      
        translate([0,0,wall_thick])
        rounded_cube([n*adapter_magnet_dims[0]-10,adapter_magnet_dims[1]-10,dims[2]*5]);
    }
}
