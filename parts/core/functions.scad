function add(vector, k) = [ for (vector=vector) vector+k ];
    
function get_points(distances) // A vector of 2
    = [ [-distances[0]/2,-distances[1]/2],
        [distances[0]/2,-distances[1]/2],
        [-distances[0]/2,distances[1]/2],
        [distances[0]/2,distances[1]/2]
    ];

function selector(item, dict) = dict[search([item], dict)[0]];

function magnet_size_correct(magnet_size) 
    = [ magnet_size[0]+0.4, magnet_size[1]+0.2 ];