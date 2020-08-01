type ZID = Int
type Name = String

db :: [(ZID, Name)]
db = [(3253158, "Liam"),
      (8888888, "Rich"),
      (4444444, "Mort")]

searchMonadSugared :: [ZID] -> Maybe [Name]
searchMonadSugared [] = pure []
searchMonadSugared (z:zs) = do 
  n  <- lookup z db
  ns <- searchMonadSugared zs
  pure (n : ns)

searchMonadSugared :: [ZID] -> Maybe [Name]
searchMonadSugared [] = pure []
searchMonadSugared (z : zs) = lookup z db >>= 

searchApplicative :: [ZID] -> Maybe [Name]
searchApplicative [] = pure []
searchApplicative (z:zs) = (:) <$> lookup z db <*> searchApplicative zs
-- fmap (:) to the result returned from lookup to create a Maybe wrapped function.
-- We then applicative bind and recursively call on the rest of the list.
-- This appends all the results into one list if all searches returns a value.
-- If any search returns a Nothing, the whole chain is broken, and Nothing is returned.

main = do
  print (searchMonadSugared [3253158]) -- Just ["Liam"]
  print (searchApplicative [3253158]) -- Just ["Liam"]

  print (searchMonadSugared [3253158, 1]) -- Nothing
  print (searchApplicative [3253158, 1]) -- Nothing