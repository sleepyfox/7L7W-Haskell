module Main where
	-- take a range of integers e.g. [1..12] 
	-- and make a multiplication table from it
	mult_table :: [Integer] -> [(Integer, Integer, Integer)]
	mult_table nums = [(x, y, x * y) | x <- nums, y <- nums]