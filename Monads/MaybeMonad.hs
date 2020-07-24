import Prelude hiding (Maybe, Just, Nothing)

-- Functors, Applicatives and Monads
-- deal with how functions and values work
-- in different contexts.

-- Maybe provides two contexts: Nothing and Just.
-- We can wrap values and functions in these contexts.
data Maybe a = Nothing | Just a
  deriving (Show, Eq)

instance Functor Maybe where
  -- fmap on Just applies the function to the value
  -- and wraps it up again in another Just.
  -- fmap does nothing on Nothing values.

  -- fmap :: Functor f => (a -> b) -> f a -> f b
  fmap f (Just x) = Just (f x)
  fmap _ Nothing = Nothing

  -- We can write inline fmap with (<$>).

instance Applicative Maybe where
  -- pure wraps up a value in Just without doing anything to it.

  -- pure :: Applicative f => a -> f a
  pure x = Just x

  -- <*> allows us to apply functions wrapped in a context
  -- to a value wrapped in a context.

  -- (<*>) :: Applicative f => f (a -> b) -> f a -> f b
  Just f <*> Just x = Just (f x)
  _      <*> _      = Nothing
  -- The second case catches everything. 
  -- Essentially equivalent to both:
    -- Nothing <*> Just _ = Nothing
    -- Just f <*> Nothing = Nothing

-- The Applicative instance of Maybe
-- allows us to chain together Maybe wrapped
-- functions and values. 

-- A Just value is returned only if all subparts return Just.
testJustApplicative = Just (*) <*> Just 5 <*> Just 2

-- A Nothing is returned if any subpart returns Nothing.
testNothingApplicative1 = Nothing <*> Just 5 <*> Just 2
testNothingApplicative2 = Just (*) <*> Nothing <*> Just 2
testNothingApplicative3 = Just (*) <*> Just 5 <*> Nothing

instance Monad Maybe where
  -- >>= also known as bind.
  -- >>= takes a wrapped value and a function that returns a wrapped value
  -- and applies the function to the value returning it in a new wrapper.

  -- (>>=) :: m a -> (a -> m b) -> m b
  Nothing >>= f = Nothing
  Just val >>= f = f val

-- The bind allows us to sequentially compose functions of the form (a -> m b)

half x = if even x
         then Just (x `div` 2)
         else Nothing

-- All calls of half here return a Just value.
testJustMonad = Just 32 >>= half >>= half >>= half

-- The first call returns a Just value, but the second call returns Nothing.
testNothingMonad1 = Just 6 >>= half >>= half

-- We can continue calling half on nothing, but it will just continually return Nothing.
testNothingMonad2 = Nothing >>= half >>= half >>= half
