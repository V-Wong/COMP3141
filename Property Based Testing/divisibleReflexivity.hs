import Test.QuickCheck

divisible :: Integer -> Integer -> Bool
divisible x y = x `mod` y == 0

-- This fails because of division by 0.
prop_reflexive_fail :: Integer -> Bool
prop_reflexive_fail x = divisible x x

-- ==> encodes a pre-condition.
-- This may throw away a lot of test cases.
prop_reflexive_precondition :: Integer -> Property
prop_reflexive_precondition x = x > 0 ==> divisible x x

-- This uses a different generator.
-- We often need to define custom generators.
prop_reflexive_generator :: Positive Integer -> Property
prop_reflexive_generator (Positive x) = x /= 0 ==> divisible x x

main = do
  quickCheck prop_reflexive_precondition
  quickCheck prop_reflexive_generator
  quickCheck prop_reflexive_fail
