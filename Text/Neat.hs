module Text.Neat (File, parseString) where

import Control.Applicative ((<$), (<$>), (<*), (<*>), (*>), (<|>), many, some)
import Data.Char (isSpace)
import Data.List (intercalate, stripPrefix)
import Text.Parsec hiding ((<|>), many, optional)
import Text.Neat.Input


parseString :: String -> String -> File
parseString name input = case runParser file () name input of
    Right result -> result
    Left failure -> error $ "parsing failure at " ++ show failure


bareMarkers    = ("{{", "}}")
commentMarkers = ("{#", "#}")
elementMarkers = ("{%", "%}")


file :: Parsec String () File
file = File <$> block <* eof where
  block = Block <$> many chunk
  chunk = Chunk <$> location <*> element
  element = choice $ try <$> [
    Bare    <$> value' `within` bareMarkers,
    Comment <$> block `within` commentMarkers,
    Define  <$> tag "def"    Name    <*> block              <* end "enddef",
    Filter  <$> tag "filter" Value   <*> block              <* end "endfilter",
    For     <$> tag "for"    binding <*> block <*> else'    <* end "endfor",
    If      <$> tag "if"     Value   <*> block <*> else'    <* end "endif",
    Switch  <$> tag "switch" Value   <*> cases <*> default' <* end "endswitch",
    With    <$> tag "with"   binding <*> block              <* end "endwith",
    Text    <$> (filterText <$> some textChar <*> precedesBare)]

  else'    = optionMaybe . try $ end "else" *> block
  default' = optionMaybe . try $ end "default" *> block
  cases    = spaces *> many (try case') where
    case'  = Case <$> tag "case" Pattern <*> block

  filterText chars True = chars
  filterText chars False = trimTrail chars

  trimTrail s | hasTrail = intercalate "\n" init'
              | otherwise = s where
    (lines', init', last') = (lines s, init lines', last lines')
    hasTrail = length lines' > 1 && not (null last') && all isSpace last'

  precedesBare = option False (True <$ lookAhead bare)
    where bare = try $ string $ fst bareMarkers

  -- TODO: Get location before trimming.
  tag name f = f <$> location <*> ((trim <$> (t *> text)) `within` elementMarkers)
    where t = spaces *> string name <* notFollowedBy letter
  end name = (spaces *> string name <* spaces) `within` elementMarkers

  p `within` (left, right) = between (string left) (string right) p

  text = many textChar
  -- TODO: Get location before trimming.
  value' = Value <$> location <*> (trim <$> text)

  binding l s = case split " in " s of
    [p, v] -> Binding (Pattern l p) (Value l v)
    _      -> case split " as " s of
      [v, p] -> Binding (Pattern l p) (Value l v)
      _      -> case split " = " s of
        [p, v] -> Binding (Pattern l p) (Value l v)
        _      -> error $ "invalid for: " ++ s

  location = locationFrom <$> getPosition where
    locationFrom pos = Location (sourceName pos, sourceLine pos)

  -- TODO: Generate from markers.
  textChar = noneOf "{#%}"
          <|> try (char '{' <* notFollowedBy (oneOf "{#%"))
          <|> try (oneOf "#%}" <* notFollowedBy (char '}'))


split :: Eq a => [a] -> [a] -> [[a]]
split [] l = fmap return l
split _ [] = [] : []
split d  l = case stripPrefix d l of
               Just rest -> [] : split d rest
               Nothing   -> let (x:xs) = l
                             in case split d xs of
                               []     -> [x:xs]
                               (y:ys) -> (x:y):ys


trim :: String -> String
trim = f . f where f = reverse . dropWhile isSpace
