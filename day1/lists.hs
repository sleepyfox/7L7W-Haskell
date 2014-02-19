module Main where
	size :: Num a => [t] -> a
	size [] = 0
	size (h:t) = 1 + size t

	prod :: Num a => [a] -> a
	prod [] = 1
	prod (h:t) = h * prod t