use <misc.scad>;
use <ethoscope_modules.scad>;
use <ethoscope_render.scad>;
use <tube_stand_2.scad>;


        //// ARENA SPECS

dims = [155,150,15]; //normal length
wall_thick = 3;
magnet_size = [6.2,3]; // diameter, height
magnet_dims = [dims[0]-25,dims[1],magnet_size[1]*2+wall_thick];
arena_dims = [dims[0],dims[1],2];
makerbeam = 10;

        //// TUBES SPECS
// O-ring specs
outer_diam = 22;
ring_diam = 2.2;

// Tube rack specs
tube_diam = 20.5; //18.5
beam_width = 10;
rack_length = 165;
tube_length = 150;

// For standing
standing = 1;

$fn=30;
rotate([180,0,0])
difference(){
    horizontal_tube_rack(
        tube_diam = tube_diam,
        beam_width = beam_width,
        rack_length = rack_length,
      insert=false);
    translate([0,rack_length/2+3,-4])
    cube(20, center=true);
    translate([0,-(rack_length/2+3),-4])
    cube(20, center=true);
    translate([0,rack_length/2-3.5,-4])
    cylinder(h=30, d=3);
    translate([0,-(rack_length/2-3.5),-4])
    cylinder(h=30, d=3);
}