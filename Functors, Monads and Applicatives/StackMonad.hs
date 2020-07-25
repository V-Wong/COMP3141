-- A State Monad approach to implementing a Stack.

newtype Stack a = S ([Int] -> Maybe ([Int], a))

instance Functor Stack where
  -- fmap applies the value to the result value.
  -- The stack array is unchanged.
  fmap f (S sa) = S $ \s ->
      case sa s of 
        Nothing      -> Nothing
        Just (s', a) -> Just (s', f a)

instance Applicative Stack where
  -- pure sets the result value to x.
  -- The stack array starts empty.
  pure x = S (\s -> Just (s, x))

  -- Applicative bind returns a function that:
    -- Applies sf to s to get s' and f.
    -- Then applies sx to s' to get s'' and then apply f to x to get (s'', f x).
  S sf <*> S sx = S $ \s -> 
    case sf s of 
      Nothing     -> Nothing
      Just (s', f) -> case sx s' of
          Nothing      -> Nothing
          Just (s'', x) -> Just (s'', f x)

instance Monad Stack where
  return = pure

  -- Monadic bind returns a function that:
    -- Applies sa to s to get s' and a.
    -- (f a) then applies a function to a and wraps it up in another Stack.
    -- We use unwrapStack to extract the function out of it, and then apply it to s'.
  S sa >>= f = S $ \s -> 
    case sa s of 
      Nothing     -> Nothing
      Just (s', a) -> unwrapStack (f a) s'
    where 
      unwrapStack :: Stack a -> ([Int] -> Maybe ([Int], a))
      unwrapStack (S a) = a

push :: Int -> Stack ()
push x = S $ \xs -> Just (x : xs, ())

pop :: Stack Int
pop = S $ uncons
  where
    uncons :: [a] -> Maybe ([a], a)
    uncons [] = Nothing
    uncons (x : xs) = Just (xs, x)

-- The state is threaded through each function call.
-- End state is ([4, 3, 2, 1], 5).
testStack :: Stack Int
testStack = do
  push 1
  push 2
  push 3
  push 4
  push 5
  x <- pop
  push x
  pop

-- Extract the stack array and result value out of a Stack.
-- Does so by pattern matching to get the function out of the Stack.
-- Then running the function with an empty list.
toTuple :: Stack a -> Maybe ([Int], a)
toTuple stack = let (S f) = stack in f []