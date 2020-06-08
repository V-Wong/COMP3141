import Prelude hiding (zip)

zip :: (a -> b -> c) -> [a] -> [b] -> [c]
zip f [] _ = []
zip f _ [] = []
zip f (x:xs) (y:ys) = (x `f` y) : zip f xs ys