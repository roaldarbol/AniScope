use <../core/core.scad>;

module wall(
    dims, 
    wall_thick, 
    wall_type="hex", // or "full"
    with_led=false,
){
    // extra = 1;
    inner_dims = dims + [-2*wall_thick,-2*wall_thick,1];
    half_dims = dims + [-wall_thick, -wall_thick, 0];
    hex_dims_x = [dims[0], wall_thick, dims[2]];
    hex_dims_y = [dims[1], wall_thick, dims[2]];

    if (wall_type == "hex"){
        for (i = [-1,1]){
            translate([0,i*dims[1]/2,0]) hex_wall(hex_dims_x, 10, 5);
            rotate([0,0,90]) translate([0,i*dims[1]/2,0]) hex_wall(hex_dims_x, 10, 5);
        }
        difference(){
            cube(half_dims, center=true);
            rounded_cube(half_dims, 10, outside=true);
        }
        
    } else if (wall_type == "full"){
        difference(){
            rounded_cube(dims, 2);
            rounded_cube(inner_dims, 2);
        }
    }
}