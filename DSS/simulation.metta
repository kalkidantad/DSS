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
; !(import! &self Addaptive_sampling_for_GP:utils:random_number)
; !(import! &self Addaptive_sampling_for_GP:DSS:probabilityy)



;; Probability calculation 

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



;; Initializes all data points with (D=0, A=0, w=1, p=0.01).
;; Each generation:
;; Selects data points based on the highest probability.
;; Updates difficulty and age based on selection.
;; Recomputes weights (w) and probabilities (p).
;; Selects new data for evaluation.

!(bind! &new_data (new-space))
!(bind! &program (new-space))

!(bind! randint (py-atom random.randint))


;; Add Programs
!(manuplate-space add-atom &program (collapse (match &self (program $index) (program $index $index 0))))
!(manuplate-space add-atom &new_data 
   (collapse (match &self (data_point $index $D $A $W $INITIAL) 
                    (data_point $index $D $A $W $INITIAL))))



; Function to initialize dataset with uniform probability
; (= (initialize-data $total_data_size $subset_size)
;    (let* (
;           ( () (println! (------ Initializing Data Points ------)))
;           ($initial_probability (/ $subset_size $total_data_size))  ;; Compute uniform probability
;           ($data_points (collapse (match &new_data (data_point $index  $D $A $W $INITIAL) 
;                                       (data_point $index 0 0 1 $initial_probability))))  ;; Use computed p
;         )
;         (manuplate-space add-atom &new_data) 
        
        
;           ;; Get Programs for Evaluation data $data_points
;    )
; )


; ;; Function to initialize the first generation subset 
; (= (initialize-subset $data_size $subset_size)
;   (let* ( 
;           ( ()  (println! (------ Initializing First Generation Subset ------)))
;          ;  ($selected_points (collapse (random $subset_size $data_size)
;             ($selected_points (randint $subset_size $data_size))

;             ; ((superpose (match (data_point $index $D $A $W $INITIAL))) 
;             ;    (superpose (&new_data)) 
;             ;    (($index $D $A $W $INITIAL) (superpose $selected_points) $y)  
;             ;    ((data_point $index $D $A $W $INITIAL) $y) 
;             ;    )

;           )
;          ($initialized_subset (collapse (Map $selected_points)))

;           )  ;; Randomly select subset_size data points
          
;         )
;       ;   $initialized_subset
; ;    )
; ; )

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

; !(selectedIndices 0 100 10 ())

!( let* 
   (
   ($a (selectedIndices 0 100 10 ()))
   ($b (superpose $a))
   )
   (match &new_data (data_point $b $d $f $t $u) (data_point $b $d $f $t $u))
)


;; Function to update difficulty and age based on selection

;; consider fitness function (evaluate)
(= (update-difficulty-age $selected_data)
   (let* (
          ( () (println! (------ Updating Difficulty and Age ------)))
          ($updated_data
            (collapse (match &new_data ($data $index $D $A $w $p)
               (if (isMember $index $selected_data)
                   (data_point $index (+ $D (if (> (randint 1 10) 7) 1 0)) 0 $w $p)  ;; If selected, reset age to 0 & possibly increase difficulty by 1 if the random number generated is greter than 7
                   (data_point $index $D (+ $A 1) $w $p)   ;; If not selected, increase age
               )
            )))
        )
        (manuplate-space add-atom &new_data $updated_data)
   )
)

;; To recompute weights and probabilities
(= (update-probabilities $subset_size)
   (let* (
          ( () (println! (------ Updating Probabilities ------)))
          ($updated_weights (collapse (fitness-weight (superpose (match &new_data ($data $index $D $A $w $p) 
                                                   ($data $index $D $A $w $p))) 2 2))) 
          ($total_weight (total_fitness_weight (collapse (get-weight (superpose $updated_weights)))))
          ($wiProduct (collapse (product (superpose $updated_weights) $subset_size)))
          ($probability (collapse (compute_probability (superpose $wiProduct) $total_weight)))
        )
        (manuplate-space add-atom &new_data $probability)
   )
)


;; Select Data Points Based on Updated Probabilities
;; needs improvement
(= (select-top-data $subset_size)
   (collapse (select $subset_size () 
       (reverse (sort (to-list (collapse (superpose (match &new_data ($data $index $D $A $w $p) 
                                               ($data $index $D $A $w $p))))))))))


(= (get_programs $programs)
   (case $programs(
      (() (collapse (match &program ($program $index $index  $score) ($program $index  $score))))
      ($programs $programs)
   ))
   
)


;; Dynamic Subset Sampling for Evolution
(= (generation $n $programs $dataset $subset_size $total_data_size)
   (let* (
          ( () (println! (------ Generation $n ------)))
         ;  ( () (println! (Dataset Used: $dataset)))
          
          ;; Select initial subset for the first generation, otherwise use select-top-data
          ($subset_data (if (== $n $5)
                            (initialize-subset $data_size $subset_size)
                            (select-top-data $subset_size)
                        ))
          
          ( () (println! (Selected Data: $subset_data)))
          
          ;; Evaluate programs on the selected dataset
          ($evaluated_programs (evaluate (get-programs) $subset_data))
          ( () (println! (Programs Evaluated: $evaluated_programs)))
          
          ;; Evolve the programs
          ($new_generation (evolve $evaluated_programs))
          ( () (println! (Programs Evolved: $new_generation)))
          
          ;; Update dataset difficulty, age, and probabilities
          ( () (update-difficulty-age $dataset))  
          ( () (update-probabilities $subset_size))  
          
          ;; Select new data for the next generation
          ($new_data (select-top-data $subset_size))
          ( () (println! (New Dataset Selected: $new_data)))
        )
       
       ;; Recursive call until n reaches 1
       (if (== (- $n 1) 0)
           $new_generation
           (generation (- $n 1) $new_generation $new_data $subset_size $total_data_size)
       )
   )
)





; !(initialize-data 100 10)   ;; Assuming 100 total records, 10 selected per generation
!(generation 5 () (initialize-subset 100 10) 10 100)


;; Run the Dynamic Subset Sampling for 5 Generations
; !(initialize-data)
;; !(generation 5 () (select-top-data 4) 4)