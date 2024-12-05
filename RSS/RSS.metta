! (register-module! ../RSS)
!(import! &self RSS:data)
! (bind! &data (new-space))

;; add-atom test case
!(manuplate-space add-atom &data (collapse (match &self (data_point $x) (data_point $x a))))
!(collapse (match &data (data_point $x a) (data_point $x a)))





















;; Select instances from B with a uniform probability S/T to create a subset S(0)

;for generation g
;;evaluate test fitness 
;;Evolve mutation crossover
;;generate subset of length n