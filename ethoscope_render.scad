use <misc.scad>;
use <ethoscope_top.scad>;
use <ethoscope_cam.scad>;
use <ethoscope_arenas.scad>;
use <ethoscope_arena_empty.scad>;

$fn = 200;

// General
wall_thick = 3;
primary_bolt = 3;
secondary_bolt = 2;
makerbeam = 10;
magnet_size = [6.2,3]; // diameter, height
wellplate_dims = [127.63,85.47,2]; 
target_diam = 7;

// Dimensions
dims = [160,160,15]; //normal length
magnet_dims = [dims[0]-25,dims[1],magnet_size[1]*2+wall_thick];
central_magnet_dims = [50,50,magnet_size[1]*2+wall_thick];
light_chamber_dims = [dims[0],dims[1],20];
arena_dims = [dims[0],dims[1],2];
chamber_dims = [100,20,20]; // [diameter, height, gap width]
beam_height = 300;

// Camera specs
cam_dims = [50, 50]; // USB: [40,40] - RPi: [30, 25]
lens_diam = 25; // lens hole diameter
standoff_dims = [34,34,10]; // USB: [34,34,10] - RPi: [21,13.5,6];
usb_hole_distances = [28,28];
usb_hole_positions = get_points(usb_hole_distances);
// ======= Full models ======== //

////// Top
//color([0.3,0.3,0.3])
////translate([0,0,beam_height])
//rotate([180,0,0])
//ethoscope_end(
//    dims = dims, 
//    magnet_dims = magnet_dims, 
//    makerbeam = makerbeam, 
//    wall_thick = 6, 
//    magnet_size = magnet_size, 
//    bolt_diam = primary_bolt, 
//    with_floor = false
//);


// Camera mount
//color([0.3,0.3,0.3])    
////translate([0,0,beam_height-1.25*dims[2]])
//rotate([180,0,0])
//ethoscope_cam(
//    dims = magnet_dims,
//    makerbeam = makerbeam,
//    wall_thick = 6, 
//    magnet_size = magnet_size, 
//    standoff_dims = central_magnet_dims, 
//    bolt_diam = secondary_bolt,
//    cam_dims = cam_dims, 
//    lens_diam = lens_diam
// );
 
 color([0.3,0.3,0.3])    
//translate([0,0,beam_height-1.25*dims[2]])
rotate([180,0,0])
ethoscope_usb_cam_adapter(
    dims = magnet_dims,
    makerbeam = makerbeam,
    wall_thick = 3, 
    magnet_pos = "bottom",
    magnet_size = magnet_size, 
    standoff_dims = central_magnet_dims, 
    bolt_diam = 2.5,
    cam_dims = cam_dims, 
    lens_diam = lens_diam,
    usb_hole_positions = usb_hole_positions
 );



// Light chamber
//intersection(){
//    translate([0,0,light_chamber_dims[2]/2])
//    color([1,1,1])
//    ethoscope_end(
//        dims = light_chamber_dims, 
//        magnet_dims = magnet_dims, 
//        makerbeam = makerbeam, 
//        wall_thick = 6, 
//        magnet_size = magnet_size, 
//        bolt_diam = primary_bolt, 
//        with_floor = true,
//        floor_thick = 2
//    );
//    translate([dims[0]/2-20,dims[1]/2-10,0])
//    cube([30,30,100]);
//}
    


//// Arena
//translate([0,0,light_chamber_dims[2]+5])
//color([1,1,1])
//arena_empty(
//    dims = arena_dims, 
//    magnet_dims = magnet_dims,
//    magnet_size = magnet_size, 
//    makerbeam = makerbeam
//);
////!arena_metabolic_chamber(
////    dims = arena_dims, 
////    magnet_dims = magnet_dims, 
////    chamber_dims = chamber_dims,
////    magnet_size = magnet_size, 
////    makerbeam = makerbeam
////);
//
//
//// Makerbeams
//color([0.6,0.6,0.6]){
//for (i=[-1,1]){
//    translate([dims[0]/2,i*dims[1]/2,beam_height/2])
//    cube([makerbeam, makerbeam, beam_height], center=true);
//}
//mirror([1,0,0])
//for (i=[-1,1]){
//    translate([dims[0]/2,i*dims[1]/2,beam_height/2])
//    cube([makerbeam, makerbeam, beam_height], center=true);
//}
//}