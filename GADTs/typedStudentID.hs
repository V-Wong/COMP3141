{-# LANGUAGE DataKinds, KindSignatures #-}

import Data.Either

-- A type parameter is phantom if it does not appear
-- on the right hand side of a type definition.

-- Uses of phantom types:
--  - Track data invariants that have been established about a value.
--  - Track information about representation (units of measurement).
--  - Enforcing order of operations performed on values (type states).

-- x here is a phantom type.
data Stream = UG | PG
data StudentID (x :: Stream) = SID Int
  deriving (Show, Eq)

postgrads :: [Int]
postgrads = [3253158]

-- Smart constructor that wrap around the standard constructor and enforces data invariants.

-- data Either a b = Left a | Right b
makeStudentID :: Int -> Either (StudentID UG) (StudentID PG)
makeStudentID i | i `elem` postgrads = Right (SID i) 
                | otherwise          = Left  (SID i)

enrollInCOMP3141 :: StudentID UG -> IO ()
enrollInCOMP3141 (SID x) 
  = putStrLn (show x ++ " enrolled in COMP3141!")

main = do
  let ugID = makeStudentID 1
  case ugID of 
    Left id -> enrollInCOMP3141 id
    Right _ -> pure () -- this case would not match for the given ugID.

    -- Attempting to enroll with a postgrad id would result in a type error:
      -- Right id -> enrollInCOMP3141 id

  let pgID = makeStudentID 3253158
  case pgID of 
    Left _ -> pure () -- this case would not match for the given pgID.
    Right id -> print $ (show id) ++ " undergrad, can't enroll."
