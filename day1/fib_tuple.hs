-- Using tuples

module Main where
	fibTuple :: (Integer, Integer, Integer) -> (Integer, Integer, Integer)
	fibTuple (x, y, 0) = (x, y, 0)
	fibTuple (x, y, i) = fibTuple (y, x + y, i - 1)

	fibResult :: (Integer, Integer, Integer) -> Integer
	fibResult (x, y, z) = x

	fib :: Integer -> Integer
	fib x = fibResult (fibTuple (0, 1, x))

	