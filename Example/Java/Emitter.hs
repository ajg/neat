{-# LINE 1 "Emitter.hs.neat" #-}

import Example.Java.AST
import System.FilePath
import Text.Neat

main = putStrLn $ emit sampleFile

{-# LINE 8 "Emitter.hs.neat" #-}
emit (File path package imports cls) = (""
  ++ {-# LINE 8 "Emitter.hs.neat" #-}
  "\n  // Code generated from "
  ++ ({-# LINE 9 "Emitter.hs.neat" #-}
  output ( takeFileName path ))
  ++ {-# LINE 9 "Emitter.hs.neat" #-}
  "\n  package "
  ++ ({-# LINE 10 "Emitter.hs.neat" #-}
  output ( package ))
  ++ {-# LINE 10 "Emitter.hs.neat" #-}
  ";\n"
  ++ ({-# LINE 12 "Emitter.hs.neat" #-}
  let _l = toList (imports) in if (not . null) _l
    then _l >>= \{-# LINE 12 "Emitter.hs.neat" #-}
  (Import static qname wildcard) -> (""
    ++ {-# LINE 12 "Emitter.hs.neat" #-}
    "\n  import "
    ++ ({-# LINE 13 "Emitter.hs.neat" #-}
    if (static)
      then (
      {-# LINE 13 "Emitter.hs.neat" #-}
      "static ")
      else "")
    ++ ({-# LINE 13 "Emitter.hs.neat" #-}
    output ( qname ))
    ++ ({-# LINE 13 "Emitter.hs.neat" #-}
    if (wildcard)
      then (
      {-# LINE 13 "Emitter.hs.neat" #-}
      ".*")
      else "")
    ++ {-# LINE 13 "Emitter.hs.neat" #-}
    ";")
    else "")
  ++ {-# LINE 14 "Emitter.hs.neat" #-}
  "\n"
  ++ ({-# LINE 16 "Emitter.hs.neat" #-}
  case (cls) of{-# LINE 16 "Emitter.hs.neat" #-}
  (Class annotations access modifier name parents members) -> (""
    ++ {-# LINE 16 "Emitter.hs.neat" #-}
    "\n    "
    ++ ({-# LINE 17 "Emitter.hs.neat" #-}
    output ( access ))
    ++ {-# LINE 17 "Emitter.hs.neat" #-}
    " "
    ++ ({-# LINE 17 "Emitter.hs.neat" #-}
    output ( modifier ))
    ++ {-# LINE 17 "Emitter.hs.neat" #-}
    " class "
    ++ ({-# LINE 17 "Emitter.hs.neat" #-}
    output ( name ))
    ++ {-# LINE 17 "Emitter.hs.neat" #-}
    ""
    ++ ({-# LINE 18 "Emitter.hs.neat" #-}
    let _l = toList (parents) in if (not . null) _l
      then _l >>= \{-# LINE 18 "Emitter.hs.neat" #-}
    parent -> (""
      ++ {-# LINE 18 "Emitter.hs.neat" #-}
      ""
      ++ ({-# LINE 19 "Emitter.hs.neat" #-}
      case (parent) of{-# LINE 20 "Emitter.hs.neat" #-}
      (Implements interfaces) -> (""
        ++ {-# LINE 20 "Emitter.hs.neat" #-}
        "\n       implements "
        ++ ({-# LINE 21 "Emitter.hs.neat" #-}
        output ( interfaces ))
        ++ {-# LINE 21 "Emitter.hs.neat" #-}
        ""){-# LINE 22 "Emitter.hs.neat" #-}
      (Extends super) -> (""
        ++ {-# LINE 22 "Emitter.hs.neat" #-}
        "\n       extends "
        ++ ({-# LINE 23 "Emitter.hs.neat" #-}
        output ( super ))
        ++ {-# LINE 23 "Emitter.hs.neat" #-}
        ""))
      ++ {-# LINE 24 "Emitter.hs.neat" #-}
      "")
      else "")
    ++ {-# LINE 25 "Emitter.hs.neat" #-}
    "\n    {"
    ++ ({-# LINE 27 "Emitter.hs.neat" #-}
    let _l = toList (members) in if (not . null) _l
      then _l >>= \{-# LINE 27 "Emitter.hs.neat" #-}
    (Member annotations access element) -> (""
      ++ {-# LINE 27 "Emitter.hs.neat" #-}
      ""
      ++ ({-# LINE 28 "Emitter.hs.neat" #-}
      case (element) of{-# LINE 29 "Emitter.hs.neat" #-}
      (Constructor arguments (_, code)) -> (
        {-# LINE 29 "Emitter.hs.neat" #-}
        "\n"){-# LINE 31 "Emitter.hs.neat" #-}
      (Method qualifier modifier type' name arguments exceptions body) -> (
        {-# LINE 31 "Emitter.hs.neat" #-}
        "\n")
      _ ->(
        {-# LINE 33 "Emitter.hs.neat" #-}
        "\n          // Unimplemented member type."))
      ++ {-# LINE 35 "Emitter.hs.neat" #-}
      "")
      else "")
    ++ {-# LINE 36 "Emitter.hs.neat" #-}
    "\n    }"))
  ++ {-# LINE 38 "Emitter.hs.neat" #-}
  "\n"){-# LINE 39 "Emitter.hs.neat" #-}

