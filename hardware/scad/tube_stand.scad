//// ========================================= //
//// ============ TEST TUBE MOUNT ============ //
//// ========================================= //
//
//// Here's some documentation of what the holder is, and what it's used for..
//// Maybe a brief licensing bit?
//
//
//// Generate the damn thing
//horisontal_tube_rack(tube_diam, beam_width, rack_length);
//
//// ========================================= //
//// ================ Specs ================== //
//// ========================================= //
//
//// Current specs fit these tubes from Amazon (https://amzn.to/3n3Qyw3) 
//// with these O-rings (https://amzn.to/30EqjF5)
//
//// General specs
//$fn = 30;
//wall_thick = 2;
//bolt = 3.2;
//bolt_diameter = 3.0; 
//
//
//// O-ring specs
//outer_diam = 22;
//ring_diam = 2.2;
//
//
//// Tube rack specs
//tube_diam = 20.5; //18.5
//beam_width = 10;
//rack_length = 140;
//
//// For standing
//standing = 1;
//
//
//// ========================================= //
//// ================ Modules ================ //
//// ========================================= //
//
//
//// === Module: O-ring === //
//module o_ring(outer_diam, ring_diam) {
//    outer_diam = outer_diam + 1;
//    rotate([0,0,0])
//    rotate_extrude(angle=360) {
//        translate([(outer_diam-ring_diam/2)/2, 0])
//        circle(d=ring_diam); 
//        } // rotate_extrude
//    cylinder(d=outer_diam-ring_diam/2, h=ring_diam, center=true);
//}
//
//// === Module: Test tube rack === //
//module horisontal_tube_rack(tube_diam, beam_width, rack_length) {
//    min_space_between = 8;
//    space_above = 5;
//    beam_width = beam_width + 0.2;
//    rack_width = (2*wall_thick)+ring_diam;
//    rack_height = space_above+tube_diam/2;
//    end_space = 2 * (beam_width+wall_thick);
//    
//    // Calculate the max number of tubes and their spacing
//    func_tube = tube_diam+min_space_between;
//    n_tubes = floor((rack_length)/(tube_diam+min_space_between));
//    shift = (rack_length - (n_tubes*tube_diam + (n_tubes-1)*min_space_between)) / 2;
//    
//    union(){
//        difference(){
//            cube([rack_width, rack_length, rack_height], center=true);
//            
//            // Inserts for tubes
//            rotate([0,90,0])
//            translate([-rack_height/2,-(rack_length-tube_diam)/2+shift,0])
//            for (i=[0:1:n_tubes-1]){
//                translate([0,i*(tube_diam+min_space_between),0]){
//                    cylinder(d=tube_diam, h=beam_width, center=true);
//                    o_ring(outer_diam,ring_diam);
//                }
//            }
//            
//            // Standing rack
//            if (standing > 0.5){
//                end_length = 2*beam_width;
//                bolt_rad= (bolt_diameter+1)/2;
//            
//                // MakerBeam insert
//                for (i=[-1:2:1]){
//                    translate([-wall_thick,i*rack_length/2-i*end_length/2.5,0])
//                    cube([rack_width, beam_width, beam_width], center=true);
//                
//                    // Screw head
////                    rotate([0,90,0])
////                    translate([0,i*rack_length/2-i*end_length/2.5,0])
////                    cylinder(rack_width,bolt_rad,bolt_rad*2, center=true);
//                    
//                    translate([rack_width/2,i*rack_length/2-i*end_length/2.5,0])
//                    rotate([0,-90,0]){
//                    cylinder(h=rack_width, d=bolt_diameter);
//                    hull(){
//                        translate([0,0,2])cylinder(h=0.1, d=bolt_diameter);
//                        cylinder(h=0.1, d=bolt_diameter*2);
//                    }
//                }
//                }  
//            }
//        }
//        
//        // Add attachment segment
//        if (standing < 0.5){
//            end_width = beam_width;
//            end_length = 2*beam_width;
//            
//            translate([beam_width/2+rack_width/2,0,-(rack_height-wall_thick)/2])
//            for (i=[-1:2:1]){
//                translate([0,i*rack_length/2-i*end_length/2,0])
//                difference(){
//                    cube([end_width,end_length,wall_thick], center=true);
//                    cylinder(d=bolt, h=wall_thick, center=true);
//                }
//            }
//        }
//    }
//}