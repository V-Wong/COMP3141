{-
instance Functor ((,) x) where
  -- fmap applies the function to the second element 
  -- and leaves the first element alone.

  fmap :: (a -> b) -> (x, a) -> (x, b)
  fmap f (x, a) = (x, f a)

instance Monoid x => Applicative ((,) x) where
  -- We need the first element to be of monoid class
  -- to combine the values and provide an identity value for pure.

  pure :: a -> (x, a)
  pure a = (mempty, a)

  -- Applicative bind applies the function to the second element
  -- and mappends (<>) the first elements.

  (<*>) :: (x, a -> b) -> (x, a) -> (x, b)
  (<*>) (x, f) (x', a) = (x <> x', f a)
-}

main = do
  -- The following three are equivalent.
  -- We want the first element to be of monoid class
  -- so that the first line makes sense and equivalent to the rest.
  -- The identity element here is the empty string
  -- and mappend is (++).

  print $ pure (+8) <*> ("hello", 9)
  print $ (mempty, (+8)) <*> ("hello", 9)
  print $ ("", (+8)) <*> ("hello", 9)

  -- The following three are equivalent.
  -- Identity is [] and mappend is (++).
  print $ pure (+8) <*> ([1, 2, 3], 9)
  print $ (mempty, (+8)) <*> ([1, 2, 3], 9)
  print $ ([], (+8)) <*> ([1, 2, 3], 9)
