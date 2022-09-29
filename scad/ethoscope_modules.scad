use <misc.scad>;

// ============== ETHOSCOPE CHILD MODULES ============= //


module wall(dims, wall_thick, with_floor=false, floor_thick=2){
extra = 1;
inner_dims = dims + [-2*wall_thick,-2*wall_thick,1];
hole_width = 5;
n_holes = [floor((dims[0]) / (hole_width*2)),
           floor((dims[1]) / (hole_width*2))];

difference(){
    rounded_cube(dims, 2);
    if (with_floor==true){
        translate([0,0,floor_thick])
        rounded_cube(inner_dims, 2);
        translate([0,0,dims[2]-20])
        rounded_cube(dims, 2);
    } else {
    rounded_cube(inner_dims, 2);
    }
    
    if (with_floor==false){
        // Holes in both directions
        translate([dims[0]/2,0,0])
        for (i = [1:1:n_holes[0]]){
            rotate([0,90,90])
            translate([0,i*(dims[0]/(n_holes[0]+1)),0])
            hull(){
                translate([2.5,0,0]) cylinder(h=dims[1]+2*wall_thick, d=hole_width, center=true);
                translate([-2.5,0,0]) cylinder(h=dims[1]+2*wall_thick, d=hole_width, center=true);
            }
        }
        
        translate([0,-dims[1]/2,0])
        for (i = [1:1:n_holes[1]]){
            rotate([0,90,0])
            translate([0,i*(dims[1]/(n_holes[1]+1)),0])
            hull(){
                translate([2.5,0,0]) cylinder(h=dims[0]+2*wall_thick, d=hole_width, center=true);
                translate([-2.5,0,0]) cylinder(h=dims[0]+2*wall_thick, d=hole_width, center=true);
                }
            }
        }
    }
}

module corners(dims, outer_length){
    for (i=[-1:2:1]) {
        translate([dims[0]/2,i*dims[1]/2,0])
        rounded_cube([outer_length,outer_length,dims[2]],2);
    }
}

module corners_hollow(dims, makerbeam, bolt_diam){
    for (i=[-1:2:1]) {
        translate([dims[0]/2,i*dims[1]/2,-dims[2]/2])
        makerbeam_end(bolt_diam=bolt_diam, makerbeam=makerbeam, length=dims[2]);
    } 
}

module magnets(dims, magnet_size, wall_thick){
    for (i=[-1:2:1]) {
        translate([dims[0]/2,i*dims[1]/2,-(magnet_size[1])])
        cylinder(d=magnet_size[0], h=magnet_size[1]);
    }
}

module cross_top(dims, outer_length, magnet_size, wall_thick){
    for (i=[-1:2:1]) {
        hull(){
            translate([dims[0]/2,i*dims[1]/2,0]) 
            cylinder(h=magnet_size[1]+wall_thick, d=outer_length, center=true);
            
            translate([-dims[0]/2,-i*dims[1]/2,0]) 
            cylinder(h=magnet_size[1]+wall_thick, d=outer_length, center=true);
        }
    }
}

module standoff_single(bolt_diam, standoff_height, wall_thick){
    bolt_diam = bolt_diam + 0.15; // Here's changing the camera bolt size
    $fn=30;
    difference(){
        hull(){
            translate([0,0,standoff_height-0.2]) cylinder(d=bolt_diam+wall_thick, h=0.1);
            cylinder(d=(bolt_diam+wall_thick)*standoff_height/4, h=0.1);
        }
        cylinder(d=bolt_diam, h=standoff_height); 
    }
}


module standoff_quad(standoff_dims, bolt_diam, wall_thick){
    for (i=[-1:2:1]){
        translate([standoff_dims[0]/2,i*standoff_dims[1]/2,0])
        standoff_single(bolt_diam, standoff_dims[2], wall_thick);
    }
    mirror([1,0,0])
    for (i=[-1:2:1]){
        translate([standoff_dims[0]/2,i*standoff_dims[1]/2,0])
        standoff_single(bolt_diam, standoff_dims[2], wall_thick);
    }
}