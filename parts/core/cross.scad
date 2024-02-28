module cross(dims, outer_length, magnet_size=[0,0], wall_thick){
    for (i=[-1,1]) {
        hull(){
            translate([dims[0]/2,i*dims[1]/2,0]) 
            cylinder(h=magnet_size[1]+wall_thick, d=outer_length, center=true);
            
            translate([-dims[0]/2,-i*dims[1]/2,0]) 
            cylinder(h=magnet_size[1]+wall_thick, d=outer_length, center=true);
        }
    }
}