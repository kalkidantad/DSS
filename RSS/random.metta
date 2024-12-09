!(bind! np-rnd (py-atom random)) 
!((py-dot np-rnd sample) (py-tuple (1 2 3 5 6 7)) 2 )