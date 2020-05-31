module Main where
import Prelude hiding (reverse)

-- [1, 2, 3]
-- -> 3 : reverse [1, 2]
-- -> 3 : (2 : reverse [1])
-- -> 3 : (2 : (1 : []))
-- -> [3, 2, 1]
reverse1 :: [a] -> [a]
reverse1 [] = []
reverse1 l = (last l) : (reverse1 (init l))

-- [1, 2, 3]
-- -> reverse [2, 3] ++ [1]
-- -> (reverse [3] ++ [2]) ++ [1]
-- -> (([] ++ [3]) ++ [2]) ++ [1]
-- -> [3, 2, 1]
reverse2 :: [a] -> [a]
reverse2 [] = []
reverse2 (x:xs) = reverse2 xs ++ [x]

-- [1, 2, 3]
-- -> flip(1, flip(2, flip(3, [])))
-- -> flip(1, flip(2, [3]))
-- -> flip(1, [3, 2])
-- -> [3, 2, 1]
reverse3 :: [a] -> [a]
reverse3 = foldl (flip (:)) []

main :: IO()
main = do
    print (reverse1 [1, 2, 3])
    print (reverse2 [1, 2, 3])
    print (reverse3 [1, 2, 3])