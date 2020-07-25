-- Combinatorial list monad.
-- The standard definition in Haskell.

-- Functor methods

-- Standard list map.
fmap' f [] = []
fmap' f (x : xs) = f x $ fmap' f xs

-- Applicative methods

-- Wrap up element in a single element list.
pure' x = [x]

-- [(*2), (+1)] <*>! [1, 2, 3, 4, 5] = [2, 4, 6, 8, 10] ++ [2, 3, 4, 5, 6]
(<*>!) [] _ = []
(<*>!) (f : fs) args = map f args ++ fs <*>! args

-- Monad methods

-- [1, 2, 3] >>=! (\x -> [x + 1, x - 1]) >>=! (\x -> [x * 2]) = [4,0,6,2,8,4]
(>>=!) :: [a] -> (a -> [b]) -> [b]
(>>=!) as f = concatMap f as
-- or (>>=!) = flip concatMap

-- concatMap takes a function that produces a list from the elements of a list,
-- and concatenates each of the produced lists in order.

main = do
  print ([(*2), (+1)] <*>! [1, 2, 3, 4, 5])
  print ([1, 2, 3] >>=! (\x -> [x + 1, x - 1]) >>=! (\x -> [x * 2]))
