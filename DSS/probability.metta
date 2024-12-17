!(register-module! ../../addaptive_sampling)
!(import! &self addaptive_sampling:utils:to_list_and_sum)

! (bind! power (py-atom pow))

(deficualtParam 0.9)
(ageParam 0.2)
;(data_point $index $diff $age $w $probability)
(data_point 0 2 1 2 0) (data_point 1 3 2 2 0) (data_point 2 2 1 0 0) (data_point 3 3 3 0 0)

(=(get-data ()) (collapse (match &self (data_point $index $diff $age $w $probability) (data_point $index $diff $age $w $probability)) )
)

;; total_fitness_weight
(=(total_fitness_weight $w)
  (foldl (to-list $w))
)

;fitness weight of single data Wi(g)
(=(fitness-weight (data_point $index $D $A $w $p) $d $a)(
    (let* (
          ($Di  ((py-dot power pow) $D $d))
          ($Ai  ((py-dot power pow) $A $a))
          ($wi (+ $Di  $Ai))
         )
         (data_point $index $D $A $wi $p)
    )
))

;!(let $datas (get-data ()) (fitness-weight (superpose $datas) 2 2))
!(total_fitness_weight (collapse (match &self (data_point $index $diff $age $w $probability) $w )))
