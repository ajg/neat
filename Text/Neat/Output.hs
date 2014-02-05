{-# LANGUAGE FlexibleInstances, OverlappingInstances, UndecidableInstances #-}

module Text.Neat.Output where

import Data.Char (isSpace)
import Data.Foldable (toList)
import Data.List (intercalate, stripPrefix)
import Text.Neat.File

-- TODO? list, output, zero => toList, toString, toBool

list x = toList x


class Output a where
  output :: a -> String

instance (Show a) => Output a where
  output = show

instance Output a => Output [a] where
  output = concatMap output

instance Output a => Output (Maybe a) where
  output = maybe "" output

instance (Output a, Output b) => Output (Either a b) where
  output = either output output

instance Output Char where
  output = return

class Zero a where
  zero :: a -> Bool

instance Zero [a] where
  zero = null

instance Zero (Maybe a) where
  zero Nothing = True
  zero _       = False

instance (Num a, Eq a) => Zero a where
  zero = (== 0)

instance Zero Bool where
  zero = (== False)

instance Zero Char where
  zero = (== '\0')

join :: (Output a, Output b) => a -> [b] -> String
join d l = intercalate (output d) (fmap output l)

trim :: Output a => a -> String
trim = f . f . output where f = reverse . dropWhile isSpace

nest :: Output a => a -> String
nest = join "\n  " . lines . output

prune :: Output a => a -> String
prune = xxx . lines . output where
  xxx [l] = l
  xxx ls = join "\n" . filter fluff $ ls
  fluff l = any (not . isSpace) l || l == ""

unless :: (Zero a, Output a, Output b) => a -> b -> String
unless a b = if zero a then output b else output a

quote :: Output a => a -> String
quote = show . output
