function magnet_size_correct(magnet_size) 
    = [ magnet_size[0]+0.4, magnet_size[1]+0.2 ];

module magnets(dims, magnet_size, wall_thick){
    magnet_size_corrected = magnet_size_correct(magnet_size);
    
    for (i = [-1,1]){
        for (j = [0,1]){
            translate([i*dims[0]/2,0,0]){
                mirror([j,0,0])
                cylinder(d=magnet_size_corrected[0], h=magnet_size_corrected[1]);
            }
        }
    }
    // for (i=[-1,1]) {
    //     translate([dims[0]/2,i*dims[1]/2,-(magnet_size_corrected[1])])
    //     cylinder(d=magnet_size_corrected[0], h=magnet_size_corrected[1]);
    // }
}