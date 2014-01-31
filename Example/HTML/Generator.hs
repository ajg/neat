
import Example.HTML.Post
import Example.HTML.Page

main = putStrLn (generatePage samplePost)

samplePost = Post "Joe" "Breakfast" ["I love pancakes, waffles & toast."]
