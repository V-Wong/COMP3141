import Prelude hiding (filter)

filter1 :: (a -> Bool) -> [a] -> [a]
filter1 f [] = []
filter1 f (x:xs) = if f x then x : filter1 f xs else filter1 f xs

-- foldr takes elements right to left.
-- This is suitable as we progressively add elements to the start of the list.
filter2 :: (a -> Bool) -> [a] -> [a]
filter2 f = foldr step []
    where
        step next filtered
            | f next = next : filtered
            | otherwise = filtered

-- foldl takes elements left to right.
-- If we add elements like above, we end up with a reversed list.
-- We hence must do a a concatenation in O(n) time.
filter3 :: (a -> Bool) -> [a] -> [a]
filter3 f = foldl step []
    where
        step filtered next
            | f next = filtered ++ [next]
            | otherwise = filtered