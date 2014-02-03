{-# LANGUAGE FlexibleInstances #-}
module Example.HTML.Post where

import Text.Neat.Output

data Post = Post Author Subject [Paragraph]

type Author    = String
type Subject   = String
type Paragraph = String


newtype Safe = Safe String

safe = Safe

instance Output String where
  output = concatMap escape where
    escape '&'  = "&amp;"
    escape '<'  = "&lt;"
    escape '>'  = "&gt;"
    escape '"'  = "&quot;"
    escape '\'' = "&apos;"
    escape c    = [c]

instance Output Safe where
  output (Safe s) = s

