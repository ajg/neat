module Text.Neat.Output.Haskell (output) where

import Data.List (intercalate)
import Text.Neat.File
import Text.Neat.Output


instance Output File where
  output = file


file (File path (Block chunks)) = divide chunks where
    divide [] = []
    divide (c @ (Chunk l e) : rest) = element' e ++ divide rest
      where element' (Text s) = location l ++ s
            element' _ = chunk c

chunk (Chunk l d @ (Define _ _)) = location l ++ element d
chunk (Chunk l t @ (Text _)) = location l ++ element t
chunk (Chunk l e) = "(" ++ location l ++ element e ++ ")"

block (Block cs) = "(" ++ (nested $ case cs of
    [c] -> "\n" ++ chunk c
    _   -> "[]" ++ appendEach (fmap chunk cs)) ++ ")"
  where appendEach = concatMap $ (++) ("\n++ ")
        nested = intercalate "\n  " . lines

function (Function _ n (Pattern _ p)) = n ++ p
value    (Value l v)    = {- location l ++ -} "(" ++ v ++ ")"
pattern  (Pattern l p)  = location l ++ p
case'    (Case p b)     = pattern p ++ " -> " ++ block b
location (Location f l) = "{-# LINE " ++ show l ++ " " ++ show f ++ " #-}\n"

element (Bare v)     = "output " ++ value v
element (Comment _)  = "[]" -- TODO? Escape and output within {- -}.
element (Define f b) = function f ++ " = " ++ block b
element (Filter v b) = value v ++ " " ++ block b

element (For (Binding p v) b e) =
  "let _l = list " ++ value v ++ " in if (not . null) _l"
  ++ "\n  then _l >>= \\" ++ pattern p ++ " -> " ++ block b
  ++ "\n  else " ++ maybe "[]" block e

element (If v b e) =
  "if (not . zero) " ++ value v
  ++ "\n  then " ++ block b
  ++ "\n  else " ++ maybe "[]" block e

element (Switch v cs d) =
  "case " ++ value v ++ " of"
  ++ (case' =<< cs)
  ++ maybe "" (("\n_ ->" ++) . block) d

element (With (Binding p v) b) =
  "case " ++ value v ++ " of"
  ++ pattern p ++ " -> " ++ block b

element (Text s) = show s
