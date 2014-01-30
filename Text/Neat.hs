module Text.Neat (parseString) where

import Control.Applicative hiding (empty)
import Data.Char (isSpace)
import Data.List (intercalate, isPrefixOf, stripPrefix)
import Text.Parsec hiding ((<|>), many, optional)

parseString :: String -> String -> String
parseString name input = case runParser file () name input of
    Right result -> output result
    Left failure -> error ("parsing failure at " ++ show failure)

data Element  = Actual Value
              | Comment Block
              | Define Name Block
              | Filter Value Block
              | With Binding Block
              | For Binding Block (Maybe Block)
              | If Value Block (Maybe Block)
              | Switch Value [Case] (Maybe Block)
              | Text String                 deriving (Eq, Ord, Read, Show)
data File     = File Block                  deriving (Eq, Ord, Read, Show)
data Block    = Block [Chunk]               deriving (Eq, Ord, Read, Show)
data Chunk    = Chunk Location Element      deriving (Eq, Ord, Read, Show)
data Case     = Case Pattern Block          deriving (Eq, Ord, Read, Show)
data Binding  = Binding Pattern Value       deriving (Eq, Ord, Read, Show)
data Location = Location (String, Int)      deriving (Eq, Ord, Read, Show)
data Value    = Value Location String       deriving (Eq, Ord, Read, Show)
data Pattern  = Pattern Location String     deriving (Eq, Ord, Read, Show)
data Name     = Name Location String        deriving (Eq, Ord, Read, Show)

class Output a where
  output :: a -> String

actualMarkers, commentMarkers, elementMarkers :: (String, String)
actualMarkers  = ("{{", "}}")
commentMarkers = ("{#", "#}")
elementMarkers = ("{%", "%}")

prelude   = ""
interlude = "" -- TODO: "import Data.Foldable (toList)\n\n"
postlude  = ""

instance Output File where
  output (File (Block chunks)) = prelude ++ divide chunks ++ postlude where
    divide [] = []
    divide (chunk @ (Chunk location element) : rest) =
      output' element ++ interlude ++ divide rest where
        output' (Text text) = output location ++ text
        output' _ = output chunk

instance Output Block where
  output (Block chunks) = "(" ++ (nested $ case chunks of
      [chunk] -> nl ++ output chunk
      _       -> empty ++ appendEach (output <$> chunks)) ++ ")"
    where appendEach = concatMap $ (++) (nl ++ "++ ")
          nested = join (indent "") . lines

instance Output Chunk where
  output (Chunk location define @ (Define _ _)) = output location ++ output define
  output (Chunk location text @ (Text _)) = output location ++ output text
  output (Chunk location element) = "(" ++ output location ++ output element ++ ")"

instance Output Name where
  output (Name location name) = {- output location ++ -} name

instance Output Value where
  output (Value location value) = {- output location ++ -} "(" ++ value ++ ")"

instance Output Pattern where
  output (Pattern location pattern) = output location ++ pattern

instance Output Location where
  output (Location (file, line)) =
    "{-# LINE " ++ show line ++ " " ++ show file ++ " #-}" ++ nl

instance Output Element where
  output (Text text)          = show text
  output (Comment _)          = empty
  output (Actual value)       = format ++ " " ++ output value
  output (Define name block)  = output name ++ " = " ++ output block
  output (Filter value block) = output value ++ " " ++ output block

  output (For (Binding pattern value) block else') =
    "let _l = toList " ++ output value ++ " in if (not . null) _l"
    ++ indent "then _l >>= \\" ++ output pattern ++ " -> " ++ output block
    ++ indent "else " ++ maybe empty output else'

  output (If value block else') =
    "if " ++ output value
    ++ indent "then " ++ output block
    ++ indent "else " ++ maybe empty output else'

  output (With (Binding pattern value) block) =
    "case " ++ output value ++ " of"
    ++ output pattern ++ " -> " ++ output block

  output (Switch value cases default') =
    "case " ++ output value ++ " of"
    ++ (output =<< cases)
    ++ maybe "" (("\n_ ->" ++) . output) default'

instance Output Case where
  output (Case pattern block) =
    output pattern ++ " -> " ++ output block


nl, empty, format :: String
nl     = "\n"
empty  = "\"\""
format = "format"

indent :: String -> String
indent  = (++) (nl ++ "  ")

join :: [a] -> [[a]] -> [a]
join = intercalate

trim :: String -> String
trim = f . f where f = reverse . dropWhile isSpace

split :: Eq a => [a] -> [a] -> [[a]]
split [] l = return <$> l
split _ [] = [] : []
split d  l = case stripPrefix d l of
               Just rest -> [] : split d rest
               Nothing   -> let (x:xs) = l
                             in case split d xs of
                               []     -> [x:xs]
                               (y:ys) -> (x:y):ys

file :: Parsec String () File
file = File <$> block <* eof where
  block = Block <$> many chunk
  chunk = Chunk <$> location <*> element
  element = choice $ try <$> [
    Actual  <$> value' `within` actualMarkers,
    Comment <$> block `within` commentMarkers,
    Define  <$> open "def"    Name    <*> block              <* end "def",
    Filter  <$> open "filter" Value   <*> block              <* end "filter",
    With    <$> open "with"   binding <*> block              <* end "with",
    For     <$> open "for"    binding <*> block <*> else'    <* end "for",
    If      <$> open "if"     Value   <*> block <*> else'    <* end "if",
    Switch  <$> open "switch" Value   <*> cases <*> default' <* end "switch",
    Text    <$> (filterText <$> some textChar <*> precedesActual)]

  else'    = optionMaybe . try $ close "else" *> block
  default' = optionMaybe . try $ close "default" *> block
  cases    = spaces *> many (try case') where
    case'  = Case <$> open "case" Pattern <*> block

  filterText chars True = chars
  filterText chars False = trimTrail chars

  trimTrail s | hasTrail = join nl init'
              | otherwise = s where
    (lines', init', last') = (lines s, init lines', last lines')
    hasTrail = length lines' > 1 && not (null last') && all isSpace last'

  precedesActual = option False (True <$ lookAhead actual)
    where actual = try $ string $ fst actualMarkers

  -- TODO: Get location before trimming.
  open tag f = f <$> location <*> ((trim <$> (t *> text)) `within` elementMarkers)
    where t = spaces *> string tag <* notFollowedBy letter
  close tag = (spaces *> string tag <* spaces) `within` elementMarkers
  end = close . ("end" ++)

  p `within` (left, right) = between (string left) (string right) p

  text = many textChar
  -- TODO: Get location before trimming.
  value' = Value <$> location <*> ({-trim <$> -}text)

  binding l s = case split " in " s of
    [p, v] -> Binding (Pattern l p) (Value l v)
    _      -> case split " as " s of
      [v, p] -> Binding (Pattern l p) (Value l v)
      _      -> case split " = " s of
        [p, v] -> Binding (Pattern l p) (Value l v)
        _      -> error $ "invalid for: " ++ s

  location = locationFrom <$> getPosition where
    locationFrom pos = Location (sourceName pos, sourceLine pos)

  textChar = noneOf "{#%}"
          <|> try (char '{' <* notFollowedBy (oneOf "{#%"))
          <|> try (oneOf "#%}" <* notFollowedBy (char '}'))
