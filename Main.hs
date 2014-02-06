-- Copyright 2014 Alvaro J. Genial [http://alva.ro]; see LICENSE file for more.

import System.Environment (getArgs)
import System.FilePath (addExtension, dropExtension, takeFileName)
import System.IO (interact, readFile, writeFile)
import Text.Neat.Input.Django (input)
import Text.Neat.Output.Haskell
import Text.Neat.Output.XML
import Text.Neat.Output.XSLT


main :: IO ()
main = getArgs >>= \args -> case args of
  ["--hs"]         -> interact (parse outputHS "-")
  ["--xml"]        -> interact (parse outputXML "-")
  ["--xslt"]       -> interact (parse outputXSLT "-")
  ["--hs", path]   -> handleFile outputHS path (dropExtension path)
  ["--xml", path]  -> handleFile outputXML path (addExtension path "xml")
  ["--xslt", path] -> handleFile outputXSLT path (addExtension (dropExtension path) "xsl")
  [_, _]           -> error "invalid arguments"
  [_]              -> error "invalid argument"
  []               -> error "too few arguments"
  _                -> error "too many arguments"
  where parse f s = f . input s
        handleFile f pathIn pathOut = do
          string <- readFile pathIn
          result <- return $ parse f (takeFileName pathIn) string
          writeFile pathOut result
