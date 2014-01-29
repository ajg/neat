module Text.Neat (parseFile, parseString) where

import Control.Applicative
import Data.Char (isSpace)
import Data.List (intercalate)
import System.FilePath (takeFileName)
import Text.Parsec hiding ((<|>), many, optional)

data Element  = Actual Value
              | Comment Block
              | Define Name Block
              | Filter Value Block
              | For (Pattern, Value) Block (Maybe Block)
              | If Value Block (Maybe Block)
              | Switch Value [Case] (Maybe Block)
              | Text String                 deriving (Eq, Ord, Read, Show)
data File     = File Block                  deriving (Eq, Ord, Read, Show)
data Block    = Block [Chunk]               deriving (Eq, Ord, Read, Show)
data Chunk    = Chunk Location Element      deriving (Eq, Ord, Read, Show)
data Case     = Case Pattern Block          deriving (Eq, Ord, Read, Show)
data Location = Location (String, Int)      deriving (Eq, Ord, Read, Show)
data Value    = Value Location String       deriving (Eq, Ord, Read, Show)
data Pattern  = Pattern Location String     deriving (Eq, Ord, Read, Show)
data Name     = Name Location String        deriving (Eq, Ord, Read, Show)

class Output a where
  output :: a -> String

parseFile :: FilePath -> IO String
parseFile path = readFile path >>= return . parseString name
  where name = takeFileName path

parseString :: String -> String -> String
parseString name input = case runParser file () name input of
    Right result -> output result
    Left failure -> error ("parsing failure at " ++ show failure)

actualMarkers, commentMarkers, elementMarkers :: (String, String)
actualMarkers  = ("{{", "}}")
commentMarkers = ("{#", "#}")
elementMarkers = ("{%", "%}")

nl, nothing, format :: String
nl      = "\n"
nothing = ['"', '"']
format  = "format"

indent, group :: String -> String
indent  = (++) (nl ++ "  ")
group s = "(" ++ s ++ ")"

nested :: Output a => a -> String
nested = group . nest where
  nest = join (indent "") . lines . output

join :: [a] -> [[a]] -> [a]
join = intercalate

trim :: String -> String
trim = f . f where f = reverse . dropWhile isSpace

split :: [a] -> [a] -> [[a]]
split delim list = error "not implemented"

instance Output File where
  output (File (Block chunks)) = divide chunks where
    divide [] = []
    divide (chunk @ (Chunk location element) : rest) =
      output' element ++ divide rest where
        output' (Text text) = output location ++ text
        output' _ = output chunk

instance Output Block where
  output (Block [chunk]) = nl ++ output chunk
  output (Block chunks) = nothing ++ appendEach (output <$> chunks)
    where appendEach = concatMap $ (++) (nl ++ "++ ")

instance Output Chunk where
  output (Chunk location define @ (Define _ _)) = output location ++ output define
  output (Chunk location text @ (Text _)) = output location ++ output text
  output (Chunk location element) = group $ output location ++ output element

instance Output Name where
  output (Name location name) = {- output location ++ -} name

instance Output Value where
  output (Value location value) = {- output location ++ -} group value

instance Output Pattern where
  output (Pattern location pattern) = {- output location ++ -} pattern

instance Output Location where
  output (Location (file', line)) =
    "{-# LINE " ++ show line ++ " " ++ show file' ++ " #-}" ++ nl

instance Output Element where
  output (Text t)             = show t
  output (Comment _)          = nothing
  output (Actual value)       = format ++ " " ++ output value
  output (Define name block)  = output name ++ " = " ++ nested block
  output (Filter value block) = output value ++ " " ++ nested block

  output (For (pattern, value) block Nothing) =
    output value ++ " >>= \\" ++ output pattern ++ " -> " ++ nested block

  output (For text _ (Just _)) =
    error "not implemented"

  output (If value block else') =
    "if " ++ output value
    ++ indent "then " ++ nested block
    ++ indent "else " ++ maybe nothing nested else'

  output (Switch value cases default') =
    "case " ++ output value ++ " of"
    ++ (output =<< cases)
    ++ maybe "" (("\n_ ->" ++) . nested) default'

instance Output Case where
  output (Case pattern block) =
    output pattern ++ " -> " ++ nested block


file :: Parsec String () File
file = File <$> block <* eof where
  block = Block <$> many chunk
  chunk = Chunk <$> location <*> element
  element = choice $ try <$> [
    Actual  <$> value' `within` actualMarkers,
    Comment <$> block `within` commentMarkers,
    Define  <$> open "def"    name   <*> block <* end "def",
    Filter  <$> open "filter" value  <*> block <* end "filter",
    For     <$> open "for"    clause <*> block <*> else' <* end "for",
    If      <$> open "if"     value  <*> block <*> else' <* end "if",
    Switch  <$> open "switch" value  <*> cases <*> default' <* end "switch",
    Text    <$> (filterText <$> some textChar <*> precedesActual)]

  else'    = optionMaybe . try $ close "else" *> block
  default' = optionMaybe . try $ close "default" *> block
  cases    = spaces *> many (try case') where
    case'  = Case <$> open "case" pattern <*> block

  filterText chars True = chars
  filterText chars False = trimTrail chars

  trimTrail s | hasTrail = join nl init'
              | otherwise = s where
    (lines', init', last') = (lines s, init lines', last lines')
    hasTrail = length lines' > 1 && not (null last') && all isSpace last'

  precedesActual = option False (True <$ lookAhead actual)
    where actual = try $ string $ fst actualMarkers

  open tag f = f <$> location <*> ((trim <$> (t *> text)) `within` elementMarkers)
    where t = spaces *> string tag <* notFollowedBy letter
  close tag = (spaces *> string tag <* spaces) `within` elementMarkers
  end = close . ("end" ++)

  p `within` (left, right) = between (string left) (string right) p

  text = many textChar
  value' = Value <$> location <*> (trim <$> text)

  value = Value
  name = Name
  pattern = Pattern

  clause l s = case split " in " s of
    [p, v] -> (Pattern l p, Value l v)
    _      -> error $ "invalid for: " ++ s

  location = locationFrom <$> getPosition where
    locationFrom pos = Location (sourceName pos, sourceLine pos)

  textChar = noneOf "{#%}"
          <|> try (char '{' <* notFollowedBy (oneOf "{#%"))
          <|> try (oneOf "#%}" <* notFollowedBy (char '}'))
