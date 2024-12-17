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
(=(evaluate $population $dataset)
  (case $population
     ((($program $index $fitness) (fitness $population (random_fit ())))
      ($population (collapse (fitness (superpose $population) (random_fit ()))))
     )
   )
)

!(evaluate (program 31 0.5014647685599923) (sf))