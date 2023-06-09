use <misc.scad>;
use <ethoscope_modules.scad>;

module ethoscope_base(
    dims, 
    magnet_dims, 
    makerbeam=10, 
    wall_thick=3, 
    magnet_size, 
    bolt_diam, 
    with_floor=false,
    with_led=false,
    floor_thick=2
) {
     
    makerbeam = makerbeam + 0.2; // NEEDS A BETTER NAME!!!
    magnet_dims = [magnet_dims[0], magnet_dims[1], dims[2]];

     difference(){
         
         // MakerBeam corner attachments
         union(){
             wall(dims, wall_thick, with_floor, with_led, floor_thick);
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