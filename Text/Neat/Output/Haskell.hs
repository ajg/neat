{-# LINE 1 "Haskell.hs.neat" #-}
-- Copyright 2014 Alvaro J. Genial [http://alva.ro]; see LICENSE file for more.

module Text.Neat.Output.Haskell (outputHS) where

import Text.Neat.Template
import Text.Neat.Output


instance Output File where
 output (File path (Block chunks)) = ({-# LINE 10 "Haskell.hs.neat" #-}
  "" ++ ({-# LINE 11 "Haskell.hs.neat" #-}
  let _l = list (chunks) in
    if (not . null) _l
      then _l >>= \{-# LINE 11 "Haskell.hs.neat" #-}
  chunk @ (Chunk location element) -> ({-# LINE 11 "Haskell.hs.neat" #-}
    "" ++ ({-# LINE 12 "Haskell.hs.neat" #-}
    
      case (element) of {-# LINE 13 "Haskell.hs.neat" #-}
    (Text text) -> (({-# LINE 13 "Haskell.hs.neat" #-}
      output (location)) ++ ({-# LINE 13 "Haskell.hs.neat" #-}
      output (text)) ++ {-# LINE 13 "Haskell.hs.neat" #-}
      "") 
    _ -> (({-# LINE 14 "Haskell.hs.neat" #-}
      output (chunk)) ++ {-# LINE 14 "Haskell.hs.neat" #-}
      "")) ++ {-# LINE 15 "Haskell.hs.neat" #-}
    "")
      else []) ++ {-# LINE 16 "Haskell.hs.neat" #-}
  ""){-# LINE 17 "Haskell.hs.neat" #-}


instance Output Block where
 output (Block chunks) = ({-# LINE 20 "Haskell.hs.neat" #-}
  "(" ++ ({-# LINE 20 "Haskell.hs.neat" #-}
  output (nest $ join " ++ " $ chunks)) ++ {-# LINE 20 "Haskell.hs.neat" #-}
  ")"){-# LINE 20 "Haskell.hs.neat" #-}


instance Output Chunk where
 output chunk @ (Chunk location element) = ({-# LINE 23 "Haskell.hs.neat" #-}
  "" ++ ({-# LINE 24 "Haskell.hs.neat" #-}
  
    case (chunk) of {-# LINE 25 "Haskell.hs.neat" #-}
  (Chunk _ (Define _ _)) -> (({-# LINE 25 "Haskell.hs.neat" #-}
    output (element)) ++ {-# LINE 25 "Haskell.hs.neat" #-}
    ""){-# LINE 26 "Haskell.hs.neat" #-}
  (Chunk _ (Text _)) -> (({-# LINE 26 "Haskell.hs.neat" #-}
    output (location)) ++ ({-# LINE 26 "Haskell.hs.neat" #-}
    output (element)) ++ {-# LINE 26 "Haskell.hs.neat" #-}
    "") 
  _ -> ({-# LINE 27 "Haskell.hs.neat" #-}
    "(" ++ ({-# LINE 27 "Haskell.hs.neat" #-}
    output (location)) ++ ({-# LINE 27 "Haskell.hs.neat" #-}
    output (element)) ++ {-# LINE 27 "Haskell.hs.neat" #-}
    ")")) ++ {-# LINE 28 "Haskell.hs.neat" #-}
  ""){-# LINE 29 "Haskell.hs.neat" #-}


instance Output Case where
 output (Case pattern block) = (({-# LINE 32 "Haskell.hs.neat" #-}
  output (pattern)) ++ {-# LINE 32 "Haskell.hs.neat" #-}
  " -> " ++ ({-# LINE 32 "Haskell.hs.neat" #-}
  output (block))){-# LINE 32 "Haskell.hs.neat" #-}


instance Output Location where
 output (Location file line) = ({-# LINE 35 "Haskell.hs.neat" #-}
  "{-# LINE " ++ ({-# LINE 35 "Haskell.hs.neat" #-}
  output (line)) ++ {-# LINE 35 "Haskell.hs.neat" #-}
  " " ++ ({-# LINE 35 "Haskell.hs.neat" #-}
  output (quote $ file)) ++ {-# LINE 35 "Haskell.hs.neat" #-}
  " #-}\n"){-# LINE 37 "Haskell.hs.neat" #-}


instance Output Function where
 output (Function _ name (Pattern _ pattern)) = (({-# LINE 40 "Haskell.hs.neat" #-}
  output (name)) ++ ({-# LINE 40 "Haskell.hs.neat" #-}
  output (pattern))){-# LINE 40 "Haskell.hs.neat" #-}


instance Output Value where
 output (Value location pipeline) = ({-# LINE 43 "Haskell.hs.neat" #-}
  "(" ++ ({-# LINE 43 "Haskell.hs.neat" #-}
  output (join " $ " $ reverse $ pipeline)) ++ {-# LINE 43 "Haskell.hs.neat" #-}
  ")"){-# LINE 43 "Haskell.hs.neat" #-}


instance Output Pattern where
 output (Pattern location pattern) = (({-# LINE 46 "Haskell.hs.neat" #-}
  output (location)) ++ ({-# LINE 46 "Haskell.hs.neat" #-}
  output (pattern))){-# LINE 46 "Haskell.hs.neat" #-}


instance Output Element where
 output (Output value) = ({-# LINE 49 "Haskell.hs.neat" #-}
  "output " ++ ({-# LINE 49 "Haskell.hs.neat" #-}
  output (value))){-# LINE 49 "Haskell.hs.neat" #-}

 output (Comment comment) = (({-# LINE 50 "Haskell.hs.neat" #-}
  output ('{')) ++ {-# LINE 50 "Haskell.hs.neat" #-}
  "#" ++ ({-# LINE 50 "Haskell.hs.neat" #-}
  output (comment)) ++ {-# LINE 50 "Haskell.hs.neat" #-}
  "#" ++ ({-# LINE 50 "Haskell.hs.neat" #-}
  output ('}'))){-# LINE 50 "Haskell.hs.neat" #-}

 output (Define function block) = (({-# LINE 51 "Haskell.hs.neat" #-}
  output (function)) ++ {-# LINE 51 "Haskell.hs.neat" #-}
  " = " ++ ({-# LINE 51 "Haskell.hs.neat" #-}
  output (block))){-# LINE 51 "Haskell.hs.neat" #-}

 output (Filter value block) = (({-# LINE 52 "Haskell.hs.neat" #-}
  output (value)) ++ {-# LINE 52 "Haskell.hs.neat" #-}
  " " ++ ({-# LINE 52 "Haskell.hs.neat" #-}
  output (block))){-# LINE 52 "Haskell.hs.neat" #-}


 output (For (Binding pattern value) block other) = ({-# LINE 54 "Haskell.hs.neat" #-}
  "let _l = list " ++ ({-# LINE 54 "Haskell.hs.neat" #-}
  output (value)) ++ {-# LINE 54 "Haskell.hs.neat" #-}
  " in\n  if (not . null) _l\n    then _l >>= \\" ++ ({-# LINE 56 "Haskell.hs.neat" #-}
  output (pattern)) ++ {-# LINE 56 "Haskell.hs.neat" #-}
  " -> " ++ ({-# LINE 56 "Haskell.hs.neat" #-}
  output (block)) ++ {-# LINE 56 "Haskell.hs.neat" #-}
  "\n    else " ++ ({-# LINE 57 "Haskell.hs.neat" #-}
  output (unless other "[]")) ++ {-# LINE 57 "Haskell.hs.neat" #-}
  ""){-# LINE 58 "Haskell.hs.neat" #-}


 output (If value block other) = ({-# LINE 60 "Haskell.hs.neat" #-}
  "if (not . zero) " ++ ({-# LINE 60 "Haskell.hs.neat" #-}
  output (value)) ++ {-# LINE 60 "Haskell.hs.neat" #-}
  "\n  then " ++ ({-# LINE 61 "Haskell.hs.neat" #-}
  output (block)) ++ {-# LINE 61 "Haskell.hs.neat" #-}
  "\n  else " ++ ({-# LINE 62 "Haskell.hs.neat" #-}
  output (unless other "[]")) ++ {-# LINE 62 "Haskell.hs.neat" #-}
  ""){-# LINE 63 "Haskell.hs.neat" #-}


 output (Switch value cases other) = ({-# LINE 65 "Haskell.hs.neat" #-}
  "\n  case " ++ ({-# LINE 66 "Haskell.hs.neat" #-}
  output (value)) ++ {-# LINE 66 "Haskell.hs.neat" #-}
  " of " ++ ({-# LINE 66 "Haskell.hs.neat" #-}
  output (cases)) ++ {-# LINE 66 "Haskell.hs.neat" #-}
  " " ++ ({-# LINE 66 "Haskell.hs.neat" #-}
  if (not . zero) (other)
    then ({-# LINE 66 "Haskell.hs.neat" #-}
    "\n_ -> " ++ ({-# LINE 67 "Haskell.hs.neat" #-}
    output (other)))
    else []) ++ {-# LINE 67 "Haskell.hs.neat" #-}
  ""){-# LINE 68 "Haskell.hs.neat" #-}


 output (With (Binding pattern value) block) = ({-# LINE 70 "Haskell.hs.neat" #-}
  "\n  case " ++ ({-# LINE 71 "Haskell.hs.neat" #-}
  output (value)) ++ {-# LINE 71 "Haskell.hs.neat" #-}
  " of " ++ ({-# LINE 71 "Haskell.hs.neat" #-}
  output (pattern)) ++ {-# LINE 71 "Haskell.hs.neat" #-}
  " -> " ++ ({-# LINE 71 "Haskell.hs.neat" #-}
  output (block)) ++ {-# LINE 71 "Haskell.hs.neat" #-}
  ""){-# LINE 72 "Haskell.hs.neat" #-}


 output (Text text) = (({-# LINE 74 "Haskell.hs.neat" #-}
  output (quote $ prune $ text))){-# LINE 74 "Haskell.hs.neat" #-}



outputHS :: File -> String
outputHS = output
