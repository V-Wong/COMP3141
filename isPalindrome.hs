module Main where

isPalindrome1 :: Eq a => [a] -> Bool
isPalindrome1 l = l == reverse l

isPalindrome2 :: Eq a => [a] -> Bool
isPalindrome2 [] = True
isPalindrome2 [a] = True
isPalindrome2 xs | head xs /= last xs = False
                 | otherwise = isPalindrome2 (tail (init xs))

isPalindrome3 :: Eq a => [a] -> Bool
isPalindrome3 [] = True
isPalindrome3 [a] = True
isPalindrome3 xs = head xs == last xs && isPalindrome3 (tail (init xs))

main :: IO()
main = do
    print (isPalindrome1 [1, 2, 3])
    print (isPalindrome1 [3, 2, 3])
    print (isPalindrome1 [3, 3])
    print (isPalindrome1 [3])

    print (isPalindrome2 [1, 2, 3])
    print (isPalindrome2 [3, 2, 3])
    print (isPalindrome2 [3, 3])
    print (isPalindrome2 [3])

    print (isPalindrome3 [1, 2, 3])
    print (isPalindrome3 [3, 2, 3])
    print (isPalindrome3 [3, 3])
    print (isPalindrome3 [3])