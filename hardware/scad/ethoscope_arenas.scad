use <misc.scad>;
use <ethoscope_modules.scad>;
use <ethoscope_render.scad>;
use <ethoscope_arena_empty.scad>;
use <ethoscope_tube_stand.scad>;

// ----------------------------------------- //
// -------- Metabolic rate chamber --------- //
// ----------------------------------------- //

module sleep_preference_module(
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

module arena_sleep_preference(
    dims,
    magnet_dims,
    magnet_size,
    makerbeam
) {
    union(){
        // Arena base
        difference(){
            arena_empty(
                dims = dims, 
                magnet_dims = magnet_dims,
                magnet_size = magnet_size, 
                makerbeam = makerbeam,
                corner_height=magnet_size[1]+2
            );
            
            // Remove outer edges
            removal = 20;
            translate([((dims[0]+removal/2)/2)-0.4,0,0])
            cube([removal,dims[1],makerbeam], center=true);
            translate([((-dims[0]-removal/2)/2)+0.4,0,0])
            cube([removal,dims[1],makerbeam], center=true);
        }
        
        for (i=[-1,1]){
            for (j=[-1,1]){
                translate([i*dims[1]/4.5, j*dims[1]/4.5,0])
                sleep_preference_module();
            }
        }
    }
}

module arena_metabolic_chamber(
    dims, 
    magnet_dims, 
    chamber_dims,
    magnet_size, 
    makerbeam
) {
    
    chamber_d = chamber_dims[0]+2;
    chamber_h = chamber_dims[1];
    wall_thickness = 4;
    rubber_r = 1;
    
    union(){
        // Arena base
        arena_empty(
            dims = dims, 
            magnet_dims = magnet_dims,
            magnet_size = magnet_size, 
            makerbeam = makerbeam,
            corner_height=magnet_size[1]+2
        );
        
        // Translate other stuff on top
        translate([0,0,(chamber_dims[1]+dims[2])/2]){
            // Other stuff
            difference(){
                cylinder(d=chamber_d+2*wall_thickness, h=chamber_h, center=true);
                cylinder(d=chamber_d, h=chamber_h+1, center=true);
                cube([200,90,chamber_h+1], center=true);
                cube([chamber_dims[2],200,chamber_h+1], center=true);
                rotate_extrude(convexity = 10)
                translate([(chamber_dims[0]+2*wall_thickness + rubber_r)/2, 0, 0])
                circle(r = 1, $fn = 100);
            }
        }
    }
        
}


// -------------------------------- //
// ----------- Wellplate ---------- //
// -------------------------------- //

module arena_wellplate(
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
            // Plate base + magnet holders
            rounded_cube(dimsA, makerbeam/2, true);
            rounded_cube(dimsB, makerbeam/2, true);
            translate([0,0,magnet_dims[2]/2-dims[2]/2]){
                corners(magnet_dims, makerbeam); // Magnets
                mirror([1,0,0]) corners(magnet_dims, makerbeam); // Magnets
            }
            
            // Wellplate surround
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

module arena_tubes(
    dims, 
    magnet_dims, 
    magnet_size, 
    tube_dims,
    makerbeam
) {


    union(){
        difference(){
            // Arena base
            arena_empty(
                dims = dims, 
                magnet_dims = magnet_dims,
                magnet_size = magnet_size, 
                makerbeam = makerbeam,
                corner_height=magnet_size[1]+2
            );
            // Remove outer edges
            removal = 20;
            translate([((dims[0]+removal/2)/2)-0.4,0,0])
            cube([removal,dims[1],makerbeam], center=true);
            translate([((-dims[0]-removal/2)/2)+0.4,0,0])
            cube([removal,dims[1],makerbeam], center=true);
        }
        
        tube_disp = (tube_dims[1]-15) / 2;
        
        translate([0,0,tube_dims[0]/4+dims[2]])
        for (i=[-1,1]){
            translate([i*tube_disp,0,0])
            horizontal_tube_rack(
                tube_diam = tube_dims[0], 
                beam_width = makerbeam, 
                rack_length = 170, 
                magnet_size = magnet_size,
                insert = false);
        }
    }
}

module arena_spacer(
    dims,
    magnet_dims,
    magnet_size,
    makerbeam,
    corner_height
) {
    
    arena_empty(
            dims = dims, 
            magnet_dims = magnet_dims,
            magnet_size = magnet_size, 
            makerbeam = makerbeam,
            corner_height=20,
            top_magnets = true
        );
}