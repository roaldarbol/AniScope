use <../core/core.scad>;

module beam_slider(
    makerbeam = 10.2,
    wall_thick = 3,
    bolt_diam = 3
){
    height = 15;

    difference(){
        rounded_cube([makerbeam + wall_thick, makerbeam + wall_thick, height]);

        // Makerbeam
        cube([makerbeam, makerbeam, 10+5], center = true);

        // Bolt lane
        rotate([-90,0,0])
        hull(){
            cylinder(h = 20, d = bolt_diam, $fn = 30);
            translate([0,10,0]) cylinder(h = 20, d = bolt_diam, $fn = 30);
        }
    }
}