module Main where

elementAt1 :: Num a => [a] -> Int -> a
elementAt1 x k | k - 1 >= (length x) = error "k must be smaller than length of list"
               | otherwise = x !! (k - 1)

elementAt2 :: Num a => [a] -> Int -> a
elementAt2 [] k = error "k must be smaller than length of list"
elementAt2 x 1 = head x
elementAt2 (x:xs) k = elementAt2 xs (k - 1)

main :: IO()
main = do
    print (elementAt1 [5, 10, 15] 2)
    print (elementAt2 [5, 10, 15] 2)
    print (elementAt1 [5] 1)
    print (elementAt2 [5] 1)
    print (elementAt1 [] 1)
    print (elementAt2 [] 1)