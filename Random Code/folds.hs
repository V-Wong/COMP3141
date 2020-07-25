import Prelude hiding (foldl, foldr)

-- foldl f acc [a, b, c]
-- = foldl f (f acc a) [bc]
-- = foldl f (f (f acc a) b) [c]
-- = foldl f (f (f (f acc a) b) c) []
-- = f (f (f acc a) b) c
-- This will take elements at the head of the list until none are left.
foldl :: (a -> b -> a) -> a -> [b] -> a
foldl f acc [] = acc
foldl f acc (x:xs) = foldl f (f acc x) xs

-- foldr f base [a, b, c] =
-- = f a (foldr f base [b, c])
-- = f a (f b (foldr f base [c]))
-- = f a (f b (f c (foldr f base [])))
-- = f a (f b (f c base))
-- This will go to the end of the list and step backwards.
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f base [] = base
foldr f base (x:xs) = f x (foldr f base xs)
