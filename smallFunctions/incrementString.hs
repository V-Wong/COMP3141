import Data.Char

incrementString1 :: [Char] -> [Char]
incrementString1 =
    let increment x = 1 + x
    in \xs -> map chr (map increment (map ord xs))

incrementString2 :: [Char] -> [Char]
incrementString2 = map chr . map (1+) . map ord

incrementString3 :: [Char] -> [Char]
incrementString3 = map (chr . (1+) . ord)

incrementString4 :: [Char] -> [Char]
incrementString4 = \xs -> map chr . map (1+) $ map ord xs