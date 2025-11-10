use <../core/core.scad>;
use <frame.scad>;
use <../misc/misc.scad>;

module platform_adapter(
    dims, 
    magnet_pos, 
    makerbeam=10, 
    wall_type="hex",
    wall_thick=3, 
    magnet_size, 
    bolt_diam, 
    adapter_magnet_dims = []
){
    difference(){
        union(){
            frame(
                dims = dims, 
                magnet_pos = magnet_pos, 
                makerbeam = makerbeam, 
                wall_type = "hex",
                wall_thick = wall_thick, 
                magnet_size = magnet_size, 
                bolt_diam = bolt_diam,
                floor_type = "none",
                adapter_magnet_dims = adapter_magnet_dims
            );
            // Extra padding around beams
            for (i = [0:3]){
                rotate([0,0,i*90])
                translate([dims[0]/2, dims[1]/2,0])
                beam_slider(
                    makerbeam = makerbeam,
                    wall_thick = 3,
                    bolt_diam = bolt_diam
                    );
            }
        }
        // Remove the bottom of the beam support
            for (i = [0:3]){
                rotate([0,0,i*90])
                translate([dims[0]/2, dims[1]/2,0])
                cube([makerbeam, makerbeam, dims[2]*1.5], center = true);
            }
    }
}