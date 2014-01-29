
module Java.AST where

data File = File FilePath Package [Import] Class
data     Import = Import Bool Trail Bool
data     Package = Package Trail
type         Trail = [Name]
data       Identity = Identity [Link]
type         Name = String
type         Link = (Name, Maybe [Type])
data         Type = Type [Annotation] [Qualifier] Identity [Specifier]
data           Annotation = Annotation Trail (Maybe String)
data           Qualifier = Final | Volatile | Synchronized
data           Specifier = Array
data           Modifier = Static | Abstract | None
data       Kind = Enum | {- Class | -} Interface
data   Class = Class [Annotation] (Maybe Access) Modifier Name [Parent] [Member]
data     Access = Public | Protected | Private
data     Parent = Implements [Identity]
                | Extends    Identity
data     Member = Member [Annotation] (Maybe Access) Element
data       Element = Enumeration Name [Enumerator]
                   | Constructor [Argument] Block
                   | Field  Qualifier Modifier Type Name (Maybe Value)
                   | Method Qualifier Modifier Type Name [Argument] [Exception] Body
                   | Nested [Modifier] Kind Name [Parent] Body
data         Enumerator = Enumerator Name (Maybe Integer)
data         Argument = Argument Type Name
data         Exception = Exception Type
type         Value = String
type         Body = Maybe Block
type         Block = (Position, String)
data           Position = Position {row, column :: Int}
