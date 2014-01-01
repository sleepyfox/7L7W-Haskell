module Main where
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