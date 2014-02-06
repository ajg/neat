{-# LINE 1 "XSLT.hs.neat" #-}
-- Copyright 2014 Alvaro J. Genial [http://alva.ro]; see LICENSE file for more.

module Text.Neat.Output.XSLT (outputXSLT) where

import Text.Neat.Template
import Text.Neat.Output


instance Output File where
 output (File path block) = ({-# LINE 10 "XSLT.hs.neat" #-}
  "<?xml version=\"1.0\"?>\n<xsl:stylesheet version=\"1.0\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\">" ++ ({-# LINE 12 "XSLT.hs.neat" #-}
  output (block)) ++ {-# LINE 12 "XSLT.hs.neat" #-}
  "\n</xsl:stylesheet>"){-# LINE 14 "XSLT.hs.neat" #-}


instance Output Block where
 output (Block chunks) = ({-# LINE 17 "XSLT.hs.neat" #-}
  "" ++ ({-# LINE 18 "XSLT.hs.neat" #-}
  let _l = list (chunks) in
    if (not . null) _l
      then _l >>= \{-# LINE 18 "XSLT.hs.neat" #-}
  chunk -> ({-# LINE 18 "XSLT.hs.neat" #-}
    "" ++ ({-# LINE 19 "XSLT.hs.neat" #-}
    output (chunk)) ++ {-# LINE 19 "XSLT.hs.neat" #-}
    "")
      else []) ++ {-# LINE 20 "XSLT.hs.neat" #-}
  ""){-# LINE 21 "XSLT.hs.neat" #-}


instance Output Chunk where
 output (Chunk location element) = ({-# LINE 24 "XSLT.hs.neat" #-}
  "" ++ ({-# LINE 25 "XSLT.hs.neat" #-}
  output (element)) ++ {-# LINE 25 "XSLT.hs.neat" #-}
  ""){-# LINE 26 "XSLT.hs.neat" #-}


instance Output Location where
 output (Location file line) = ({-# LINE 29 "XSLT.hs.neat" #-}
  "<!-- Source: " ++ ({-# LINE 29 "XSLT.hs.neat" #-}
  output (file)) ++ {-# LINE 29 "XSLT.hs.neat" #-}
  ":" ++ ({-# LINE 29 "XSLT.hs.neat" #-}
  output (line)) ++ {-# LINE 29 "XSLT.hs.neat" #-}
  " -->"){-# LINE 29 "XSLT.hs.neat" #-}


instance Output Value where
 output (Value _ value) = (({-# LINE 32 "XSLT.hs.neat" #-}
  output (value))){-# LINE 32 "XSLT.hs.neat" #-}


instance Output Pattern where
 output (Pattern _ pattern) = (({-# LINE 35 "XSLT.hs.neat" #-}
  output (pattern))){-# LINE 35 "XSLT.hs.neat" #-}


instance Output Element where
 output (Output value) = ({-# LINE 38 "XSLT.hs.neat" #-}
  "\n  <xsl:value-of select=" ++ ({-# LINE 39 "XSLT.hs.neat" #-}
  output (quote $ value)) ++ {-# LINE 39 "XSLT.hs.neat" #-}
  " />"){-# LINE 40 "XSLT.hs.neat" #-}


 output (Comment comment) = ({-# LINE 42 "XSLT.hs.neat" #-}
  "\n  <xsl:comment>" ++ ({-# LINE 43 "XSLT.hs.neat" #-}
  output (comment)) ++ {-# LINE 43 "XSLT.hs.neat" #-}
  "</xsl:comment>"){-# LINE 44 "XSLT.hs.neat" #-}


 output (Define (Function location name pattern) block) = ({-# LINE 46 "XSLT.hs.neat" #-}
  "" ++ ({-# LINE 47 "XSLT.hs.neat" #-}
  output (location)) ++ {-# LINE 47 "XSLT.hs.neat" #-}
  "\n  <xsl:template name=" ++ ({-# LINE 48 "XSLT.hs.neat" #-}
  output (quote $ name)) ++ {-# LINE 48 "XSLT.hs.neat" #-}
  " match=" ++ ({-# LINE 48 "XSLT.hs.neat" #-}
  output (quote $ pattern)) ++ {-# LINE 48 "XSLT.hs.neat" #-}
  ">" ++ ({-# LINE 49 "XSLT.hs.neat" #-}
  output (block)) ++ {-# LINE 49 "XSLT.hs.neat" #-}
  "\n  </xsl:template>"){-# LINE 51 "XSLT.hs.neat" #-}


 output (Filter value block) = ({-# LINE 53 "XSLT.hs.neat" #-}
  "\n  <!-- TODO: filters -->"){-# LINE 55 "XSLT.hs.neat" #-}


 output (For (Binding pattern value) block else') = ({-# LINE 57 "XSLT.hs.neat" #-}
  "\n  <xsl:choose>\n    <xsl:when test=" ++ ({-# LINE 59 "XSLT.hs.neat" #-}
  output (quote $ value)) ++ {-# LINE 59 "XSLT.hs.neat" #-}
  ">\n      <xsl:for-each select=" ++ ({-# LINE 60 "XSLT.hs.neat" #-}
  output (quote $ value)) ++ {-# LINE 60 "XSLT.hs.neat" #-}
  ">" ++ ({-# LINE 61 "XSLT.hs.neat" #-}
  output (block)) ++ {-# LINE 61 "XSLT.hs.neat" #-}
  "\n      </xsl:for-each>\n    </xsl:when>" ++ ({-# LINE 64 "XSLT.hs.neat" #-}
  if (not . zero) (else')
    then ({-# LINE 64 "XSLT.hs.neat" #-}
    "\n      <xsl:otherwise>" ++ ({-# LINE 65 "XSLT.hs.neat" #-}
    output (else')) ++ {-# LINE 65 "XSLT.hs.neat" #-}
    "</xsl:otherwise>")
    else []) ++ {-# LINE 66 "XSLT.hs.neat" #-}
  "\n  </xsl:choose>"){-# LINE 68 "XSLT.hs.neat" #-}


 output (If value block else') = ({-# LINE 70 "XSLT.hs.neat" #-}
  "\n  <xsl:if test=" ++ ({-# LINE 71 "XSLT.hs.neat" #-}
  output (quote $ value)) ++ {-# LINE 71 "XSLT.hs.neat" #-}
  ">\n    <xsl:for-each select=" ++ ({-# LINE 72 "XSLT.hs.neat" #-}
  output (quote $ value)) ++ {-# LINE 72 "XSLT.hs.neat" #-}
  ">" ++ ({-# LINE 73 "XSLT.hs.neat" #-}
  output (block)) ++ {-# LINE 73 "XSLT.hs.neat" #-}
  "\n    </xsl:for-each>\n  </xsl:if>" ++ ({-# LINE 76 "XSLT.hs.neat" #-}
  if (not . zero) (else')
    then ({-# LINE 76 "XSLT.hs.neat" #-}
    "\n    <xsl:if test=" ++ ({-# LINE 77 "XSLT.hs.neat" #-}
    output (quote $ prepend "!" $ value)) ++ {-# LINE 77 "XSLT.hs.neat" #-}
    ">\n      <xsl:for-each select=" ++ ({-# LINE 78 "XSLT.hs.neat" #-}
    output (quote $ value)) ++ {-# LINE 78 "XSLT.hs.neat" #-}
    ">" ++ ({-# LINE 79 "XSLT.hs.neat" #-}
    output (block)) ++ {-# LINE 79 "XSLT.hs.neat" #-}
    "\n      </xsl:for-each>\n    </xsl:if>")
    else []) ++ {-# LINE 82 "XSLT.hs.neat" #-}
  ""){-# LINE 83 "XSLT.hs.neat" #-}


 output (Switch value cases default') = ({-# LINE 85 "XSLT.hs.neat" #-}
  "\n  <xsl:choose>" ++ ({-# LINE 87 "XSLT.hs.neat" #-}
  let _l = list (cases) in
    if (not . null) _l
      then _l >>= \{-# LINE 87 "XSLT.hs.neat" #-}
  (Case pattern block) -> ({-# LINE 87 "XSLT.hs.neat" #-}
    "\n      <xsl:when test=" ++ ({-# LINE 88 "XSLT.hs.neat" #-}
    output (quote $ prepend value $ prepend " = " $ pattern)) ++ {-# LINE 88 "XSLT.hs.neat" #-}
    ">" ++ ({-# LINE 89 "XSLT.hs.neat" #-}
    output (block)) ++ {-# LINE 89 "XSLT.hs.neat" #-}
    "\n      </xsl:when>")
      else []) ++ {-# LINE 91 "XSLT.hs.neat" #-}
  "" ++ ({-# LINE 92 "XSLT.hs.neat" #-}
  if (not . zero) (default')
    then ({-# LINE 92 "XSLT.hs.neat" #-}
    "\n      <xsl:otherwise>" ++ ({-# LINE 93 "XSLT.hs.neat" #-}
    output (default')) ++ {-# LINE 93 "XSLT.hs.neat" #-}
    "</xsl:otherwise>")
    else []) ++ {-# LINE 94 "XSLT.hs.neat" #-}
  "\n  </xsl:choose>"){-# LINE 96 "XSLT.hs.neat" #-}


 output (With (Binding pattern value) block) = ({-# LINE 98 "XSLT.hs.neat" #-}
  "\n  <xsl:variable name=" ++ ({-# LINE 99 "XSLT.hs.neat" #-}
  output (quote $ pattern)) ++ {-# LINE 99 "XSLT.hs.neat" #-}
  " select=" ++ ({-# LINE 99 "XSLT.hs.neat" #-}
  output (quote $ value)) ++ {-# LINE 99 "XSLT.hs.neat" #-}
  "" ++ ({-# LINE 100 "XSLT.hs.neat" #-}
  output (block)) ++ {-# LINE 100 "XSLT.hs.neat" #-}
  "\n  </xsl:variable>"){-# LINE 102 "XSLT.hs.neat" #-}


 output (Text text) = ({-# LINE 104 "XSLT.hs.neat" #-}
  "\n  <xsl:text>" ++ ({-# LINE 105 "XSLT.hs.neat" #-}
  output (text)) ++ {-# LINE 105 "XSLT.hs.neat" #-}
  "</xsl:text>"){-# LINE 106 "XSLT.hs.neat" #-}



outputXSLT :: File -> String
outputXSLT = output
