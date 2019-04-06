import System.IO
import System.Directory
-- import qualified Data.ByteString.Lazy as BS
-- need to install cryptohash dependency
-- import qualified Crypto.Hash.SHA1 as SHA1

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

-- talvez esse c2 tenha que mudar pra IO string, o que pode dificultar um pouco as coisas
writeAddHashToFile :: String -> String -> String -> IO ()   -- funfando
writeAddHashToFile filename s1 s2 = do
    a <- openFile filename AppendMode
    let c = genAddHash s1 s2
    hPutStrLn a c
    hClose a 

-- cria a estrutura de pasta
createFolder ::  IO ()  -- funfando
createFolder = do
    System.Directory.createDirectoryIfMissing True "./.legit/archive"
    System.Directory.createDirectoryIfMissing True "./.legit/commits"

-- cria e escreve no arquivo de git add
createAndWriteAddFile :: String -> String -> IO ()     -- funfa se existir a pasta
createAndWriteAddFile c1 c2 = writeAddHashToFile "./.legit/archive/add.txt" c1 c2
