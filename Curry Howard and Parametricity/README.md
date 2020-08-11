# Natural Deduction, Curry Howard Correspondence and Parametricity

## Curry Howard Correspondence
The **CH correspondence** is the direct relationship between computer programs and mathematical proofs. 

| Programming | Logic |
| ----------- | ----- |
| Types       | Propositions |
| Programs    | Proofs       |
| Evaluation  | Proof simplification |

In particular, logical connectives can be converted to Haskell types and back

| Type | Logical Connective |
| ---- | ------------------ |
| Tuples | Conjunction (∧) |
| Either | Disjunction (∨) |
| Functions | Implication |
| () | True |
| Void | False |

We can hence prove a logical result by constructing a valid Haskell program:

```haskell
// This proves that conjunction is commutative.
andCommutativity :: (A -> B) -> (B -> A)
andCommutativity p = (snd p, fst p)
```

```haskell
// This proves that implication is transitive.
transitive :: (A -> B) -> (B -> C) -> (A -> C)
transitive f g x = g (f x)
```

### More Examples of Programs and Proofs with Natural Deduction
**Prove A implies A**

![](https://latex.codecogs.com/gif.latex?%5Cfrac%20%7B%5Cdisplaystyle%5Cfrac%7B%7D%7BA%20%5Cvdash%20A%7D%5Ctexttt%7Bx%7D%7D%20%7BA%20%5Crightarrow%20A%7D%20%5Ctextrm%7B%24%5Crightarrow%24-I%7D_%7B%5Ctexttt%7Bx%7D%7D)
```haskell
prop_id :: a -> a
prop_id = \x -> x
```

**Prove A implies (A OR True)**

![](https://latex.codecogs.com/gif.latex?%5Cfrac%20%7B%5Cdisplaystyle%5Cfrac%20%7B%5Cdisplaystyle%5Cfrac%20%7B%7D%20%7BA%20%5Cvdash%20A%7D%20%5Ctexttt%7Bx%7D%20%7D%20%7BA%20%5Cvdash%20A%20%5Clor%20%5Cbot%7D%20%5Ctextrm%7B%24%5Clor%24-I%7D_%7BL%7D%20%7D%20%7BA%20%5Crightarrow%20%28A%20%5Clor%20%5Cbot%29%7D%20%5Ctextrm%7B%24%5Crightarrow%24-I%7D_%7B%5Ctexttt%7Bx%7D%7D)
```haskell
prop_or_true :: a -> (Either a ())
prop_or_true a = Right ()
```

**Prove A implies (A AND True)**

![](https://latex.codecogs.com/gif.latex?%5Cfrac%20%7B%5Cdisplaystyle%5Cfrac%20%7B%5Cdisplaystyle%5Cfrac%20%7B%7D%20%7BA%20%5Cvdash%20A%7D%20%5Ctexttt%7Bx%7D%20%5Cquad%20%5Cdisplaystyle%5Cfrac%20%7B%7D%20%7BA%20%5Cvdash%20%5Ctop%7D%20%5Ctextrm%7B%24%5Ctop%24-I%7D%20%7D%20%7BA%20%5Cvdash%20A%20%5Cland%20%5Ctop%7D%20%5Ctextrm%7B%24%5Cland%24-I%7D%20%7D%20%7BA%20%5Crightarrow%20%28A%20%5Cland%20%5Ctop%29%7D%20%5Ctextrm%7B%24%5Crightarrow%24-I%7D_%7B%5Ctexttt%7Bx%7D%7D)
```haskell
prop_and_true :: a -> (a, ())
prop_and_true a = (a, ())
```

**Prove A implies (A implies False) implies False**

![](https://latex.codecogs.com/gif.latex?%5Cfrac%20%7B%5Cdisplaystyle%5Cfrac%20%7B%5Cdisplaystyle%5Cfrac%20%7B%5Cdisplaystyle%5Cfrac%20%7B%7D%20%7BA%2C%20%28A%20%5Crightarrow%20%5Cbot%29%20%5Cvdash%20A%20%5Crightarrow%20%5Cbot%7D%20%5Ctexttt%7Bf%7D%20%5Cquad%20%5Cdisplaystyle%5Cfrac%20%7B%7D%20%7BA%2C%20%28A%20%5Crightarrow%20%5Cbot%29%20%5Cvdash%20A%7D%20%5Ctexttt%7Bx%7D%20%7D%20%7BA%2C%20%28A%20%5Crightarrow%20%5Cbot%29%20%5Cvdash%20%5Cbot%7D%20%5Ctextrm%7B%24%5Crightarrow%24-E%7D%20%7D%20%7BA%20%5Cvdash%20%28A%20%5Crightarrow%20%5Cbot%29%20%5Crightarrow%20%5Cbot%7D%20%5Ctextrm%7B%24%5Crightarrow%24-I%7D_%7B%5Ctexttt%7Bf%7D%7D%20%7D%20%7BA%20%5Crightarrow%20%28A%20%5Crightarrow%20%5Cbot%29%20%5Crightarrow%20%5Cbot%7D%20%5Ctextrm%7B%24%5Crightarrow%24-I%7D_%7B%5Ctexttt%7Bx%7D%7D)
```haskell
prop_double_neg_intro :: a -> (a -> Void) -> Void
prop_double_neg_intro a f = f a
```

## Type Isomorphism
Two types A and B are **isomorphic** if there exists a **bijection** between them. That is, for each value in A we can find a unique correponding value in B and vice versa.

### Examples of Type Isomorphism
```haskell
data Switch1 = On Name Int
            | Off Name

data Switch2 = (Name, Maybe Int)
```

## Polynmorphism and Parametricity
### Type Quantifiers
```haskell
fst :: (a, b) -> a

-- or more verbosely:

fst :: forall a b. (a, b) -> a
```

This quantification over type variables is known as **parametric polymorphism**.

## Generality and Ordering
A function of type _Int -> Int_ can be substituted with a polymorphic function of type _forall a -> a_ by instantiating the type variable to _Int_. The reverse is not true however. 

We hence have a notion of ordering. The type _A_ is more general than _B_ if type variables in _A_ can be instantiated to give the type _B_.

## Constraining Implementations
Polymorphic type signatures constrain implementations as the implementations must not rely on the type variable being any specific type. The more general a type, the more restricted the implementations. For example:

```haskell
id :: a -> a
id = \x -> x
```

is the only possible implementation of a function with type _a -> a_. We cannot assume the type is numeric and perform arithmetic. We cannot assume the type is boolean and do logical negation. And so on....

This has practical benefits, as the more general a type signature, the less possible mistakes that can be made when implementing the function.

## Principle of Parametricity
**Parametricity** states that the result of polymorphic functions cannot depend on **values** of an abstracted type.

More formally, let _g_ be a polymorphic function on type _a_ and have an abitrary function _f :: a -> a_. Then running _f_ on all the _a_ values in the input of _g_ will give the same result as running _g_ first, then _f_ on all the _a_ values of the output. Essentially **transforming inputs is equivalent to translating outputs**.

### Examples of Parametricity
```haskell
foo :: forall a. [a] -> [a]

-- Guaranteed property for any f.
foo . (map f) == (map f) . foo
```

```haskell
head :: forall a. [a] -> a

-- Guaranteed property for any f.
f (head ls) == head (map f ls)
```

```haskell
(++) :: forall a. [a] -> [a] -> [a]

-- Guaranteed property for any f.
(map f xs) ++ (map f ys) == map f (xs ++ ys)
```

```haskell
concat :: forall a. [[a]] -> [a]

-- Guaranteed property for any f.
concat ( map (map f) xs ) == map f (concat xs)
```