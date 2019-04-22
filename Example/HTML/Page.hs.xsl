<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:text>module Example.HTML.Page where

import Example.HTML.Post
import Text.Neat.Output

</xsl:text><!-- Source: Page.hs.neat:6 -->
  <xsl:template name="generatePage" match=" (Post author subject paragraphs)">
  <xsl:text>
<!-- This code was automatically generated using Neat. -->
<!DOCTYPE html>
<html>
  <head>
    <title></xsl:text>
  <xsl:value-of select="subject" />
  <xsl:text> - Posts</title>
  </head>
  <body>
    <h1></xsl:text>
  <xsl:value-of select="subject" />
  <xsl:text></h1>

    </xsl:text>
  <xsl:if test="author">
    <xsl:for-each select="author">
  <xsl:text>
      <h2>By </xsl:text>
  <xsl:value-of select="safe author" />
  <xsl:text></h2>
    </xsl:text>
    </xsl:for-each>
  </xsl:if>
    <xsl:if test="!author">
      <xsl:for-each select="author">
  <xsl:text>
      <h2>By </xsl:text>
  <xsl:value-of select="safe author" />
  <xsl:text></h2>
    </xsl:text>
      </xsl:for-each>
    </xsl:if>
  <xsl:text>

    <section id="content">
      </xsl:text>
  <xsl:choose>
    <xsl:when test="paragraphs">
      <xsl:for-each select="paragraphs">
  <xsl:text>
        <p></xsl:text>
  <xsl:value-of select="paragraph" />
  <xsl:text></p>
      </xsl:text>
      </xsl:for-each>
    </xsl:when>
      <xsl:otherwise>
  <xsl:text>
        <p>This post is empty.</p>
      </xsl:text></xsl:otherwise>
  </xsl:choose>
  <xsl:text>
    </section>
  </body>
</html>
</xsl:text>
  </xsl:template>
  <xsl:text>
</xsl:text>
</xsl:stylesheet>