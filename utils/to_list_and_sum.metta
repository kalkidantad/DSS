(= (add_fold $num (Cons $x $xs))
    (let $sum (+ $num $x) (Cons $sum $xs))
)
(= (foldl (add_fold $num Nil)) $num)
(= (foldl (Cons $x $xs))
    (foldl (add_fold $x $xs))
)
(= (to-list $expr)
   (if (== $expr ()) Nil
     (Cons (car-atom $expr)
           (to-list (cdr-atom $expr)))
   )
)
! (foldl (to-list (1 2 3 4 5)))