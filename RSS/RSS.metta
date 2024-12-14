!(register-module! ../RSS)
!(import! &self RSS:data)
;!(import! &self RSS:program)
!(bind! &data (new-space))
;!(bind! &program (new-space))
! (bind! np-rnd (py-atom numpy.random))


;; add Data to space
!(manuplate-space add-atom &data (collapse (match &self (data_point $x) (data_point $x))))

;; add programs to space
;!(manuplate-space add-atom &program (collapse (match &self (program $x) (program $x))))

;!(collapse (match &data (data_point $x) (data_point $x a)))
;!(collapse (match &program (program $x) (program $x a)))
;!(get-atoms &data)


;! ((py-dot np-rnd choice) (Kwargs (dataset)))






















;; Select instances from B with a uniform probability S/T to create a subset S(0)

;for generation g
;;evaluate test fitness 
;;Evolve mutation crossover
;;generate subset of length n