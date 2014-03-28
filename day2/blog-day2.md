# Haskell
This blog entry is about the book "Seven Languages in Seven Weeks" by Bruce Tate, (available from Amazon [here:](http://www.amazon.co.uk/gp/product/193435659X/))

Day 2 of Haskell has had some interesting things, and I'm feeling more at home with the Haskell way of doing things and working with the type system, which has been interesting as I've spent so long with dynamically typed languages. 
Partial application of all functions is an interesting twist, but one that makes perfect sense and I now find myself wanting to do in JavaScript, which is easy enough but not quite so elegant. 
Anonymous function definition e.g. 

	(\x y -> x * y) 

is familiar, but I still prefer CoffeeScript's 

	(x y) -> x * y 

it just seems neater. Function composition with the dot operator is nice, I can see myself using more of this but it isn't quite 'natural' yet in the way that cons (:) is. 

# Exercises: Find
## Functions that you can use on lists, strings, or tuples 

* Lists: Prelude.hs (the standard Haskell library) includes a number of list processing functions, the University of New South Wales has a nice overview page [here](http://www.cse.unsw.edu.au/~en1000/haskell/inbuilt.html)
* Strings: strings in Haskell are just lists of chars, so just use the string functions above
* Tuples: the link above also contains some basic functions for manipulating tuples

## A way to sort lists
Use Data.List.sortBy e.g.

	> import Data.List (sortBy)
	> sortBy compare [3,1,2]
	[1,2,3]
	> sortBy compare ["c", "a", "b"]
	["a","b","c"] 

# Exercises: Do
## Write a sort that takes a list and returns a sorted list

This is fairly easy using recursion and a classic bubble sort, the sorting is done when the list is the same before and after a pass of the bubbling.

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

Note that this will work for lists of strings, as they are in the Ordinal type class. 

	> sortedList [2,3,1]
	> [1,2,3]

A neat trick here is where we compare the list to the bubble'd list, we can just use the ordinary equality (==) operator here as it also compares lists!

## Write a sort that takes a list and a function that compares its two arguments and then returns a sorted list

This is a more generic version of the above, but injecting a comparator.

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

I couldn't find a type notation for "a function x defined elsewhere", instead it seems you have to embed that function's type signature itself in parentheses e.g. (a -> a -> Ordering) for a function that takes two things and returns GT, EQ or LT.

You can use the sort just like the previous example by using the compare function from the standard library:

	> sortedList compare [3,1,2]
	> [1,2,3]

Or you can use your own function that compares two items. I've provided an example function that does the reverse of compare, called rev:

	> sortedList rev [3,1,0,2]
	> [3,2,1,0]
	> sortedList rev ["Fred", "Alex", "George"]
	> ["George","Fred","Alex"]

## Write a Haskell function to convert a string to a number. The string should be in the form of $2,345,678.99 and can possibly have leading zeros.

This is reasonably simple, first filter out anything that isn't a numeral or a decimal point and then use the reader to convert the string to a float. There doesn't appear to be a built-in type for decimals like Java's BigDecimal

	module Main where
	removeComma:: String -> String
	removeComma s = filter (`elem` '.':['0'..'9']) s 

	convertToNum:: String -> Float
	convertToNum [] = 0.0
	convertToNum s = read (removeComma s)::Float

An example with leading and trailing zeroes:
	
	> convertToNum "$01234.020"
	> 1234.02

I really wanted to use a Regexp for this, but had to use a char filter instead. This may be a good thing, as once you try and solve a problem with a Regexp, now you have two problems :-)

## Write a function that takes an argument x and returns a lazy sequence that has every third number, starting with x
"Then, write a function that includes every fifth number, beginning with y. Combine these functions through composition to return every eighth number, beginning with x + y"

Simples! 

	module Main where
	by3s:: (Enum a, Num a) => a -> [a]
	by3s x = [x, x + 3..]

	by5s:: (Enum a, Num a) => a -> [a]
	by5s y = [y, y + 5..]

This gives us the following output:

	> take 5 (by3s 1)
	> [1,4,7,10,13]
	> take 5 (by5s 1)
	> [1,6,11,16,21]

But how to get every eighth number? What would the result look like? 

	> [1,9,17,25,33]

Hmmm. This stumped me for a while until I realised that if you added 1 to this sequence you get 

	> [2,10,18,26,34]

We can get this if we output the sum of the previous two sequences, which we can do with the zipWith function introduced at the top of page 290:

	  by8s:: (Enum a, Num a) => a -> a -> [a]
	  by8s x y = zipWith (+) (by3s x) (by5s y)	

	> take 5 (by8s 1 1)
	> [2,10,18,26,34] 

I was initially flummoxed because I saw the words "Combine these functions through composition" and I assumed that they meant the composition operator (.), and I couldn't see any way of taking the output from one function as the input for the other, as both functions take a single argument and return a list. Hmmm... poor manuscript editing I guess.

## Use a partially applied function to define a function that will return half of a number and another that will append \n to the end of any string

This really looks to be stupidly simple, am I missing something?

	module Madras where
	half = (/2)
	eol = (++"\n")

There were some extra bonus problems at the end:

## Write a function to determine the greatest common denominator of two integers

There's actually a function in Prelude called 'gcd' that does exactly what we need, but let's assume that's cheating :-)

This problem can be expressed as: for two integers _a_ and _b_

* A is a subset of N (natural numbers) where x in A such that x < a and a % x is 0
* B is a subset of N where y in B such that y < b and b % y is 0
* The solution is the largest member of the intersection of sets A and B

We can write this like so:

	module GCD where
	import Data.List (intersect)

	greatestCommonDenominator:: Integral a => a -> a -> a
	greatestCommonDenominator a b = maximum (intersect (factors a) (factors b))

	factors:: Integral t => t -> [t]
	factors x = [y | y <- [1..x], rem x y == 0]

This proved to be quite a bit easier than I thought

## Create a lazy sequence of prime numbers

We can create a naive Turner sieve like so:

	module Prime where
	  primes:: [Int]
	  primes = sieve [2..]
	    where
	      sieve (p:xs) = p : sieve [x | x <- xs, rem x p /= 0]

This is very poorly performing, not even having a 'from squares' optimisation, but shows the form.

## Break a long string into individual lines at proper word boundaries

I'm presuming here that what is required is a function that will take a long string and a margin column (say 80 chars) and will break the line at the first word boundary <= margin recursively returning an array of Strings.

My approach to this is to write a recursive function that takes a string and keep adding words to the end of an initially empty string until it is over the margin, then to push that string onto a stack.


## Add line numbers to the previous exercise

As before but returning an array of tuples, each being a line number and a String. 

## To the above exercise, add functions to left, right, and fully justify the text with spaces (making both margins straight)


