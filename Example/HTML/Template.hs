{-# LINE 1 "Template.hs.neat" #-}
module Example.HTML.Template where

import Example.HTML.Post
import Text.Neat

{-# LINE 6 "Template.hs.neat" #-}
generate (Post author subject paragraphs) = (""
  ++ {-# LINE 6 "Template.hs.neat" #-}
  "\n<!-- This code was automatically generated using Neat. -->\n<!DOCTYPE html>\n<html>\n  <head>\n    <title>"
  ++ ({-# LINE 11 "Template.hs.neat" #-}
  output ( subject ))
  ++ {-# LINE 11 "Template.hs.neat" #-}
  " - Posts</title>\n  </head>\n  <body>\n    <h1>"
  ++ ({-# LINE 14 "Template.hs.neat" #-}
  output ( subject ))
  ++ {-# LINE 14 "Template.hs.neat" #-}
  "</h1>\n"
  ++ ({-# LINE 16 "Template.hs.neat" #-}
  if (author == "")
    then (
    {-# LINE 16 "Template.hs.neat" #-}
    "\n      <h2>Anonymous</h2>")
    else (""
    ++ {-# LINE 18 "Template.hs.neat" #-}
    "\n      <h2>By "
    ++ ({-# LINE 19 "Template.hs.neat" #-}
    output ( author ))
    ++ {-# LINE 19 "Template.hs.neat" #-}
    "</h2>"))
  ++ {-# LINE 20 "Template.hs.neat" #-}
  "\n\n    <section id=\"content\">"
  ++ ({-# LINE 23 "Template.hs.neat" #-}
  let _l = toList (paragraphs) in if (not . null) _l
    then _l >>= \{-# LINE 23 "Template.hs.neat" #-}
  paragraph -> (""
    ++ {-# LINE 23 "Template.hs.neat" #-}
    "\n        <p>"
    ++ ({-# LINE 24 "Template.hs.neat" #-}
    output ( paragraph ))
    ++ {-# LINE 24 "Template.hs.neat" #-}
    "</p>")
    else (
    {-# LINE 25 "Template.hs.neat" #-}
    "\n        <p>This post is empty.</p>"))
  ++ {-# LINE 27 "Template.hs.neat" #-}
  "\n    </section>\n  </body>\n</html>\n"){-# LINE 31 "Template.hs.neat" #-}

