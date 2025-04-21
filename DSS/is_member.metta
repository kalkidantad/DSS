!(register-module! ../../Addaptive_sampling_for_GP)
!(import! &self Addaptive_sampling_for_GP:DSS:new_data)
!(import! &self Addaptive_sampling_for_GP:utils:manuplate-space)

!(bind! &new_data (new-space))

!(manuplate-space add-atom &new_data 
   (collapse (match &self (data_point $index $D $A $W $INITIAL) 
                    (data_point $index $D $A $W $INITIAL))))

;; checks whether a given index exists in the selected data
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

;; to test by giving some records
!(isMember 7 ((data_point 7 0 0 0 0) (data_point 21 0 0 0 0) (data_point 11 0 0 0 0)))

