module Text.Neat (parseFile, parseString) where

import Control.Applicative
import Data.Char (isSpace)
import Data.List (intercalate)
import System.FilePath (takeFileName)
import Text.Parsec hiding ((<|>), many, optional)

data File     = File Block                 deriving (Eq, Ord, Read, Show)
data Block    = Block [Chunk]              deriving (Eq, Ord, Read, Show)
data Chunk    = Chunk Location Element     deriving (Eq, Ord, Read, Show)
data Value    = Value String               deriving (Eq, Ord, Read, Show)
data Case     = Case Location String Block deriving (Eq, Ord, Read, Show)
data Location = Location (String, Int)     deriving (Eq, Ord, Read, Show)
data Element  = Actual Value
              | Comment Block
              | Define String Block
              | Filter Value Block
              | For String Block (Maybe Block)
              | If Value Block (Maybe Block)
              | Switch Value [Case] (Maybe Block)
              | Text String
  deriving (Eq, Ord, Read, Show)


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

lambda, match :: String -> Block -> String
lambda name block   = ">>= \\" ++ name ++ " -> " ++ nested block
match pattern block = " " ++ pattern ++ " -> " ++ nested block

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

instance Output Value where
  output (Value text) = group text

instance Output Location where
  output (Location (file', line)) =
    "{-# LINE " ++ show line ++ " " ++ show file' ++ " #-}" ++ nl

instance Output Element where
  output (Text text)          = show text
  output (Comment _)          = nothing
  output (Actual value)       = format ++ " " ++ output value
  output (Define text block)  = text ++ " = " ++ nested block
  output (Filter value block) = output value ++ " " ++ nested block

  output (For text block Nothing) =
    case split " in " text of
      [name, value] -> group value ++ " " ++ lambda name block
      _             -> error $ "invalid for: " ++ text

  output (For _ _ (Just _)) =
    error "not implemented"

  output (If value block else') =
    "if " ++ output value
    ++ indent "then " ++ nested block
    ++ indent "else " ++ maybe nothing nested else'

  output (Switch value cases default') =
    "case " ++ output value ++ " of"
    ++ (output =<< cases)
    ++ maybe "" (("\n" ++) . match "_") default'

instance Output Case where
  output (Case location pattern block) =
    output location ++ match pattern block


file :: Parsec String () File
file = File <$> block <* eof where
  block = Block <$> many chunk
  chunk = Chunk <$> location <*> element
  element = choice $ try <$> [
    Actual  <$> value `within` actualMarkers,
    Comment <$> block `within` commentMarkers,
    Define  <$> opening  "def"    <*> block <* closing "enddef",
    Filter  <$> opening' "filter" <*> block <* closing "endfilter",
    For     <$> opening  "for"    <*> block <*> else' <* closing "endfor",
    If      <$> opening' "if"     <*> block <*> else' <* closing "endif",
    Switch  <$> opening' "switch" <*> cases <*> default' <* closing "endswitch",
    Text    <$> (filterText <$> some textChar <*> precedesActual)]

  cases = spaces *> many (try case')
  case' = Case <$> location <*> opening "case" <*> block
  else' = optionMaybe . try $ closing "else" *> block
  default' = optionMaybe . try $ closing "default" *> block

  filterText chars True = chars
  filterText chars False = trimTrail chars

  trimTrail s | hasTrail = join nl init'
              | otherwise = s where
    (lines', init', last') = (lines s, init lines', last lines')
    hasTrail = length lines' > 1 && not (null last') && all isSpace last'

  precedesActual = option False (True <$ lookAhead actual)
    where actual = try $ string $ fst actualMarkers

  opening' = (Value <$>) . opening
  opening name = (trim <$> (t *> text)) `within` elementMarkers
    where t = spaces *> string name <* notFollowedBy letter
  closing name = (spaces *> string name <* spaces) `within` elementMarkers
  p `within` (left, right) = between (string left) (string right) p

  text = many textChar
  value = Value <$> trim <$> text

  location = locationFrom <$> getPosition where
    locationFrom pos = Location (sourceName pos, sourceLine pos)

  textChar = noneOf "{#%}"
          <|> try (char '{' <* notFollowedBy (oneOf "{#%"))
          <|> try (oneOf "#%}" <* notFollowedBy (char '}'))
