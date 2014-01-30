{-# LINE 1 "Emitter.hs.neat" #-}

import Example.Java.AST
import System.FilePath
import Text.Neat

main = putStrLn (emit sampleFile)


{-# LINE 9 "Emitter.hs.neat" #-}
emit (File path package imports cls) = (""
  ++ {-# LINE 9 "Emitter.hs.neat" #-}
  "\n  // Code generated from "
  ++ ({-# LINE 10 "Emitter.hs.neat" #-}
  output ( takeFileName path ))
  ++ {-# LINE 10 "Emitter.hs.neat" #-}
  "\n  package "
  ++ ({-# LINE 11 "Emitter.hs.neat" #-}
  output ( package ))
  ++ {-# LINE 11 "Emitter.hs.neat" #-}
  ";\n"
  ++ ({-# LINE 13 "Emitter.hs.neat" #-}
  let _l = toList (imports) in if (not . null) _l
    then _l >>= \{-# LINE 13 "Emitter.hs.neat" #-}
  (Import static qname wildcard) -> (""
    ++ {-# LINE 13 "Emitter.hs.neat" #-}
    "\n  import "
    ++ ({-# LINE 14 "Emitter.hs.neat" #-}
    if (static)
      then (
      {-# LINE 14 "Emitter.hs.neat" #-}
      "static ")
      else "")
    ++ ({-# LINE 14 "Emitter.hs.neat" #-}
    output ( qname ))
    ++ ({-# LINE 14 "Emitter.hs.neat" #-}
    if (wildcard)
      then (
      {-# LINE 14 "Emitter.hs.neat" #-}
      ".*")
      else "")
    ++ {-# LINE 14 "Emitter.hs.neat" #-}
    ";")
    else "")
  ++ {-# LINE 15 "Emitter.hs.neat" #-}
  "\n"
  ++ ({-# LINE 17 "Emitter.hs.neat" #-}
  case (cls) of{-# LINE 17 "Emitter.hs.neat" #-}
  (Class annotations access modifier name parents members) -> (""
    ++ {-# LINE 17 "Emitter.hs.neat" #-}
    "\n    "
    ++ ({-# LINE 18 "Emitter.hs.neat" #-}
    output ( access ))
    ++ {-# LINE 18 "Emitter.hs.neat" #-}
    " "
    ++ ({-# LINE 18 "Emitter.hs.neat" #-}
    output ( modifier ))
    ++ {-# LINE 18 "Emitter.hs.neat" #-}
    " class "
    ++ ({-# LINE 18 "Emitter.hs.neat" #-}
    output ( name ))
    ++ {-# LINE 18 "Emitter.hs.neat" #-}
    ""
    ++ ({-# LINE 19 "Emitter.hs.neat" #-}
    let _l = toList (parents) in if (not . null) _l
      then _l >>= \{-# LINE 19 "Emitter.hs.neat" #-}
    parent -> (""
      ++ {-# LINE 19 "Emitter.hs.neat" #-}
      ""
      ++ ({-# LINE 20 "Emitter.hs.neat" #-}
      case (parent) of{-# LINE 21 "Emitter.hs.neat" #-}
      (Implements interfaces) -> (""
        ++ {-# LINE 21 "Emitter.hs.neat" #-}
        "\n       implements "
        ++ ({-# LINE 22 "Emitter.hs.neat" #-}
        output ( interfaces ))
        ++ {-# LINE 22 "Emitter.hs.neat" #-}
        ""){-# LINE 23 "Emitter.hs.neat" #-}
      (Extends super) -> (""
        ++ {-# LINE 23 "Emitter.hs.neat" #-}
        "\n       extends "
        ++ ({-# LINE 24 "Emitter.hs.neat" #-}
        output ( super ))
        ++ {-# LINE 24 "Emitter.hs.neat" #-}
        ""))
      ++ {-# LINE 25 "Emitter.hs.neat" #-}
      "")
      else "")
    ++ {-# LINE 26 "Emitter.hs.neat" #-}
    "\n    {"
    ++ ({-# LINE 28 "Emitter.hs.neat" #-}
    let _l = toList (members) in if (not . null) _l
      then _l >>= \{-# LINE 28 "Emitter.hs.neat" #-}
    (Member annotations access element) -> (""
      ++ {-# LINE 28 "Emitter.hs.neat" #-}
      ""
      ++ ({-# LINE 29 "Emitter.hs.neat" #-}
      case (element) of{-# LINE 30 "Emitter.hs.neat" #-}
      (Constructor arguments (_, code)) -> (
        {-# LINE 30 "Emitter.hs.neat" #-}
        "\n"){-# LINE 32 "Emitter.hs.neat" #-}
      (Method qualifier modifier type' name arguments exceptions body) -> (
        {-# LINE 32 "Emitter.hs.neat" #-}
        "\n")
      _ ->(
        {-# LINE 34 "Emitter.hs.neat" #-}
        "\n          // Unimplemented member type."))
      ++ {-# LINE 36 "Emitter.hs.neat" #-}
      "")
      else "")
    ++ {-# LINE 37 "Emitter.hs.neat" #-}
    "\n    }"))
  ++ {-# LINE 39 "Emitter.hs.neat" #-}
  "\n"){-# LINE 40 "Emitter.hs.neat" #-}

