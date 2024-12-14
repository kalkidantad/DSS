!(register-module! ../RSS)
!(import! &self RSS:data)
;!(import! &self RSS:program)
!(bind! &data (new-space))
;!(bind! &program (new-space))
! (bind! power (py-atom pow))
!(bind! add (py-atom sum))

;; add Data to space
;initialize  deficualty degree 0 and age 0
;!(manuplate-space add-atom &data (collapse (match &self (data_point $x) (data_point $x 0 0))))

;!(get-atoms &data)

(=(generate $generation)(
    if (>= $generation 0)
       ()
       ()
))
;fitness weight of single data
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

;total_fitness_weight

(=(total_fitness_weight)(
  ((py-dot add sum)  (py-list(collapse (match &self (data_point $x) $x))))
))

!(fitness-weight (data_point 2 5 3) 2 3)
       



