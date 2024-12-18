 ;sort
(= (sort Nil) Nil)
(= (insert $num Nil) (Cons $num Nil))

(= (sort (Cons $x $xs))
    (insert  $x (sort $xs)))
(= (insert  $num (Cons $x $xs))
    (if (> $num $x)
        (Cons $x (insert  $num $xs))
        (Cons $num (Cons $x $xs))))