// ----------------------------------------- //
// ------------- Respirometry -------------- //
// ----------------------------------------- //

use <arena_empty.scad>;

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