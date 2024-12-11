!(bind! np-rnd (py-atom random)) 
(= [$x] $x)
( = (random-sample $data ) (
   let $list ((py-dot np-rnd sample) (py-tuple $data) 2)  (py-atom $list)
))



!(random-sample (12 14 11 13))

