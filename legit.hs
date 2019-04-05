-- need to install cryptohash dependency
import System.IO
import System.Directory
import qualified Data.ByteString.Lazy as BS
import qualified Crypto.Hash.SHA1 as SHA1

-- verifica se o arquivo ja fora adicionado no legit antes
verifyPresenceInLegit :: String -> [String] -> Bool     -- funfando nice
verifyPresenceInLegit a [] = False
verifyPresenceInLegit a (h:t) = if (h == a) then True else verifyPresenceInLegit a t

-- verifica se existe diferença entre o arquivo atual e na pasta legit
verifiyDiferenceInLegit :: String -> String -> Bool     -- funfando nice
verifiyDiferenceInLegit a b = a == b
    
-- Arquiva o commit como o arquivo na pasta .gitLegit
-- genCommit :: 

-- -- transforma o conteúdo de um arquivo em uma gigantesca string
-- fileToString filename

-- -- verifica se existe a pasta .gitlegit e a cria se não existir
-- createFolder = 

-- gitAdd = do
--     var <- getLine
