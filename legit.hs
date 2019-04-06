-- need to install cryptohash dependency
import System.IO
import System.Directory
import qualified Data.ByteString.Lazy as BS
import qualified Crypto.Hash.SHA1 as SHA1

data UnixTime

split :: String -> Char -> [String]
split [] delim = [""]
split (c:cs) delim
    | c == delim = "" : rest
    | otherwise = (c : head rest) : tail rest
    where
        rest = split cs delim

-- verifica se o arquivo ja fora adicionado no legit antes
-- chamar o segundo argumento com a funcao `lines x`
verifyPresenceInLegit :: String -> [String] -> Bool     -- funfando nice
verifyPresenceInLegit a [] = False
verifyPresenceInLegit a (h:t) = if (h == a) then True else verifyPresenceInLegit a t

-- verifica se existe diferença entre o arquivo atual e na pasta legit
verifyDiferenceInLegit :: String -> String -> Bool     -- funfando nice
verifyDiferenceInLegit a b = a == b

genAddHash :: String -> String -> String    -- funfando
genAddHash a b = a ++ ":" ++ b

writeAddHashToFile :: IO () -> String -> String -> IO ()   -- funfando
writeAddHashToFile filename s1 s2 = do
    a <- openFile filename AppendMode
    let c = genAddHash s1 s2
    hPutStrLn a c
    hClose a 

-- verifica se existe a pasta .gitlegit e a cria se não existir 
createFolder ::  IO ()  -- funfando
createFolder = System.Directory.createDirectoryIfMissing True "./.legit/archive"

createFile c1 c2 = do
    -- let timestamp = (round . (* 1000)) <$> getPOSIXTime 
    writeAddHashToFile "./.legit/archive/add.txt" c1 c2
