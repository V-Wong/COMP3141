# Data Invariants, Abstraction and Refinement

## Data Invariants
**Data invariants** are properties that pertain to a particular data type. 

Examples:
- Words in a dictionary are in sorted order.
- BST satisfies search tree properties.
- Date value will never be invalid (e.g. 31/13/2019).

### Wellformedness
**Wellformedness predicate** is a function on an value of the data type that returns true if and only if all data invariants of the data type hold.
```haskell 
  wf :: X -> Bool
  wf (x :: X) -- returns true if and only if data variants are held.
```
We must show that each constructor always produces a well formed value
```haskell
c :: ... -> X
wf (c ...)
```
and that each update operation produces a well formed value when given a well formed input
```haskell
u :: X -> X
wf x => wf (u x)
```

**Smart constructor** is a constructor that wraps around the default constructor and enforces data invariants.
Usually with modules we hide the default constructor and export only the smart constructor.

## Abstraction
**Abstraction** is the process of eliminating detail. An abstract implementation is often simpler but less performant
compared to a more concrete implementation.

An **Abstract Data Type** is a data type where implementation details of the type and its associated operations are hidden.

This means we no longer have to reason about them in terms of implementation.

## Refinement
**Refinement** is the inverse of abstraction. A refined implementation is often more complex but also more performant compared 
to the abstract implementation.

### Refinement Relations
We can connect our abstract model to our concrete implementation using a **refinement relation**. 
This tells us if the two structures represent the same object conceptually. This is useful
because it is often much easier to test and verify the correctness of the simpler abstract implementation.

```haskell
rel :: ConcreteType -> AbstractType -> Bool
```

We then want each constructor and update operations to maintain the refinement relation

```haskell
prop_empty_r = rel createConcrete createAbstract
prop_update_r = rel x y => rel (updateConcrete x) (updateAbstract y)
```

These refinement relations allow us to reason about our complex concrete implementation in terms of the simpler abstract implementation.

### Abstraction Function
Refinment relationships are very hard to QuickCheck because it is hard to generate two related values randomly. 
We can hence use an **abstraction function** that computes the corresponding abstract value from the concrete value. 

### Refinement Function
A **refinement function** is the opposite of an abstraction function where we go from abstract to refined instead. 
This is often appropriate when the abstraction function is hard or impossible to write.

```haskell
toAbstract :: ConcreteType -> AbstractType
rel = \(x :: ConcreteType) (y :: AbstractType) -> toAbstract x == y -- the refinement relation function is also simplified
```

### Refinement and Specifications
Functional correctness specifications can usually be expressed as
- All data invariants are maintained, and
- The implementation is a refinement of an abstract correctness model.
