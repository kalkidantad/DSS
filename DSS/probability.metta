!(register-module! ../../addaptive_sampling)
!(import! &self addaptive_sampling:utils:to_list_and_sum)

! (bind! power (py-atom pow))

(deficualtParam 0.9)
(ageParam 0.2)

;;;(data_point $index $diff $age $w $probability)

;; function to extruct weight of data
(= (get-weight (data_point $index $diff $age $w $probability)) $w)

;; wi*s
(=(product ($data_point $index $diff $age $w $probability) $subset_size)
   ( 
    let $Wip (* $w $subset_size) ($data_point $index $diff $age $w $probability $Wip)
   )
)

;; total_fitness_weight
(=(total_fitness_weight $w)
  (foldl (to-list $w))
)

;fitness weight of single data Wi(g)
(=(fitness-weight (data_point $index $D $A $w $p) $d $a)
    (let* (
          ($Di  ((py-dot power pow) $D $d))
          ($Ai  ((py-dot power pow) $A $a))
          ($wi  (+ $Di  $Ai))
         )
         (data_point $index $D $A $wi $p)
    )
)

;compute probability of single data
(= (compute_probability ($data_point $index $diff $age $w $probability $Wip) $total_fitness_weight)
    (
        let $newProbability (/ $Wip $total_fitness_weight) ($data_point $index $diff $age $w $newProbability)
    )
)


;; function to compute probability (data points) (subset size to select)
(= (probability $data_points $subset_size )
  (let* ( ( ()  (println! (------ probability computing  ------)))
          ($wi (collapse (fitness-weight (superpose $data_points) 2 2)))
          ($total_fitness_weight (total_fitness_weight (collapse (get-weight (superpose $wi)))))
          ($wiProduct (collapse (product (superpose $wi) $subset_size)))
          ($probability (collapse (compute_probability (superpose $wiProduct) $total_fitness_weight)))
        )
        $probability
   )
)



!(probability ((data_point 0 2 1 2 0) (data_point 1 3 2 2 0) (data_point 2 2 1 0 0) (data_point 3 3 3 0 0)) 2)


