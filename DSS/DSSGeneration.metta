!(register-module! ../../addaptive_sampling)
!(import! &self addaptive_sampling:RSS:data)
!(import! &self addaptive_sampling:RSS:program)
!(import! &self addaptive_sampling:utils:manuplate-space)
!(import! &self addaptive_sampling:utils:random_number)
!(import! &self addaptive_sampling:RSS:evaluate)
!(import! &self addaptive_sampling:RSS:evolve)

!(bind! &data (new-space))
!(bind! &program (new-space))

;; bind data and programs to space
;; add Data to space (data_point $index $diff $age $w $probability)
!(manuplate-space add-atom &data (collapse (match &self (data_point $index) (data_point $index $index 0 0 0 0))))
!(manuplate-space add-atom &program (collapse (match &self (program $index) (program $index $index 0))))


;;select instance subset of subset_size
(= (selectSubset $subset_size $data_size)(
   collapse (let $randomIndex (random $subset_size $data_size ()) 
        ((superpose (match)) (superpose (&data)) ($data (superpose $randomIndex) $index $diff $age $w $probability)  
                                                 ($data $index $diff $age $w $probability) 
        )
   )
))

(= (get_programs $programs)
   (case $programs(
      (() (collapse (match &program ($program $index $index  $score) ($program $index  $score))))
      ($programs $programs)
   ))
   
)


(=(generation $n $programs $dataset)
  (let* ( ( ()  (println! (------ $n Generation  ------)))
          ( ()  (println! (Random subset generated : $dataset)))
          ($evaluated_programs (evaluate (get_programs $programs) $dataset))
          ( ()  (println! (programs evaluated : $evaluated_programs)))
          ($new_generaion (evolve $evaluated_programs))
          ( ()  (println! (programs generated : $new_generaion)))
          ($new_random_subset (selectSubset 4 25))
          ( ()  (println! (New Random subset generated)))
        )
       (if(== (- $n 1) 0)
          $new_generaion
          (generation (- $n 1) $new_generaion $new_random_subset)
       )
   )
)

;!(generation 5 () (selectSubset 4 25))

!(selectSubset 4 25)