import Data.List

main = do
    a <- readFile "LICENSE"
    let b = lines a
    print b

limpa (h:t) b = if h /= "" then h : b else limpa t
