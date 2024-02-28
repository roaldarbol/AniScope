use <../core/core.scad>;

module arena_empty(
    dims, 
    magnet_dims,
    magnet_size,
    makerbeam,
    corner_height,
    top_magnets=false,
) {
        
    magnet_dims = [magnet_dims[0], magnet_dims[1], corner_height];
    
    
    dimsA = [dims[0]-makerbeam-1, dims[1]+makerbeam, dims[2]];
    dimsB = [dims[0]+makerbeam, dims[1]-makerbeam-1, dims[2]];
    echo(magnet_dims[2]);
    difference(){
        union(){
            
            // Plate base + magnet holders
            rounded_cube(dimsA, makerbeam/2, true);
            rounded_cube(dimsB, makerbeam/2, true);
            translate([0,0,magnet_dims[2]/2-dims[2]/2]){
            //     corners(magnet_dims, makerbeam); // Corners
            //     mirror([1,0,0]) corners(magnet_dims, makerbeam); // Corners
            }
        }
               
        // Bottom magnets
        translate([0,0,magnet_size[1]/2]){
            magnets([magnet_dims[0], magnet_dims[1], magnet_size[1]+2], magnet_size, 3);
            mirror([1,0,0]) magnets([magnet_dims[0], magnet_dims[1], magnet_size[1]+2], magnet_size, 3);
        }
        if (top_magnets == true){
            // Bottom magnets
            translate([0,0,corner_height-dims[2]/2]){
                magnets(magnet_dims, magnet_size, 3);
                mirror([1,0,0]) magnets(magnet_dims, magnet_size, 3);
        }
    }
  }
}

module wall(
    dims, 
    wall_thick, 
    with_floor=false, 
    with_led=false,
    floor_thick=2
){
    extra = 1;
    inner_dims = dims + [-2*wall_thick,-2*wall_thick,1];
    dims_negative = dims + [1,1,0];
    hole_width = 5;
    n_holes = [floor((dims[0]) / (hole_width*2)),
               floor((dims[1]) / (hole_width*2))];

    difference(){
        rounded_cube(dims, 2);
        if (with_floor==true){
            translate([0,0,floor_thick])
            rounded_cube(inner_dims, 2);
            translate([0,0,dims[2]-10])
            rounded_cube(dims_negative, 2);
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
                        cube([wall_thick*2,9,19], center=true);
                    }
                }
            }
        }
    }
}