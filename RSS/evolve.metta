;;;;;;;;;;;;;;;;;;;;;;;;
;; evaluate the populations using selected data
;; params
;;       population or programs
;;       subset
(=(isFit ($program $index $fitness))(
   if ( >= $fitness 0.50) 
       ($program $index $fitness)
       (empty)
))
(= (filter $predicate $list)
   (collapse ($predicate (superpose $list)))
)
;(: evolve (-> list list fitness))
(=(evolve $population)
  (filter isFit $population)
)