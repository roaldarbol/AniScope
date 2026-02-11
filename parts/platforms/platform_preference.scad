use <platform_empty.scad>;
use <../core/core.scad>;
use <../misc/misc.scad>;

module platform_sleep_preference(
    dims,
    module_type,
    magnet_dims,
    magnet_size,
    makerbeam
) {
    union(){
        // platform base
        difference(){
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

            // rounded_cube([80, 80, 50], outside = true);
            // rounded_cube([83, 83, 10], outside = true);
        }
        
        if (module_type == "a"){
            for (i=[-1,1]){
                for (j=[-1,1]){
                    translate([i*dims[1]/4.5, j*dims[1]/4.5,0])
                    sleep_preference_module_a();
                }
            }
        } else if (module_type == "b") {
            translate([0,0,dims[2]/2]){
                translate([0,0,40 / 2])
                difference(){
                    rounded_cube([84, 84, 40], outside = true);
                    rounded_cube([82, 82, 50], outside = true);
                    translate([0,-5,0])
                    #rounded_cube([40, 82, 40], outside = true);
                }
                
                // Main place
                translate([0,-50,40 / 2 - 1.5])
                fan_holder([40,12,40]);
            }
        }
    }
}


module sleep_preference_module_a(
    n_rooms = 4
) {

    outer_d = 68;
    glass_h = 10;
    neopixel_h = glass_h - 4;
    neopixel_d_outer = 66;
    neopixel_d_inner = 52;
    inner_d = 30;
    translate([0,0,2])
    difference(){
        union(){
            // Outer high
            difference(){
                cylinder(d=outer_d,h=glass_h+2);
                cylinder(d=outer_d-1, h=glass_h+4);
            }
            
            // Outer glass
            difference(){
                cylinder(d=outer_d-1, h=glass_h);
                cylinder(d=outer_d-2, h=glass_h+2);
            }
            
            // Outer NeoPixel
            difference(){
                cylinder(d=neopixel_d_outer, h=glass_h-4);
                cylinder(d=neopixel_d_outer-2, h=glass_h);
            }
            
            // Inner NeoPixel
            difference(){
                cylinder(d=neopixel_d_inner+1, h=glass_h-4);
                cylinder(d=neopixel_d_inner-1, h=glass_h);
            }
            
            // Outer bedroom wall
            difference(){
                cylinder(d=neopixel_d_inner-1, h=glass_h);
                cylinder(d=neopixel_d_inner-2, h=glass_h+2);
            }
            
            // Inner wall
            difference(){
                cylinder(d=inner_d, h=10);
                cylinder(d=inner_d-2, h=16);
                translate([0,0,2.5])
                for (i=[0,90]){
                    rotate([0,0,i])
                    cube([50,10,5], center=true);
                }
            }
            
            // Side walls
            union(){
                for (i=[45,135]){
                    for (j=[-10,10]){
                        difference(){
                            rotate([0,0,i+j])
                            translate([0,0,5])
                            cube([2,neopixel_d_outer,10], center=true);
                            cylinder(d=inner_d-2,h=11);
                        }
                    }
                }
            }     
        }
        translate([0,0,neopixel_h])
        difference(){
            cylinder(d=neopixel_d_outer, h=4);
            translate([0,0,-1])
            cylinder(d=neopixel_d_inner-1, h=6);
        }
        
        #rotate([0,0,45])
        translate([outer_d/2,0,glass_h+0.5])
        cube([5,5,3], center=true);
    }
    
    // Bottom floor
    cylinder(d=outer_d, h=2);
   
}