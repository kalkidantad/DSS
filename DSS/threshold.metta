
(=(get-fitness $index $evaluated_programs)
   (collapse (match $evaluated_programs (($program $idx $fitness)
        (if (= $idx $index) $fitness  ;; Return fitness if index matches
            (get-fitness $index (rest $evaluated_programs)))  ;; Recursively search in the list
     )
   )))




(= (update-difficulty-age $selected_data)
   (let* (
          ( () (println! (------ Updating Difficulty and Age Based on Fitness ------)))
          ($evaluated_programs (evaluate &population &subset))  ;; Get fitness values
          ($updated_data
            (collapse (match &new_data ($data $index $D $A $w $p)
               (if (isMember $index $selected_data)
                   (let (
                          ($fitness (get-fitness $index $evaluated_programs)) ;; Retrieve fitness for $index
                          ($newD (if (< $fitness THRESHOLD) (+ $D 1) 0)) ;; Increase D if fitness is low, else reset
                        )
                      (data_point $index $newD 0 $w $p)  ;; Reset age & adjust difficulty
                   )
                   (data_point $index $D (+ $A 1) $w $p)   ;; If not selected, increase age
               )
            )))
        )
        (manuplate-space add-atom &new_data $updated_data)
   )
)
