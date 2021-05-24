# Functors, Applicatives and Monads

## Functors
### Operations
| Name  | Type Definition | Interpretation |
| ----- | --------------- | -------------- |
| fmap  | ``fmap :: (a -> b) -> f a -> f b``  | Applies a function to a functor wrapped value |

### Laws
| Law  | Equation | Interpretation |
| ---- | -------- | -------------- |
| Identity  | ``fmap id == id``  |
| Composition  | ``fmap (f . g) == fmap f . fmap . g``  |

## Applicatives
### Operations
| Name  | Type Definition | Interpretation |
| ----- | --------------- | -------------- |
| pure  | ``pure :: a -> f a``  | Lifts some value to the functor |
| Applicative Bind  | ``(<*>) :: f (a -> b) -> f a -> f b`` | Apply a functor wrapped function to a functor wrapped value |

### Laws
| Law  | Equation | Interpretation |
| ---- | -------- | -------------- |
| Identity  | ``pure id <\*> v == v``  |
| Homomorphism  | ``pure f <\*> pure x == pure (f x)`` |
| Interchange  | ``u <\*> pure y == pure ($ y) <\*> u`` |
| Composition  | ``pure (.) u <\*> v <\*> w == u <\*> (v <\*> w)`` |

## Monads
### Operations
| Name  | Type Definition | Interpretation |
| ----- | --------------- | -------------- |
| Monadic Bind  | ``(>>=) :: m a -> (a -> m b) -> m b`` | Applies a function that takes a normal value and returns a monad wrapped value to a monad wrapped value |
| Composition | ``(<=<) :: (b -> m c) -> (a -> m b) -> (a -> m c)`` | ``(f <=< g) x = g x >>= f``. Composes two functions that return monad wrapped values into one.

### Laws
| Law  | Equation | Interpretation |
| ---- | -------- | -------------- |
| Associativity  | ``f <=< (g <=< x) == (f <=< g) <=< x``  |
| Left identity  | ``pure <=< f == f`` |
| Right identity  | ``f <=< pure == f`` |

