module Main where
  removeComma:: String -> String
  removeComma s = filter (`elem` '.':['0'..'9']) s 

  convertToNum:: String -> Float
  convertToNum [] = 0.0
  convertToNum s = read (removeComma s)::Float