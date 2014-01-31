module Text.Neat.Output.Haskell (output) where

import Data.List (intercalate)
import Text.Neat.File
import Text.Neat.Output (Output, output)


prelude   = ""
interlude = "" -- TODO: "import Text.Neat.Output\n\n"
postlude  = ""

instance Output Char where
  output = return

instance Output File where
  output (File (Block chunks)) = prelude ++ divide chunks ++ postlude where
    divide [] = []
    divide (chunk @ (Chunk location element) : rest) =
      output' element ++ interlude ++ divide rest where
        output' (Text text) = output location ++ text
        output' _ = output chunk

instance Output Block where
  output (Block chunks) = "(" ++ (nested $ case chunks of
      [chunk] -> "\n" ++ output chunk
      _       -> "[]" ++ appendEach (fmap output chunks)) ++ ")"
    where appendEach = concatMap $ (++) ("\n++ ")
          nested = intercalate "\n  " . lines

instance Output Chunk where
  output (Chunk location define @ (Define _ _)) = output location ++ output define
  output (Chunk location text @ (Text _)) = output location ++ output text
  output (Chunk location element) = "(" ++ output location ++ output element ++ ")"

instance Output Function where
  output (Function _ name (Pattern _ pattern)) = name ++ output pattern

instance Output Value where
  output (Value location value) = {- output location ++ -} "(" ++ value ++ ")"

instance Output Pattern where
  output (Pattern location pattern) = output location ++ pattern

instance Output Location where
  output (Location file line) =
    "{-# LINE " ++ show line ++ " " ++ show file ++ " #-}\n"

instance Output Case where
  output (Case pattern block) =
    output pattern ++ " -> " ++ output block

instance Output Element where
  output (Bare value)         = "output " ++ output value
  output (Comment _)          = "[]" -- TODO? Escape and output within {- -}.
  output (Define function block)  = output function ++ " = " ++ output block
  output (Filter value block) = output value ++ " " ++ output block

  output (For (Binding pattern value) block else') =
    "let _l = list " ++ output value ++ " in if (not . null) _l"
    ++ "\n  then _l >>= \\" ++ output pattern ++ " -> " ++ output block
    ++ "\n  else " ++ maybe "[]" output else'

  output (If value block else') =
    "if (not . zero) " ++ output value
    ++ "\n  then " ++ output block
    ++ "\n  else " ++ maybe "[]" output else'

  output (Switch value cases default') =
    "case " ++ output value ++ " of"
    ++ (output =<< cases)
    ++ maybe "" (("\n_ ->" ++) . output) default'

  output (With (Binding pattern value) block) =
    "case " ++ output value ++ " of"
    ++ output pattern ++ " -> " ++ output block

  output (Text text) = show text
