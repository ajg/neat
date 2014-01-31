
import System.Environment (getArgs)
import System.FilePath (dropExtension, takeFileName)
import System.IO (interact, readFile, writeFile)
import Text.Neat (parseString)
import Text.Neat.Output.Haskell (output)

main :: IO ()
main = getArgs >>= \args -> case args of
  []     -> interact (parse "-")
  [path] -> handleFile path
  _      -> error "too many arguments"
  where parse s = output . parseString s
        handleFile path = do
          string <- readFile path
          result <- return $ parse (takeFileName path) string
          writeFile (dropExtension path) result
