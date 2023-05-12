inner_d = 18*2;
outer_d = inner_d + 5;
magnet_size = [6.2,3]; // diameter, height
$fn = 100;

ethoscope_metabolic_chamber(true, inner_d, outer_d, magnet_size);

module ethoscope_metabolic_chamber(
    hose_on_side=true,
    inner_d,
    outer_d,
    magnet_size
){
    h = 30;
    h_inner = 8;
    air_duct_d = 3;
    hose_connector_inner_d = 10;
    
    
    difference(){
        union(){
            cylinder(h=h, d=outer_d);
            cylinder(h=h+h_inner, d=inner_d);
            difference(){
                cylinder(h=h+h_inner/2, d=outer_d+3);
                cylinder(h=h+h_inner/2, d=outer_d);
            }
        }
        
        // Magnets
        for (i=[-1,1]){
            translate([i*0.3*outer_d,0,0])
            cylinder(h=magnet_size[1], d=magnet_size[0]);
        }
        
        if (hose_on_side==true){
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
            translate([0,0,h])
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
        }
        
        
    }
}

