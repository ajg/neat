
import System.Environment (getArgs)
import System.FilePath (dropExtension, takeFileName)
import System.IO (interact, readFile, writeFile)
import Text.Neat (parseString)

main :: IO ()
main = getArgs >>= \args -> case args of
  []     -> interact (parseString "-")
  [path] -> handleFile path
  _      -> error "too many arguments"
  where handleFile path = do
          input <- readFile path
          output <- return $ parseString (takeFileName path) input
          writeFile (dropExtension path) output
