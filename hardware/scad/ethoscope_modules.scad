use <misc.scad>;

// ============== ETHOSCOPE CHILD MODULES ============= //


module wall(
    dims, 
    wall_thick, 
    with_floor=false, 
    with_led=false,
    floor_thick=2
){
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
            translate([0,0,dims[2]-10])
            rounded_cube(dims, 2);
        } else {
        rounded_cube(inner_dims, 2);
        }
        if (with_led==true){
            translate([0,0,-dims[2]/4])
            for (i=[-1,1]){
                for (j=[0,1]){
                    rotate([0,0,j*90])
                    translate([i*(dims[0]-1.5*wall_thick)/2,0,0]){
                        cube([wall_thick,dims[1]-20,14], center=true);
                        translate([0,i*(dims[1]-50)/2,4])
                        #cube([wall_thick*2,9,19], center=true);
                    }
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