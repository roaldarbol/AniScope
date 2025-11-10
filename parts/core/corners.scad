use <rounded_cube.scad>;
use <makerbeam.scad>;

module corners(dims, outer_length){
    for (i=[-1,1]) {
        translate([dims[0]/2,i*dims[1]/2,0])
        rounded_cube(
            dims = [outer_length,outer_length,dims[2]],
            radius = 2,
            outside = true
            );
    }
}

module corners_hollow(dims, makerbeam, bolt_diam){
    for (i=[-1,1]) {
        translate([dims[0]/2,i*dims[1]/2,-dims[2]/2])
        makerbeam_end(bolt_diam=bolt_diam, makerbeam=makerbeam, length=dims[2]);
    } 
}

module corner_fillets(
    dims, 
    makerbeam
){
    difference(){
        cube(dims, center=true);
        rounded_cube(dims + [0,0,2], makerbeam, outside=true);
    }
}