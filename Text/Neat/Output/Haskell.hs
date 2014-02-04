{-# LINE 1 "Haskell.hs.neat" #-}
module Text.Neat.Output.Haskell (output) where

import Text.Neat.File
import Text.Neat.Output


instance Output File where
 output (File path (Block chunks)) = ({-# LINE 8 "Haskell.hs.neat" #-}
  "" ++ ({-# LINE 9 "Haskell.hs.neat" #-}
  let _l = list (chunks) in
    if (not . null) _l
      then _l >>= \{-# LINE 9 "Haskell.hs.neat" #-}
  chunk @ (Chunk location element) -> ({-# LINE 9 "Haskell.hs.neat" #-}
    "" ++ ({-# LINE 10 "Haskell.hs.neat" #-}
    
      case (element) of {-# LINE 11 "Haskell.hs.neat" #-}
    (Text text) -> (({-# LINE 11 "Haskell.hs.neat" #-}
      output (location)) ++ ({-# LINE 11 "Haskell.hs.neat" #-}
      output (text)) ++ {-# LINE 11 "Haskell.hs.neat" #-}
      "") 
    _ -> (({-# LINE 12 "Haskell.hs.neat" #-}
      output (chunk)) ++ {-# LINE 12 "Haskell.hs.neat" #-}
      "")) ++ {-# LINE 13 "Haskell.hs.neat" #-}
    "")
      else []) ++ {-# LINE 14 "Haskell.hs.neat" #-}
  ""){-# LINE 15 "Haskell.hs.neat" #-}


instance Output Chunk where
 output chunk @ (Chunk location element) = ({-# LINE 18 "Haskell.hs.neat" #-}
  "" ++ ({-# LINE 19 "Haskell.hs.neat" #-}
  
    case (chunk) of {-# LINE 20 "Haskell.hs.neat" #-}
  (Chunk _ define @ (Define _ _)) -> (({-# LINE 20 "Haskell.hs.neat" #-}
    output (define)) ++ {-# LINE 20 "Haskell.hs.neat" #-}
    ""){-# LINE 21 "Haskell.hs.neat" #-}
  (Chunk _ text @ (Text _)) -> (({-# LINE 21 "Haskell.hs.neat" #-}
    output (location)) ++ ({-# LINE 21 "Haskell.hs.neat" #-}
    output (text)) ++ {-# LINE 21 "Haskell.hs.neat" #-}
    "") 
  _ -> ({-# LINE 22 "Haskell.hs.neat" #-}
    "(" ++ ({-# LINE 22 "Haskell.hs.neat" #-}
    output (location)) ++ ({-# LINE 22 "Haskell.hs.neat" #-}
    output (element)) ++ {-# LINE 22 "Haskell.hs.neat" #-}
    ")")) ++ {-# LINE 23 "Haskell.hs.neat" #-}
  ""){-# LINE 24 "Haskell.hs.neat" #-}


instance Output Block where
 output (Block chunks) = ({-# LINE 27 "Haskell.hs.neat" #-}
  "(" ++ ({-# LINE 27 "Haskell.hs.neat" #-}
  output (nest $ join " ++ " $ chunks)) ++ {-# LINE 27 "Haskell.hs.neat" #-}
  ")"){-# LINE 27 "Haskell.hs.neat" #-}


instance Output Case where
 output (Case pattern block) = (({-# LINE 30 "Haskell.hs.neat" #-}
  output (pattern)) ++ {-# LINE 30 "Haskell.hs.neat" #-}
  " -> " ++ ({-# LINE 30 "Haskell.hs.neat" #-}
  output (block))){-# LINE 30 "Haskell.hs.neat" #-}


instance Output Location where
 output (Location file line) = ({-# LINE 33 "Haskell.hs.neat" #-}
  "{-# LINE " ++ ({-# LINE 33 "Haskell.hs.neat" #-}
  output (line)) ++ {-# LINE 33 "Haskell.hs.neat" #-}
  " " ++ ({-# LINE 33 "Haskell.hs.neat" #-}
  output (show file)) ++ {-# LINE 33 "Haskell.hs.neat" #-}
  " #-}\n"){-# LINE 35 "Haskell.hs.neat" #-}


instance Output Function where
 output (Function _ name (Pattern _ pattern)) = (({-# LINE 38 "Haskell.hs.neat" #-}
  output (name)) ++ ({-# LINE 38 "Haskell.hs.neat" #-}
  output (pattern))){-# LINE 38 "Haskell.hs.neat" #-}


instance Output Value where
 output (Value location pipeline) = ({-# LINE 41 "Haskell.hs.neat" #-}
  "(" ++ ({-# LINE 41 "Haskell.hs.neat" #-}
  output (join " $ " $ reverse $ pipeline)) ++ {-# LINE 41 "Haskell.hs.neat" #-}
  ")"){-# LINE 41 "Haskell.hs.neat" #-}


instance Output Pattern where
 output (Pattern location pattern) = (({-# LINE 44 "Haskell.hs.neat" #-}
  output (location)) ++ ({-# LINE 44 "Haskell.hs.neat" #-}
  output (pattern))){-# LINE 44 "Haskell.hs.neat" #-}


instance Output Element where
 output (Output value) = ({-# LINE 47 "Haskell.hs.neat" #-}
  "output " ++ ({-# LINE 47 "Haskell.hs.neat" #-}
  output (value))){-# LINE 47 "Haskell.hs.neat" #-}

 output (Comment comment) = (({-# LINE 48 "Haskell.hs.neat" #-}
  output ('{')) ++ {-# LINE 48 "Haskell.hs.neat" #-}
  "#" ++ ({-# LINE 48 "Haskell.hs.neat" #-}
  output (comment)) ++ {-# LINE 48 "Haskell.hs.neat" #-}
  "#" ++ ({-# LINE 48 "Haskell.hs.neat" #-}
  output ('}'))){-# LINE 48 "Haskell.hs.neat" #-}

 output (Define function block) = (({-# LINE 49 "Haskell.hs.neat" #-}
  output (function)) ++ {-# LINE 49 "Haskell.hs.neat" #-}
  " = " ++ ({-# LINE 49 "Haskell.hs.neat" #-}
  output (block))){-# LINE 49 "Haskell.hs.neat" #-}

 output (Filter value block) = (({-# LINE 50 "Haskell.hs.neat" #-}
  output (value)) ++ {-# LINE 50 "Haskell.hs.neat" #-}
  " " ++ ({-# LINE 50 "Haskell.hs.neat" #-}
  output (block))){-# LINE 50 "Haskell.hs.neat" #-}


 output (For (Binding pattern value) block other) = ({-# LINE 52 "Haskell.hs.neat" #-}
  "let _l = list " ++ ({-# LINE 52 "Haskell.hs.neat" #-}
  output (value)) ++ {-# LINE 52 "Haskell.hs.neat" #-}
  " in\n  if (not . null) _l\n    then _l >>= \\" ++ ({-# LINE 54 "Haskell.hs.neat" #-}
  output (pattern)) ++ {-# LINE 54 "Haskell.hs.neat" #-}
  " -> " ++ ({-# LINE 54 "Haskell.hs.neat" #-}
  output (block)) ++ {-# LINE 54 "Haskell.hs.neat" #-}
  "\n    else " ++ ({-# LINE 55 "Haskell.hs.neat" #-}
  output (unless other "[]")) ++ {-# LINE 55 "Haskell.hs.neat" #-}
  ""){-# LINE 56 "Haskell.hs.neat" #-}


 output (If value block other) = ({-# LINE 58 "Haskell.hs.neat" #-}
  "if (not . zero) " ++ ({-# LINE 58 "Haskell.hs.neat" #-}
  output (value)) ++ {-# LINE 58 "Haskell.hs.neat" #-}
  "\n  then " ++ ({-# LINE 59 "Haskell.hs.neat" #-}
  output (block)) ++ {-# LINE 59 "Haskell.hs.neat" #-}
  "\n  else " ++ ({-# LINE 60 "Haskell.hs.neat" #-}
  output (unless other "[]")) ++ {-# LINE 60 "Haskell.hs.neat" #-}
  ""){-# LINE 61 "Haskell.hs.neat" #-}


 output (Switch value cases other) = ({-# LINE 63 "Haskell.hs.neat" #-}
  "\n  case " ++ ({-# LINE 64 "Haskell.hs.neat" #-}
  output (value)) ++ {-# LINE 64 "Haskell.hs.neat" #-}
  " of " ++ ({-# LINE 64 "Haskell.hs.neat" #-}
  output (cases)) ++ {-# LINE 64 "Haskell.hs.neat" #-}
  " " ++ ({-# LINE 64 "Haskell.hs.neat" #-}
  if (not . zero) (other)
    then ({-# LINE 64 "Haskell.hs.neat" #-}
    "\n_ -> " ++ ({-# LINE 65 "Haskell.hs.neat" #-}
    output (other)))
    else []) ++ {-# LINE 65 "Haskell.hs.neat" #-}
  ""){-# LINE 66 "Haskell.hs.neat" #-}


 output (With (Binding pattern value) block) = ({-# LINE 68 "Haskell.hs.neat" #-}
  "\n  case " ++ ({-# LINE 69 "Haskell.hs.neat" #-}
  output (value)) ++ {-# LINE 69 "Haskell.hs.neat" #-}
  " of " ++ ({-# LINE 69 "Haskell.hs.neat" #-}
  output (pattern)) ++ {-# LINE 69 "Haskell.hs.neat" #-}
  " -> " ++ ({-# LINE 69 "Haskell.hs.neat" #-}
  output (block)) ++ {-# LINE 69 "Haskell.hs.neat" #-}
  ""){-# LINE 70 "Haskell.hs.neat" #-}


 output (Text text) = (({-# LINE 72 "Haskell.hs.neat" #-}
  output (show $ prune $ text))){-# LINE 72 "Haskell.hs.neat" #-}

