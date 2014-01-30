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
             | Constructor [Argument] Block
             | Field  Qualifier Modifier Type Name (Maybe Value)
             | Method Qualifier Modifier Type Name [Argument] [Exception] Body

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

data QName    = QName [Name]
type Name     = String
type Value    = String
type Body     = Maybe Block
type Block    = (Position, String)
data Position = Position {row, column :: Int}

sampleFile = File "Foo.java.neat" (QName ["org.example"]) [] cls
  where cls = Class [] Public Unmodified "Foo" [] []

instance Output QName where
  output (QName names) = intercalate "." names

instance Output Type where
  output (Type annotations qualifiers specifiers qname parameters) =
    output qname

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
