module Main where
	-- take a range of integers e.g. [1..12] 
	-- and make a multiplication table from it
	import Test.HUnit

	mult_table :: [Integer] -> [(Integer, Integer, Integer)]
	mult_table nums = [(x, y, x * y) | x <- nums, y <- nums]

	tests = TestList [ 
		TestCase (assertEqual "a mult_table of the empty list should be empty" 
			[] (mult_table [])),
		TestCase (assertEqual "a mult_table of just the number 1 should be [(1,1,1)]"
			[(1,1,1)] (mult_table [1])),
		TestCase (assertEqual "a mult_table of [1..3] should have 9 elements"
			9 (length (mult_table [1,2,3]))),
		TestCase (assertEqual "a mult_table of [1..3] should include (3,3,9)"
			True (elem (3,3,9) (mult_table [1,2,3]))) ]

	main = do runTestTT tests
