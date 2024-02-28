use <rounded_cube.scad>;

module corners(dims, outer_length){
    for (i=[-1,1]) {
        translate([dims[0]/2,i*dims[1]/2,0])
        rounded_cube([outer_length,outer_length,dims[2]],2);
    }
}

module corners_hollow(dims, makerbeam, bolt_diam){
    for (i=[-1,1]) {
        translate([dims[0]/2,i*dims[1]/2,-dims[2]/2])
        makerbeam_end(bolt_diam=bolt_diam, makerbeam=makerbeam, length=dims[2]);
    } 
}