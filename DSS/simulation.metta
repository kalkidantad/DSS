!(register-module! ../../Addaptive_sampling_for_GP)
!(import! &self Addaptive_sampling_for_GP:DSS:new_data)
!(import! &self Addaptive_sampling_for_GP:RSS:program)
!(import! &self Addaptive_sampling_for_GP:utils:manuplate-space)
!(import! &self Addaptive_sampling_for_GP:RSS:evaluate)
!(import! &self Addaptive_sampling_for_GP:RSS:evolve)
!(import! &self Addaptive_sampling_for_GP:utils:reverse)
!(import! &self Addaptive_sampling_for_GP:utils:sort)
!(import! &self Addaptive_sampling_for_GP:utils:select)
!(import! &self Addaptive_sampling_for_GP:utils:to_list_and_sum)
!(import! &self Addaptive_sampling_for_GP:DSS:update-difficulty-age)
; !(import! &self Addaptive_sampling_for_GP:DSS:probabilityy)
; !(import! &self Addaptive_sampling_for_GP:DSS:probability_selection)


!(bind! &new_data (new-space))
!(bind! &program (new-space))

!(bind! randint (py-atom random.randint))



;; Initializes all data points with (D=0, A=0, w=1, p=0.01).
;; Each generation:
;; Selects data points based on the highest probability.
;; Updates difficulty and age based on selection.
;; Recomputes weights (w) and probabilities (p).
;; Selects new data for evaluation.




;; Add Programs
!(manuplate-space add-atom &program (collapse (match &self (program $index) (program $index $index 0))))
!(manuplate-space add-atom &new_data 
   (collapse (match &self (data_point $index $D $A $W $INITIAL) 
                    (data_point $index $D $A $W $INITIAL))))



(= (selectedIndices $lb $ub $n $acc) 
   (if (== $n 0)
      $acc
      (let*
         (
            ($i (randint $lb $ub))
            ($c (cons-atom $i $acc))
         )
         (selectedIndices $lb $ub (- $n 1) $c)
      )
))

!(selectedIndices 0 100 10 ())

!( let* 
   (
   ($a (selectedIndices 0 100 10 ()))
   ($b (superpose $a))
   )
   (match &new_data (data_point $b $d $f $t $u) (data_point $b $d $f $t $u))
)



(= (get_programs $programs)
   (case $programs(
      (() (collapse (match &program ($program $index $index  $score) ($program $index  $score))))
      ($programs $programs)
   ))
   
)

(= (get-data ()) (
   collapse (match &new_data ($data $index $D $A $w $pro) $pro)
))

(= (to-list $expr)
   (if (== $expr ()) Nil
     (Cons (car-atom $expr)
           (to-list (cdr-atom $expr)))
   )
)
(= (get-data-with-probability  $probabilities)
    ((superpose (match)) (superpose (&new_data)) ($data $index $D $A $w (superpose $probabilities))  ($data $index $D $A $w) )
)


;; Dynamic Subset Sampling for Evolution
(= (generation $n $programs $dataset $subset_size $total_data_size)
   (let* (
          ( () (println! (------ Generation $n ------)))
         ;  ( () (println! (Dataset Used: $dataset)))
          
          ;; Select initial subset for the first generation, otherwise use select-top-data
          ($subset_data (if (== $n $5)
                            (selectedIndices 0 $total_data_size $subset_size ())
                            (get-data-with-probability (select $subset_size () (reverse (sort (to-list (collapse (superpose (get-data ())))))))
)
                        ))
          ( () (println! (Selected Data: $subset_data)))
          
          ;; Evaluate programs on the selected dataset
          ($evaluated_programs (evaluate (get-programs) $subset_data))
          ( () (println! (Programs Evaluated: $evaluated_programs)))
          
          ;; Evolve the programs
          ($new_generation (evolve $evaluated_programs))
          ( () (println! (Programs Evolved: $new_generation)))
          
          ;; Update dataset difficulty & age
          ( () (update-difficulty-age $new_generation))
          ( () (probability $new_generation $subset_size))  
         ;  ( () (update-probabilities $subset_size))  

          ;; Select new data for the next generation
          ($new_data (get-data-with-probability (select $subset_size () (reverse (sort (to-list (collapse (superpose (get-data ())))))))))
          ( () (println! (New Dataset Selected: $new_data)))
        )
       
       ;; Recursive call until n reaches 1
       (if (== (- $n 1) 0)
           $new_generation
           (generation (- $n 1) $new_generation $new_data $subset_size $total_data_size)
       )
   )
)





!(generation 5 () (selectedIndices 0 100 10 ()) 10 100)


;; Run the Dynamic Subset Sampling for 5 Generations
;; !(generation 5 () (select-top-data 4) 4)