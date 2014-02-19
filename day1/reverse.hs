module Main where
	import Test.HUnit

	--using reverse built-in
	rev :: String -> String
	rev [] = []
	rev x = reverse x

	--using the : operator and recursion
	rev2 :: String -> String
	rev2 [] = []
	rev2 (h:t) = (rev2 t) ++ [h] 

	--using plain recursion
	rev3 :: String -> String
	rev3 [] = []
	rev3 x = [last x] ++ rev3 (init x)

	test_rev = TestList [ 
		TestCase (assertEqual "The empty string reversed should be itself" 
			"" (rev "")),
		TestCase (assertEqual "A reversed should be itself"
			"A" (rev "A")),
		TestCase (assertEqual "Fred reversed should be derF"
			"derF" (rev "Fred")) ]
		
	test_rev2 = TestList [
		TestCase (assertEqual "The empty string reversed should be itself" 
			"" (rev2 "")),
		TestCase (assertEqual "A reversed should be itself"
			"A" (rev2 "A")),
		TestCase (assertEqual "Fred reversed should be derF"
			"derF" (rev2 "Fred")) ]

	test_rev3 = TestList [
		TestCase (assertEqual "The empty string reversed should be itself" 
			"" (rev3 "")),
		TestCase (assertEqual "A reversed should be itself"
			"A" (rev3 "A")),
		TestCase (assertEqual "Fred reversed should be derF"
			"derF" (rev3 "Fred")) ]

	tests = TestList [ TestLabel "rev tests" test_rev, 
					   TestLabel "rev2 tests" test_rev2, 
					   TestLabel "rev3 tests" test_rev3 ]
	main = do runTestTT tests
