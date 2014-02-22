module Main where
	import Test.HUnit

	colours = ["black", "white", "blue", "yellow", "red"]
	colour_combs :: [(String, String)] 
	colour_combs = [(x,y) | x <- colours, y <- colours, x <= y ]

	results = colour_combs 

	tests = TestList [ 
		TestCase (assertEqual "results should contain (black, black)" 
			True (elem ("black","black") results) ),
		TestCase (assertEqual "results should contain (black, blue)" 
			True (elem ("black","blue") results) ),
		TestCase (assertEqual "results should NOT contain (blue, black)" 
			False (elem ("blue","black") results) ),		
		TestCase (assertEqual "results should contain 15 tuples"
			15 (length results) ) ]

	main = do runTestTT tests
