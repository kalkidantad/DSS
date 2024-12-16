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
;; add Data to space
!(manuplate-space add-atom &data (collapse (match &self (data_point $index) (data_point $index $index))))
!(manuplate-space add-atom &program (collapse (match &self (program $index) (program $index $index 0))))

;!(match &program ($program 5 $index  $score) ($program $index  $score))
;;select instance subset of subset_size
(= (selectSubset $subset_size $data_size)(
   collapse (let $randomIndex (random $subset_size $data_size ()) 
        ((superpose (match)) (superpose (&data)) ($x (superpose $randomIndex) $y)  ($x $y) )
   )
))

(= (get_programs ())
   (collapse (match &program ($program $index $index  $score) ($program $index  $score)))
)


(=(generation $n $dataset)
  (let* ( ($evaluated_programs (evaluate (get_programs ()) $dataset))
          ( ()  (println! (programs evaluated)))
          ($new_generaion (evolve $evaluated_programs))
          ( ()  (println! (programs generated)))
          ($new_random_subset (selectSubset 4 25))
          ( ()  (println! (New Random subset generated)))
        )
        $new_random_subset
   )
)
(=(generation $n $dataset)
  (let $evaluated_programs (evaluate (get_programs ()) $dataset)
       (let () (println! $evaluated_programs)
       
       )
      
  )
) 

!(generation 5 (selectSubset 4 25))


(let $newGen (evolve $evaluated_programs)
                (let () (println! (finished program Evolution))
                    $newGen
                ))