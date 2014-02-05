
import System.Environment (getArgs)
import System.FilePath (addExtension, dropExtension, takeFileName)
import System.IO (interact, readFile, writeFile)
import Text.Neat.Input.Django (input)
import Text.Neat.Output.Haskell
import Text.Neat.Output.XML


main :: IO ()
main = getArgs >>= \args -> case args of
  ["-h"]       -> interact (parse outputHS "-")
  ["-x"]       -> interact (parse outputXML "-")
  ["-h", path] -> handleFile outputHS path (dropExtension path)
  ["-x", path] -> handleFile outputXML path (addExtension path "xml")
  [path, "-h"] -> handleFile outputHS path (dropExtension path)
  [path, "-x"] -> handleFile outputXML path (addExtension path "xml")
  [_, _]       -> error "invalid arguments"
  [_]          -> error "invalid argument"
  []           -> error "too few arguments"
  _            -> error "too many arguments"
  where parse f s = f . input s
        handleFile f pathIn pathOut = do
          string <- readFile pathIn
          result <- return $ parse f (takeFileName pathIn) string
          writeFile pathOut result
