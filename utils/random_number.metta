;;;;;;;;;;;;;;;;;;;;;;
;;; This Function Generates random n unique numbers from m numbers


! (bind! np-rnd (py-atom numpy.random))

;; check if the element is a member of a list
;(= (isMember $x $list)
;    (not (== (collapse (intersection (superpose ($x)) (superpose $list))) ()))
;)

(= (isMember $x $tuple)
    (if (== $tuple ()) False
        (let*
            (
                ($head (car-atom $tuple))
                ($tail (cdr-atom $tuple))
            )
        (
            if (== $x $head) True (isMember $x $tail)
        )
)
)
)
;;random number generator
(: random (-> Number Number list tuple))
(=($x) $x)
(=(random $num $range $list )(
  if(== $num 0)
    $list
    (let $item ((py-dot np-rnd randint) $range) (
      if(isMember $item $list)
        (random $num $range $list)
        ((let* (
               ($newlist (cons-atom $item $list))
               ($newNum (- $num 1))
               )
              (random $newNum $range $newlist)
       ))
    ))
  
))

;!(random 7 30 ())
;; issue  metta-run does not support py-atom
;;        metta does not support intersection fonction










