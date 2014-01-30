
import Example.HTML.Post
import Example.HTML.Template

main = putStrLn (template samplePost)

samplePost = Post "Joe" "Breakfast" ["I love pancakes, waffles & toast."]
