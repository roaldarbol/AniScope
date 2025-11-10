use <../core/core.scad>;

module platform_mount(
    makerbeam = 10.2,
    magnet_size = [6,3],
    wall_thick = 3,
    bolt_diam = 3
){
    height = 15;
    shelf_height = magnet_size[1] + wall_thick;
    magnet_offset = 25/2;

    difference(){
        union(){
            rounded_cube([makerbeam + wall_thick, makerbeam + wall_thick, height]);
            translate([0,0, - (height/2) + (shelf_height / 2)])
            for (i = [0,90]){
                rotate([0,0,i])
                hull(){
                    rounded_cube([makerbeam + wall_thick, makerbeam + wall_thick, shelf_height]);
                    translate([magnet_offset,0,0])
                    rounded_cube([makerbeam + wall_thick, makerbeam + wall_thick, shelf_height]);
                }
            }
        }

        // Makerbeam
        cube([makerbeam, makerbeam, 10+5], center = true);

        // Bolt lane
        rotate([90,0,0])
        hull(){
            cylinder(h = 20, d = bolt_diam, $fn = 30);
            translate([0,10,0]) cylinder(h = 20, d = bolt_diam, $fn = 30);
        }

        // Magnets
        translate([0,0, - (height/2)])
        for (i = [0,90]){
            rotate([0,0,i])
            translate([magnet_offset,0,0])
            cylinder(d = magnet_size[0], h = magnet_size[1], $fn = 30);
        }
    }
}