use <../core/core.scad>;

module floor(
    dims,
    floor_type,
){
    dims_negative = dims + [1,1,0];

    if (floor_type == "full"){
        translate([0,0,dims[2]])
        rounded_cube(dims, 2);
    } else if (floor_type == "x"){
        translate([0,0,dims[2]])
        cross(
            dims = dims, 
            outer_length = 10, 
            wall_thick = dims[2]
        );
    } else if (floor_type == "hex"){
        !hex_grid(dims, 10, 5);
    }
}