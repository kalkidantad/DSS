!(bind! np-rnd (py-atom random)) 
(= [$x] $x)
( = (random-sample $data ) (
   let $list ((py-dot np-rnd sample) (py-tuple $data) 2)  $list
))



!( let $x 
        (random-sample ((data_point 91) (data_point 92) (data_point 93) (data_point 94) (data_point 95) (data_point 96)))
        
        (get-type $x))

