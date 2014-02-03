{-# LINE 1 "Haskell2.hs.neat" #-}
module Text.Neat.Output.Haskell2 (output) where

import Text.Neat.File
import Text.Neat.Output


instance Output File where
 output (File path (Block chunks)) = ({-# LINE 8 "Haskell2.hs.neat" #-}
  "" ++ ({-# LINE 9 "Haskell2.hs.neat" #-}
  let _l = list (chunks) in
    if (not . null) _l
      then _l >>= \{-# LINE 9 "Haskell2.hs.neat" #-}
  chunk @ (Chunk location element) -> ({-# LINE 9 "Haskell2.hs.neat" #-}
    "" ++ ({-# LINE 10 "Haskell2.hs.neat" #-}
    
      case (element) of {-# LINE 11 "Haskell2.hs.neat" #-}
    (Text text) -> (({-# LINE 11 "Haskell2.hs.neat" #-}
      output (location)) ++ ({-# LINE 11 "Haskell2.hs.neat" #-}
      output (text)) ++ {-# LINE 11 "Haskell2.hs.neat" #-}
      "") 
    _ -> (({-# LINE 12 "Haskell2.hs.neat" #-}
      output (chunk)) ++ {-# LINE 12 "Haskell2.hs.neat" #-}
      "")) ++ {-# LINE 13 "Haskell2.hs.neat" #-}
    "")
      else []) ++ {-# LINE 14 "Haskell2.hs.neat" #-}
  ""){-# LINE 15 "Haskell2.hs.neat" #-}


instance Output Chunk where
 output chunk @ (Chunk location element) = ({-# LINE 18 "Haskell2.hs.neat" #-}
  "" ++ ({-# LINE 19 "Haskell2.hs.neat" #-}
  
    case (chunk) of {-# LINE 20 "Haskell2.hs.neat" #-}
  (Chunk _ define @ (Define _ _)) -> (({-# LINE 20 "Haskell2.hs.neat" #-}
    output (define)) ++ {-# LINE 20 "Haskell2.hs.neat" #-}
    ""){-# LINE 21 "Haskell2.hs.neat" #-}
  (Chunk _ text @ (Text _)) -> (({-# LINE 21 "Haskell2.hs.neat" #-}
    output (location)) ++ ({-# LINE 21 "Haskell2.hs.neat" #-}
    output (text)) ++ {-# LINE 21 "Haskell2.hs.neat" #-}
    "") 
  _ -> ({-# LINE 22 "Haskell2.hs.neat" #-}
    "(" ++ ({-# LINE 22 "Haskell2.hs.neat" #-}
    output (location)) ++ ({-# LINE 22 "Haskell2.hs.neat" #-}
    output (element)) ++ {-# LINE 22 "Haskell2.hs.neat" #-}
    ")")) ++ {-# LINE 23 "Haskell2.hs.neat" #-}
  ""){-# LINE 24 "Haskell2.hs.neat" #-}


instance Output Block where
 output (Block chunks) = ({-# LINE 27 "Haskell2.hs.neat" #-}
  "(" ++ ({-# LINE 27 "Haskell2.hs.neat" #-}
  output ((nest . join " ++ ") chunks)) ++ {-# LINE 27 "Haskell2.hs.neat" #-}
  ")"){-# LINE 27 "Haskell2.hs.neat" #-}


instance Output Case where
 output (Case pattern block) = (({-# LINE 30 "Haskell2.hs.neat" #-}
  output (pattern)) ++ {-# LINE 30 "Haskell2.hs.neat" #-}
  " -> " ++ ({-# LINE 30 "Haskell2.hs.neat" #-}
  output (block))){-# LINE 30 "Haskell2.hs.neat" #-}


instance Output Location where
 output (Location file line) = ({-# LINE 33 "Haskell2.hs.neat" #-}
  "{-# LINE " ++ ({-# LINE 33 "Haskell2.hs.neat" #-}
  output (line)) ++ {-# LINE 33 "Haskell2.hs.neat" #-}
  "" ++ ({-# LINE 33 "Haskell2.hs.neat" #-}
  output (show file)) ++ {-# LINE 33 "Haskell2.hs.neat" #-}
  " #-}"){-# LINE 34 "Haskell2.hs.neat" #-}


instance Output Function where
 output (Function _ name (Pattern _ pattern)) = (({-# LINE 37 "Haskell2.hs.neat" #-}
  output (name)) ++ ({-# LINE 37 "Haskell2.hs.neat" #-}
  output (pattern))){-# LINE 37 "Haskell2.hs.neat" #-}


instance Output Value where
 output (Value location value) = ({-# LINE 40 "Haskell2.hs.neat" #-}
  "(" ++ ({-# LINE 40 "Haskell2.hs.neat" #-}
  output (value)) ++ {-# LINE 40 "Haskell2.hs.neat" #-}
  ")"){-# LINE 40 "Haskell2.hs.neat" #-}


instance Output Pattern where
 output (Pattern location pattern) = (({-# LINE 43 "Haskell2.hs.neat" #-}
  output (location)) ++ ({-# LINE 43 "Haskell2.hs.neat" #-}
  output (pattern))){-# LINE 43 "Haskell2.hs.neat" #-}


instance Output Element where
 output (Bare value) = ({-# LINE 46 "Haskell2.hs.neat" #-}
  "output " ++ ({-# LINE 46 "Haskell2.hs.neat" #-}
  output (value))){-# LINE 46 "Haskell2.hs.neat" #-}

 output (Comment comment) = (({-# LINE 47 "Haskell2.hs.neat" #-}
  output ('{')) ++ {-# LINE 47 "Haskell2.hs.neat" #-}
  "#" ++ ({-# LINE 47 "Haskell2.hs.neat" #-}
  output (comment)) ++ {-# LINE 47 "Haskell2.hs.neat" #-}
  "#" ++ ({-# LINE 47 "Haskell2.hs.neat" #-}
  output ('}'))){-# LINE 47 "Haskell2.hs.neat" #-}

 output (Define function block) = (({-# LINE 48 "Haskell2.hs.neat" #-}
  output (function)) ++ {-# LINE 48 "Haskell2.hs.neat" #-}
  " = " ++ ({-# LINE 48 "Haskell2.hs.neat" #-}
  output (block))){-# LINE 48 "Haskell2.hs.neat" #-}

 output (Filter value block) = (({-# LINE 49 "Haskell2.hs.neat" #-}
  output (value)) ++ {-# LINE 49 "Haskell2.hs.neat" #-}
  "" ++ ({-# LINE 49 "Haskell2.hs.neat" #-}
  output (block))){-# LINE 49 "Haskell2.hs.neat" #-}


 output (For (Binding pattern value) block other) = ({-# LINE 51 "Haskell2.hs.neat" #-}
  "let _l = list " ++ ({-# LINE 51 "Haskell2.hs.neat" #-}
  output (value)) ++ {-# LINE 51 "Haskell2.hs.neat" #-}
  " in\n  if (not . null) _l\n    then _l >>= \\" ++ ({-# LINE 53 "Haskell2.hs.neat" #-}
  output (pattern)) ++ {-# LINE 53 "Haskell2.hs.neat" #-}
  " -> " ++ ({-# LINE 53 "Haskell2.hs.neat" #-}
  output (block)) ++ {-# LINE 53 "Haskell2.hs.neat" #-}
  "\n    else " ++ ({-# LINE 54 "Haskell2.hs.neat" #-}
  output (unless other "[]")) ++ {-# LINE 54 "Haskell2.hs.neat" #-}
  ""){-# LINE 55 "Haskell2.hs.neat" #-}


 output (If value block other) = ({-# LINE 57 "Haskell2.hs.neat" #-}
  "if (not . zero) " ++ ({-# LINE 57 "Haskell2.hs.neat" #-}
  output (value)) ++ {-# LINE 57 "Haskell2.hs.neat" #-}
  "\n  then " ++ ({-# LINE 58 "Haskell2.hs.neat" #-}
  output (block)) ++ {-# LINE 58 "Haskell2.hs.neat" #-}
  "\n  else " ++ ({-# LINE 59 "Haskell2.hs.neat" #-}
  output (unless other "[]")) ++ {-# LINE 59 "Haskell2.hs.neat" #-}
  ""){-# LINE 60 "Haskell2.hs.neat" #-}


 output (Switch value cases other) = ({-# LINE 62 "Haskell2.hs.neat" #-}
  "\n  case " ++ ({-# LINE 63 "Haskell2.hs.neat" #-}
  output (value)) ++ {-# LINE 63 "Haskell2.hs.neat" #-}
  " of " ++ ({-# LINE 63 "Haskell2.hs.neat" #-}
  output (cases)) ++ {-# LINE 63 "Haskell2.hs.neat" #-}
  "" ++ ({-# LINE 63 "Haskell2.hs.neat" #-}
  if (not . zero) (other)
    then ({-# LINE 63 "Haskell2.hs.neat" #-}
    "\n_ -> " ++ ({-# LINE 64 "Haskell2.hs.neat" #-}
    output (other)))
    else []) ++ {-# LINE 64 "Haskell2.hs.neat" #-}
  ""){-# LINE 65 "Haskell2.hs.neat" #-}


 output (With (Binding pattern value) block) = ({-# LINE 67 "Haskell2.hs.neat" #-}
  "\n  case " ++ ({-# LINE 68 "Haskell2.hs.neat" #-}
  output (value)) ++ {-# LINE 68 "Haskell2.hs.neat" #-}
  " of " ++ ({-# LINE 68 "Haskell2.hs.neat" #-}
  output (pattern)) ++ {-# LINE 68 "Haskell2.hs.neat" #-}
  " -> " ++ ({-# LINE 68 "Haskell2.hs.neat" #-}
  output (block)) ++ {-# LINE 68 "Haskell2.hs.neat" #-}
  ""){-# LINE 69 "Haskell2.hs.neat" #-}


 output (Text text) = (({-# LINE 71 "Haskell2.hs.neat" #-}
  output ((show . prune) text))){-# LINE 71 "Haskell2.hs.neat" #-}

