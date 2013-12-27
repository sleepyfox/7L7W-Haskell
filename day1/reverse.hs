module Main where
	rev :: String -> String
	rev [] = []
	rev x = reverse x

	rev2 :: String -> String
	rev2 [] = []
	rev2 (h:t) = (rev2 t) ++ [h] 