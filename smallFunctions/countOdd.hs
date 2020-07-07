module Main where

countOdd1 :: [Int] -> Int
countOdd1 [] = 0
countOdd1 (x:xs) = if odd x then 1 + countOdd1 xs else countOdd1 xs

countOdd2 :: [Int] -> Int
countOdd2 [] = 0
countOdd2 (x:xs) | odd x = 1 + countOdd2 xs
                 | otherwise = countOdd2 xs

main :: IO()
main = do 
    print (countOdd1 [1, 2, 3])
    print (countOdd1 [1, 2..100])
    print (countOdd2 [1, 2, 3])
    print (countOdd2 [1, 2..100])