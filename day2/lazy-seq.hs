module Main where
  by3s:: (Enum a, Num a) => a -> [a]
  by3s x = [x, x + 3..]

  by5s:: (Enum a, Num a) => a -> [a]
  by5s y = [y, y + 5..]

  by8s:: (Enum a, Num a) => a -> a -> [a]
  by8s x y = zipWith (+) (by3s x) (by5s y)