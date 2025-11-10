use <../core/core.scad>;
use <floor.scad>;
use <wall.scad>;

module frame(
    dims, 
    magnet_pos, 
    makerbeam=10, 
    wall_type="hex",
    wall_thick=3, 
    magnet_size, 
    bolt_diam,
    with_led=false,
    floor_type="x",
    floor_thick=2,
    adapter_magnet_dims = []
) {
     
    magnet_pos = [magnet_pos[0], magnet_pos[1], dims[2]];

     difference(){
         
         // MakerBeam corner attachments
         union(){
             wall(dims, wall_thick, wall_type);
             floor(dims, floor_type, floor_thick, magnet_size, adapter_magnet_dims);
             corners(dims, makerbeam);
             mirror([1,0,0]) corners(dims, makerbeam);
             
             // Create the magnet attachments next to MakerBeam
             for (i = [0,90]){
                rotate([0,0,i])
                translate([0,0,-(dims[2]-magnet_pos[2])/2]){ // Magnets
                    corners(magnet_pos, makerbeam);
                    mirror([1,0,0]) corners(magnet_pos, makerbeam);

                    // Make some connection between the corner and the magnet uprights
                    corners(dims - [0,12.5,0], makerbeam);
                    mirror([1,0,0]) corners(dims - [0,12.5,0], makerbeam);
                    // corners(magnet_pos+[25/2,0,0], makerbeam); // filling empty space
                    // mirror([1,0,0]) corners(magnet_pos+[25/2,0,0], makerbeam);
                }
             }
         }

         for (i = [0,90]){
            rotate([0,0,i]){
                // Makerbeam corners
                corners_hollow(dims, makerbeam, bolt_diam);
                mirror([1,0,0]) corners_hollow(dims, makerbeam, bolt_diam);
                
                // Bottom magnets
                rotate([0,0,i])
                translate([0,0,-magnet_pos[2]/2]){ // Magnets
                    magnets2(magnet_pos, magnet_size, wall_thick);
                    mirror([1,0,0]) magnets2(magnet_pos, magnet_size, wall_thick);
                    mirror([0,1,0]) magnets2(magnet_pos, magnet_size, wall_thick);
                    mirror([1,1,0]) magnets2(magnet_pos, magnet_size, wall_thick);
                }

                // Top magnets – mirror the bottom placement across the Z‑midplane
                // #translate([0, 0, magnet_pos[2]/2 - magnet_size[1]])  // move 
                rotate([0,0,i])
                translate([0,0,magnet_pos[2]/2 - magnet_size[1]]){ // Magnets
                    magnets2(magnet_pos, magnet_size, wall_thick);
                    mirror([1,0,0]) magnets2(magnet_pos, magnet_size, wall_thick);
                    mirror([0,1,0]) magnets2(magnet_pos, magnet_size, wall_thick);
                    mirror([1,1,0]) magnets2(magnet_pos, magnet_size, wall_thick);
                }

                // Side magnets
                // magnet_pos_side = [
                //     magnet_pos[0], 
                //     magnet_pos[1] + magnet_size[1]/2
                //     ];
                // translate([0,0,-(magnet_pos[2]/2)+magnet_size[0]*1.5+35])
                // magnets(
                //     magnet_pos_side, 
                //     magnet_size, 
                //     // magnet_rot = [90,0,0],
                //     wall_thick);
            }
         }
     }
 }