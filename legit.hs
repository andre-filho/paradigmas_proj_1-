-- need to install cryptohash dependency
import System.IO
import System.Directory
import Data.ByteString as BSU
import qualified Crypto.Hash.SHA1 as SHA1

-- Comprime o conteúdo do arq selecionado
compressContent :: ByteString
-- compressContent bytestring_content =

-- verifica se a hash nome_aqv : conteudo já existe
verifyPresenceInLegit :: filecontent encryptedcontent -> Bool

-- -- verifica se existe diferença entre o arquivo atual e na pasta legit
verifiyDiferenceInLegit :: filecontent encryptedcontent -> Bool

-- vai gerar o nome encriptado para o arquivo
genFilenameHash :: String -> String
genFilenameHash filename = bytestringToString (SHA1.hash (stringToByteString filename))

-- converte string para bytestring_content
stringToByteString :: String -> ByteString
stringToByteString str = BSU.fromString str

-- converte bytestring para 
bytestringToString :: ByteString -> String
bytestringToString bstr = BSU.toString bstr
    
-- Arquiva o commit como o arquivo na pasta .gitLegit
genCommit :: 

-- -- verifica se existe a pasta .gitlegit e a cria se não existir
createFolder = 

-- adiciona lista de arquivos para o commit



gitAdd = do
    var <- getLine
