use <../core/core.scad>;
fan_holder([40,10,40], 2.5);
module fan_holder(dims, wall_thickness) {
    extra_space = 1;
    dims = [
        dims[0] + extra_space * 2, 
        dims[1] + extra_space * 2,
        dims[2] + extra_space
        ];
    outside_dims = [
        dims[0] + wall_thickness * 2, 
        dims[1] + wall_thickness * 2,
        dims[2] + wall_thickness
        ];

    difference(){
        cube(outside_dims, center = true);
        translate([0,0,wall_thickness])
        cube(dims, center = true);
        translate([0,0,wall_thickness + extra_space])
        cube([dims[0] - 5, dims[1] + 20, dims[2]], center = true);
    }

    // Wall
    translate([0,dims[1] / 2 + (wall_thickness) / 2, (wall_thickness) / 2])
    hex_wall([dims[0], wall_thickness, dims[2]], hole_diameter = 2, hole_spacing = 1);
}