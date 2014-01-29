{-# LINE 1 "Emitter.hs.neat" #-}
module {- Example. -} Java.Emitter where

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



{-
instance Show Type where
{-# LINE 33 "Emitter.hs.neat" #-}
show (Type annotations qualifiers specifiers qname parameters) = (""
  ++ {-# LINE 33 "Emitter.hs.neat" #-}
  "\n"
  ++ ({-# LINE 34 "Emitter.hs.neat" #-}
  format ( join "." qname ))
  ++ {-# LINE 34 "Emitter.hs.neat" #-}
  "\n"){-# LINE 35 "Emitter.hs.neat" #-}

-}

{-# LINE 38 "Emitter.hs.neat" #-}
emit (File path package imports cls) = (""
  ++ {-# LINE 38 "Emitter.hs.neat" #-}
  "\n// Code generated from "
  ++ ({-# LINE 39 "Emitter.hs.neat" #-}
  format ( takeFileName path ))
  ++ {-# LINE 39 "Emitter.hs.neat" #-}
  "\npackage "
  ++ ({-# LINE 40 "Emitter.hs.neat" #-}
  format ( package ))
  ++ {-# LINE 40 "Emitter.hs.neat" #-}
  ";\n\n"
  ++ ({-# LINE 42 "Emitter.hs.neat" #-}
  let _l = toList (imports) in if null _l
    then _l >>= \{-# LINE 42 "Emitter.hs.neat" #-}
  (Import static qname wildcard) -> (""
    ++ {-# LINE 42 "Emitter.hs.neat" #-}
    "\nimport "
    ++ ({-# LINE 43 "Emitter.hs.neat" #-}
    if (static)
      then (
      {-# LINE 43 "Emitter.hs.neat" #-}
      "static ")
      else "")
    ++ ({-# LINE 43 "Emitter.hs.neat" #-}
    format ( qname ))
    ++ ({-# LINE 43 "Emitter.hs.neat" #-}
    if (wildcard)
      then (
      {-# LINE 43 "Emitter.hs.neat" #-}
      ".*")
      else "")
    ++ {-# LINE 43 "Emitter.hs.neat" #-}
    ";\n")
    else "")
  ++ {-# LINE 44 "Emitter.hs.neat" #-}
  "\n\n"
  ++ ({-# LINE 46 "Emitter.hs.neat" #-}
  case (cls) of{-# LINE 46 "Emitter.hs.neat" #-}
  (Class annotations access modifier name parents members) -> (""
    ++ {-# LINE 46 "Emitter.hs.neat" #-}
    "\n"
    ++ ({-# LINE 47 "Emitter.hs.neat" #-}
    format ( access ))
    ++ {-# LINE 47 "Emitter.hs.neat" #-}
    " "
    ++ ({-# LINE 47 "Emitter.hs.neat" #-}
    format ( modifier ))
    ++ {-# LINE 47 "Emitter.hs.neat" #-}
    " class "
    ++ ({-# LINE 47 "Emitter.hs.neat" #-}
    format ( name ))
    ++ {-# LINE 47 "Emitter.hs.neat" #-}
    "\n"
    ++ ({-# LINE 48 "Emitter.hs.neat" #-}
    let _l = toList (parents) in if null _l
      then _l >>= \{-# LINE 48 "Emitter.hs.neat" #-}
    parent -> (""
      ++ {-# LINE 48 "Emitter.hs.neat" #-}
      ""
      ++ ({-# LINE 49 "Emitter.hs.neat" #-}
      case (parent) of{-# LINE 50 "Emitter.hs.neat" #-}
      (Implements interfaces) -> (""
        ++ {-# LINE 50 "Emitter.hs.neat" #-}
        "\n   implements "
        ++ ({-# LINE 51 "Emitter.hs.neat" #-}
        format ( interfaces ))
        ++ {-# LINE 51 "Emitter.hs.neat" #-}
        ""){-# LINE 52 "Emitter.hs.neat" #-}
      (Extends super) -> (""
        ++ {-# LINE 52 "Emitter.hs.neat" #-}
        "\n   extends "
        ++ ({-# LINE 53 "Emitter.hs.neat" #-}
        format ( super ))
        ++ {-# LINE 53 "Emitter.hs.neat" #-}
        ""))
      ++ {-# LINE 54 "Emitter.hs.neat" #-}
      "\n")
      else "")
    ++ {-# LINE 55 "Emitter.hs.neat" #-}
    "\n{"
    ++ ({-# LINE 57 "Emitter.hs.neat" #-}
    let _l = toList (members) in if null _l
      then _l >>= \{-# LINE 57 "Emitter.hs.neat" #-}
    (Member annotations access element) -> (""
      ++ {-# LINE 57 "Emitter.hs.neat" #-}
      ""
      ++ ({-# LINE 58 "Emitter.hs.neat" #-}
      case (element) of{-# LINE 59 "Emitter.hs.neat" #-}
      (Constructor arguments (_, code)) -> (
        {-# LINE 59 "Emitter.hs.neat" #-}
        "\n"){-# LINE 61 "Emitter.hs.neat" #-}
      (Method qualifier modifier type' name arguments exceptions body) -> (
        {-# LINE 61 "Emitter.hs.neat" #-}
        "\n")
      _ ->(
        {-# LINE 63 "Emitter.hs.neat" #-}
        "\n      // Unimplemented member type."))
      ++ {-# LINE 65 "Emitter.hs.neat" #-}
      "")
      else "")
    ++ {-# LINE 66 "Emitter.hs.neat" #-}
    "\n}\n"))
  ++ {-# LINE 68 "Emitter.hs.neat" #-}
  "\n"){-# LINE 69 "Emitter.hs.neat" #-}

