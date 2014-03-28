module GCD where

import Data.List (intersect)

greatestCommonDenominator:: Integral a => a -> a -> a
greatestCommonDenominator a b = maximum (intersect (factors a) (factors b))

factors:: Integral t => t -> [t]
factors x = [y | y <- [1..x], rem x y == 0]