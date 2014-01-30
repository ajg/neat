
module Example.HTML.Post where

import Text.Neat

data Post = Post Author Subject [Paragraph]

type Author    = String
type Subject   = String
type Paragraph = String

samplePost = Post "Joe" "Breakfast" ["I love pancakes, waffles & toast."]

newtype Safe = Safe String

safe = Safe

instance Output Char where
  output '&'  = "&amp;"
  output '<'  = "&lt;"
  output '>'  = "&gt;"
  output '"'  = "&quot;"
  output '\'' = "&apos;"
  output c    = [c]

instance Output Safe where
  output (Safe s) = s

