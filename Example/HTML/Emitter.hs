{-# LINE 1 "Emitter.hs.neat" #-}

import Example.HTML.Post
import Text.Neat

main = putStrLn $ emit samplePost


{-# LINE 8 "Emitter.hs.neat" #-}
emit (Post author subject paragraphs) = (""
  ++ {-# LINE 8 "Emitter.hs.neat" #-}
  "\n<!-- This code was automatically generated using Neat. -->\n<!DOCTYPE html>\n<html>\n  <head>\n    <title>"
  ++ ({-# LINE 13 "Emitter.hs.neat" #-}
  output ( subject ))
  ++ {-# LINE 13 "Emitter.hs.neat" #-}
  " - Posts</title>\n  </head>\n  <body>\n    <h1>"
  ++ ({-# LINE 16 "Emitter.hs.neat" #-}
  output ( subject ))
  ++ {-# LINE 16 "Emitter.hs.neat" #-}
  "</h1>\n"
  ++ ({-# LINE 18 "Emitter.hs.neat" #-}
  if (author == "")
    then (
    {-# LINE 18 "Emitter.hs.neat" #-}
    "\n      <h2>Anonymous</h2>")
    else (""
    ++ {-# LINE 20 "Emitter.hs.neat" #-}
    "\n      <h2>By "
    ++ ({-# LINE 21 "Emitter.hs.neat" #-}
    output ( author ))
    ++ {-# LINE 21 "Emitter.hs.neat" #-}
    "</h2>"))
  ++ {-# LINE 22 "Emitter.hs.neat" #-}
  "\n\n    <section id=\"content\">"
  ++ ({-# LINE 25 "Emitter.hs.neat" #-}
  let _l = toList (paragraphs) in if (not . null) _l
    then _l >>= \{-# LINE 25 "Emitter.hs.neat" #-}
  paragraph -> (""
    ++ {-# LINE 25 "Emitter.hs.neat" #-}
    "\n        <p>"
    ++ ({-# LINE 26 "Emitter.hs.neat" #-}
    output ( paragraph ))
    ++ {-# LINE 26 "Emitter.hs.neat" #-}
    "</p>")
    else (
    {-# LINE 27 "Emitter.hs.neat" #-}
    "\n        <p>This post is empty.</p>"))
  ++ {-# LINE 29 "Emitter.hs.neat" #-}
  "\n    </section>\n  </body>\n</html>\n"){-# LINE 33 "Emitter.hs.neat" #-}

