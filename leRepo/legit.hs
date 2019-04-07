import System.IO
import System.Directory
-- import qualified Data.ByteString.Lazy as BS
-- need to install cryptohash dependency
-- import qualified Crypto.Hash.SHA1 as SHA1

data UnixTime


-- Função que adiciona os arquivos para sere commitados
legitAdd :: String -> IO () 
legitAdd filesNames = do
    createFolder
    readFiles (words filesNames)



-- Cria a estrutura de pastas, se não existir. Caso exista, não faz nada.
createFolder ::  IO ()  -- Funcionando
createFolder = do
    System.Directory.createDirectoryIfMissing True "./.legit/archive"
    System.Directory.createDirectoryIfMissing True "./.legit/commits"



readFiles :: [String] -> IO ()
readFiles [ ] = putStrLn "Complete"
readFiles (h:t) = do
    let name = h 
    contents <- readFile name 
    writeFile ("./.legit/archive/" ++ name) contents
    readFiles t


-- readFiles :: [String] -> IO ()
-- readFiles [ ] = putStrLn "Cabô"
-- readFiles (h:t) =  do
--     let name = h 
--     contents <- readFile name 
--     putStrLn contents
--     putStrLn "###################################"
--     readFiles t
    

-- readFiles :: [String] -> [IO String]
-- readFiles [] = []
-- readFiles (h:t) = [contents] ++ readFiles t
--     where  
--         name = h 
--         contents = readFile name
    
-- writeFiles :: [IO String] -> IO ()
-- writeFiles [] = writeFile "./.legit/archive/addFile.txt" "EOF"
-- writeFiles (h:t) = do
--     writeFile "./.legit/archive/addFile.txt" (h + "####")
--     writeFiles t
    

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



-- checkAddExistance = do
--     let a = System.Directory.doesFileExist "./.legit/archive/add.txt"
--     a == (True :: IO Bool)
    
-- cria e escreve no arquivo de git add
createAndWriteAddFile :: String -> String -> IO ()     -- funfa se existir a pasta
createAndWriteAddFile c1 c2 = writeAddHashToFile "./.legit/archive/add.txt" c1 c2


