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
   (
      case $list
      (
         (($program $index $fitness) $list)
         ($list (collapse ($predicate (superpose $list))))
      )
   )
   
)
;(: evolve (-> list list fitness))
(=(evolve $population)
(let $program (filter isFit $population)
  (if (== $program ())
       $population
       $program
   )
)
  
)
;!(evolve ((program 31 0.014647685599923)(program 31 0.014647685599923)))