{-# LINE 1 "Emitter.hs.neat" #-}

import Data.Foldable
import Data.List
import Example.Java.AST
import System.FilePath

format x = show x

main = putStrLn $ emit file where
  file = File "Foo.java.neat" (QName ["org.example"]) [] cls
  cls  = Class [] Public Unmodified "Foo" [] []

{-# LINE 13 "Emitter.hs.neat" #-}
emit (File path package imports cls) = (""
  ++ {-# LINE 13 "Emitter.hs.neat" #-}
  "\n  // Code generated from "
  ++ ({-# LINE 14 "Emitter.hs.neat" #-}
  format ( takeFileName path ))
  ++ {-# LINE 14 "Emitter.hs.neat" #-}
  "\n  package "
  ++ ({-# LINE 15 "Emitter.hs.neat" #-}
  format ( package ))
  ++ {-# LINE 15 "Emitter.hs.neat" #-}
  ";\n"
  ++ ({-# LINE 17 "Emitter.hs.neat" #-}
  let _l = toList (imports) in if (not . null) _l
    then _l >>= \{-# LINE 17 "Emitter.hs.neat" #-}
  (Import static qname wildcard) -> (""
    ++ {-# LINE 17 "Emitter.hs.neat" #-}
    "\n  import "
    ++ ({-# LINE 18 "Emitter.hs.neat" #-}
    if (static)
      then (
      {-# LINE 18 "Emitter.hs.neat" #-}
      "static ")
      else "")
    ++ ({-# LINE 18 "Emitter.hs.neat" #-}
    format ( qname ))
    ++ ({-# LINE 18 "Emitter.hs.neat" #-}
    if (wildcard)
      then (
      {-# LINE 18 "Emitter.hs.neat" #-}
      ".*")
      else "")
    ++ {-# LINE 18 "Emitter.hs.neat" #-}
    ";")
    else "")
  ++ {-# LINE 19 "Emitter.hs.neat" #-}
  "\n"
  ++ ({-# LINE 21 "Emitter.hs.neat" #-}
  case (cls) of{-# LINE 21 "Emitter.hs.neat" #-}
  (Class annotations access modifier name parents members) -> (""
    ++ {-# LINE 21 "Emitter.hs.neat" #-}
    "\n    "
    ++ ({-# LINE 22 "Emitter.hs.neat" #-}
    format ( access ))
    ++ {-# LINE 22 "Emitter.hs.neat" #-}
    " "
    ++ ({-# LINE 22 "Emitter.hs.neat" #-}
    format ( modifier ))
    ++ {-# LINE 22 "Emitter.hs.neat" #-}
    " class "
    ++ ({-# LINE 22 "Emitter.hs.neat" #-}
    format ( name ))
    ++ {-# LINE 22 "Emitter.hs.neat" #-}
    ""
    ++ ({-# LINE 23 "Emitter.hs.neat" #-}
    let _l = toList (parents) in if (not . null) _l
      then _l >>= \{-# LINE 23 "Emitter.hs.neat" #-}
    parent -> (""
      ++ {-# LINE 23 "Emitter.hs.neat" #-}
      ""
      ++ ({-# LINE 24 "Emitter.hs.neat" #-}
      case (parent) of{-# LINE 25 "Emitter.hs.neat" #-}
      (Implements interfaces) -> (""
        ++ {-# LINE 25 "Emitter.hs.neat" #-}
        "\n       implements "
        ++ ({-# LINE 26 "Emitter.hs.neat" #-}
        format ( interfaces ))
        ++ {-# LINE 26 "Emitter.hs.neat" #-}
        ""){-# LINE 27 "Emitter.hs.neat" #-}
      (Extends super) -> (""
        ++ {-# LINE 27 "Emitter.hs.neat" #-}
        "\n       extends "
        ++ ({-# LINE 28 "Emitter.hs.neat" #-}
        format ( super ))
        ++ {-# LINE 28 "Emitter.hs.neat" #-}
        ""))
      ++ {-# LINE 29 "Emitter.hs.neat" #-}
      "")
      else "")
    ++ {-# LINE 30 "Emitter.hs.neat" #-}
    "\n    {"
    ++ ({-# LINE 32 "Emitter.hs.neat" #-}
    let _l = toList (members) in if (not . null) _l
      then _l >>= \{-# LINE 32 "Emitter.hs.neat" #-}
    (Member annotations access element) -> (""
      ++ {-# LINE 32 "Emitter.hs.neat" #-}
      ""
      ++ ({-# LINE 33 "Emitter.hs.neat" #-}
      case (element) of{-# LINE 34 "Emitter.hs.neat" #-}
      (Constructor arguments (_, code)) -> (
        {-# LINE 34 "Emitter.hs.neat" #-}
        "\n"){-# LINE 36 "Emitter.hs.neat" #-}
      (Method qualifier modifier type' name arguments exceptions body) -> (
        {-# LINE 36 "Emitter.hs.neat" #-}
        "\n")
      _ ->(
        {-# LINE 38 "Emitter.hs.neat" #-}
        "\n          // Unimplemented member type."))
      ++ {-# LINE 40 "Emitter.hs.neat" #-}
      "")
      else "")
    ++ {-# LINE 41 "Emitter.hs.neat" #-}
    "\n    }"))
  ++ {-# LINE 43 "Emitter.hs.neat" #-}
  "\n"){-# LINE 44 "Emitter.hs.neat" #-}

