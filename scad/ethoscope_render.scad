use <misc.scad>;
use <ethoscope_top.scad>;
use <ethoscope_cam.scad>;
use <ethoscope_arenas.scad>;
use <ethoscope_arena_empty.scad>;
use <ethoscope_adapters.scad>;

$fn = 100;

// General
wall_thick = 3;
primary_bolt = 3;
secondary_bolt = 2;
makerbeam = 10.2;
magnet_size = [6.2,3]; // diameter, height
wellplate_dims = [127.63,85.47,2]; 
target_diam = 7;

// Dimensions
dims = [160,160,15]; //normal length
magnet_dims = [dims[0]-25,dims[1],magnet_size[1]*2+wall_thick];
central_magnet_dims = [50,50,magnet_size[1]*2+wall_thick];
light_chamber_dims = [dims[0],dims[1],40];
arena_dims = [dims[0],dims[1],3];
chamber_dims = [100,20,20]; // [diameter, height, gap width]
tube_dims = [20.5, 130]; // [diameter, length]

// Camera specs
cam_dims = [50, 50]; // USB: [40,40] - RPi: [30, 25]
lens_diam = 25; // lens hole diameter
standoff_dims = [34,34,10]; // USB: [34,34,10] - RPi: [21,13.5,6];
usb_hole_distances = [21,13.5]; // USB: [28,28] - RPi: [21,13.5];
usb_hole_positions = get_points(usb_hole_distances);

// NeoPixel diffuser
lid_thickness = 10;

// Missc for visualization
beam_height = 300;


// ======= Full models ======== //

sleep_preference_module($fn = 200);

//arena_sleep_preference(
//    dims = arena_dims,
//    magnet_dims = magnet_dims,
//    magnet_size = magnet_size,
//    makerbeam = makerbeam,
//    $fn = 200
//);


//arena_spacer(
//    dims = arena_dims, 
//    magnet_dims = magnet_dims,
//    magnet_size = magnet_size, 
//    makerbeam = makerbeam,
//    corner_height = 20
//    );
    

////// Top
//color([0.3,0.3,0.3])
//translate([0,0,beam_height])
//rotate([180,0,0])
//ethoscope_end(
//    dims = dims, 
//    magnet_dims = magnet_dims, 
//    makerbeam = makerbeam, 
//    wall_thick = 5, 
//    magnet_size = magnet_size, 
//    bolt_diam = primary_bolt, 
//    with_floor = false 
//);


// Camera mount
//color([0.3,0.3,0.3])    
////translate([0,0,beam_height-1.25*dims[2]])
//rotate([180,0,0])
//ethoscope_x_mount(
//    dims = magnet_dims,
//    makerbeam = makerbeam,
//    wall_thick = 6, 
//    magnet_size = magnet_size, 
//    standoff_dims = central_magnet_dims, 
//    bolt_diam = secondary_bolt,
//    cam_dims = cam_dims, 
//    lens_diam = lens_diam
// );
 
// color([0.3,0.3,0.3])    
//translate([0,0,beam_height-1.25*dims[2]])
//rotate([180,0,0])
//ethoscope_usb_cam_adapter(
//    dims = magnet_dims,
//    makerbeam = makerbeam,
//    wall_thick = 3, 
//    magnet_pos = "bottom",
//    magnet_size = magnet_size, 
//    standoff_dims = central_magnet_dims, 
//    bolt_diam = 2.5,
//    cam_dims = cam_dims, 
//    lens_diam = lens_diam,
//    usb_hole_positions = usb_hole_positions
// );
 
//ethoscope_neopixel_adapter(
//    dims = magnet_dims,
//    makerbeam = makerbeam,
//    wall_thick = 3, 
//    magnet_pos = "bottom",
//    magnet_size = magnet_size, 
//    standoff_dims = central_magnet_dims, 
//    bolt_diam = 2.5,
//    neopixel_diam = 36.8 // 16: 44.5
// );
 
// ethoscope_neopixel_adapter_lid(
//    lid_thickness,
//    magnet_size,
//    wall_thick
//);



//// Light chamber
//difference(){
//    translate([0,0,light_chamber_dims[2]/2])
//    color([1,1,1])
//    ethoscope_end(
//        dims = light_chamber_dims, 
//        magnet_dims = magnet_dims, 
//        makerbeam = makerbeam, 
//        wall_thick = makerbeam-2, 
//        magnet_size = magnet_size, 
//        bolt_diam = primary_bolt, 
//        with_floor = true,
//        with_led=true,
//        floor_thick = 2
//    );
////    translate([dims[0]/2-20,dims[1]/2-10,0])
////    cube([30,30,100]);
//    
//    translate([light_chamber_dims[0]/2, light_chamber_dims[1]/2-20,10])
//    rotate([90,90,90])
//    #intersection(){
//        cylinder(d=8.1, h=10, center=true);
//        cube([7.1,8.1,10], center=true);
//    }
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
//arena_tubes(
//    dims = arena_dims, 
//    magnet_dims = magnet_dims, 
//    magnet_size = magnet_size, 
//    tube_dims = tube_dims,
//    makerbeam = makerbeam
//);
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