
import System.Environment (getArgs)
import Text.Neat (parseFile)

main :: IO ()
main = getArgs >>= \args -> case args of
         [path] -> parseFile path >>= putStrLn
         [] -> error "no file specified"
         _ -> error "too many arguments"
