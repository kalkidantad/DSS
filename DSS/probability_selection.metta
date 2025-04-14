!(register-module! ../../Addaptive_sampling_for_GP)
!(import! &self Addaptive_sampling_for_GP:utils:reverse)
!(import! &self Addaptive_sampling_for_GP:utils:sort)
!(import! &self Addaptive_sampling_for_GP:utils:select)

;;select n subset based on probability
(data_point 3 3 3 18 0.8780487804878049) (data_point 2 2 1 5 0.24390243902439024) (data_point 1 3 2 13 0.6341463414634146) (data_point 0 2 1 5 0.24390243902439024)

(= (get-data ()) (
   collapse (match &self ($data $index $D $A $w $pro) $pro)
))

(= (to-list $expr)
   (if (== $expr ()) Nil
     (Cons (car-atom $expr)
           (to-list (cdr-atom $expr)))
   )
)
(= (get-data-with-probability  $probabilities)
    ((superpose (match)) (superpose (&self)) ($data $index $D $A $w (superpose $probabilities))  ($data $index $D $A $w) )
)

!(get-data-with-probability (select 2 () (reverse (sort (to-list (collapse (superpose (get-data ()))))))))
!(select 2 () (reverse (sort (to-list (collapse (superpose (get-data ())))))))



