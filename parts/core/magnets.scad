function magnet_size_correct(magnet_size) 
    = [ magnet_size[0]+0.4, magnet_size[1]+0.2 ];

module magnets(dims, magnet_size, wall_thick){    
    for (i = [-1,1]){
        translate([i*dims[0]/2,0,0]){
            cylinder(d=magnet_size[0], h=magnet_size[1]);
            }
    }
}

module magnets2(dims, magnet_size, wall_thick){
    for (i=[-1,1]) {
        translate([dims[0]/2,i*dims[1]/2,0]){
            cylinder(d=magnet_size[0], h=magnet_size[1]);
            mirror([0,1,0]) cylinder(d=magnet_size[0], h=magnet_size[1]);
        }
    }
}