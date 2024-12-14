!(register-module! ../RSS)
!(import! &self RSS:data)
!(import! &self RSS:random2)
;!(import! &self RSS:program)
!(bind! &data (new-space))
;!(bind! &program (new-space))
;! (bind! np-rnd (py-atom numpy.random))


;; add Data to space
!(manuplate-space add-atom &data (collapse (match &self (data_point $x) (data_point $x))))

;; add programs to space
!(manuplate-space add-atom &program (collapse (match &self (program $x) (program $x))))

;;select instance subset of subset_size
(=(selectSubset $subset_size)(
   (let $randomIndex (random $subset_size ()) (
     (superpose (match)) (superpose (&self)) ($x  (superpose $randomIndex)) ($x)
   )
   )
))

!(selectSubset 4)


;!((superpose (match)) (superpose (&self)) ($x  (superpose(3 19 13 20 12 16 10 9)) $in) ($x $in $in))























;; Select instances from B with a uniform probability S/T to create a subset S(0)

;for generation g
;;evaluate test fitness 
;;Evolve mutation crossover
;;generate subset of length n