module Main where

	import Test.HUnit

	test1 = TestCase (assertEqual "This test fails" 1 3)
	test2 = TestCase (assertEqual "This test succeeds" 1 1)

	tests = TestList [ TestLabel "test-1" test1, 
					   TestLabel "test-2" test2 ]

	main = do runTestTT tests
