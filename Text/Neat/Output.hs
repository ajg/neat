{-# LANGUAGE FlexibleInstances, OverlappingInstances, UndecidableInstances #-}

module Text.Neat.Output (Output, output, Zero, zero, join, list, trim) where

import Data.Char (isSpace)
import Data.Foldable (toList)
import Data.List (intercalate, stripPrefix)

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


join :: (Output a, Output b) => a -> [b] -> String
join d l = intercalate (output d) (fmap output l)

trim :: Output a => a -> String
trim = f . f . output where f = reverse . dropWhile isSpace
