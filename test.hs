data Zero
data NonZero
newtype CheckedInt t = Checked Int

safeDiv :: Int -> CheckedInt NonZero -> Int
safeDiv x (Checked y) = x `div` y 

-- check :: Int -> Either (CheckedInt Zero) (CheckedInt NonZero)
-- check 0 = Left $ Checked 0
-- check n = Right $ Checked n

check :: Int -> CheckedInt (Either Zero NonZero)
check 0 = Checked 0
check n = Checked n