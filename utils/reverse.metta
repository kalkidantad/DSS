 ;reverse
(:reverse (-> List List))
(= (reverse Nil) Nil)
(= (append Nil $num) (Cons $num Nil))

(= (append (Cons $x $xs) $num)
    (Cons $x (append $xs $num)))
(= (reverse (Cons $x $xs))
    (append (reverse $xs) $x))