module Main where
import Prelude hiding (length)

length :: [a] -> Int
length [] = 0
length (_:xs) = 1 + length xs

main :: IO()
main = do 
    print (length [1, 2, 3])
    print (length [])