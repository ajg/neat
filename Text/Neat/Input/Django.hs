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
    Bare    <$> expr  `within` bareMarkers,
    Comment <$> block `within` commentMarkers,
    Define  <$> tag "def"    function <*> block              <* end "enddef",
    Filter  <$> tag "filter" value    <*> block              <* end "endfilter",
    For     <$> tag "for"    binding  <*> block <*> else'    <* end "endfor",
    If      <$> tag "if"     value    <*> block <*> else'    <* end "endif",
    Switch  <$> tag "switch" value    <*> cases <*> default' <* end "endswitch",
    With    <$> tag "with"   binding  <*> block              <* end "endwith",
    Text    <$> some textChar]

  expr     = value <$> location <*> trimmedText
  else'    = optionMaybe . try $ end "else" *> block
  default' = optionMaybe . try $ end "default" *> block
  cases    = spaces *> many (try case') where
    case'  = Case <$> tag "case" Pattern <*> block

  tag name f = let t = keyword name *> trimmedText
                in f <$> location <*> (t `within` elementMarkers)
  end name = keyword name `within` elementMarkers
  keyword k = string k <* notFollowedBy nameChar <* spaces

  p `within` (left, right) =
    between (string left <* spaces) (spaces *> string right) p

  trimmedText = spaces *> (trim <$> many textChar)
  trim = reverse . dropWhile isSpace . reverse . dropWhile isSpace

  value l s    = Value l (trim <$> split "|" s)
  function l s = Function l n (Pattern l p) where (n, p) = span isName s
  binding  l s = case split " in " s of
    [p, v] -> Binding (Pattern l (trim p)) (value l v)
    _      -> case split " as " s of
      [v, p] -> Binding (Pattern l (trim p)) (value l v)
      _      -> case split "=" s of
        [p, v] -> Binding (Pattern l (trim p)) (value l v)
        _      -> error $ "invalid for: " ++ s

  isName c = isAlphaNum c || c `elem` "'_"
  nameChar = alphaNum <|> oneOf "'_"
  textChar = noneOf "{#%}" -- TODO: Generate this from markers.
          <|> try (char '{' <* notFollowedBy (oneOf "{#%"))
          <|> try (oneOf "#%}" <* notFollowedBy (char '}'))
  location = f <$> getPosition
    where f p = Location (sourceName p) (sourceLine p)
