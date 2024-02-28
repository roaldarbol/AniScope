use <../core/core.scad>;

module adapter_neopixel(
    dims,
    makerbeam=10,
    wall_thick=3,
    magnet_pos="bottom",
    magnet_size, 
    adapter_magnet_dims, 
    bolt_diam,
    neopixel_diam
 ) {
     
     adapter_magnet_dims_low = [adapter_magnet_dims[0],adapter_magnet_dims[1], 3];
     neopixel_diam = neopixel_diam + 2;
    
   
    difference(){
        union(){
            corners(adapter_magnet_dims_low, makerbeam); // Central magnets
            mirror([1,0,0]) corners(adapter_magnet_dims_low, makerbeam); // Central magnets
            rounded_cube([62,62,magnet_size[1]+wall_thick]);
        }
        
        if (magnet_pos=="bottom"){
            // Bottom center magnets
            magnets(adapter_magnet_dims, magnet_size, wall_thick);
            mirror([1,0,0]) magnets(adapter_magnet_dims, magnet_size, wall_thick);
        }
        
        if (magnet_pos=="top"){
            // Top center magnets
            translate([0,0,magnet_size[1]]){
                magnets(adapter_magnet_dims, magnet_size, wall_thick);
                mirror([1,0,0]) magnets(adapter_magnet_dims, magnet_size, wall_thick);
            }
        }
      

//        rounded_cube([40,40,dims[2]]);
        translate([0,0,2]){
            cylinder(h=magnet_size[1]+wall_thick, d=neopixel_diam, center=true);
            
            difference(){
                cylinder(h=magnet_size[1]+wall_thick, d=56, center=true);
                cylinder(h=magnet_size[1]+wall_thick, d=52, center=true);
            }
                
//            translate([0,62/2,0])
            for (i=[0:3]){
                rotate([0,0,i*90])
                cube([3,70,magnet_size[1]+wall_thick], center=true);
            }

        }
    }
}

module adapter_neopixel_lid(
    lid_thickness,
    magnet_size,
    wall_thick
) {
    height = magnet_size[1] + wall_thick;
    outer_diam = 55.8;
    inner_diam = 52.2;
    
     difference(){
         cylinder(h=height, d=outer_diam, center=true);
         translate([0,0,0])
         cylinder(h=height, d=inner_diam, center=true);
         for (i=[0:7]){
             rotate([0,0,45*i/2])
             cube([4,70,height], center=true);
         }
     }
     translate([0,0,(height+lid_thickness)/2])
    cylinder(h=lid_thickness, d=outer_diam, center=true);
 }