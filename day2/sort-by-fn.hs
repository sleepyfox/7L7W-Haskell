module Maine where
  bubbleGeneric:: (Ord a) => (a -> a -> Ordering) -> [a] -> [a]
  bubbleGeneric _ [] = []
  bubbleGeneric _ [x] = [x]
  bubbleGeneric fn (x:y:xs)
    | fn x y == GT = y:(bubbleGeneric fn (x:xs))
    | otherwise = x:(bubbleGeneric fn (y:xs))

  sortedList:: (Ord a) => (a -> a -> Ordering) -> [a] -> [a]
  sortedList fn x 
    | x == s = x 
    | otherwise = sortedList fn s
    where s = bubbleGeneric fn x 

  rev:: Ord a => a -> a -> Ordering
  rev a b 
    | a > b = LT 
    | a == b = EQ
    | otherwise = GT