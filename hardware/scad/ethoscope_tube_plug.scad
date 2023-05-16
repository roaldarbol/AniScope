outer_d1 = 30;
outer_d2 = 27.5;
inner_d1 = outer_d1 - 2.5;
inner_d2 = outer_d2 - 2.5;
chamber_length = 97.5;
magnet_size = [6.2,3]; // diameter, height

$fn = $preview ? 60 : 200;

// tube_plug(
//     hose_on_side = false, 
//     inner_d = inner_d1, 
//     outer_d = outer_d1, 
//     magnet_size = magnet_size
//     );

tube_floor(
    chamber_length = chamber_length,
    inner_d1 = inner_d1,
    inner_d2 = inner_d2
    );

module tube_plug(
    hose_on_side=false,
    inner_d,
    outer_d,
    magnet_size
){
    h = 15;
    h_inner = 10;
    air_duct_d = 3;
    hose_connector_inner_d = 9.8;
    
    
    difference(){
        union(){
            cylinder(h=h, d=outer_d);
            
            // Remove space for floor
            translate([0,0,h])
            intersection(){
                translate([1/3*inner_d,0,0])
                cube(inner_d, center=true);
                cylinder(h=h_inner, d=inner_d);
            }

            // cylinder(h=h+h_inner, d=inner_d);
            // #difference(){
            //     cylinder(h=h+h_inner/2, d=outer_d+3);
            //     cylinder(h=h+h_inner/2, d=outer_d);
            // }
        }
        
        if (hose_on_side==true){
            // Magnets
            for (i=[-1,1]){
                translate([i*0.3*outer_d,0,0])
                cylinder(h=magnet_size[1], d=magnet_size[0]);
            }

            // Airhole
            translate([0,0,h/2])
            cylinder(h=h,d=air_duct_d);
            
            translate([0,0,h/2])
            rotate([90,0,0])
            cylinder(h=outer_d,d=air_duct_d);
            
            translate([0,-outer_d/2+10,h/2]){
                rotate([90,0,0]){
                    cylinder(h=outer_d,d=hose_connector_inner_d);
                    translate([0,0,8])
                    cylinder(h=outer_d,d=hose_connector_inner_d+7);
                }
            }
        } else {
            // Airhole
            cylinder(h=h+h_inner,d=air_duct_d);
            cylinder(h=10, d=hose_connector_inner_d);

            // Innder funnel
            translate([0,0,h])
            cylinder(d1=air_duct_d, d2=inner_d-2, h=h_inner);

            // Magnet
            rotate([0,90,0])
            translate([-h/2,0,-outer_d/2])
            cylinder(d=magnet_size[0], h=magnet_size[1]);   
        }

    }

    // Mini floor + attachment points
    translate([0,0,h-0.5]){
        // Floor
        difference(){
            intersection(){
                translate([-2/3*inner_d,0,-0.5])
                cube(inner_d, center=true);
                cylinder(h=h_inner, d=inner_d);
            }
            for (i=[-1,1]){
                translate([-1/3.5*inner_d,i*0.2*inner_d,h_inner-2])
                cylinder(d=3,h=2);
            }
        }
        

        // Attachment points
        for (i=[-90,0,90]){
            rotate([0,0,i])
            translate([1/2*inner_d-2.5,0,0])
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

module tube_floor(
    chamber_length,
    inner_d1,
    inner_d2
){
    chamber_length = chamber_length - 2*10;

    translate([0,0,-chamber_length/2])
    intersection(){
        translate([2/3*inner_d1+0.2,0,chamber_length/2])
        cube([inner_d1+2, inner_d1+2, chamber_length], center=true);
        cylinder(d1=inner_d1, d2 = inner_d2, h=chamber_length);
    }
    for (i=[-1,1]){
        for (j=[-1,1]){
            translate([1/3.5*inner_d1,i*0.2*inner_d1,j*chamber_length/2+j/2])
            cylinder(d=2.5, h=2, center=true);
        }
    }
}

