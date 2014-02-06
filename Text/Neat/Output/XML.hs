{-# LINE 1 "XML.hs.neat" #-}
module Text.Neat.Output.XML (outputXML) where

import Text.Neat.Template
import Text.Neat.Output


instance Output File where
 output (File path block) = ({-# LINE 8 "XML.hs.neat" #-}
  "<?xml version=\"1.0\"?>\n<File path=" ++ ({-# LINE 9 "XML.hs.neat" #-}
  output (quote $ path)) ++ {-# LINE 9 "XML.hs.neat" #-}
  ">" ++ ({-# LINE 10 "XML.hs.neat" #-}
  output (block)) ++ {-# LINE 10 "XML.hs.neat" #-}
  "\n</File>"){-# LINE 12 "XML.hs.neat" #-}


instance Output Block where
 output (Block chunks) = ({-# LINE 15 "XML.hs.neat" #-}
  "\n  <Block>" ++ ({-# LINE 17 "XML.hs.neat" #-}
  let _l = list (chunks) in
    if (not . null) _l
      then _l >>= \{-# LINE 17 "XML.hs.neat" #-}
  chunk -> ({-# LINE 17 "XML.hs.neat" #-}
    "" ++ ({-# LINE 18 "XML.hs.neat" #-}
    output (chunk)) ++ {-# LINE 18 "XML.hs.neat" #-}
    "")
      else []) ++ {-# LINE 19 "XML.hs.neat" #-}
  "\n  </Block>"){-# LINE 21 "XML.hs.neat" #-}


instance Output Chunk where
 output (Chunk location element) = ({-# LINE 24 "XML.hs.neat" #-}
  "\n  <Chunk " ++ ({-# LINE 25 "XML.hs.neat" #-}
  output (location)) ++ {-# LINE 25 "XML.hs.neat" #-}
  ">" ++ ({-# LINE 26 "XML.hs.neat" #-}
  output (element)) ++ {-# LINE 26 "XML.hs.neat" #-}
  "\n  </Chunk>"){-# LINE 28 "XML.hs.neat" #-}


instance Output Case where
 output (Case pattern block) = ({-# LINE 31 "XML.hs.neat" #-}
  "\n  <Case>" ++ ({-# LINE 33 "XML.hs.neat" #-}
  output (pattern)) ++ {-# LINE 33 "XML.hs.neat" #-}
  "" ++ ({-# LINE 34 "XML.hs.neat" #-}
  output (block)) ++ {-# LINE 34 "XML.hs.neat" #-}
  "\n  </Case>"){-# LINE 36 "XML.hs.neat" #-}


instance Output Location where
 output (Location file line) = ({-# LINE 39 "XML.hs.neat" #-}
  "file=" ++ ({-# LINE 39 "XML.hs.neat" #-}
  output (quote $ file)) ++ {-# LINE 39 "XML.hs.neat" #-}
  " line=\"" ++ ({-# LINE 39 "XML.hs.neat" #-}
  output (line)) ++ {-# LINE 39 "XML.hs.neat" #-}
  "\""){-# LINE 39 "XML.hs.neat" #-}


instance Output Value where
 output (Value location pipeline) = ({-# LINE 42 "XML.hs.neat" #-}
  "\n  <Value " ++ ({-# LINE 43 "XML.hs.neat" #-}
  output (location)) ++ {-# LINE 43 "XML.hs.neat" #-}
  ">\n    <Pipeline>" ++ ({-# LINE 45 "XML.hs.neat" #-}
  let _l = list (pipeline) in
    if (not . null) _l
      then _l >>= \{-# LINE 45 "XML.hs.neat" #-}
  pipe -> ({-# LINE 45 "XML.hs.neat" #-}
    "\n        <Pipe><![CDATA[" ++ ({-# LINE 46 "XML.hs.neat" #-}
    output (pipe)) ++ {-# LINE 46 "XML.hs.neat" #-}
    "]]></Pipe>")
      else []) ++ {-# LINE 47 "XML.hs.neat" #-}
  "\n    </Pipeline>\n  </Value>"){-# LINE 50 "XML.hs.neat" #-}


instance Output Pattern where
 output (Pattern location pattern) = ({-# LINE 53 "XML.hs.neat" #-}
  "\n  <Pattern " ++ ({-# LINE 54 "XML.hs.neat" #-}
  output (location)) ++ {-# LINE 54 "XML.hs.neat" #-}
  "><![CDATA[" ++ ({-# LINE 54 "XML.hs.neat" #-}
  output (pattern)) ++ {-# LINE 54 "XML.hs.neat" #-}
  "]]></Pattern>"){-# LINE 55 "XML.hs.neat" #-}


instance Output Element where
 output (Output value) = ({-# LINE 58 "XML.hs.neat" #-}
  "\n  <Output>" ++ ({-# LINE 59 "XML.hs.neat" #-}
  output (value)) ++ {-# LINE 59 "XML.hs.neat" #-}
  "</Output>"){-# LINE 60 "XML.hs.neat" #-}


 output (Comment comment) = ({-# LINE 62 "XML.hs.neat" #-}
  "\n  <Comment><![CDATA[" ++ ({-# LINE 63 "XML.hs.neat" #-}
  output (comment)) ++ {-# LINE 63 "XML.hs.neat" #-}
  "]]></Output>"){-# LINE 64 "XML.hs.neat" #-}


 output (Define (Function location name pattern) block) = ({-# LINE 66 "XML.hs.neat" #-}
  "\n  <Define name=" ++ ({-# LINE 67 "XML.hs.neat" #-}
  output (quote $ name)) ++ {-# LINE 67 "XML.hs.neat" #-}
  " " ++ ({-# LINE 67 "XML.hs.neat" #-}
  output (location)) ++ {-# LINE 67 "XML.hs.neat" #-}
  ">" ++ ({-# LINE 68 "XML.hs.neat" #-}
  output (pattern)) ++ {-# LINE 68 "XML.hs.neat" #-}
  "" ++ ({-# LINE 69 "XML.hs.neat" #-}
  output (block)) ++ {-# LINE 69 "XML.hs.neat" #-}
  "\n  </Define>"){-# LINE 71 "XML.hs.neat" #-}


 output (Filter value block) = ({-# LINE 73 "XML.hs.neat" #-}
  "\n  <Filter>" ++ ({-# LINE 75 "XML.hs.neat" #-}
  output (value)) ++ {-# LINE 75 "XML.hs.neat" #-}
  "" ++ ({-# LINE 76 "XML.hs.neat" #-}
  output (block)) ++ {-# LINE 76 "XML.hs.neat" #-}
  "\n  </Filter>"){-# LINE 78 "XML.hs.neat" #-}


 output (For binding block else') = ({-# LINE 80 "XML.hs.neat" #-}
  "\n  <For>" ++ ({-# LINE 82 "XML.hs.neat" #-}
  output (binding)) ++ {-# LINE 82 "XML.hs.neat" #-}
  "" ++ ({-# LINE 83 "XML.hs.neat" #-}
  output (block)) ++ {-# LINE 83 "XML.hs.neat" #-}
  "" ++ ({-# LINE 84 "XML.hs.neat" #-}
  if (not . zero) (else')
    then ({-# LINE 84 "XML.hs.neat" #-}
    "<Else>" ++ ({-# LINE 84 "XML.hs.neat" #-}
    output (else')) ++ {-# LINE 84 "XML.hs.neat" #-}
    "</Else>")
    else []) ++ {-# LINE 84 "XML.hs.neat" #-}
  "\n  </For>"){-# LINE 86 "XML.hs.neat" #-}


 output (If value block else') = ({-# LINE 88 "XML.hs.neat" #-}
  "\n  <If>" ++ ({-# LINE 90 "XML.hs.neat" #-}
  output (value)) ++ {-# LINE 90 "XML.hs.neat" #-}
  "" ++ ({-# LINE 91 "XML.hs.neat" #-}
  output (block)) ++ {-# LINE 91 "XML.hs.neat" #-}
  "" ++ ({-# LINE 92 "XML.hs.neat" #-}
  if (not . zero) (else')
    then ({-# LINE 92 "XML.hs.neat" #-}
    "<Else>" ++ ({-# LINE 92 "XML.hs.neat" #-}
    output (else')) ++ {-# LINE 92 "XML.hs.neat" #-}
    "</Else>")
    else []) ++ {-# LINE 92 "XML.hs.neat" #-}
  "\n  </If>"){-# LINE 94 "XML.hs.neat" #-}


 output (Switch value cases default') = ({-# LINE 96 "XML.hs.neat" #-}
  "\n  <Switch>" ++ ({-# LINE 98 "XML.hs.neat" #-}
  output (value)) ++ {-# LINE 98 "XML.hs.neat" #-}
  "" ++ ({-# LINE 99 "XML.hs.neat" #-}
  let _l = list (cases) in
    if (not . null) _l
      then _l >>= \{-# LINE 99 "XML.hs.neat" #-}
  case' -> ({-# LINE 99 "XML.hs.neat" #-}
    "" ++ ({-# LINE 100 "XML.hs.neat" #-}
    output (case')) ++ {-# LINE 100 "XML.hs.neat" #-}
    "")
      else []) ++ {-# LINE 101 "XML.hs.neat" #-}
  "" ++ ({-# LINE 102 "XML.hs.neat" #-}
  if (not . zero) (default')
    then ({-# LINE 102 "XML.hs.neat" #-}
    "<Default>" ++ ({-# LINE 102 "XML.hs.neat" #-}
    output (default')) ++ {-# LINE 102 "XML.hs.neat" #-}
    "</Default>")
    else []) ++ {-# LINE 102 "XML.hs.neat" #-}
  "\n  </Switch>"){-# LINE 104 "XML.hs.neat" #-}


 output (With binding block) = ({-# LINE 106 "XML.hs.neat" #-}
  "\n  <With>" ++ ({-# LINE 108 "XML.hs.neat" #-}
  output (binding)) ++ {-# LINE 108 "XML.hs.neat" #-}
  "" ++ ({-# LINE 109 "XML.hs.neat" #-}
  output (block)) ++ {-# LINE 109 "XML.hs.neat" #-}
  "\n  </With>"){-# LINE 111 "XML.hs.neat" #-}


 output (Text text) = ({-# LINE 113 "XML.hs.neat" #-}
  "<Text><![CDATA[" ++ ({-# LINE 113 "XML.hs.neat" #-}
  output (text)) ++ {-# LINE 113 "XML.hs.neat" #-}
  "]]></Text>"){-# LINE 113 "XML.hs.neat" #-}



outputXML :: File -> String
outputXML = output
