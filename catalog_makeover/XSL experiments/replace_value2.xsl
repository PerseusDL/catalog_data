<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <xsl:variable name="mads-files" select="//mads-file[@type='xml']"/>
    <xsl:variable name="new-values" select="('New value1','New value2','New value3')"/>

    <xsl:for-each select="$mads-files">
      <xsl:value-of select="."/>
      <xsl:text>
      </xsl:text>
      <xsl:value-of select="$new-values"/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
