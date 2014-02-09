{-# LINE 1 "Page.hs.neat" #-}
-- Copyright 2014 Alvaro J. Genial (http://alva.ro) -- see LICENSE.md for more.

module Example.HTML.Page where

import Example.HTML.Post
import Text.Neat.Output

generatePage (Post author subject paragraphs) = ({-# LINE 8 "Page.hs.neat" #-}
  "\n<!-- This code was automatically generated using Neat. -->\n<!DOCTYPE html>\n<html>\n  <head>\n    <title>" ++ ({-# LINE 13 "Page.hs.neat" #-}
  output (subject)) ++ {-# LINE 13 "Page.hs.neat" #-}
  " - Posts</title>\n  </head>\n  <body>\n    <h1>" ++ ({-# LINE 16 "Page.hs.neat" #-}
  output (subject)) ++ {-# LINE 16 "Page.hs.neat" #-}
  "</h1>\n" ++ ({-# LINE 18 "Page.hs.neat" #-}
  if (not . zero) (author)
    then ({-# LINE 18 "Page.hs.neat" #-}
    "\n      <h2>By " ++ ({-# LINE 19 "Page.hs.neat" #-}
    output (safe $ author)) ++ {-# LINE 19 "Page.hs.neat" #-}
    "</h2>")
    else ({-# LINE 20 "Page.hs.neat" #-}
    "\n      <h2>Anonymous</h2>")) ++ {-# LINE 22 "Page.hs.neat" #-}
  "\n\n    <section id=\"content\">" ++ ({-# LINE 25 "Page.hs.neat" #-}
  let _l = list (paragraphs) in
    if (not . null) _l
      then _l >>= \{-# LINE 25 "Page.hs.neat" #-}
  paragraph -> ({-# LINE 25 "Page.hs.neat" #-}
    "\n        <p>" ++ ({-# LINE 26 "Page.hs.neat" #-}
    output (paragraph)) ++ {-# LINE 26 "Page.hs.neat" #-}
    "</p>")
      else ({-# LINE 27 "Page.hs.neat" #-}
    "\n        <p>This post is empty.</p>")) ++ {-# LINE 29 "Page.hs.neat" #-}
  "\n    </section>\n  </body>\n</html>"){-# LINE 33 "Page.hs.neat" #-}

