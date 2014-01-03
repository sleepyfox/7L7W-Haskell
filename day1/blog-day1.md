# Haskell
This blog entry is about the book "Seven Languages in Seven Weeks" by Bruce Tate, (available from Amazon [here:](http://www.amazon.co.uk/gp/product/193435659X/ref=as_li_qf_sp_asin_tl?ie=UTF8&camp=1634&creative=6738&creativeASIN=193435659X&linkCode=as2&tag=agileenvir-21))

Starting work on Haskell has been pretty nifty. The Glasgow Haskell compiler is packaged on the Ubuntu repos as 'haskell-platform' so installing it on 13.10 is as simple as: 

	$ sudo apt-get install haskell-package

More details about the [Haskell platform](http://www.haskell.org/platform/) and how to install it for various OSs can be found at the previous link.

The day 1 activities from the book are 'Find':

* The Haskell [wiki](http://www.amazon.co.uk/gp/product/193435659X/ref=as_li_qf_sp_asin_tl?ie=UTF8&camp=1634&creative=6738&creativeASIN=193435659X&linkCode=as2&tag=agileenvir-21)
* A Haskell online group supporting your compiler [(GHC)](http://www.haskell.org/haskellwiki/GHC)

and 'Do':

1. How many different ways can you find to write allEven?
2. Write a function that takes a list and returns the same list in reverse.
3. Write a function that builds two-tuples with all possible combinations of two of the colors black, white, blue, yellow, and red. Note that you should include only one of (black, blue) and (blue, black).
4. Write a list comprehension to build a childhood multiplication table. The table would be a list of three-tuples where the first two are integers from 1–12 and the third is the product of the first two.
5. Solve the map-colouring problem

For the first of these, find different ways to implement allEven, I started with three. I'm sure I could have found more with a greater knowledge of the language, but the book doesn't introduce you to much in the way of syntax in day one.

## One
First: a simple effort using tail recursion:

	allEven :: [Integer] -> [Integer]
	allEven [] = []
	allEven (h:t) = if even h then h:allEven t else allEven t
    
For the second version I decided to use a filter - I'd never have known about the filter function for lists unless I'd also been leafing through "Learn you a Haskell for great good" [(LYAHFGG)](http://learnyouahaskell.com/).

	allEven2 :: [Integer] -> [Integer]
	allEven2 x = filter even x

For the last version I used the list comprehensions that had formed the closing part of the day 1 text:

	allEven3 :: [Integer] -> [Integer]
	allEven3 list = [x | x <- list, even x]

I'm guessing at this stage that even though making an explicit type declaration for the function isn't necessary it is probably good practice.

## Two
The second task was to write a function that takes a list and returns the same list in reverse. This was trivially easy as I'd noticed the 'reverse' function for lists in [LYAHFGG](http://learnyouahaskell.com/) 

	rev :: String -> String
	rev [] = []
	rev x = reverse x

Stating the base case for the empty list isn't really necessary, as the reverse function built-in deals with this, I'm not sure at this stage whether it is considered a good practice or whether it is redundant, we'll see.

	rev2 :: String -> String
	rev2 [] = []
	rev2 (h:t) = (rev2 t) ++ [h] 

I took a second stab at reverse using the colon operator like so:

	rev2 :: String -> String
	rev2 [] = []
	rev2 (h:t) = (rev2 t) ++ [h] 

And for a last attempt I used 'plain' recursion using the init and last list functions:

	rev3 :: String -> String
	rev3 [] = []
	rev3 x = [last x] ++ rev3 (init x)

It seems that _String_ is just a shorthand for _[Char]_ - I'm sure that this will be covered in more detail when we get into the type system.

## Three
The third task was to write a function that builds all possible combinations of two given colours without including the duplicate of (A,B) namely (B,A)

	colours = ["black", "white", "blue", "yellow", "red"]
	--colour_combs :: -> [(String, String)]
	colour_combs = [(x,y) | x <- colours, y <- colours, x <= y ]

At this point I wasn't sure whether I need to include a 'main' that sets up the colours and calls colour_combs or whether I should define colour_combs as 

	:: [String] -> [(String, String)] 

instead of the 

	:: null -> [(String, String)] 

that I have here. Haskell doesn't like the null -> syntax so obviously there's another way of defining a function that takes no input and produces an output. [EDIT] obvious really, by removing the arrow we specify a 0ary function, like so:

	colour_combs :: [(String, String)]

## Four
The fourth task was to build a multiplication table using list comprehension. This seemed pretty straightforward:

	mult_table :: [Integer] -> [(Integer, Integer, Integer)]
	mult_table nums = [(x, y, x * y) | x <- nums, y <- nums]

It would be nice to format the output a little more nicely, but we haven't covered anything about I/O yet...

## Five
The fifth problem was a repeat of the map colouring problem from the Prolog chapter, this seemed to be an interesting problem because this problem was given as one of the examples of how using Prolog for certain kinds of problem could dramatically simplify the task of creating a solution. 

For this I knew that the core of the solution would be a list comprehension with the constraints of which states border each other (and therefore cannot have the same colour) as guards. I chose to implement the function as one that outputs a list of tuples (state_name, colour) like so:

	states = ["Tennessee", "Mississippi", "Alabama", "Georgia", "Florida"]
	colours = ["Red", "Green", "Blue"]
	map_colours = [[("Tennessee", t),("Mississippi", m), ("Alabama",a),
		("Georgia", g), ("Florida", f)] | 
		m <- colours, t <- colours, a <- colours, g <- colours, f <- colours,
		m /= t, m /= a, t /= a, t /= g, a /= g, a /= f, g /= f]
	 
I've implemented the states and colours as value lists rather than as inputs to the function, and I presume that bundling them within the scope of the module is the idiomatic way of encapsulation with Haskell, rather than hiding them using closures or another mechanism. Again pretty-printing the output would have improved things, but this will have to wait. Looking at other's solutions a common thread seems to be to output a 5-tuple with the order of entries corresponding to states, I didn't like this as the output requires implicit knowledge to interpret, and an approach that approached the hash solution that I would use in other languages like Ruby or CoffeeScript seemed more readable.

Now: looking forward to day 2 :-)


