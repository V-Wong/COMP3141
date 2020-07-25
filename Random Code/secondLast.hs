module Main where

-- Using direct indexing
secondLast1 :: [a] -> a
secondLast1 x | length x < 2 = error "List must contain > 2 items"
              | otherwise = x !! ((length x) - 2)

-- Recursive approach using pattern matching
secondLast2 :: [a] -> a
secondLast2 [] = error "List must contain > 2 items"
secondLast2 [x] = error "List must contain > 2 items"
secondLast2 [x, y] = x
secondLast2 (x:xs) = secondLast2 xs

-- Recursive approach using tail
secondLast3 :: [a] -> a
secondLast3 [] = error "List must contain > 2 items"
secondLast3 [x] = error "List must contain > 2 items"
secondLast3 [x, y] = x
secondLast3 list = secondLast3 (tail list)

main :: IO()
main = do 
    print (secondLast1 [1, 2])
    print (secondLast1 [1, 2, 3, 4])
    print (secondLast2 [1, 2])
    print (secondLast2 [1, 2, 3, 4])
    print (secondLast3 [1, 2])
    print (secondLast3 [1, 2, 3, 4])
    print (secondLast3 [1])