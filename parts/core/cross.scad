module cross(dims, outer_length){
    for (i=[-1,1]) {
        hull(){
            translate([dims[0]/2,i*dims[1]/2,0]) 
            cylinder(h=dims[2], d=outer_length, center=true);
            
            translate([-dims[0]/2,-i*dims[1]/2,0]) 
            cylinder(h=dims[2], d=outer_length, center=true);
        }
    }
}