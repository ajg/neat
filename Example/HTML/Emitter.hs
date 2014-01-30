{-# LINE 1 "Emitter.hs.neat" #-}

import Data.Foldable
import Example.HTML.Post
import System.FilePath

main = putStrLn $ emit post where
  post = Post "Joe" (UserInput "Breakfast") [UserInput "I love pancakes, waffles and toast."]

format x = show x

{-# LINE 11 "Emitter.hs.neat" #-}
emit (Post author subject paragraphs) = (""
  ++ {-# LINE 11 "Emitter.hs.neat" #-}
  "\n<!-- This code was automatically generated using Neat. -->\n<!DOCTYPE html>\n<html>\n  <head>\n    <title>"
  ++ ({-# LINE 16 "Emitter.hs.neat" #-}
  format ( subject ))
  ++ {-# LINE 16 "Emitter.hs.neat" #-}
  " - Posts</title>\n  </head>\n  <body>\n    <h1>"
  ++ ({-# LINE 19 "Emitter.hs.neat" #-}
  format ( subject ))
  ++ {-# LINE 19 "Emitter.hs.neat" #-}
  "</h1>\n"
  ++ ({-# LINE 21 "Emitter.hs.neat" #-}
  if (author == "")
    then (
    {-# LINE 21 "Emitter.hs.neat" #-}
    "\n      <h2>Anonymous</h2>")
    else (""
    ++ {-# LINE 23 "Emitter.hs.neat" #-}
    "\n      <h2>By "
    ++ ({-# LINE 24 "Emitter.hs.neat" #-}
    format ( author ))
    ++ {-# LINE 24 "Emitter.hs.neat" #-}
    "</h2>"))
  ++ {-# LINE 25 "Emitter.hs.neat" #-}
  "\n\n    <section id=\"content\">"
  ++ ({-# LINE 28 "Emitter.hs.neat" #-}
  let _l = toList (paragraphs) in if (not . null) _l
    then _l >>= \{-# LINE 28 "Emitter.hs.neat" #-}
  paragraph -> (""
    ++ {-# LINE 28 "Emitter.hs.neat" #-}
    "\n        <p>"
    ++ ({-# LINE 29 "Emitter.hs.neat" #-}
    format ( paragraph ))
    ++ {-# LINE 29 "Emitter.hs.neat" #-}
    "</p>")
    else (
    {-# LINE 30 "Emitter.hs.neat" #-}
    "\n        <p>This post is empty.</p>"))
  ++ {-# LINE 32 "Emitter.hs.neat" #-}
  "\n    </section>\n  </body>\n</html>\n"){-# LINE 36 "Emitter.hs.neat" #-}

