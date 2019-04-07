import Data.List

-- formatString a = a

-- stringToJson a = 

formatEachToJSON [] filename = hClose filename
formatEachToJSON (h:t) filename = 

main = do
    a <- readFile "issues.md"
    -- let b = lines a
