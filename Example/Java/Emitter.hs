{-# LINE 1 "Emitter.hs.neat" #-}

import Data.Maybe (fromMaybe)
import Example.Java.AST
import System.FilePath
import Text.Neat

main = putStrLn (emit sampleFile)


{-# LINE 10 "Emitter.hs.neat" #-}
emit (File path package imports cls) = (""
  ++ {-# LINE 10 "Emitter.hs.neat" #-}
  "\n  // Code generated from "
  ++ ({-# LINE 11 "Emitter.hs.neat" #-}
  output ( takeFileName path ))
  ++ {-# LINE 11 "Emitter.hs.neat" #-}
  "\n  package "
  ++ ({-# LINE 12 "Emitter.hs.neat" #-}
  output ( package ))
  ++ {-# LINE 12 "Emitter.hs.neat" #-}
  ";\n"
  ++ ({-# LINE 14 "Emitter.hs.neat" #-}
  let _l = toList (imports) in if (not . null) _l
    then _l >>= \{-# LINE 14 "Emitter.hs.neat" #-}
  (Import static qname wildcard) -> (""
    ++ {-# LINE 14 "Emitter.hs.neat" #-}
    "\n  import "
    ++ ({-# LINE 15 "Emitter.hs.neat" #-}
    if (static)
      then (
      {-# LINE 15 "Emitter.hs.neat" #-}
      "static ")
      else "")
    ++ ({-# LINE 15 "Emitter.hs.neat" #-}
    output ( qname ))
    ++ ({-# LINE 15 "Emitter.hs.neat" #-}
    if (wildcard)
      then (
      {-# LINE 15 "Emitter.hs.neat" #-}
      ".*")
      else "")
    ++ {-# LINE 15 "Emitter.hs.neat" #-}
    ";")
    else "")
  ++ {-# LINE 16 "Emitter.hs.neat" #-}
  "\n"
  ++ ({-# LINE 18 "Emitter.hs.neat" #-}
  case (cls) of{-# LINE 18 "Emitter.hs.neat" #-}
  (Class annotations access modifier name parents members) -> (""
    ++ {-# LINE 18 "Emitter.hs.neat" #-}
    "\n    "
    ++ ({-# LINE 19 "Emitter.hs.neat" #-}
    output ( access ))
    ++ {-# LINE 19 "Emitter.hs.neat" #-}
    " "
    ++ ({-# LINE 19 "Emitter.hs.neat" #-}
    output ( modifier ))
    ++ {-# LINE 19 "Emitter.hs.neat" #-}
    " class "
    ++ ({-# LINE 19 "Emitter.hs.neat" #-}
    output ( name ))
    ++ {-# LINE 19 "Emitter.hs.neat" #-}
    ""
    ++ ({-# LINE 20 "Emitter.hs.neat" #-}
    let _l = toList (parents) in if (not . null) _l
      then _l >>= \{-# LINE 20 "Emitter.hs.neat" #-}
    parent -> (""
      ++ {-# LINE 20 "Emitter.hs.neat" #-}
      ""
      ++ ({-# LINE 21 "Emitter.hs.neat" #-}
      case (parent) of{-# LINE 22 "Emitter.hs.neat" #-}
      (Implements interfaces) -> (""
        ++ {-# LINE 22 "Emitter.hs.neat" #-}
        "\n       implements "
        ++ ({-# LINE 23 "Emitter.hs.neat" #-}
        output ( join ", " interfaces ))
        ++ {-# LINE 23 "Emitter.hs.neat" #-}
        ""){-# LINE 24 "Emitter.hs.neat" #-}
      (Extends super) -> (""
        ++ {-# LINE 24 "Emitter.hs.neat" #-}
        "\n       extends "
        ++ ({-# LINE 25 "Emitter.hs.neat" #-}
        output ( super ))
        ++ {-# LINE 25 "Emitter.hs.neat" #-}
        ""))
      ++ {-# LINE 26 "Emitter.hs.neat" #-}
      "")
      else "")
    ++ {-# LINE 27 "Emitter.hs.neat" #-}
    "\n    {"
    ++ ({-# LINE 29 "Emitter.hs.neat" #-}
    let _l = toList (members) in if (not . null) _l
      then _l >>= \{-# LINE 29 "Emitter.hs.neat" #-}
    (Member annotations access element) -> (""
      ++ {-# LINE 29 "Emitter.hs.neat" #-}
      "\n        "
      ++ ({-# LINE 30 "Emitter.hs.neat" #-}
      output ( annotations ))
      ++ {-# LINE 30 "Emitter.hs.neat" #-}
      " "
      ++ ({-# LINE 30 "Emitter.hs.neat" #-}
      output ( access ))
      ++ {-# LINE 30 "Emitter.hs.neat" #-}
      " "
      ++ ({-# LINE 30 "Emitter.hs.neat" #-}
      output ( emit' name element ))
      ++ {-# LINE 30 "Emitter.hs.neat" #-}
      "")
      else "")
    ++ {-# LINE 31 "Emitter.hs.neat" #-}
    "\n    }"))
  ++ {-# LINE 33 "Emitter.hs.neat" #-}
  "\n"){-# LINE 34 "Emitter.hs.neat" #-}


{-# LINE 36 "Emitter.hs.neat" #-}
emit' className element = (""
  ++ {-# LINE 36 "Emitter.hs.neat" #-}
  ""
  ++ ({-# LINE 37 "Emitter.hs.neat" #-}
  case (element) of{-# LINE 38 "Emitter.hs.neat" #-}
  (Constructor arguments body) -> (""
    ++ {-# LINE 38 "Emitter.hs.neat" #-}
    "\n      "
    ++ ({-# LINE 39 "Emitter.hs.neat" #-}
    output ( className ))
    ++ {-# LINE 39 "Emitter.hs.neat" #-}
    "("
    ++ ({-# LINE 39 "Emitter.hs.neat" #-}
    output ( join ", " arguments ))
    ++ {-# LINE 39 "Emitter.hs.neat" #-}
    ")"
    ++ ({-# LINE 39 "Emitter.hs.neat" #-}
    output ( fromMaybe ";" body ))
    ++ {-# LINE 39 "Emitter.hs.neat" #-}
    ""){-# LINE 40 "Emitter.hs.neat" #-}
  (Method qualifier modifier type' name arguments exceptions body) -> (""
    ++ {-# LINE 40 "Emitter.hs.neat" #-}
    "\n      "
    ++ ({-# LINE 41 "Emitter.hs.neat" #-}
    output ( modifier ))
    ++ {-# LINE 41 "Emitter.hs.neat" #-}
    " "
    ++ ({-# LINE 41 "Emitter.hs.neat" #-}
    output ( type' ))
    ++ {-# LINE 41 "Emitter.hs.neat" #-}
    " "
    ++ ({-# LINE 41 "Emitter.hs.neat" #-}
    output ( name ))
    ++ {-# LINE 41 "Emitter.hs.neat" #-}
    "("
    ++ ({-# LINE 41 "Emitter.hs.neat" #-}
    output ( join ", " arguments ))
    ++ {-# LINE 41 "Emitter.hs.neat" #-}
    ")"
    ++ ({-# LINE 42 "Emitter.hs.neat" #-}
    if ((not . null) exceptions)
      then (""
      ++ {-# LINE 42 "Emitter.hs.neat" #-}
      " throws "
      ++ ({-# LINE 42 "Emitter.hs.neat" #-}
      output ( join ", " exceptions ))
      ++ {-# LINE 42 "Emitter.hs.neat" #-}
      " ")
      else "")
    ++ {-# LINE 42 "Emitter.hs.neat" #-}
    "\n      "
    ++ ({-# LINE 43 "Emitter.hs.neat" #-}
    output ( fromMaybe ";" body ))
    ++ {-# LINE 43 "Emitter.hs.neat" #-}
    "")
  _ ->(
    {-# LINE 44 "Emitter.hs.neat" #-}
    "\n    // Unimplemented member type."))
  ++ {-# LINE 46 "Emitter.hs.neat" #-}
  "\n"){-# LINE 47 "Emitter.hs.neat" #-}

