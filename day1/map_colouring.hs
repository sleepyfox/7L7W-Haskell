module Main where
	states = ["Tennessee", "Mississippi", "Alabama", "Georgia", "Florida"]
	colours = ["Red", "Green", "Blue"]
	map_colours = [[("Tennessee",t),("Mississippi", m), ("Alabama",a),
		("Georgia", g), ("Florida", f)] | 
		m <- colours, t <- colours, a <- colours, g <- colours, f <- colours,
		m /= t, m /= a, t /= a, t /= g, a /= g, a /= f, g /= f]
	 