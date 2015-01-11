-- Copyright 2014 Alvaro J. Genial (http://alva.ro) -- see LICENSE.md for more.
{-# LANGUAGE NamedFieldPuns #-}
module Main (main) where

import Data.Maybe
import Options.Applicative
import System.FilePath     (addExtension, dropExtension, takeFileName)

import Text.Neat.Input.Django   (input)
import Text.Neat.Output.Haskell
import Text.Neat.Output.XML
import Text.Neat.Output.XSLT

data OutputType
    = HsOutput
    | XmlOutput
    | XsltOutput
  deriving (Show, Read, Eq)

data Args = Args {
    outputType :: OutputType
  , filePath   :: Maybe FilePath
  } deriving (Show, Read, Eq)

argsParser :: Parser Args
argsParser = Args <$> outputTypeOption <*> optional filePathArg
  where
    outputTypeOption =
            flag' HsOutput   (long "hs"   <> help "Generate Haskell output.")
        <|> flag' XmlOutput  (long "xml"  <> help "Generate XML output.")
        <|> flag' XsltOutput (long "xslt" <> help "Generate XSLT output.")
    filePathArg = strArgument
        (metavar "FILE" <> help "Input file. Defaults to stdin.")

main :: IO ()
main = execParser opts >>= \Args{outputType, filePath} -> do
    contents <- maybe getContents readFile filePath

    let fileName = fromMaybe "-" $ takeFileName <$> filePath
        handler  = case outputType of HsOutput   -> outputHS
                                      XmlOutput  -> outputXML
                                      XsltOutput -> outputXSLT
        output   = handler $ input fileName contents

    case filePath of
        Nothing -> putStr output
        Just fp -> writeFile (getOutputPath outputType fp) output
  where
    opts = info (helper <*> argsParser) fullDesc

getOutputPath :: OutputType -> FilePath -> FilePath
getOutputPath   HsOutput = dropExtension
getOutputPath  XmlOutput = flip addExtension "xml"
getOutputPath XsltOutput = flip addExtension "xsl" . dropExtension

