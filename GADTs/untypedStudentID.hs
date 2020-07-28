data UG
data PG
data StudentID x = SID Int

-- x is of kind * as are UG and PG. But so are String, Boolean, etc.
-- The Haskell type system hence allows us to define things such as StudentID Boolean
-- which does not make sense as we only want to restrict to UG and PG.

-- The type system for types in Haskell is hence very untyped.

-- This is fine and reasonable.
test1 :: StudentID UG
test1 = undefined

-- This is not reasonable but is not caught by the compiler
-- as we have nothing that stops x from being a String.
test2 :: StudentID String
test2 = undefined

-- DataKinds extension allows us to use data type as a kind instead of a type.