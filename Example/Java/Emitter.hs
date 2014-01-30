{-# LINE 1 "Emitter.hs.neat" #-}

import Data.Foldable
import Data.List
import Example.Java.AST
import System.FilePath

format x = show x

main = putStrLn $ emit file where
  file = File "Foo.java.neat" (QName ["org.example"]) [] cls
  cls  = Class [] Public Unmodified "Foo" [] []


{-
instance Show Type where
{-# LINE 16 "Emitter.hs.neat" #-}
show (Type annotations qualifiers specifiers qname parameters) = (""
  ++ {-# LINE 16 "Emitter.hs.neat" #-}
  "\n"
  ++ ({-# LINE 17 "Emitter.hs.neat" #-}
  format ( qname | join "." ))
  ++ {-# LINE 17 "Emitter.hs.neat" #-}
  "\n"){-# LINE 18 "Emitter.hs.neat" #-}


join = intercalate
-}

{-# LINE 23 "Emitter.hs.neat" #-}
emit (File path package imports cls) = (""
  ++ {-# LINE 23 "Emitter.hs.neat" #-}
  "\n// Code generated from "
  ++ ({-# LINE 24 "Emitter.hs.neat" #-}
  format ( takeFileName path ))
  ++ {-# LINE 24 "Emitter.hs.neat" #-}
  "\npackage "
  ++ ({-# LINE 25 "Emitter.hs.neat" #-}
  format ( package ))
  ++ {-# LINE 25 "Emitter.hs.neat" #-}
  ";\n\n"
  ++ ({-# LINE 27 "Emitter.hs.neat" #-}
  let _l = toList (imports) in if null _l
    then _l >>= \{-# LINE 27 "Emitter.hs.neat" #-}
  (Import static qname wildcard) -> (""
    ++ {-# LINE 27 "Emitter.hs.neat" #-}
    "\nimport "
    ++ ({-# LINE 28 "Emitter.hs.neat" #-}
    if (static)
      then (
      {-# LINE 28 "Emitter.hs.neat" #-}
      "static ")
      else "")
    ++ ({-# LINE 28 "Emitter.hs.neat" #-}
    format ( qname ))
    ++ ({-# LINE 28 "Emitter.hs.neat" #-}
    if (wildcard)
      then (
      {-# LINE 28 "Emitter.hs.neat" #-}
      ".*")
      else "")
    ++ {-# LINE 28 "Emitter.hs.neat" #-}
    ";\n")
    else "")
  ++ {-# LINE 29 "Emitter.hs.neat" #-}
  "\n\n"
  ++ ({-# LINE 31 "Emitter.hs.neat" #-}
  case (cls) of{-# LINE 31 "Emitter.hs.neat" #-}
  (Class annotations access modifier name parents members) -> (""
    ++ {-# LINE 31 "Emitter.hs.neat" #-}
    "\n"
    ++ ({-# LINE 32 "Emitter.hs.neat" #-}
    format ( access ))
    ++ {-# LINE 32 "Emitter.hs.neat" #-}
    " "
    ++ ({-# LINE 32 "Emitter.hs.neat" #-}
    format ( modifier ))
    ++ {-# LINE 32 "Emitter.hs.neat" #-}
    " class "
    ++ ({-# LINE 32 "Emitter.hs.neat" #-}
    format ( name ))
    ++ {-# LINE 32 "Emitter.hs.neat" #-}
    "\n"
    ++ ({-# LINE 33 "Emitter.hs.neat" #-}
    let _l = toList (parents) in if null _l
      then _l >>= \{-# LINE 33 "Emitter.hs.neat" #-}
    parent -> (""
      ++ {-# LINE 33 "Emitter.hs.neat" #-}
      ""
      ++ ({-# LINE 34 "Emitter.hs.neat" #-}
      case (parent) of{-# LINE 35 "Emitter.hs.neat" #-}
      (Implements interfaces) -> (""
        ++ {-# LINE 35 "Emitter.hs.neat" #-}
        "\n   implements "
        ++ ({-# LINE 36 "Emitter.hs.neat" #-}
        format ( interfaces ))
        ++ {-# LINE 36 "Emitter.hs.neat" #-}
        ""){-# LINE 37 "Emitter.hs.neat" #-}
      (Extends super) -> (""
        ++ {-# LINE 37 "Emitter.hs.neat" #-}
        "\n   extends "
        ++ ({-# LINE 38 "Emitter.hs.neat" #-}
        format ( super ))
        ++ {-# LINE 38 "Emitter.hs.neat" #-}
        ""))
      ++ {-# LINE 39 "Emitter.hs.neat" #-}
      "\n")
      else "")
    ++ {-# LINE 40 "Emitter.hs.neat" #-}
    "\n{"
    ++ ({-# LINE 42 "Emitter.hs.neat" #-}
    let _l = toList (members) in if null _l
      then _l >>= \{-# LINE 42 "Emitter.hs.neat" #-}
    (Member annotations access element) -> (""
      ++ {-# LINE 42 "Emitter.hs.neat" #-}
      ""
      ++ ({-# LINE 43 "Emitter.hs.neat" #-}
      case (element) of{-# LINE 44 "Emitter.hs.neat" #-}
      (Constructor arguments (_, code)) -> (
        {-# LINE 44 "Emitter.hs.neat" #-}
        "\n"){-# LINE 46 "Emitter.hs.neat" #-}
      (Method qualifier modifier type' name arguments exceptions body) -> (
        {-# LINE 46 "Emitter.hs.neat" #-}
        "\n")
      _ ->(
        {-# LINE 48 "Emitter.hs.neat" #-}
        "\n      // Unimplemented member type."))
      ++ {-# LINE 50 "Emitter.hs.neat" #-}
      "")
      else "")
    ++ {-# LINE 51 "Emitter.hs.neat" #-}
    "\n}\n"))
  ++ {-# LINE 53 "Emitter.hs.neat" #-}
  "\n"){-# LINE 54 "Emitter.hs.neat" #-}

