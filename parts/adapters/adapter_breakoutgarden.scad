use <../core/core.scad>;
use <adapter_empty.scad>;

module adapter_breakoutgarden(
    dims,
    makerbeam=10,
    wall_thick=3,
    magnet_pos="bottom",
    magnet_size, 
    adapter_magnet_dims
 ) {
    // Base adapter
    adapter_empty(
        n=1,
        dims,
        makerbeam,
        wall_thick,
        magnet_pos,
        magnet_size, 
        adapter_magnet_dims
    );
    height = magnet_size[1]+wall_thick;
    board_dims = [103, 65, 1.5];
    board_container_dims = [
        board_dims[0] + 4,
        board_dims[1] + 4,
        board_dims[2] + 4
        ];
    translate([0,0,(height + board_container_dims[2]) / 2])
    difference(){
        // Top piece
        rounded_cube(dims = board_container_dims, radius = 1, outside = false, $fn = 60);

        translate([(board_container_dims[0]-board_dims[0]) / 2,0,0]){
            // Board itself
            rounded_cube(dims = board_dims, radius = 1, outside = false, $fn = 60);
        
            // Center cutout
            translate([2.5,0,0])
            rounded_cube([board_dims[0]+5, board_dims[1]-10, board_container_dims[2]*1.1], radius = 0.1);
        }
    } 
 }