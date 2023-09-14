use <ethoscope_modules.scad>;
// outer_d1 = 30;
// outer_d2 = 27.5;
// inner_d1 = outer_d1 - 2.5;
// inner_d2 = outer_d2 - 2.5;
// chamber_length = 97.5;
// magnet_size = [6.2,3]; // diameter, height

$fn = $preview ? 60 : 200;

// tube_plug(
//     hose_on_side = false, 
//     inner_d = inner_d1, 
//     outer_d = outer_d1, 
//     magnet_size = magnet_size
//     );

// tube_floor(
//     chamber_length = chamber_length,
//     inner_d1 = inner_d1,
//     inner_d2 = inner_d2
//     );

module tube_plug(
    connector_position="end",
    include_floor=true,
    include_funnel=true,
    include_anchor=false,
    inner_d,
    outer_d,
    o_ring_d=2,
    magnet_size,
    hose_connector_d=10
){
    h = 10.2;
    h_inner = 10;
    air_duct_d = 3;
    hose_connector_inner_d = hose_connector_d - 0.2;
    inner_d = inner_d - 0.1;
    magnet_size_corrected = magnet_size_correct(magnet_size);

    
    difference(){
        union(){
            difference(){
                union(){
                    cylinder(h=h, d=outer_d);
                    if (connector_position=="side"){
                        // Add extra base
                        translate([0,0,-h])
                        cylinder(h=h, d=outer_d);
                    }
                    
                    if (include_floor==true){
                        // Remove space for floor
                        translate([0,0,h])
                        intersection(){
                            translate([1/3*inner_d,0,0])
                            cube(inner_d, center=true);
                            cylinder(h=h_inner, d=inner_d);
                        }
                    } else {
                        // Remove space for floor
                        translate([0,0,h])
                        cylinder(h=h_inner, d=inner_d);
                    }
                }
                
                if (connector_position=="side"){
                    // Magnet
                    rotate([0,90,0])
                    translate([-h/2,0,-outer_d/2])
                    cylinder(d=magnet_size_corrected[0], h=magnet_size_corrected[1]);   

                    // Airhole
                    translate([0,0,-air_duct_d/2])
                    cylinder(h=h*2+h_inner,d=air_duct_d);

                    // Innder funnel
                    if (include_funnel==true){
                        translate([0,0,h+2])
                        cylinder(d1=air_duct_d, d2=inner_d-1, h=h_inner-1);
                    }
                    
                    // translate([0,0,h/2])
                    rotate([0,90,0])
                    cylinder(h=outer_d,d=air_duct_d);
                    
                    translate([outer_d/2-10,0,0]){
                        rotate([0,90,0]){
                            cylinder(h=outer_d,d=hose_connector_inner_d);
                            translate([0,0,9])
                            cylinder(h=outer_d,d=hose_connector_inner_d+8);
                        }
                    }
                } else {
                    // Airhole
                    cylinder(h=h+h_inner+10,d=air_duct_d);
                    cylinder(h=10, d=hose_connector_inner_d);

                    if (include_funnel==true){
                        translate([0,0,h+2])
                        cylinder(d1=air_duct_d, d2=inner_d-1, h=h_inner-1);
                    }

                    // Magnet
                    rotate([0,90,0])
                    translate([-h/2,0,-outer_d/2])
                    cylinder(d=magnet_size_corrected[0], h=magnet_size_corrected[1]);   
                }
            }

            // Mini floor + attachment points
            if (include_floor==true){
                translate([0,0,h]){
                    // Floor
                    difference(){
                        intersection(){
                            translate([-2/3*inner_d,0,-0.5])
                            cube(inner_d, center=true);
                            cylinder(h=h_inner-0.5, d=inner_d);
                        }
                    }
                    

                    // Attachment points
                    for (i=[-90,0,90]){
                        rotate([0,0,i])
                        translate([1/2*inner_d-2*o_ring_d,0,0])
                        cylinder(h=h_inner+1, d=5);
                    }
                    

                }

                // Fence !!! In slicing, cut into separate object 
                translate([0,0,h+h_inner])
                intersection(){
                    translate([1/3*inner_d+0.2,0,0])
                    cube(inner_d, center=true);
                    cylinder(d=inner_d, h=2);
                }
            }
        }

        // Create anchor-point
        if(include_anchor==true){
            translate([0,-inner_d/4,h+h_inner])
            cube([8,2,11], center=true);
        }
        
        // O-ring
        for (i=[1.5,3.5]){
            translate([0,0,h+i*(h_inner/5)])
            rotate_extrude(){
                translate([inner_d/2-o_ring_d/4-0.2,0,0])
                hull(){
                    circle(d=o_ring_d);
                    translate([3,0,0])
                    circle(d=o_ring_d);
                }
                // circle(d=o_ring_d);
            }
        }
    }

    // O-ring
    // %for (i=[1.5,3.5]){
    //     translate([0,0,h+i*(h_inner/5)])
    //     rotate_extrude(){
    //         translate([inner_d/2-o_ring_d/4-0.2,0,0])
    //         circle(d=o_ring_d);
    //         // circle(d=o_ring_d);
    //     }
    // }
    
}

module tube_floor(
    chamber_length,
    inner_d1,
    inner_d2,
    pegs=false
){
    chamber_length = chamber_length - 2*9.5;
    peg_d = 2.5;
    peg_h = 2;

    translate([0,0,-chamber_length/2])
    intersection(){
        translate([2/3*inner_d1+1.5,0,chamber_length/2])
        cube([inner_d1+2, inner_d1+2, chamber_length], center=true);
        cylinder(d1=inner_d1, d2 = inner_d2, h=chamber_length);
    }
    if (pegs==true){
        for (i=[-1,1]){
            for (j=[-1,1]){
                translate([1/3.5*inner_d1,i*0.2*inner_d1,j*chamber_length/2+j/2])
                cylinder(d=peg_d, h=peg_h, center=true);
            }
        }
    }
}

