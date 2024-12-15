!(register-module! ../../addaptive_sampling)
!(import! &self addaptive_sampling:RSS:data)
!(import! &self addaptive_sampling:RSS:program)
!(import! &self addaptive_sampling:RSS:random_subset)
!(import! &self addaptive_sampling:RSS:evaluate)
!(import! &self addaptive_sampling:RSS:evolve)

(=(generation $n)(
     ;Generate a random subset S(g) from dataset B
     ()
))