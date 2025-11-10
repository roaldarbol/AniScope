use <../core/core.scad>;
use <../adapters/xmount.scad>;

module floor(
    dims,
    floor_type,
    floor_thick,
    magnet_size,
    adapter_magnet_dims = []
){
    dims_negative = dims + [1,1,0];

    if (floor_type == "none") {
        
    } else if (floor_type == "full"){
        translate([0,0,-dims[2]/2+floor_thick/2])
        rounded_cube([dims[0], dims[1], floor_thick]);
    } else if (floor_type == "x"){
        translate([0,0,-dims[2]/4])
        x_mount([dims[0], dims[1], dims[2]/2],
                makerbeam=10,
                wall_thick=3,
                magnet_size=magnet_size,
                adapter_magnet_dims
                );
    } else if (floor_type == "hex"){
        translate([0,0,-dims[2]/2 + floor_thick / 2])
        hex_floor([dims[0], dims[1], floor_thick], 10, 5);
    }
}