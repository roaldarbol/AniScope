use <../core/core.scad>;

module adapter_usb_cam(
    n_cams=1,
    dims,
    makerbeam=10,
    wall_thick=3,
    magnet_pos="bottom",
    magnet_size, 
    adapter_magnet_dims, 
    bolt_diam,
    usb_hole_positions,
    lens_hole_diam
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
      
        translate([0,0,wall_thick])
        rounded_cube([n_cams*adapter_magnet_dims[0]-10,adapter_magnet_dims[1]-10,dims[2]]);
        
        if (n_cams==1){
            translate([0,0,-3*1.5])
            for (j=[0,1]){
                rotate([0,0,j*90])
                for(k=usb_hole_positions){
                        translate([k[0], k[1],0])
                        cylinder(d=bolt_diam, h=wall_thick*4);
                }
            }
            // Lens
            cylinder(d=lens_hole_diam, h=dims[2]*4, center = true);
        } else if (n_cams==2){
            for (i = [-1,1]){
                translate([i*adapter_magnet_dims[0]/2,0,0]){
                    for (j=[0,1]){
                        rotate([0,0,j*90])
                        for(k=usb_hole_positions){
                                translate([k[0], k[1],0])
                                cylinder(d=bolt_diam, h=wall_thick*4, center = true);
                        }
                    }
                // Lens
                cylinder(d=lens_hole_diam, h=dims[2]*4, center = true);
                }
            }
        }
    }
}