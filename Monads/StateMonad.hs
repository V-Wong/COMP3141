import Control.Monad

-- The State type holds a function from the 
-- actual state to a tuple of state and a result value.
-- Essentially: initialState -> (newState, result)
-- runState is an accesor that allows us to access the held function
-- without pattern matching.
newtype State s a = State { runState :: s -> (s, a) }

instance Functor (State s) where
  fmap = Control.Monad.liftM

instance Applicative (State s) where
  pure = return
  (<*>) = Control.Monad.ap

instance Monad (State s) where
  return = Main.pure

  -- This is the bind function which allows for sequential composition.
  -- We take a state processor p and a function k that is used to create
  -- another state processor from the result of the first state processor.

  -- (>>=) :: State s a -> (a -> State s b) -> State s b 
  -- which is equivalent to:
  -- (>>=) :: (s -> (s, a)) -> (a -> s -> (s, b)) -> (s -> (s, b)).
  p >>= k = State $ \s ->
    let (s', a) = runState p s -- run first processor on initial state.
    in runState (k a) s' -- run second processor on above state.

-- Set the result value to the state, and leave the state unchanged.
get :: State s s
get = State $ \s -> (s, s)

-- Set the result value to () and update the state.
put :: s -> State s ()
put s = State $ \_ -> (s, ())

-- Set the result value and leave the state unchanged.
pure :: a -> State s a
pure a = State $ \s -> (s, a)

-- Set the result value to () and modifies the state using function f.
modify :: (s -> s) -> State s ()
modify f = State $ \s -> (f s, ())
