-- need to install cryptohash dependency
import System.IO
import System.Directory
import qualified Data.ByteString.Lazy as BS
import qualified Crypto.Hash.SHA1 as SHA1

-- verifica se o arquivo ja fora adicionado no legit antes
-- chamar o segundo argumento com a funcao `lines x`
verifyPresenceInLegit :: String -> [String] -> Bool     -- funfando nice
verifyPresenceInLegit a [] = False
verifyPresenceInLegit a (h:t) = if (h == a) then True else verifyPresenceInLegit a t

-- verifica se existe diferença entre o arquivo atual e na pasta legit
verifiyDiferenceInLegit :: String -> String -> Bool     -- funfando nice
verifiyDiferenceInLegit a b = a == b

genAddHash :: String -> String -> String    -- funfando
genAddHash a b = a ++ ":" ++ b

writeAddToFile s1 s2 = do   -- funfando
    a <- openFile "asdf.txt" AppendMode
    let c = genAddHash s1 s2
    hPutStrLn a c
    hClose a 
    
-- Arquiva o commit como o arquivo na pasta .gitLegit
-- genCommit :: 

-- -- transforma o conteúdo de um arquivo em uma gigantesca string
-- fileToString filename

-- -- verifica se existe a pasta .gitlegit e a cria se não existir
-- createFolder = 

-- gitAdd = do
--     var <- getLine
