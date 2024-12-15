;;;;;;;;;;;;;;;;;;;;;;
;;; This Function Generates random n unique numbers from m numbers


! (bind! np-rnd (py-atom numpy.random))

;; check if the element is a member of a list
(= (isMember $elemnt $list)
    (not (== (collapse (intersection (superpose ($elemnt)) (superpose $list))) ()))
)
;;random number generator
(: random (-> Number Number list tuple))
(=($x) $x)
(=(random $num $range $list )(
  if(== $num 0)
    $list
    (let $item ((py-dot np-rnd randint) $range) (
      if(isMember $item $list)
        (random $num $list)
        ((let* (
               ($newlist (cons-atom $item $list))
               ($newNum (- $num 1))
               )
              (random $newNum $range $newlist)
       ))
    ))
  
))

;!(random 9 30 ())











