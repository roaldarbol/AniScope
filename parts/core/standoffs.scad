// ============== ETHOSCOPE CHILD MODULES ============= //



// module standoff_single(bolt_diam, standoff_height, wall_thick){
//     bolt_diam = bolt_diam + 0.15; // Here's changing the camera bolt size
//     $fn=30;
//     difference(){
//         hull(){
//             translate([0,0,standoff_height-0.2]) cylinder(d=bolt_diam+wall_thick, h=0.1);
//             cylinder(d=(bolt_diam+wall_thick)*standoff_height/4, h=0.1);
//         }
//         cylinder(d=bolt_diam, h=standoff_height); 
//     }
// }


// module standoff_quad(standoff_dims, bolt_diam, wall_thick){
//     for (i=[-1,1]){
//         translate([standoff_dims[0]/2,i*standoff_dims[1]/2,0])
//         standoff_single(bolt_diam, standoff_dims[2], wall_thick);
//     }
//     mirror([1,0,0])
//     for (i=[-1,1]){
//         translate([standoff_dims[0]/2,i*standoff_dims[1]/2,0])
//         standoff_single(bolt_diam, standoff_dims[2], wall_thick);
//     }
// }