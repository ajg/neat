-- Copyright 2014 Alvaro J. Genial [http://alva.ro]; see LICENSE file for more.

import Example.HTML.Post
import Example.HTML.Page

main = putStrLn (generatePage samplePost)

samplePost = Post "Joe" "Breakfast" ["I love pancakes, waffles & toast."]
