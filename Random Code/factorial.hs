module Main where

fact :: Int -> Int
fact n | n < 0 = error "Factorial function only accepts positive integers"
       | n == 0 = 1
       | otherwise = n * fact (n - 1)

main :: IO()
main = do 
    print (fact 5)
    print (fact 0)
    print (fact (-1))