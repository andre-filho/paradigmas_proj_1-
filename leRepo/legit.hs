import System.IO
import System.Directory
import Data.Time.Clock
-- import qualified Data.ByteString.Lazy as BS
-- need to install cryptohash dependency
-- import qualified Crypto.Hash.SHA1 as SHA1
-- data UnixTime

-- ################################################ GIT ADD ############################################

-- Função que adiciona os arquivos para sere commitados
legitAdd :: String -> IO () 
legitAdd filesNames = do
    createFolder
    removeFiles
    readFiles (words filesNames)

-- Cria a estrutura de pastas, se não existir. Caso exista, não faz nada.
createFolder ::  IO () 
createFolder = do
    System.Directory.createDirectoryIfMissing True "./.legit/archive"
    System.Directory.createDirectoryIfMissing True "./.legit/commits"
    System.Directory.createDirectoryIfMissing True "./.legit/repository"

-- Apaga arquivos do diretório de armazenamento de commits
removeFiles :: IO ()
removeFiles = do
    files <- getDirectoryContents "./.legit/archive"
    cleanArchive files

cleanArchive :: [String] -> IO ()
cleanArchive [ ] = putStrLn "Complete Cleaning"
cleanArchive (h:t) = do
    if (h /= "." && h /= "..") then recursiveClean h t
    else cleanArchive t

recursiveClean :: String -> [String] -> IO ()
recursiveClean head tail = do
    removeFile ("./.legit/archive/" ++ head)
    cleanArchive tail
    

-- Recebe a string contendo os nomes dos arquivos a serem adicionas e os salva na pasta ".legit/archive"
readFiles :: [String] -> IO ()
readFiles [ ] = putStrLn "Complete Reading"
readFiles (h:t) = do
    let name = h 
    contents <- readFile name 
    writeFile ("./.legit/archive/" ++ name) contents
    readFiles t


-- ################################################ GIT COMMIT ############################################

legitCommit :: String -> IO ()
legitCommit commitMessage = do
    filesToAdd <- getDirectoryContents  "./.legit/archive"
    commitingFiles filesToAdd
    writeFile ("./.legit/repository/.commitMessage") commitMessage
    let commitFolder = ("./.legit/commits/" ++ commitMessage)
    System.Directory.createDirectoryIfMissing True commitFolder
    saveHistory commitFolder

saveHistory :: String -> IO ()
saveHistory commitFolder = do
    filesToAdd <- getDirectoryContents  "./.legit/repository"
    savingCommit filesToAdd commitFolder

savingCommit :: [String] -> String -> IO ()
savingCommit  [ ] _ = putStrLn "Complete Commiting"
savingCommit  (h:t) commitFolder = do
    if (h /= "." && h /= "..") then recursiveSave h t commitFolder
    else savingCommit t commitFolder


recursiveSave :: String -> [String] -> String -> IO ()
recursiveSave head tail commitFolder = do
    let name = head
    contents <- readFile ("./.legit/repository/" ++ head)
    writeFile (commitFolder ++ "/" ++ name) contents
    savingCommit tail commitFolder


commitingFiles :: [String] -> IO ()
commitingFiles [ ] = putStrLn "Complete Commiting"
commitingFiles (h:t) = do
    if (h /= "." && h /= "..") then recursiveAdd h t
    else commitingFiles t 

recursiveAdd :: String -> [String] -> IO ()
recursiveAdd head tail = do
    let name = head
    contents <- readFile ("./.legit/archive/" ++ head)
    writeFile ("./.legit/repository/" ++ name) contents
    commitingFiles tail
    
    

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
    

-- split :: String -> Char -> [String]
-- split [] delim = [""]
-- split (c:cs) delim
--     | c == delim = "" : rest
--     | otherwise = (c : head rest) : tail rest
--     where
--         rest = split cs delim

-- -- verifica se o arquivo ja fora adicionado no legit antes
-- -- chamar o segundo argumento com a funcao `lines x`
-- verifyPresenceInLegit :: String -> [String] -> Bool     -- funfando nice
-- verifyPresenceInLegit a [] = False
-- verifyPresenceInLegit a (h:t) = if (h == a) then True else verifyPresenceInLegit a t

-- -- verifica se existe diferença entre o arquivo atual e na pasta legit
-- verifyDiferenceInLegit :: String -> String -> Bool     -- funfando nice
-- verifyDiferenceInLegit a b = a == b

-- genAddHash :: String -> String -> String    -- funfando
-- genAddHash a b = a ++ ":" ++ b

-- -- talvez esse c2 tenha que mudar pra IO string, o que pode dificultar um pouco as coisas
-- writeAddHashToFile :: String -> String -> String -> IO ()   -- funfando
-- writeAddHashToFile filename s1 s2 = do
--     a <- openFile filename AppendMode
--     let c = genAddHash s1 s2
--     hPutStrLn a c
--     hClose a 



-- -- checkAddExistance = do
-- --     let a = System.Directory.doesFileExist "./.legit/archive/add.txt"
-- --     a == (True :: IO Bool)
    
-- -- cria e escreve no arquivo de git add
-- createAndWriteAddFile :: String -> String -> IO ()     -- funfa se existir a pasta
-- createAndWriteAddFile c1 c2 = writeAddHashToFile "./.legit/archive/add.txt" c1 c2


