;!(import! &self addaptive_sampling:utils:manuplate-space)
;;select instance subset of subset_size
(=(selectSubset $subset_size)(
   (let $randomIndex (random $subset_size ()) 
        ( (superpose (match)) (superpose (&data)) ($x (superpose $randomIndex) $y)  ( $x $y) )
   )
))