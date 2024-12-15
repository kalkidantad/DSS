!(register-module! ../../addaptive_sampling)
!(import! &self addaptive_sampling:RSS:data)
!(import! &self addaptive_sampling:RSS:program)
!(import! &self addaptive_sampling:utils:manuplate-space)
!(import! &self addaptive_sampling:utils:random_number)
;;!(import! &self addaptive_sampling:RSS:random_dataset)
!(import! &self addaptive_sampling:RSS:evaluate)
!(import! &self addaptive_sampling:RSS:evolve)

!(bind! &data (new-space))
!(bind! &program (new-space))

;; bind data and programs to space
;; add Data to space
!(manuplate-space add-atom &data (collapse (match &self (data_point $index) (data_point $index $index))))
!(manuplate-space add-atom &program (collapse (match &self (program $index) (program $index $index 0))))

;;select instance subset of subset_size
(= (selectSubset $subset_size $data_size)(
   (let $randomIndex (random $subset_size $data_size ()) 
        ((superpose (match)) (superpose (&data)) ($x (superpose $randomIndex) $y)  ( $x $y) )
   )
))

(=(generation $n $dataset)(
     ;Generate a random subset S(g) from dataset B
     ($dataset)
))

!(generation 5 (selectSubset 2 25))
