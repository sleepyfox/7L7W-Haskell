module Main where

	import Test.HUnit

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

	testAllEven = TestList [ 
		TestCase (assertEqual "1 should not be even" 
			[] (allEven [1])),
		TestCase (assertEqual "empty list is even" 
		   	[] (allEven [])),
		TestCase (assertEqual "Out of [1,2] only 2 should be even" 
			[2] (allEven [1,2])),
		TestCase (assertEqual "[1..7] yields [2,4,6]" 
		   	[2,4,6] (allEven [1..7])),
		TestCase (assertEqual "[7..1] yields [6,4,2]"
		  	[6,4,2] (allEven [7,6..1])) ]

	testAllEven2 = TestList [ 
		TestCase (assertEqual "1 should not be even" 
			[] (allEven2 [1])),
		TestCase (assertEqual "empty list is even" 
		   	[] (allEven2 [])),
		TestCase (assertEqual "Out of [1,2] only 2 should be even" 
			[2] (allEven2 [1,2])),
		TestCase (assertEqual "[1..7] yields [2,4,6]" 
		   	[2,4,6] (allEven2 [1..7])),
		TestCase (assertEqual "[7..1] yields [6,4,2]"
		  	[6,4,2] (allEven2 [7,6..1])) ]

	testAllEven3 = TestList [ 
		TestCase (assertEqual "1 should not be even" 
			[] (allEven3 [1])),
		TestCase (assertEqual "empty list is even" 
		   	[] (allEven3 [])),
		TestCase (assertEqual "Out of [1,2] only 2 should be even" 
			[2] (allEven3 [1,2])),
		TestCase (assertEqual "[1..7] yields [2,4,6]" 
		   	[2,4,6] (allEven3 [1..7])),
		TestCase (assertEqual "[7..1] yields [6,4,2]"
		  	[6,4,2] (allEven3 [7,6..1])) ]

	tests = TestList [ TestLabel "allEven tests" testAllEven, 
					   TestLabel "allEven2 tests" testAllEven2, 
					   TestLabel "allEven3 tests" testAllEven3 ]
	
	main = do runTestTT tests
