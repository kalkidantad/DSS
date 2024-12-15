!(register-module! ../RSS)
!(import! &self RSS:data)
!(import! &self RSS:random2)


(=($x) $x)
;; add Data to space
!(manuplate-space add-atom &data (collapse (match &self (data_point $x) (data_point $x $x))))

;; add programs to space
;!(manuplate-space add-atom &program (collapse (match &self (program $x) (program $x))))

;;select instance subset of subset_size
(=(selectSubset $subset_size)(
   (let $randomIndex (random $subset_size ()) 
        ( (superpose (match)) (superpose (&data)) ($x (superpose $randomIndex) $y)  ( $x $y) )
   )
))
!(selectSubset 8)

























;; Select instances from B with a uniform probability S/T to create a subset S(0)

;for generation g
;;evaluate test fitness 
;;Evolve mutation crossover
;;generate subset of length n