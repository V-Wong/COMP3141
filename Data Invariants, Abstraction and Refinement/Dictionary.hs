module Dictionary
  ( Word
  , Definition
  , Dict
  , emptyDict
  , insertWord
  , lookup
  ) where

import Prelude hiding (Word, lookup)
import Test.QuickCheck
import Test.QuickCheck.Modifiers

type Word = String
type Definition = String

-- Note: only the type is exported, not the data constructor.
-- We can hence not use D to create a Dict or pattern match in other files.
-- This protects out data, by only allowing modifications through the exported functions.
newtype Dict = D [DictEntry] deriving (Show, Eq)

data DictEntry
  = Entry { word :: Word
          , defn :: Definition
          } deriving (Eq, Show)

emptyDict :: Dict
emptyDict = D []

insertWord :: Word -> Definition -> Dict -> Dict
insertWord w def (D defs) = D (insertEntry (Entry w def) defs)
  where
    insertEntry w (e : es) = case compare (word w) (word e) of 
                              GT -> e : (insertEntry w es)
                              EQ -> w : es
                              LT -> w : e : es
    insertEntry w [] = [w]

lookup :: Word -> Dict -> Maybe Definition
lookup w (D es) = search w es
  where
    search w [] = Nothing
    search w (e : es) = case compare w (word e) of
      LT -> Nothing
      EQ -> Just (defn e)
      GT -> search w es

sorted :: (Ord a) => [a] -> Bool
sorted []  = True
sorted [x] = True
sorted (x : y : xs) = x <= y && sorted (y : xs)

-- A wellformed Dict has only one data invariant: that all entries are sorted.
wellformed :: Dict -> Bool
wellformed (D es) = sorted es

-- We want all constuctor and update operations to maintain the data invariants.
-- Lookup doesn't manipulate so we don't need to test it.

-- Note: any arbitrarily generated dictionary is unlikely to be well formed,
-- so QuickCheck will discard a lot of test cases unless we create our own generator for it.
prop_insert_wf dict w d = wellformed dict ==> wellformed (insertWord w d dict)

instance Ord DictEntry where
  -- Allows us to compare two entries by only comparing the words.
  Entry w1 d1 <= Entry w2 d2 = w1 <= w2

instance Arbitrary DictEntry where
  arbitrary = Entry <$> arbitrary <*> arbitrary

instance Arbitrary Dict where
  arbitrary = do
    Ordered ds <- arbitrary
    pure (D ds)

prop_arbitrary_wf dict = wellformed dict
