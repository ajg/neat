
import Example.HTML.Post
import Example.HTML.Template

main = putStrLn (generate samplePost)

samplePost = Post "Joe" "Breakfast" ["I love pancakes, waffles & toast."]
