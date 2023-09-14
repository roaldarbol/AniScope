module tube_insert(
    chamber_length,
    inner_d,
    min_height
){
    inner_d = inner_d - 0.1;
    chamber_length = chamber_length - 2*9.5;
    // rotate([90,0,0])
    difference(){
        cylinder(d=inner_d, h=chamber_length, center=true);
        translate([5,0,0]){
            for (i=[-1,1]){
                rotate([90,0,0])
                translate([i*0.2*inner_d,i*0.2*chamber_length,0])
                hull(){
                    cylinder(d=inner_d*0.5, h=inner_d, center=true);
                    translate([0,i*0.5*chamber_length,0])
                    cylinder(d=inner_d*0.5, h=inner_d, center=true);
                }
            }
            // translate([0,5,0])
            hull(){
                rotate([90,0,0])
                translate([0.2*inner_d,0.2*chamber_length,0])
                cylinder(d=inner_d*0.5, h=inner_d, center=true);
                rotate([90,0,0])
                translate([-0.2*inner_d,-0.2*chamber_length,0])
                cylinder(d=inner_d*0.5, h=inner_d, center=true);
            }
        }
    }
    intersection() {
        difference(){
            cylinder(d=inner_d, h=chamber_length, center=true);
            cylinder(d=inner_d-3, h=chamber_length, center=true);
        }
        #translate([0,inner_d/2,0])
        hull(){
                rotate([90,0,0])
                translate([0.2*inner_d,-0.1*chamber_length,0])
                cylinder(d=inner_d, h=inner_d, center=true);
                rotate([90,0,0])
                translate([-0.2*inner_d,0.1*chamber_length,0])
                cylinder(d=inner_d*0.5, h=inner_d, center=true);
            }
    }
    
}