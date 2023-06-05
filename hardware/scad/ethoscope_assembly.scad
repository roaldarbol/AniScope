use <misc.scad>;
use <ethoscope_top.scad>;
use <ethoscope_xmount.scad>;
use <ethoscope_arenas.scad>;
use <ethoscope_arena_empty.scad>;
use <ethoscope_adapters.scad>;
use <ethoscope_tube_plug.scad>;

$fn = $preview ? 60 : 200;

/* [Assembly] */
// Which part to render?
Render = "base"; // [base: Base, arena_blank: Arena (blank), arena_tubes: Arena (tubes), arena_wellplate: Arena (wellplate), x_mount: X-mount, cam_adapter: Camera adapter]

/* [General] */
Wall_thickness = 3; 
// Which T-slots are used?
makerbeam = 10.2; // [10.2: Makerbeam, 15.2: MakerbeamXL]
// Magnet size (diameter, height)
magnet_size = [6.2,3];

/* [Dimensions] */
// Ethoscope dimensions (length, width, height)
dims = [160,160,15]; //normal length
light_chamber_dims = [dims[0],dims[1],40];
arena_dims = [dims[0],dims[1],3];
// Diameter, height, gap width
chamber_dims = [100,20,20]; 
// Dimensions, wellplate (length, width, height)
Wellplate_dimensions = [127.63,85.47,2]; 
// Dimensions, tubes (diameter, length)
tube_dims = [20.5, 130]; // [diameter, length]
// Dimensions, Abax tubes (outer diameter, thickness, length)
abax_tube_dims = [30, 2, 100]; 

/* [Camera specs] */
// Number of cameras
Number_of_cameras = 1; // [1:1:2]
// Type of camera
Camera_type = "usb"; // [usb: USB, rpi: Raspberry Pi]
// Standoff positions
standoff_dims = [34,34,10]; // USB: [34,34,10] - RPi: [21,13.5,6];
usb_hole_distances = [21,13.5]; // USB: [28,28] - RPi: [21,13.5];
Camera_screw = 2; // Bolt used to attach cameras

/* [Misc] */
// NeoPixel diffuser
lid_thickness = 10;
// Misc for visualization
beam_height = 300;
// Target diameter
target_diam = 7;

/* [Hidden] */
magnet_dims = [dims[0]-25,dims[1],magnet_size[1]*2+Wall_thickness];
central_magnet_dims = [50,50,magnet_size[1]*2+Wall_thickness];
cam_dims = [50, 50]; // Size of the mount
primary_bolt = 3; // Bolt used in MakerBeams
usb_hole_positions = get_points(usb_hole_distances);

// ======= Full models ======== //

// sleep_preference_module($fn = 200);

// arena_sleep_preference(
//    dims = arena_dims,
//    magnet_dims = magnet_dims,
//    magnet_size = magnet_size,
//    makerbeam = makerbeam,
//    $fn = 200
// );


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
//    Wall_thickness = 5, 
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
//    Wall_thickness = 6, 
//    magnet_size = magnet_size, 
//    standoff_dims = central_magnet_dims, 
//    bolt_diam = Camera_screw,
//    cam_dims = cam_dims, 
//    lens_diam = lens_diam
// );
 
// color([0.3,0.3,0.3])    
//translate([0,0,beam_height-1.25*dims[2]])
//rotate([180,0,0])
//ethoscope_usb_cam_adapter(
//    dims = magnet_dims,
//    makerbeam = makerbeam,
//    Wall_thickness = 3, 
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
//    Wall_thickness = 3, 
//    magnet_pos = "bottom",
//    magnet_size = magnet_size, 
//    standoff_dims = central_magnet_dims, 
//    bolt_diam = 2.5,
//    neopixel_diam = 36.8 // 16: 44.5
// );
 
// ethoscope_neopixel_adapter_lid(
//    lid_thickness,
//    magnet_size,
//    Wall_thickness
//);



//// Light chamber
//difference(){
//    translate([0,0,light_chamber_dims[2]/2])
//    color([1,1,1])
//    ethoscope_end(
//        dims = light_chamber_dims, 
//        magnet_dims = magnet_dims, 
//        makerbeam = makerbeam, 
//        Wall_thickness = makerbeam-2, 
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
// arena_tubes(
//    dims = arena_dims, 
//    magnet_dims = magnet_dims, 
//    magnet_size = magnet_size, 
//    tube_dims = abax_tube_dims,
//    makerbeam = makerbeam
// );
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

// Tube inserts
// translate([abax_tube_dims[2]/2,0,0])
// rotate([0,-90,0])
tube_plug(
    hose_on_side = false, 
    inner_d = abax_tube_dims[0]-2*abax_tube_dims[1], 
    outer_d = abax_tube_dims[0], 
    magnet_size = magnet_size
    );

// rotate([0,90,0])
// translate([0,0,-12])
// tube_floor(
//     chamber_length = abax_tube_dims[2],
//     inner_d1 = abax_tube_dims[0]-2*abax_tube_dims[1],
//     inner_d2 = abax_tube_dims[0]-2*abax_tube_dims[1]
//     );