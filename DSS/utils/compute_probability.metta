;total_fitness_weight
(=(total_fitness_weight)(
  ((py-dot add sum)  (py-list(collapse (match &self (data_point $x) $x))))
))

;fitness weight of single data Wi(g)
(=(fitness-weight (data_point $x $D $A) $d $a)(
    (let* (
          ($Di  ((py-dot power pow) $D $d))
          ($Ai  ((py-dot power pow) $A $a))
          ($wi (+ $Di  $Ai))
         )
         $wi)
))

;compute probability
(= (compute_probability $data_point $subset_size $total_fitness_weight)(
    (let $product 
         (* (fitness-weight $data_point) $subset_size)
         (/ $product $total_fitness_weight)
           
    )
))