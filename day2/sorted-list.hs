module Main where
  bubble:: (Ord a) => [a] -> [a]
  bubble [] = []
  bubble [x] = [x]
  bubble (x:y:xs)
    | x > y = y:(bubble (x:xs))
    | otherwise = x:(bubble (y:xs))

  sortedList:: (Ord a) => [a] -> [a]
  sortedList x 
    | x == s = x 
    | otherwise = sortedList s
    where s = bubble x 