module Main where

removeOdd :: [Int] -> [Int]
removeOdd [] = []
removeOdd (x:xs) | not (odd x) = x : removeOdd xs
                 | otherwise = removeOdd xs

main :: IO()
main = do 
    print (removeOdd [])
    print (removeOdd [1, 2, 3])
    print (removeOdd [1, 2..100])