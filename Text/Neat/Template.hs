module Text.Neat.Template where

data Element  = Output Value
              | Comment Block
              | Define Function Block
              | Filter Value Block
              | With Binding Block
              | For Binding Block (Maybe Block)
              | If Value Block (Maybe Block)
              | Switch Value [Case] (Maybe Block)
              | Text String                     deriving (Eq, Ord, Read, Show)
data File     = File String Block               deriving (Eq, Ord, Read, Show)
data Block    = Block [Chunk]                   deriving (Eq, Ord, Read, Show)
data Chunk    = Chunk Location Element          deriving (Eq, Ord, Read, Show)
data Case     = Case Pattern Block              deriving (Eq, Ord, Read, Show)
data Binding  = Binding Pattern Value           deriving (Eq, Ord, Read, Show)
data Location = Location String Int             deriving (Eq, Ord, Read, Show)
data Value    = Value Location Pipeline         deriving (Eq, Ord, Read, Show)
data Pattern  = Pattern Location String         deriving (Eq, Ord, Read, Show)
data Function = Function Location Name Pattern  deriving (Eq, Ord, Read, Show)
type Name     = String
type Pipeline = [String]
