;(:select (-> Size List List))
(= (select $size $list Nil) $list)
(= (select $size $list (Cons $x $xs))
       (if (== (- $size 1) -1)
        $list
        (let $newList (cons-atom  $x $list) (select (- $size 1) $newList $xs))
   )
)


;!(select 8 () (Cons 1 (Cons 2 (Cons 3 (Cons 4 (Cons 5 (Cons 6 (Cons 7 Nil))))))))
