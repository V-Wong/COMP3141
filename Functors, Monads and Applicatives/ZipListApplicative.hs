data ZipList a = Nil
               | Cons a (ZipList a)
               deriving Show

instance Functor ZipList where
  fmap f Nil = Nil
  fmap f (Cons x xs) = Cons (f x) (fmap f xs)

instance Applicative ZipList where
  -- Creates an infinite list.
  -- This is required to produce a value at every position.
  -- If pure 2 returned ZipList [2] then
    -- pure (*2) <*> ZipList [1,2,3] = ZipList [2]
  -- which doesn't behave like fmap.
  pure x = Cons x (pure x)

  -- Applies each function in the first list
  -- to each corresponding element in the second list.
  -- Stops after the shorter list is exhausted.
  -- An applicative bind between a finite ZipList and an infinite zipList is hence always finite.
  (Cons f fs) <*> (Cons x xs) = Cons (f x) (fs <*> xs)
  _ <*> _ = Nil

testPure :: ZipList Int
testPure = pure 5

fs = Cons (+1) (Cons (*2) (Cons (5-) (Cons (`div` 6) Nil)))
xs1 = Cons (1) (Cons (2) (Cons (3) (Cons (4) Nil)))

shortxs = Cons (1) (Cons (2) (Cons (3) Nil))
longxs = Cons (1) (Cons (2) (Cons (3) (Cons (4) (Cons 5 (Cons 6 Nil)))))

-- Note: We cannot in general write a Monad instance for ZipLists that satisfies the laws.
-- In particular: associativity usually breaks in most implementations.