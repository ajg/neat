{-# LINE 1 "Emitter.hs.neat" #-}

import Example.Java.AST
import System.FilePath
import Text.Neat.Output

main = putStrLn (emit sampleFile)


emit (File path package imports cls) = ({-# LINE 9 "Emitter.hs.neat" #-}
  "\n  // Code generated from " ++ ({-# LINE 10 "Emitter.hs.neat" #-}
  output (takeFileName path)) ++ {-# LINE 10 "Emitter.hs.neat" #-}
  "\n  package " ++ ({-# LINE 11 "Emitter.hs.neat" #-}
  output (package)) ++ {-# LINE 11 "Emitter.hs.neat" #-}
  ";\n" ++ ({-# LINE 13 "Emitter.hs.neat" #-}
  let _l = list (imports) in
    if (not . null) _l
      then _l >>= \{-# LINE 13 "Emitter.hs.neat" #-}
  (Import static qname wildcard) -> ({-# LINE 13 "Emitter.hs.neat" #-}
    "\n  import " ++ ({-# LINE 14 "Emitter.hs.neat" #-}
    if (not . zero) (static)
      then ({-# LINE 14 "Emitter.hs.neat" #-}
      "static ")
      else []) ++ ({-# LINE 14 "Emitter.hs.neat" #-}
    output (qname)) ++ ({-# LINE 14 "Emitter.hs.neat" #-}
    if (not . zero) (wildcard)
      then ({-# LINE 14 "Emitter.hs.neat" #-}
      ".*")
      else []) ++ {-# LINE 14 "Emitter.hs.neat" #-}
    ";")
      else []) ++ {-# LINE 15 "Emitter.hs.neat" #-}
  "\n" ++ ({-# LINE 17 "Emitter.hs.neat" #-}
  
    case (cls) of {-# LINE 17 "Emitter.hs.neat" #-}
  (Class annotations access modifier name parents members) -> ({-# LINE 17 "Emitter.hs.neat" #-}
    "" ++ ({-# LINE 18 "Emitter.hs.neat" #-}
    output (access)) ++ {-# LINE 18 "Emitter.hs.neat" #-}
    " " ++ ({-# LINE 18 "Emitter.hs.neat" #-}
    output (modifier)) ++ {-# LINE 18 "Emitter.hs.neat" #-}
    " class " ++ ({-# LINE 18 "Emitter.hs.neat" #-}
    output (name)) ++ {-# LINE 18 "Emitter.hs.neat" #-}
    "" ++ ({-# LINE 19 "Emitter.hs.neat" #-}
    let _l = list (parents) in
      if (not . null) _l
        then _l >>= \{-# LINE 19 "Emitter.hs.neat" #-}
    parent -> ({-# LINE 19 "Emitter.hs.neat" #-}
      "" ++ ({-# LINE 20 "Emitter.hs.neat" #-}
      
        case (parent) of {-# LINE 21 "Emitter.hs.neat" #-}
      (Implements interfaces) -> ({-# LINE 21 "Emitter.hs.neat" #-}
        " implements " ++ ({-# LINE 21 "Emitter.hs.neat" #-}
        output (join ", " $ interfaces)) ++ {-# LINE 21 "Emitter.hs.neat" #-}
        ""){-# LINE 22 "Emitter.hs.neat" #-}
      (Extends super) -> ({-# LINE 22 "Emitter.hs.neat" #-}
        " extends " ++ ({-# LINE 22 "Emitter.hs.neat" #-}
        output (super)) ++ {-# LINE 22 "Emitter.hs.neat" #-}
        "") ) ++ {-# LINE 23 "Emitter.hs.neat" #-}
      "")
        else []) ++ {-# LINE 24 "Emitter.hs.neat" #-}
    "\n    {\n" ++ ({-# LINE 27 "Emitter.hs.neat" #-}
    let _l = list (members) in
      if (not . null) _l
        then _l >>= \{-# LINE 27 "Emitter.hs.neat" #-}
    (Member annotations access element) -> ({-# LINE 27 "Emitter.hs.neat" #-}
      "" ++ ({-# LINE 28 "Emitter.hs.neat" #-}
      output (annotations)) ++ {-# LINE 28 "Emitter.hs.neat" #-}
      " " ++ ({-# LINE 28 "Emitter.hs.neat" #-}
      output (access)) ++ {-# LINE 28 "Emitter.hs.neat" #-}
      " " ++ ({-# LINE 28 "Emitter.hs.neat" #-}
      output (emit' name element)) ++ {-# LINE 28 "Emitter.hs.neat" #-}
      "")
        else []) ++ {-# LINE 29 "Emitter.hs.neat" #-}
    "\n    }")) ++ {-# LINE 31 "Emitter.hs.neat" #-}
  ""){-# LINE 32 "Emitter.hs.neat" #-}


emit' className element = ({-# LINE 34 "Emitter.hs.neat" #-}
  "" ++ ({-# LINE 35 "Emitter.hs.neat" #-}
  
    case (element) of {-# LINE 36 "Emitter.hs.neat" #-}
  (Constructor arguments body) -> ({-# LINE 36 "Emitter.hs.neat" #-}
    "" ++ ({-# LINE 37 "Emitter.hs.neat" #-}
    output (className)) ++ {-# LINE 37 "Emitter.hs.neat" #-}
    "(" ++ ({-# LINE 37 "Emitter.hs.neat" #-}
    output (join ", " $ arguments)) ++ {-# LINE 37 "Emitter.hs.neat" #-}
    ")" ++ ({-# LINE 37 "Emitter.hs.neat" #-}
    output (unless body $ ";")) ++ {-# LINE 37 "Emitter.hs.neat" #-}
    ""){-# LINE 38 "Emitter.hs.neat" #-}
  (Method qualifier modifier type' name arguments exceptions body) -> ({-# LINE 38 "Emitter.hs.neat" #-}
    "" ++ ({-# LINE 39 "Emitter.hs.neat" #-}
    output (modifier)) ++ {-# LINE 39 "Emitter.hs.neat" #-}
    " " ++ ({-# LINE 39 "Emitter.hs.neat" #-}
    output (type')) ++ {-# LINE 39 "Emitter.hs.neat" #-}
    " " ++ ({-# LINE 39 "Emitter.hs.neat" #-}
    output (name)) ++ {-# LINE 39 "Emitter.hs.neat" #-}
    "(" ++ ({-# LINE 39 "Emitter.hs.neat" #-}
    output (join ", " $ arguments)) ++ {-# LINE 39 "Emitter.hs.neat" #-}
    ")" ++ ({-# LINE 40 "Emitter.hs.neat" #-}
    if (not . zero) (exceptions)
      then ({-# LINE 40 "Emitter.hs.neat" #-}
      " throws " ++ ({-# LINE 40 "Emitter.hs.neat" #-}
      output (join ", " $ exceptions)) ++ {-# LINE 40 "Emitter.hs.neat" #-}
      " ")
      else []) ++ {-# LINE 40 "Emitter.hs.neat" #-}
    "" ++ ({-# LINE 41 "Emitter.hs.neat" #-}
    output (unless body $ ";")) ++ {-# LINE 41 "Emitter.hs.neat" #-}
    "") 
  _ -> ({-# LINE 42 "Emitter.hs.neat" #-}
    "\n    // Unimplemented member type.")) ++ {-# LINE 44 "Emitter.hs.neat" #-}
  ""){-# LINE 45 "Emitter.hs.neat" #-}

