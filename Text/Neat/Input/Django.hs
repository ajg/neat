module Text.Neat.Input.Django (input) where

import Control.Applicative ((<$), (<$>), (<*), (<*>), (*>), (<|>), many, some)
import Data.Char (isAlphaNum, isSpace)
import Data.List (intercalate, span)
import Text.Parsec hiding ((<|>), many, optional)
import Text.Neat.File
import Text.Neat.Input


input :: String -> String -> File
input path string = case runParser (file path) () path string of
    Right result -> result
    Left failure -> error $ "parsing failure at " ++ show failure


bareMarkers    = ("{{", "}}")
commentMarkers = ("{#", "#}")
elementMarkers = ("{%", "%}")


file :: String -> Parsec String () File
file path = File path <$> block <* eof where
  block = Block <$> many chunk
  chunk = Chunk <$> location <*> element
  element = choice $ try <$> [
    Bare    <$> value `within` bareMarkers,
    Comment <$> block `within` commentMarkers,
    Define  <$> tag "def"    function <*> block              <* end "enddef",
    Filter  <$> tag "filter" Value    <*> block              <* end "endfilter",
    For     <$> tag "for"    binding  <*> block <*> else'    <* end "endfor",
    If      <$> tag "if"     Value    <*> block <*> else'    <* end "endif",
    Switch  <$> tag "switch" Value    <*> cases <*> default' <* end "endswitch",
    With    <$> tag "with"   binding  <*> block              <* end "endwith",
    Text    <$> some textChar]
 -- Text    <$> (filterText <$> some textChar <*> precedesBare)]

  else'    = optionMaybe . try $ end "else" *> block
  default' = optionMaybe . try $ end "default" *> block
  cases    = spaces *> many (try case') where
    case'  = Case <$> tag "case" Pattern <*> block

  {-
  filterText chars True = chars
  filterText chars False = trimTrail chars

  trimTrail s | hasTrail = intercalate "\n" init'
              | otherwise = s where
    (lines', init', last') = (lines s, init lines', last lines')
    hasTrail = length lines' > 1 && not (null last') && all isSpace last'

  precedesBare = option False (True <$ lookAhead bare)
    where bare = try $ string $ fst bareMarkers
  -}

  tag name f = let t = keyword name *> trimmedText
                in f <$> location <*> (t `within` elementMarkers)
  end name = keyword name `within` elementMarkers
  keyword k = string k <* notFollowedBy nameChar <* spaces

  p `within` (left, right) =
    between (string left <* spaces) (spaces *> string right) p

  trimmedText = spaces *> (rtrim <$> many textChar)
  value = Value <$> location <*> trimmedText
  rtrim = reverse . dropWhile isSpace . reverse

  function l s = Function l name (Pattern l rest)
    where (name, rest) = span isName s
  binding  l s = case split " in " s of
    [p, v] -> Binding (Pattern l p) (Value l v)
    _      -> case split " as " s of
      [v, p] -> Binding (Pattern l p) (Value l v)
      _      -> case split " = " s of
        [p, v] -> Binding (Pattern l p) (Value l v)
        _      -> error $ "invalid for: " ++ s

  isName c = isAlphaNum c || c `elem` "'_"
  nameChar = alphaNum <|> oneOf "'_"
  textChar = noneOf "{#%}" -- TODO: Generate this from markers.
          <|> try (char '{' <* notFollowedBy (oneOf "{#%"))
          <|> try (oneOf "#%}" <* notFollowedBy (char '}'))
  location = f <$> getPosition
    where f p = Location (sourceName p) (sourceLine p)
