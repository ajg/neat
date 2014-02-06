{-# LINE 1 "XSLT.hs.neat" #-}
module Text.Neat.Output.XSLT (outputXSLT) where

import Text.Neat.Template
import Text.Neat.Output


instance Output File where
 output (File path block) = ({-# LINE 8 "XSLT.hs.neat" #-}
  "<?xml version=\"1.0\"?>\n<xsl:stylesheet version=\"1.0\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\">" ++ ({-# LINE 10 "XSLT.hs.neat" #-}
  output (block)) ++ {-# LINE 10 "XSLT.hs.neat" #-}
  "\n</xsl:stylesheet>"){-# LINE 12 "XSLT.hs.neat" #-}


instance Output Block where
 output (Block chunks) = ({-# LINE 15 "XSLT.hs.neat" #-}
  "" ++ ({-# LINE 16 "XSLT.hs.neat" #-}
  let _l = list (chunks) in
    if (not . null) _l
      then _l >>= \{-# LINE 16 "XSLT.hs.neat" #-}
  chunk -> ({-# LINE 16 "XSLT.hs.neat" #-}
    "" ++ ({-# LINE 17 "XSLT.hs.neat" #-}
    output (chunk)) ++ {-# LINE 17 "XSLT.hs.neat" #-}
    "")
      else []) ++ {-# LINE 18 "XSLT.hs.neat" #-}
  ""){-# LINE 19 "XSLT.hs.neat" #-}


instance Output Chunk where
 output (Chunk location element) = ({-# LINE 22 "XSLT.hs.neat" #-}
  "" ++ ({-# LINE 23 "XSLT.hs.neat" #-}
  output (element)) ++ {-# LINE 23 "XSLT.hs.neat" #-}
  ""){-# LINE 24 "XSLT.hs.neat" #-}


instance Output Location where
 output (Location file line) = ({-# LINE 27 "XSLT.hs.neat" #-}
  "<!-- Source: " ++ ({-# LINE 27 "XSLT.hs.neat" #-}
  output (file)) ++ {-# LINE 27 "XSLT.hs.neat" #-}
  ":" ++ ({-# LINE 27 "XSLT.hs.neat" #-}
  output (line)) ++ {-# LINE 27 "XSLT.hs.neat" #-}
  " -->"){-# LINE 27 "XSLT.hs.neat" #-}


instance Output Value where
 output (Value _ value) = (({-# LINE 30 "XSLT.hs.neat" #-}
  output (value))){-# LINE 30 "XSLT.hs.neat" #-}


instance Output Pattern where
 output (Pattern _ pattern) = (({-# LINE 33 "XSLT.hs.neat" #-}
  output (pattern))){-# LINE 33 "XSLT.hs.neat" #-}


instance Output Element where
 output (Output value) = ({-# LINE 36 "XSLT.hs.neat" #-}
  "\n  <xsl:value-of select=" ++ ({-# LINE 37 "XSLT.hs.neat" #-}
  output (quote $ value)) ++ {-# LINE 37 "XSLT.hs.neat" #-}
  " />"){-# LINE 38 "XSLT.hs.neat" #-}


 output (Comment comment) = ({-# LINE 40 "XSLT.hs.neat" #-}
  "\n  <xsl:comment>" ++ ({-# LINE 41 "XSLT.hs.neat" #-}
  output (comment)) ++ {-# LINE 41 "XSLT.hs.neat" #-}
  "</xsl:comment>"){-# LINE 42 "XSLT.hs.neat" #-}


 output (Define (Function location name pattern) block) = ({-# LINE 44 "XSLT.hs.neat" #-}
  "" ++ ({-# LINE 45 "XSLT.hs.neat" #-}
  output (location)) ++ {-# LINE 45 "XSLT.hs.neat" #-}
  "\n  <xsl:template name=" ++ ({-# LINE 46 "XSLT.hs.neat" #-}
  output (quote $ name)) ++ {-# LINE 46 "XSLT.hs.neat" #-}
  " match=" ++ ({-# LINE 46 "XSLT.hs.neat" #-}
  output (quote $ pattern)) ++ {-# LINE 46 "XSLT.hs.neat" #-}
  ">" ++ ({-# LINE 47 "XSLT.hs.neat" #-}
  output (block)) ++ {-# LINE 47 "XSLT.hs.neat" #-}
  "\n  </xsl:template>"){-# LINE 49 "XSLT.hs.neat" #-}


 output (Filter value block) = ({-# LINE 51 "XSLT.hs.neat" #-}
  "\n  <!-- TODO: filters -->"){-# LINE 53 "XSLT.hs.neat" #-}


 output (For (Binding pattern value) block else') = ({-# LINE 55 "XSLT.hs.neat" #-}
  "\n  <xsl:choose>\n    <xsl:when test=" ++ ({-# LINE 57 "XSLT.hs.neat" #-}
  output (quote $ value)) ++ {-# LINE 57 "XSLT.hs.neat" #-}
  ">\n      <xsl:for-each select=" ++ ({-# LINE 58 "XSLT.hs.neat" #-}
  output (quote $ value)) ++ {-# LINE 58 "XSLT.hs.neat" #-}
  ">" ++ ({-# LINE 59 "XSLT.hs.neat" #-}
  output (block)) ++ {-# LINE 59 "XSLT.hs.neat" #-}
  "\n      </xsl:for-each>\n    </xsl:when>" ++ ({-# LINE 62 "XSLT.hs.neat" #-}
  if (not . zero) (else')
    then ({-# LINE 62 "XSLT.hs.neat" #-}
    "\n      <xsl:otherwise>" ++ ({-# LINE 63 "XSLT.hs.neat" #-}
    output (else')) ++ {-# LINE 63 "XSLT.hs.neat" #-}
    "</xsl:otherwise>")
    else []) ++ {-# LINE 64 "XSLT.hs.neat" #-}
  "\n  </xsl:choose>"){-# LINE 66 "XSLT.hs.neat" #-}


 output (If value block else') = ({-# LINE 68 "XSLT.hs.neat" #-}
  "\n  <xsl:if test=" ++ ({-# LINE 69 "XSLT.hs.neat" #-}
  output (quote $ value)) ++ {-# LINE 69 "XSLT.hs.neat" #-}
  ">\n    <xsl:for-each select=" ++ ({-# LINE 70 "XSLT.hs.neat" #-}
  output (quote $ value)) ++ {-# LINE 70 "XSLT.hs.neat" #-}
  ">" ++ ({-# LINE 71 "XSLT.hs.neat" #-}
  output (block)) ++ {-# LINE 71 "XSLT.hs.neat" #-}
  "\n    </xsl:for-each>\n  </xsl:if>" ++ ({-# LINE 74 "XSLT.hs.neat" #-}
  if (not . zero) (else')
    then ({-# LINE 74 "XSLT.hs.neat" #-}
    "\n    <xsl:if test=" ++ ({-# LINE 75 "XSLT.hs.neat" #-}
    output (quote $ prepend "!" $ value)) ++ {-# LINE 75 "XSLT.hs.neat" #-}
    ">\n      <xsl:for-each select=" ++ ({-# LINE 76 "XSLT.hs.neat" #-}
    output (quote $ value)) ++ {-# LINE 76 "XSLT.hs.neat" #-}
    ">" ++ ({-# LINE 77 "XSLT.hs.neat" #-}
    output (block)) ++ {-# LINE 77 "XSLT.hs.neat" #-}
    "\n      </xsl:for-each>\n    </xsl:if>")
    else []) ++ {-# LINE 80 "XSLT.hs.neat" #-}
  ""){-# LINE 81 "XSLT.hs.neat" #-}


 output (Switch value cases default') = ({-# LINE 83 "XSLT.hs.neat" #-}
  "\n  <xsl:choose>" ++ ({-# LINE 85 "XSLT.hs.neat" #-}
  let _l = list (cases) in
    if (not . null) _l
      then _l >>= \{-# LINE 85 "XSLT.hs.neat" #-}
  (Case pattern block) -> ({-# LINE 85 "XSLT.hs.neat" #-}
    "\n      <xsl:when test=" ++ ({-# LINE 86 "XSLT.hs.neat" #-}
    output (quote $ prepend value $ prepend " = " $ pattern)) ++ {-# LINE 86 "XSLT.hs.neat" #-}
    ">" ++ ({-# LINE 87 "XSLT.hs.neat" #-}
    output (block)) ++ {-# LINE 87 "XSLT.hs.neat" #-}
    "\n      </xsl:when>")
      else []) ++ {-# LINE 89 "XSLT.hs.neat" #-}
  "" ++ ({-# LINE 90 "XSLT.hs.neat" #-}
  if (not . zero) (default')
    then ({-# LINE 90 "XSLT.hs.neat" #-}
    "\n      <xsl:otherwise>" ++ ({-# LINE 91 "XSLT.hs.neat" #-}
    output (default')) ++ {-# LINE 91 "XSLT.hs.neat" #-}
    "</xsl:otherwise>")
    else []) ++ {-# LINE 92 "XSLT.hs.neat" #-}
  "\n  </xsl:choose>"){-# LINE 94 "XSLT.hs.neat" #-}


 output (With (Binding pattern value) block) = ({-# LINE 96 "XSLT.hs.neat" #-}
  "\n  <xsl:variable name=" ++ ({-# LINE 97 "XSLT.hs.neat" #-}
  output (quote $ pattern)) ++ {-# LINE 97 "XSLT.hs.neat" #-}
  " select=" ++ ({-# LINE 97 "XSLT.hs.neat" #-}
  output (quote $ value)) ++ {-# LINE 97 "XSLT.hs.neat" #-}
  "" ++ ({-# LINE 98 "XSLT.hs.neat" #-}
  output (block)) ++ {-# LINE 98 "XSLT.hs.neat" #-}
  "\n  </xsl:variable>"){-# LINE 100 "XSLT.hs.neat" #-}


 output (Text text) = ({-# LINE 102 "XSLT.hs.neat" #-}
  "\n  <xsl:text>" ++ ({-# LINE 103 "XSLT.hs.neat" #-}
  output (text)) ++ {-# LINE 103 "XSLT.hs.neat" #-}
  "</xsl:text>"){-# LINE 104 "XSLT.hs.neat" #-}



outputXSLT :: File -> String
outputXSLT = output
