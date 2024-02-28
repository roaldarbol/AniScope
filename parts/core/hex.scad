
// Developed by ggrieves under a CC-BY license.
// https://www.thingiverse.com/thing:1296149/files

module hex(
    hole, 
    wall, 
    thickness
){
    difference(){
        rotate([0, 0, 30]) cylinder(d = (hole + wall), h = thickness, $fn = 6);
        translate([0, 0, -0.1]) rotate([0, 0, 30]) cylinder(d = hole, h = thickness + 0.2, $fn = 6);
    }
}



module hex_grid(
    dims, 
    hole_diameter, 
    hole_spacing
) {
    a = (hole_diameter + (hole_spacing/2))*sin(60);
    for(x = [hole_diameter/2: a: dims[0]]) {
        for(y = [hole_diameter/2: 2*a*sin(60): dims[1]]) {
            translate([x, y, 0]) hex(hole_diameter, hole_spacing, dims[2]);
            translate([x + a*cos(60), y + a*sin(60), 0]) hex(hole_diameter, hole_spacing, dims[2]);

        }
    }
        
}

module hex_wall(
    dims,
    hole_diameter,
    hole_spacing
){
    dims_rotated = [dims[0], dims[2], dims[1]];
    difference(){
        cube(dims, center=true);
        cube(dims+[-5,2,-5], center=true);
    }
    
    translate([-dims[0]/2,-dims[1]/2,-dims[2]/2])
    intersection(){
        cube(dims);
        rotate([90,0,0])
        translate([0,0,-dims[1]])
        hex_grid(dims_rotated, hole_diameter, hole_spacing);
    }
    
}

module hex_floor(
    dims,
    hole_diameter,
    hole_spacing
){

    difference(){
        cube(dims, center=true);
        cube(dims+[-5,-5,2], center=true);
    }
    
    translate([-dims[0]/2,-dims[1]/2,-dims[2]/2])
    intersection(){
        cube(dims);
        rotate([90,0,0])
        translate([0,0,-dims[1]])
        #hex_grid(dims, hole_diameter, hole_spacing);
    }
    
}

// first arg is vector that defines the bounding box, length, width, height
// second arg in the 'diameter' of the holes. In OpenScad, this refers to the corner-to-corner diameter, not flat-to-flat
// this diameter is 2/sqrt(3) times larger than flat to flat
// third arg is wall thickness.  This also is measured that the corners, not the flats. 
// rotate([90,0,0])
// hex_grid([250, 250, 15], 20, 10);
// hex(1, 0.5, 1.5);