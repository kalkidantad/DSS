! (bind! np-rnd (py-atom numpy.random))

;; check if the element is a member of a list
(= (isMember $elemnt $list)
    (not (== (collapse (intersection (superpose ($elemnt)) (superpose $list))) ()))
)
;;random number generator
(=(($x)) $x)
(=(random $num $list)(
  if(== $num 0)
    $list
    (let $item ((py-dot np-rnd randint) 25) (
      if(isMember $item $list)
        (random $num $list)
        ((let* (
               ($newlist (cons-atom $item $list))
               ($newNum (- $num 1))
               )
              (random $newNum $newlist)
       ))
    ))
  
))

!(random 8 ())











;(=(random $num $list)(
;  let $item ((py-dot np-rnd randint) 25)
;    (if   (or (not (isMember $item $list)) (== $list ()))
;          (let $newlist ( cons-atom $item $list ) (random (- $num 1) $newlist))
;          (random $num $list)
;    )
;))