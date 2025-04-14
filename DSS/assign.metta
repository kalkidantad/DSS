;; Assign difficulty = 0, age = 0, weight = 1, uniform probability
; (= (assign-initial-values ($dataset $index $D $A $w $p))
;     (data_point $index 0 0 1 (/ $subset_size $total_data_size))  ;; Uniform probability initially
; )

; (= (Map ($dataset) data_point $index $D $A $W $INITIAL)
;    (data_point $index 0 0 1 (/ $subset_size $total_data_size))

; )