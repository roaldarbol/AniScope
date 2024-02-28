// === Module: O-ring === //
module o_ring(outer_diam, ring_diam) {
    outer_diam = outer_diam + 1;
    rotate([0,0,0])
    rotate_extrude(angle=360) {
        translate([(outer_diam-ring_diam/2)/2, 0])
        circle(d=ring_diam); 
        } // rotate_extrude
    cylinder(d=outer_diam-ring_diam/2, h=ring_diam, center=true);
}