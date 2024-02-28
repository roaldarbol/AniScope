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