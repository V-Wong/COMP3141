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

### Examples of programs and proofs with natural deduction
![](https://latex.codecogs.com/gif.latex?%5Cfrac%20%7B%5Cdisplaystyle%5Cfrac%7B%7D%7BA%20%5Cvdash%20A%7D%5Ctexttt%7Bx%7D%7D%20%7BA%20%5Crightarrow%20A%7D%20%5Ctextrm%7B%24%5Crightarrow%24-I%7D_%7B%5Ctexttt%7Bx%7D%7D)
```haskell
prop_id :: a -> a
prop_id = \x -> x
```

![](https://latex.codecogs.com/gif.latex?%5Cfrac%20%7B%5Cdisplaystyle%5Cfrac%20%7B%5Cdisplaystyle%5Cfrac%20%7B%7D%20%7BA%20%5Cvdash%20A%7D%20%5Ctexttt%7Bx%7D%20%7D%20%7BA%20%5Cvdash%20A%20%5Clor%20%5Cbot%7D%20%5Ctextrm%7B%24%5Clor%24-I%7D_%7BL%7D%20%7D%20%7BA%20%5Crightarrow%20%28A%20%5Clor%20%5Cbot%29%7D%20%5Ctextrm%7B%24%5Crightarrow%24-I%7D_%7B%5Ctexttt%7Bx%7D%7D)
```haskell
prop_or_true :: a -> (Either a ())
prop_or_true a = Right ()
```

![](https://latex.codecogs.com/gif.latex?%5Cfrac%20%7B%5Cdisplaystyle%5Cfrac%20%7B%5Cdisplaystyle%5Cfrac%20%7B%7D%20%7BA%20%5Cvdash%20A%7D%20%5Ctexttt%7Bx%7D%20%5Cquad%20%5Cdisplaystyle%5Cfrac%20%7B%7D%20%7BA%20%5Cvdash%20%5Ctop%7D%20%5Ctextrm%7B%24%5Ctop%24-I%7D%20%7D%20%7BA%20%5Cvdash%20A%20%5Cland%20%5Ctop%7D%20%5Ctextrm%7B%24%5Cland%24-I%7D%20%7D%20%7BA%20%5Crightarrow%20%28A%20%5Cland%20%5Ctop%29%7D%20%5Ctextrm%7B%24%5Crightarrow%24-I%7D_%7B%5Ctexttt%7Bx%7D%7D)
```haskell
prop_and_true :: a -> (a, ())
prop_and_true a = (a, ())
```

![](https://latex.codecogs.com/gif.latex?%5Cfrac%20%7B%5Cdisplaystyle%5Cfrac%20%7B%5Cdisplaystyle%5Cfrac%20%7B%5Cdisplaystyle%5Cfrac%20%7B%7D%20%7BA%2C%20%28A%20%5Crightarrow%20%5Cbot%29%20%5Cvdash%20A%20%5Crightarrow%20%5Cbot%7D%20%5Ctexttt%7Bf%7D%20%5Cquad%20%5Cdisplaystyle%5Cfrac%20%7B%7D%20%7BA%2C%20%28A%20%5Crightarrow%20%5Cbot%29%20%5Cvdash%20A%7D%20%5Ctexttt%7Bx%7D%20%7D%20%7BA%2C%20%28A%20%5Crightarrow%20%5Cbot%29%20%5Cvdash%20%5Cbot%7D%20%5Ctextrm%7B%24%5Crightarrow%24-E%7D%20%7D%20%7BA%20%5Cvdash%20%28A%20%5Crightarrow%20%5Cbot%29%20%5Crightarrow%20%5Cbot%7D%20%5Ctextrm%7B%24%5Crightarrow%24-I%7D_%7B%5Ctexttt%7Bf%7D%7D%20%7D%20%7BA%20%5Crightarrow%20%28A%20%5Crightarrow%20%5Cbot%29%20%5Crightarrow%20%5Cbot%7D%20%5Ctextrm%7B%24%5Crightarrow%24-I%7D_%7B%5Ctexttt%7Bx%7D%7D)
```haskell
prop_double_neg_intro :: a -> (a -> Void) -> Void
prop_double_neg_intro a f = f a
```
