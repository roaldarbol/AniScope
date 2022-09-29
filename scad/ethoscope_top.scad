use <misc.scad>;
use <ethoscope_modules.scad>;

module ethoscope_end(
    dims, 
    magnet_dims, 
    makerbeam=10, 
    wall_thick=3, 
    magnet_size, 
    bolt_diam, 
    with_floor=false,
    floor_thick=2
) {
     
    makerbeam = makerbeam + 0.2; // NEEDS A BETTER NAME!!!
    magnet_dims = [magnet_dims[0], magnet_dims[1], dims[2]];

     difference(){
         
         // MakerBeam corner attachments
         union(){
             wall(dims, wall_thick, with_floor, floor_thick);
             corners(dims, makerbeam);
             mirror([1,0,0]) corners(dims, makerbeam);
             translate([0,0,-(dims[2]-magnet_dims[2])/2]){ // Magnets
                corners(magnet_dims, makerbeam);
                mirror([1,0,0]) corners(magnet_dims, makerbeam);
                corners(magnet_dims+[25/2,0,0], makerbeam); // filling empty space
                mirror([1,0,0]) corners(magnet_dims+[25/2,0,0], makerbeam);
             }
         }
         corners_hollow(dims, makerbeam, bolt_diam);
         mirror([1,0,0]) corners_hollow(dims, makerbeam, bolt_diam);
         
//         Bottom magenets
         translate([0,0,-magnet_dims[2]/2+magnet_size[1]]){
            magnets(magnet_dims, magnet_size, wall_thick);
            mirror([1,0,0]) magnets(magnet_dims, magnet_size, wall_thick);   
         }
//         Top magnets
         translate([0,0,magnet_dims[2]/2]){
            magnets(magnet_dims, magnet_size, wall_thick);
            mirror([1,0,0]) magnets(magnet_dims, magnet_size, wall_thick);   
         }
     }
 }
 
// $fn = 30;
// // General
//wall_thick = 6;
//primary_bolt = 3;
//secondary_bolt = 2;
//makerbeam = 10;
//magnet_size = [6.2,3]; // diameter, height
//wellplate_dims = [127.63,85.47,2]; 
//target_diam = 7;
//
//// Dimensions
//dims = [160,160,15]; //normal length
//magnet_dims = [dims[0]-25,dims[1],magnet_size[1]*2+wall_thick];
//light_chamber_dims = [dims[0],dims[1],50];
//arena_dims = [dims[0],dims[1],2];
//chamber_dims = [100,20,20]; // [diameter, height, gap width]
//beam_height = 300;
//
//// Camera specs
//cam_dims = [40, 40]; // USB: [40,40] - RPi: [30, 25]
//lens_diam = 25; // lens hole diameter
//standoff_dims = [34,34,10]; // USB: [34,34,10] - RPi: [21,13.5,6];
// 
// ethoscope_end(
//    dims = light_chamber_dims, 
//    magnet_dims = magnet_dims, 
//    makerbeam = makerbeam, 
//    wall_thick = wall_thick, 
//    magnet_size = magnet_size, 
//    bolt_diam = primary_bolt, 
//    with_floor = true,
//    floor_thick = 2
//);
