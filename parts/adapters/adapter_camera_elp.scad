use <../core/core.scad>;

module adapter_usb_elp(
    n_cams=1,
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
            rounded_cube([(n_cams*adapter_magnet_dims[0])+12.5,adapter_magnet_dims[1]+12.5,magnet_size[1]+wall_thick]);
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
      
        rounded_cube([n_cams*adapter_magnet_dims[0]-10,adapter_magnet_dims[1]-10,dims[2]*3]);
        
        if (n_cams==1){

        } else if (n_cams==2){

        }
    }
    enclosure_dims = [42,42,30];
    connector_dims = [24,100,enclosure_dims[2]];
    translate([0,0,enclosure_dims[2]/2])
    difference() {
        rounded_cube(dims = [enclosure_dims[0]+3,enclosure_dims[1]+3,enclosure_dims[2]], radius = 1, outside = false);
        rounded_cube(dims = [enclosure_dims[0], enclosure_dims[1], enclosure_dims[2]], radius = 1, outside = false);
        
        // Remove some walls where the connector can go through
        rounded_cube(dims = connector_dims, radius = 1, outside = false);
        rotate([0,0,90])
        rounded_cube(dims = connector_dims, radius = 1, outside = false);
    }
}