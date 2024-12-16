;;;;;;;;;;;;;;;;;;;;;;;;
;; evaluate the populations using selected data
;; params
;;       population or programs
;;       subset
;; output 
;;       (program 44 0.919729009143922)
! (bind! rnd (py-atom random))
(=(random_fit ())(
   (py-dot rnd random)
))
(=(fitness ($program $index $fitness) $newFitness)(
   ($program $index $newFitness)
))
;(: evaluate (-> list list fitness))
(=(evaluate $pupulation $dataset)
  (collapse (fitness (superpose $pupulation) (random_fit ())))
)