module Example.Java.AST where

import Data.List
import Text.Neat

data File    = File FilePath QName [Import] Class
data Import  = Import Bool QName Bool
data Type    = Type [Annotation] [Qualifier] [Specifier] QName [Type]
data Class   = Class [Annotation] Access Modifier Name [Parent] [Member]
data Access  = Public
             | Protected
             | Private
             | Package
data Parent  = Implements [Type]
             | Extends Type
data Member  = Member [Annotation] Access Element
data Element = Enumeration Name [Enumerator]
             | Constructor [Argument] Body
             | Field  Qualifier Modifier Type Name (Maybe Value)
             | Method Qualifier Modifier Type Name [Argument] [Exception] Body

data QName = QName [Name]
type Name  = String
type Value = String
type Body  = Maybe String

data Qualifier  = Final
                | Volatile
                | Synchronized
data Specifier  = Array
data Modifier   = Static
                | Abstract
                | Unmodified
data Annotation = Annotation QName (Maybe String)
data Enumerator = Enumerator Name (Maybe Integer)
data Argument   = Argument Type Name
data Exception  = Exception Type


sampleFile = File "Foo.java.neat" (QName ["org.example"]) [] cls
  where cls  = Class [] Public Unmodified "Foo" [Extends bar] [Member [] Public ctor]
        bar  = Type [] [] [] (QName ["Bar"]) []
        int  = Type [] [] [] (QName ["int"]) []
        ctor = Constructor [Argument int "i"] (Just "{}")

instance Output QName where
  output (QName names) = intercalate "." names

instance Output Type where
  output (Type annotations qualifiers specifiers qname parameters) =
    output qname

instance Output Argument where
  output (Argument type' name) =
    output type' ++ " " ++ output name

instance Output Exception where
  output (Exception type') = output type'

instance Output Annotation where
  output (Annotation qname clause) =
    "@" ++ output qname ++ " " ++ output clause

instance Output Char where
  output = return

instance Output Access where
  output Public    = "public"
  output Private   = "private"
  output Protected = "protected"
  output Package   = ""

instance Output Modifier where
  output Static     = "static"
  output Abstract   = "abstract"
  output Unmodified = ""
