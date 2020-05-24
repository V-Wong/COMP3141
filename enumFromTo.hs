module Main where
import Prelude hiding (enumFromTo)

enumFromTo :: Int -> Int -> [Int]
enumFromTo m n | m > n = error "First argument must be less than second argument"
               | m == n = [m]
               | otherwise = m : enumFromTo (m + 1) n

main :: IO()
main = do 
    print (enumFromTo 1 10)
    print (enumFromTo 10 5)