module Main where
	colours = ["black", "white", "blue", "yellow", "red"]
	--colour_combs :: -> [(String, String)]
	colour_combs = [(x,y) | x <- colours, y <- colours, x <= y ]
