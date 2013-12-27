module Main where
	-- using tail recursion
	allEven :: [Integer] -> [Integer]
	allEven [] = []
	allEven (h:t) = if even h then h:allEven t else allEven t

	-- using filter
	allEven2 :: [Integer] -> [Integer]
	allEven2 x = filter even x

	-- using list comprehension
	allEven3 :: [Integer] -> [Integer]
	allEven3 list = [x | x <- list, even x]

