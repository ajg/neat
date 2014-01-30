{-# LINE 1 "Emitter.hs.neat" #-}

import Data.Foldable
import Data.List
import {- Example. -} Java.AST
import System.FilePath

format :: Show a => a -> String
format = show
join = intercalate

instance Show QName where
  show (QName names) = join "." names

instance Show Type where
  show (Type annotations qualifiers specifiers qname parameters) = show qname

instance Show Access where
  show Public    = "public"
  show Private   = "private"
  show Protected = "protected"
  show Package   = ""

instance Show Modifier where
  show Static     = "static"
  show Abstract   = "abstract"
  show Unmodified = ""

main = putStrLn $ emit file where
  file = File "Foo.java.neat" (QName ["org.example"]) [] cls
  cls  = Class [] Public Unmodified "Foo" [] []


{-
instance Show Type where
{-# LINE 35 "Emitter.hs.neat" #-}
show (Type annotations qualifiers specifiers qname parameters) = (""
  ++ {-# LINE 35 "Emitter.hs.neat" #-}
  "\n"
  ++ ({-# LINE 36 "Emitter.hs.neat" #-}
  format ( qname | join "." ))
  ++ {-# LINE 36 "Emitter.hs.neat" #-}
  "\n"){-# LINE 37 "Emitter.hs.neat" #-}

-}

{-# LINE 40 "Emitter.hs.neat" #-}
emit (File path package imports cls) = (""
  ++ {-# LINE 40 "Emitter.hs.neat" #-}
  "\n// Code generated from "
  ++ ({-# LINE 41 "Emitter.hs.neat" #-}
  format ( takeFileName path ))
  ++ {-# LINE 41 "Emitter.hs.neat" #-}
  "\npackage "
  ++ ({-# LINE 42 "Emitter.hs.neat" #-}
  format ( package ))
  ++ {-# LINE 42 "Emitter.hs.neat" #-}
  ";\n\n"
  ++ ({-# LINE 44 "Emitter.hs.neat" #-}
  let _l = toList (imports) in if null _l
    then _l >>= \{-# LINE 44 "Emitter.hs.neat" #-}
  (Import static qname wildcard) -> (""
    ++ {-# LINE 44 "Emitter.hs.neat" #-}
    "\nimport "
    ++ ({-# LINE 45 "Emitter.hs.neat" #-}
    if (static)
      then (
      {-# LINE 45 "Emitter.hs.neat" #-}
      "static ")
      else "")
    ++ ({-# LINE 45 "Emitter.hs.neat" #-}
    format ( qname ))
    ++ ({-# LINE 45 "Emitter.hs.neat" #-}
    if (wildcard)
      then (
      {-# LINE 45 "Emitter.hs.neat" #-}
      ".*")
      else "")
    ++ {-# LINE 45 "Emitter.hs.neat" #-}
    ";\n")
    else "")
  ++ {-# LINE 46 "Emitter.hs.neat" #-}
  "\n\n"
  ++ ({-# LINE 48 "Emitter.hs.neat" #-}
  case (cls) of{-# LINE 48 "Emitter.hs.neat" #-}
  (Class annotations access modifier name parents members) -> (""
    ++ {-# LINE 48 "Emitter.hs.neat" #-}
    "\n"
    ++ ({-# LINE 49 "Emitter.hs.neat" #-}
    format ( access ))
    ++ {-# LINE 49 "Emitter.hs.neat" #-}
    " "
    ++ ({-# LINE 49 "Emitter.hs.neat" #-}
    format ( modifier ))
    ++ {-# LINE 49 "Emitter.hs.neat" #-}
    " class "
    ++ ({-# LINE 49 "Emitter.hs.neat" #-}
    format ( name ))
    ++ {-# LINE 49 "Emitter.hs.neat" #-}
    "\n"
    ++ ({-# LINE 50 "Emitter.hs.neat" #-}
    let _l = toList (parents) in if null _l
      then _l >>= \{-# LINE 50 "Emitter.hs.neat" #-}
    parent -> (""
      ++ {-# LINE 50 "Emitter.hs.neat" #-}
      ""
      ++ ({-# LINE 51 "Emitter.hs.neat" #-}
      case (parent) of{-# LINE 52 "Emitter.hs.neat" #-}
      (Implements interfaces) -> (""
        ++ {-# LINE 52 "Emitter.hs.neat" #-}
        "\n   implements "
        ++ ({-# LINE 53 "Emitter.hs.neat" #-}
        format ( interfaces ))
        ++ {-# LINE 53 "Emitter.hs.neat" #-}
        ""){-# LINE 54 "Emitter.hs.neat" #-}
      (Extends super) -> (""
        ++ {-# LINE 54 "Emitter.hs.neat" #-}
        "\n   extends "
        ++ ({-# LINE 55 "Emitter.hs.neat" #-}
        format ( super ))
        ++ {-# LINE 55 "Emitter.hs.neat" #-}
        ""))
      ++ {-# LINE 56 "Emitter.hs.neat" #-}
      "\n")
      else "")
    ++ {-# LINE 57 "Emitter.hs.neat" #-}
    "\n{"
    ++ ({-# LINE 59 "Emitter.hs.neat" #-}
    let _l = toList (members) in if null _l
      then _l >>= \{-# LINE 59 "Emitter.hs.neat" #-}
    (Member annotations access element) -> (""
      ++ {-# LINE 59 "Emitter.hs.neat" #-}
      ""
      ++ ({-# LINE 60 "Emitter.hs.neat" #-}
      case (element) of{-# LINE 61 "Emitter.hs.neat" #-}
      (Constructor arguments (_, code)) -> (
        {-# LINE 61 "Emitter.hs.neat" #-}
        "\n"){-# LINE 63 "Emitter.hs.neat" #-}
      (Method qualifier modifier type' name arguments exceptions body) -> (
        {-# LINE 63 "Emitter.hs.neat" #-}
        "\n")
      _ ->(
        {-# LINE 65 "Emitter.hs.neat" #-}
        "\n      // Unimplemented member type."))
      ++ {-# LINE 67 "Emitter.hs.neat" #-}
      "")
      else "")
    ++ {-# LINE 68 "Emitter.hs.neat" #-}
    "\n}\n"))
  ++ {-# LINE 70 "Emitter.hs.neat" #-}
  "\n"){-# LINE 71 "Emitter.hs.neat" #-}

