use <misc.scad>;
use <ethoscope_base.scad>;
use <ethoscope_xmount.scad>;
use <ethoscope_arenas.scad>;
use <ethoscope_arena_empty.scad>;
use <ethoscope_adapters.scad>;
use <ethoscope_tube_plug.scad>;
function selector(item, dict) = dict[search([item], dict)[0]];

$fn = $preview ? 60 : 200;

/* [Assembly] */
// Which part to render?
part = "cam_adapter"; // [base: Base, arena_blank: Arena (blank), arena_spacer: Arena (spacer), arena_tubes: Arena (tubes), arena_wellplate: Arena (wellplate), x_mount: X-mount, cam_adapter: Camera adapter, tube_plug: Tube plug]

/* [General] */
// Ethoscope dimensions (length, width, height)
dims = [160,160,15]; //normal length
wall_thick = 3; 
// Which T-slots are used?
makerbeam = 10.2; // [10.2: Makerbeam, 15.2: MakerbeamXL]
// Magnet size (diameter, height)
magnet_size = [6,3];

/* [Arena dimensions] */
// Dimensions, preference chamber (diameter, height, gap width)
chamber_dims = [100,20,20]; 
// Dimensions, wellplate (length, width, height)
Wellplate_dimensions = [127.63,85.47,2]; 
// Dimensions, glass tubes (outer diameter, length)
glass_tube_dims = [20.5, 130];

/* [Camera] */
// Number of cameras
n_cams = 2; // [1:1:2]
// Type of camera
Camera_type = "usb"; // [usb: USB, rpi: Raspberry Pi]
Camera_screw = 2; // Bolt used to attach cameras

/* [Acrylic tubes] */
// Dimensions, acrylic tubes (outer diameter, thickness, length)
acrylic_tube_dims = [30, 2, 100]; 
// Type of tube plug
tube_plug = "flush"; // [flush: Flush, funnel: Funneled, with_floor: With floor, with_anchor: With anchor-point]
// Plug: Hose connector thread (diameter)
hose_connector_d = 10; 
// Plug: Hose connector position
connector_position = "end"; // [end: End of tube, side: Side of tube]


/* [Misc] */
// NeoPixel diffuser
lid_thickness = 10;
// Misc for visualization
beam_height = 300;
// Target diameter
target_diam = 7;

/* [Hidden] */
light_chamber_dims = [dims[0],dims[1],40];
arena_dims = [dims[0],dims[1],3];
magnet_dims = [dims[0]-25,dims[1],magnet_size[1]*2+wall_thick];
adapter_magnet_dims = [50,50,magnet_size[1]*2+wall_thick]; // Size of the mount
primary_bolt = 3; // Bolt used in MakerBeams
usb_hole_distances = [
    ["rpi", [21,13.5]],
    ["usb", [28,28]]
]; // USB: [28,28] - RPi: [21,13.5];
adapter_hole_positions = selector(Camera_type, usb_hole_distances);
usb_hole_positions = get_points(adapter_hole_positions[1]);

// Hidden tube params
// Parameters: [with_funnel, with_floor, with_anchor]
tube_parameters = [
    ["flush", [false,false,false]], 
    ["funnel", [true,false,false]],
    ["with_floor", [true,true,false]],
    ["with_anchor", [false,false,true]]
]; 
// Plug: Carve out funnel?
include_funnel = selector(tube_plug, tube_parameters)[1][0];
echo(include_funnel);
// Plug: Include space for floor (only works with funnel)
include_floor = selector(tube_plug, tube_parameters)[1][1];
// Plug: Include space for floor (only works with funnel)
include_anchor = selector(tube_plug, tube_parameters)[1][2];

// ======= Full models ======== //
print_part();
module print_part() {
    // Base without floor
	if (part == "base") {
        ethoscope_base(
            dims = light_chamber_dims, 
            magnet_dims = magnet_dims, 
            makerbeam = makerbeam, 
            wall_thick = makerbeam-2, 
            magnet_size = magnet_size, 
            bolt_diam = primary_bolt, 
            with_floor = true,
            with_led=true,
            floor_thick = 2
        );
	} else if (part == "arena_blank") {

    } else if (part == "arena_spacer") {
        arena_spacer(
            dims = arena_dims, 
            magnet_dims = magnet_dims,
            magnet_size = magnet_size, 
            makerbeam = makerbeam,
            corner_height = 20
        );	
	} else if (part == "arena_tubes") {
		arena_tubes(
            dims = arena_dims, 
            magnet_dims = magnet_dims, 
            magnet_size = magnet_size, 
            tube_dims = acrylic_tube_dims,
            makerbeam = makerbeam
        );
    } else if (part == "arena_wellplate") {
    } else if (part == "x_mount") {
        ethoscope_x_mount(
            dims = magnet_dims,
            makerbeam = makerbeam,
            wall_thick = 6, 
            magnet_size = magnet_size,
            adapter_magnet_dims = adapter_magnet_dims
        );
    } else if (part == "cam_adapter") {
        ethoscope_usb_cam_adapter(
            n_cams = n_cams,
            dims = magnet_dims,
            makerbeam = makerbeam,
            wall_thick = 3, 
            magnet_pos = "bottom",
            magnet_size = magnet_size,
            bolt_diam = 2.5,
            adapter_magnet_dims = adapter_magnet_dims,
            usb_hole_positions = usb_hole_positions
            );
	} else if (part=="tube_plug") {
        tube_plug(
            connector_position = connector_position, 
            include_floor = include_floor,
            include_funnel = include_funnel,
            include_anchor = include_anchor,
            inner_d = acrylic_tube_dims[0]-2*acrylic_tube_dims[1], 
            outer_d = acrylic_tube_dims[0], 
            o_ring_d = 2,
            magnet_size = magnet_size,
            hose_connector_d = hose_connector_d
        );
    }
}
// sleep_preference_module($fn = 200);

// arena_sleep_preference(
//    dims = arena_dims,
//    magnet_dims = magnet_dims,
//    magnet_size = magnet_size,
//    makerbeam = makerbeam,
//    $fn = 200
// );





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
//    bolt_diam = Camera_screw,
//    adapter_magnet_dims = adapter_magnet_dims, 
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
//    adapter_magnet_dims = adapter_magnet_dims, 
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
// arena_tubes(
//    dims = arena_dims, 
//    magnet_dims = magnet_dims, 
//    magnet_size = magnet_size, 
//    tube_dims = acrylic_tube_dims,
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
// translate([acrylic_tube_dims[2]/2,0,0])
// rotate([0,-90,0])
// tube_plug(
//     hose_on_side = false, 
//     inner_d = acrylic_tube_dims[0]-2*acrylic_tube_dims[1], 
//     outer_d = acrylic_tube_dims[0], 
//     magnet_size = magnet_size
//     );

// rotate([0,90,0])
// translate([0,0,-12])
// tube_floor(
//     chamber_length = acrylic_tube_dims[2],
//     inner_d1 = acrylic_tube_dims[0]-2*acrylic_tube_dims[1],
//     inner_d2 = acrylic_tube_dims[0]-2*acrylic_tube_dims[1]
//     );