-- Haskell example to test editor settings

-- Importing modules
import Data.List (sort, nub)
import Data.Maybe (fromMaybe)

-- Type declarations
type Name = String
type Age = Int

-- Data types with constructors
data Person = Person Name Age deriving (Show, Eq)

-- Enum (algebraic data types with multiple constructors)
data Color = Red | Green | Blue deriving (Show, Enum, Eq)

-- Recursive data type
data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show)

-- Record syntax
data Car = Car {
    model :: String,
    year  :: Int,
    price :: Float
} deriving (Show)

-- Pattern matching in function definitions
greet :: Person -> String
greet (Person name age) = "Hello, " ++ name ++ "! You are " ++ show age ++ " years old."

-- Pattern matching with multiple clauses
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- Using guards for conditional expressions
bmi :: Float -> Float -> String
bmi weight height
    | bmiValue < 18.5 = "Underweight"
    | bmiValue < 25.0 = "Normal weight"
    | bmiValue < 30.0 = "Overweight"
    | otherwise       = "Obese"
  where bmiValue = weight / height ^ 2

-- Case expressions
describeColor :: Color -> String
describeColor color = case color of
    Red   -> "The color is Red."
    Green -> "The color is Green."
    Blue  -> "The color is Blue."

-- Let expressions
squareSum :: Int -> Int -> Int
squareSum x y =
    let square a = a * a
    in square x + square y

-- List comprehensions
listComprehension :: [Int] -> [Int]
listComprehension xs = [x * 2 | x <- xs, x `mod` 2 == 0]

-- Higher-order functions: map, filter, foldr
higherOrderFunctions :: [Int] -> Int
higherOrderFunctions xs = foldr (+) 0 (filter even (map (* 2) xs))

-- Lambda functions
lambdaExample :: [Int] -> [Int]
lambdaExample = map (\x -> x * 2)

-- Maybe and fromMaybe
safeDivide :: Float -> Float -> Maybe Float
safeDivide _ 0 = Nothing
safeDivide x y = Just (x / y)

safeDivideResult :: Float -> Float -> Float
safeDivideResult x y = fromMaybe (-1) (safeDivide x y)

-- Monads: Using Maybe in do notation
safeRoot :: Float -> Maybe Float
safeRoot x
    | x < 0     = Nothing
    | otherwise = Just (sqrt x)

safeOperations :: Float -> Float -> Maybe Float
safeOperations x y = do
    r1 <- safeRoot x
    r2 <- safeDivide r1 y
    return r2

-- Working with lists
listOperations :: [Int] -> IO ()
listOperations xs = do
    putStrLn $ "Original list: " ++ show xs
    putStrLn $ "Sorted list: " ++ show (sort xs)
    putStrLn $ "Unique elements: " ++ show (nub xs)

-- Recursive function to calculate the sum of a list
sumList :: [Int] -> Int
sumList []     = 0
sumList (x:xs) = x + sumList xs

-- Tail recursion example
tailRecursiveSum :: [Int] -> Int
tailRecursiveSum = go 0
  where
    go acc []     = acc
    go acc (x:xs) = go (acc + x) xs

-- Infinite lists and take
infiniteListExample :: [Int]
infiniteListExample = take 10 [1..]

-- Working with custom data types (Tree example)
treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x Empty = Node x Empty Empty
treeInsert x (Node a left right)
    | x == a    = Node a left right
    | x < a     = Node a (treeInsert x left) right
    | x > a     = Node a left (treeInsert x right)

-- Searching a tree
treeSearch :: (Ord a) => a -> Tree a -> Bool
treeSearch _ Empty = False
treeSearch x (Node a left right)
    | x == a    = True
    | x < a     = treeSearch x left
    | x > a     = treeSearch x right

-- Main function
main :: IO ()
main = do
    -- Variable declarations
    let name = "Alice"
        age = 25
        person = Person name age

    -- Show a greeting message
    putStrLn (greet person)

    -- Calculate factorial
    let fact = factorial 5
    putStrLn $ "Factorial of 5: " ++ show fact

    -- Calculate BMI
    let weight = 68.0
        height = 1.75
    putStrLn $ "BMI status: " ++ bmi weight height

    -- Describe colors using case
    putStrLn (describeColor Red)

    -- Using let and list comprehensions
    putStrLn $ "Square sum of 3 and 4: " ++ show (squareSum 3 4)
    putStrLn $ "Doubled even numbers from [1..10]: " ++ show (listComprehension [1..10])

    -- Higher-order functions
    let xs = [1, 2, 3, 4, 5, 6]
    putStrLn $ "Sum of doubled even numbers: " ++ show (higherOrderFunctions xs)

    -- Using lambdas
    putStrLn $ "Doubled numbers using lambda: " ++ show (lambdaExample [1, 2, 3, 4])

    -- Safe division with Maybe and fromMaybe
    putStrLn $ "Safe divide result (10 / 0): " ++ show (safeDivideResult 10 0)

    -- Using monads with Maybe
    case safeOperations 25 5 of
        Nothing -> putStrLn "Safe operations failed."
        Just res -> putStrLn $ "Safe operations result: " ++ show res

    -- Working with lists
    listOperations xs

    -- Recursive sum of a list
    putStrLn $ "Recursive sum of [1..10]: " ++ show (sumList [1..10])

    -- Tail-recursive sum
    putStrLn $ "Tail-recursive sum of [1..10]: " ++ show (tailRecursiveSum [1..10])

    -- Infinite list example
    putStrLn $ "First 10 elements of an infinite list: " ++ show infiniteListExample

    -- Working with binary tree
    let tree = foldr treeInsert Empty [5, 3, 8, 2, 4, 7, 9]
    putStrLn $ "Is 4 in the tree? " ++ show (treeSearch 4 tree)
    putStrLn $ "Is 10 in the tree? " ++ show (treeSearch 10 tree)
