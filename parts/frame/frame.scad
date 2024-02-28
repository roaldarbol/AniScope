use <../core/core.scad>;

module frame(
    dims, 
    magnet_pos, 
    makerbeam=10, 
    wall_thick=3, 
    magnet_size, 
    bolt_diam, 
    with_floor=false,
    with_led=false,
    floor_type="x",
    floor_thick=2
) {
     
    magnet_pos = [magnet_pos[0], magnet_pos[1], dims[2]];

     difference(){
         
         // MakerBeam corner attachments
         union(){
             wall(dims, wall_thick);
             floor(dims, floor_type, floor_thick);
             corners(dims, makerbeam);
             mirror([1,0,0]) corners(dims, makerbeam);
             
             // Create the magnet attachments next to MakerBeam
             for (i = [0,90]){
                rotate([0,0,i])
                translate([0,0,-(dims[2]-magnet_pos[2])/2]){ // Magnets
                    corners(magnet_pos, makerbeam);
                    mirror([1,0,0]) corners(magnet_pos, makerbeam);
                    // corners(magnet_pos+[25/2,0,0], makerbeam); // filling empty space
                    // mirror([1,0,0]) corners(magnet_pos+[25/2,0,0], makerbeam);
                }
             }
         }

         for (i = [0,90]){
            rotate([0,0,i]){
                // Makerbeam corners
                corners_hollow(dims, makerbeam, bolt_diam);
                mirror([1,0,0]) corners_hollow(dims, makerbeam, bolt_diam);
                
                // Bottom magnets
                translate([0,0,-magnet_pos[2]/2+magnet_size[1]])
                magnets(magnet_pos, magnet_size, wall_thick);

                // Top magnets
                #translate([0,0,magnet_pos[2]/2])
                magnets(magnet_pos, magnet_size, wall_thick);

                // Side magnets
                magnet_pos_side = [
                    magnet_pos[0], 
                    magnet_pos[1] + magnet_size[1]/2
                    ];
                #translate([0,0,-(magnet_pos[2]/2)+magnet_size[0]*1.5+35])
                magnets(
                    magnet_pos_side, 
                    magnet_size, 
                    magnet_rot = [90,0,0],
                    wall_thick);
            }
         }
     }
 }


 module wall(
    dims, 
    wall_thick, 
    with_led=false,
){
    // extra = 1;
    inner_dims = dims + [-2*wall_thick,-2*wall_thick,1];

    difference(){
        rounded_cube(dims, 2);
        rounded_cube(inner_dims, 2);
    }
}

module floor(
    dims,
    floor_type,
    floor_thick
){
    dims_negative = dims + [1,1,0];

    if (floor_type == "solid"){
        translate([0,0,floor_thick])
        rounded_cube(inner_dims, 2);
        translate([0,0,dims[2]-10])
        rounded_cube(dims_negative, 2);
    } else if (floor_type == "x"){
        translate([0,0,(-dims[2]/2)+floor_thick/2])
        cross(
            dims = dims, 
            outer_length = 10, 
            wall_thick = floor_thick
        );
    }
}

    // hole_width = 5;
    // n_holes = [floor((dims[0]) / (hole_width*2)),
    //            floor((dims[1]) / (hole_width*2))];
    
        // #if (with_led==true){
        //     translate([0,0,-dims[2]/4])
        //     for (i=[-1,1]){
        //         for (j=[0,1]){
        //             rotate([0,0,j*90])
        //             translate([i*(dims[0]-1.5*wall_thick)/2,0,0]){
        //                 cube([wall_thick,dims[1]-20,14], center=true);
        //                 translate([0,i*(dims[1]-50)/2,4])
        //                 cube([wall_thick*2,9,19], center=true);
        //             }
        //         }
        //     }
        // }