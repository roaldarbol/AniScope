$fn = $preview ? 60 : 200;
inner_d = 4;
o_ring_d = 2;
connector_d = 10;

male_connector(
    inner_d = inner_d,
    connector_d = connector_d,
    o_ring_d = o_ring_d
    );
// translate([20,0,0])
// female_connector(
//     inner_d = inner_d,
//     connector_d = connector_d
// );
module male_connector(
    inner_d,
    connector_d,
    o_ring_d
){
    h_inner = 10;
    inner_d = inner_d + 1; // Modify this to fit
    intermediate_h = 3;
    intermediate_d = connector_d + 6;

    cone_h = inner_d*0.6;

    difference(){
        union(){
            cylinder(d=connector_d, h=h_inner);
            
            // Middle segment
            translate([0,0,h_inner]){
                cylinder(d=intermediate_d, h=intermediate_h);
                for (i=[0:60:350]){
                    rotate([0,0,i])
                    translate([intermediate_d/2,0,intermediate_h/2])
                    cube([intermediate_h,intermediate_h,intermediate_h], center=true);
                }
            }
            
            // Connector cone segments
            for (i=[0:3]){
                translate([0,0,h_inner+intermediate_h+i*cone_h])
                cylinder(d1=inner_d, d2=inner_d-(inner_d*0.3), h=cone_h);
            }
        }

        for (i=[1,2]){
            translate([0,0,i*(h_inner/3)])
            rotate_extrude(){
                translate([connector_d/2-o_ring_d/4,0,0])
                hull(){
                    circle(d=o_ring_d);
                    translate([3,0,0])
                    circle(d=o_ring_d);
                }
                // circle(d=o_ring_d);
            }
        }

        cylinder(d=3, h=h_inner*4);
    }
}

module female_connector(
    inner_d,
    connector_d = connector_d
){
    inner_d = inner_d + 1;
    h_inner = 10;
    intermediate_h = 3;
    intermediate_d = connector_d + 6;
    cone_h = inner_d*0.6;

    difference(){
        union(){
            cylinder(d=intermediate_d, h=h_inner);
            // Middle segment
            translate([0,0,h_inner]){
                cylinder(d=intermediate_d, h=intermediate_h);
                for (i=[0:60:350]){
                    rotate([0,0,i])
                    translate([intermediate_d/2,0,intermediate_h/2])
                    cube([intermediate_h,intermediate_h,intermediate_h], center=true);
                }
            }

            // Connector cone segments
            for (i=[0:3]){
                translate([0,0,h_inner+intermediate_h+i*cone_h])
                cylinder(d1=inner_d, d2=inner_d-(inner_d*0.3), h=cone_h);
            }
        }
        cylinder(d=3, h=h_inner*4);
        cylinder(d=connector_d+0.4, h=h_inner-0.2);
        
    }
}