// ========================================= //
// ============== MISC STUFF =============== //
// ========================================= //

// Here's some documentation of what the holder is, and what it's used for..
// Maybe a brief licensing bit?

function add(vector, k) = [for (vector=vector) vector+k];
    
function get_points(distances) // A vector of 2
    = [ [-distances[0]/2,-distances[1]/2],
        [distances[0]/2,-distances[1]/2],
        [-distances[0]/2,distances[1]/2],
        [distances[0]/2,distances[1]/2]
    ];

module o_ring(
    outer_diam=22, 
    ring_diam=2.2
) {
    outer_diam = outer_diam + 1;
    rotate([0,0,0])
    rotate_extrude(angle=360) {
        translate([(outer_diam-ring_diam/2)/2, 0])
        circle(d=ring_diam); 
        } // rotate_extrude
    cylinder(d=outer_diam-ring_diam/2, h=ring_diam, center=true);
}



module makerbeam_end(
    bolt_diam, 
    makerbeam, 
    length=10
) {
    
    // The last part of a MakerBeam along with a a flatheaded bolt for mounting
    
    translate([0,0,length/2+(2/3)*bolt_diam]) 
    rotate([0,90,0]){   // Bring things up to level
        cube([length, makerbeam, makerbeam], center=true);   // MakerBeam
        translate([length/2+(2/3)*bolt_diam,0,0]) rotate([0,-90,0]){
            cylinder(h=length, d=bolt_diam);    // Bolt
            hull(){     // Bolt head
                translate([0,0,(2/3)*bolt_diam]) cylinder(h=0.1, d=bolt_diam);
                cylinder(h=0.2, d=bolt_diam*2);
            }
        }
    }
}


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