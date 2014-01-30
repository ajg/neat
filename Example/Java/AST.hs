module Example.Java.AST where

data File    = File FilePath QName [Import] Class
data Import  = Import Bool QName Bool
data Type    = Type [Annotation] [Qualifier] [Specifier] QName [Type]
data Kind    = Enum
             | Interface
          -- | Class
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
             | Nested [Modifier] Kind Name [Parent] Body

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
