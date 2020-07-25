# Functors, Applicatives and Monads

## Functors
### Operations
- fmap :: (a -> b) -> f a -> f b
### Laws
- Identity: fmap id == id
- Composition: fmap (f . g) == fmap f . fmap g

## Applicatives
### Operations
- pure :: a -> f a
- (<*>) :: f (a -> b) -> f a -> f b
### Laws
- Identity: pure id <\*> v == v
- Homomorphism: pure f <\*> pure x == pure (f x)
- Interchange: u <\*> pure y == pure ($ y) <\*> u
- Composition: pure (.) u <\*> v <\*> w == u <\*> (v <\*> w)

## Monads
### Operations
- (>>=) :: m a -> (a -> m b) -> m b
- (<=<) :: (b -> m c) -> (a -> m b) -> (a -> m c)
  - (f <=< g) x = g x >>= f
### Laws
- Associativity: f <=< (g <=< x) == (f <=< g) <=< x
- Left identity: pure <=< f == f
- Right identity: f <=< pure == f
