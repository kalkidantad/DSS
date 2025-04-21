!(register-module! ../../Addaptive_sampling_for_GP)
!(import! &self Addaptive_sampling_for_GP:DSS:new_data)
!(import! &self Addaptive_sampling_for_GP:utils:manuplate-space)
; !(import! &self Addaptive_sampling_for_GP:DSS:is_member)

!(bind! &new_data (new-space))
!(bind! &program (new-space))

!(bind! randint (py-atom random.randint))

!(manuplate-space add-atom &new_data 
   (collapse (match &self (data_point $index $D $A $W $INITIAL) 
                    (data_point $index $D $A $W $INITIAL))))


(= (isMember $x $record)
    (if (== $checker Symbol) False
        (let*
            (
                ($head (car-atom $record))
                ($tail (cdr-atom $record))
                ($searched (index-atom $head 1))      
                ($checker (get-metatype $record))
            )
            (   (if (== $x ()) False 
                    (if (== $x $searched) True (isMember $x $tail)))     
            )
)
)
)

(= (update-difficulty-age $selected_data)
   (let* (
          ( () (println! (------ Updating Difficulty and Age ------)))
          ($updated_data
            (collapse (match &new_data (data_point $index $D $A $w $p)

               (if (isMember $index $selected_data)
                   (data_point $index (+ $D (if (> (randint 1 10) 7) 1 0)) 0 $w $p)  ;; If selected, reset age to 0 & possibly increase difficulty by 1 if the random number generated is greter than 7
                   (let*
                        ($new_age (+ $A 1))
                   )
                   (data_point $index $D $new_age $w $p)   ;; If not selected, increase age and retain the difficulty
               )
            )))
        )
        $updated_data
   )
)

!(update-difficulty-age ((data_point 1 0 0 0 0) (data_point 11 0 0 0 0) (data_point 21 0 0 0 0) (data_point 31 0 0 0 0) (data_point 41 0 0 0 0) (data_point 51 0 0 0 0) (data_point 61 0 0 0 0) v (data_point 71 0 0 0 0) (data_point 81 0 0 0 0) (data_point 91 0 0 0 0)))

; !(match &new_data (data_point $index $D $A $w $p) (data_point $index $D $A $w $p))