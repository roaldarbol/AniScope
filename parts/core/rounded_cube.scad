module rounded_cube(
    dims, 
    radius=1, 
    outside=false, 
    $fn=60
) {

    new_dims = dims / 2;
    if (outside==true){
        new_dims = [new_dims[0] - radius, new_dims[1] - radius, new_dims[2]];
        points = [  [new_dims[0],-new_dims[1],0], 
                [new_dims[0],new_dims[1],0], 
                [-new_dims[0],new_dims[1],0], 
                [-new_dims[0],-new_dims[1],0] ];
        translate([0,0,-dims[2]/2])
        hull(){
            for (p = points){
                translate(p) cylinder(r=radius, h=dims[2]);
            }
        }
    } else {
        points = [  [new_dims[0],-new_dims[1],0], 
                [new_dims[0],new_dims[1],0], 
                [-new_dims[0],new_dims[1],0], 
                [-new_dims[0],-new_dims[1],0] ];
        translate([0,0,-dims[2]/2])
        hull(){
            for (p = points){
                translate(p) cylinder(r=radius, h=dims[2]);
            }
        }
    }
}