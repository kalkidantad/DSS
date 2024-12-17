;;;;;;;;;;;;;;;;;;;;;;;;
;; evaluate the populations using selected data
;; params
;;       population or programs
;;       subset
;; output 
;;       (program 44 0.919729009143922)
!(bind! rnd (py-atom random))
(=(random_fit ())(
   (py-dot rnd random)
))
(=(fitness ($program $index $fitness) $newFitness)(
   $program $index $newFitness
))
;(: evaluate (-> list list fitness))
(=(evaluate $population $dataset)
  (case $population
     (((program $index $fitness) (fitness $population (random_fit ())))
      ($population (collapse (fitness (superpose $population) (random_fit ()))))
     )
   )
)

;!(evaluate ( (program 11 0) (program 12 0) (program 15 0) (program 3 0) (program 2 0) (program 9 0) (program 10 0) (program 16 0) (program 1 0) (program 8 0) (program 5 0) (program 14 0) (program 4 0) (program 6 0) (program 18 0) (program 0 0)) ((data_point 8) (data_point 13) (data_point 21) (data_point 11)))