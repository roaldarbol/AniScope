use <../core/core.scad>;
module grid_box_scaffold(
    magnet_spacing = 85,
    magnet_size = [5, 3],
    makerbeam = 10,
    bolt_diam = 3
) {
    corner_structure_height = makerbeam; // Full height for corners
    magnet_dims = [magnet_spacing, magnet_spacing, corner_structure_height];
    
    beam_height = 2; // Just the visible lip height
    beam_width = 5;
    
    difference(){
        union(){
            // Corner holders
            corners(magnet_dims, makerbeam);
            mirror([1,0,0]) corners(magnet_dims, makerbeam);
            
            // Horizontal beams connecting corners - match visible corner height
            for (j = [-1, 1]) {
                translate([0, j * magnet_spacing/2, -makerbeam/2 + beam_height /2])
                    cube([magnet_spacing, beam_width, beam_height], center=true);
            }
            
            // Vertical beams connecting corners - match visible corner height
            for (i = [-1, 1]) {
                translate([i * magnet_spacing/2, 0, -makerbeam/2 + beam_height /2])
                    cube([beam_width, magnet_spacing, beam_height], center=true);
            }
        }
        
        // Bolt holes for Makerbeam attachment
        corners_hollow(magnet_dims, makerbeam, bolt_diam);
        mirror([1,0,0]) corners_hollow(magnet_dims, makerbeam, bolt_diam);
    }
}

// module grid_box_scaffold(
//     box_height = 50,
//     magnet_spacing = 85,
//     magnet_size = [5, 3],
//     makerbeam = 10
// ) {
//     beam_height = magnet_size[1] + 3;
//     magnet_dims = [magnet_spacing, magnet_spacing, box_height];
    
//     beam_width = 3;
//     side_thickness = 3.2;
    
//     difference(){
//         union(){
//             // Magnet holders in corners
//             difference(){
//                 translate([0,0,box_height / 2 - beam_height / 2]){
//                     corners(magnet_dims, makerbeam);
//                     mirror([1,0,0]) corners(magnet_dims, makerbeam);
//                 }

//                 // Slits for side elements
//                 // Horizontal beams connecting corners
//                 for (j = [-1, 1]) {
//                     #translate([0, j * magnet_spacing/2, box_height / 2])
//                         cube([magnet_spacing - 5, side_thickness, box_height], center=true);
//                 }
                
//                 // Vertical beams connecting corners
//                 for (i = [-1, 1]) {
//                     #translate([i * magnet_spacing/2, 0, box_height / 2])
//                         cube([side_thickness, magnet_spacing - 5, box_height], center=true);
//                 }
//             }
            
//             // Horizontal beams connecting corners
//             for (j = [-1, 1]) {
//                 translate([0, j * magnet_spacing/2, 0])
//                     cube([magnet_spacing, beam_width, beam_height], center=true);
//             }
            
//             // Vertical beams connecting corners
//             for (i = [-1, 1]) {
//                 translate([i * magnet_spacing/2, 0, 0])
//                     cube([beam_width, magnet_spacing, beam_height], center=true);
//             }
//         }
        
//         // Downward-facing magnets at bottom of each corner
//         translate([0, 0, -beam_height / 2 ]){
//             magnets2([magnet_spacing, magnet_spacing, magnet_size[1]+2], magnet_size, 3);
//             mirror([1,0,0]) magnets2([magnet_spacing, magnet_spacing, magnet_size[1]+2], magnet_size, 3);
//         }
//     }
// }