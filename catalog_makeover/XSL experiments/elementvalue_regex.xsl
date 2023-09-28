<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <xsl:variable name="mads-files" select="//mads-file[@type='xml']"/>
    <xsl:variable name="regex" select="'^.*mads.xml$'"/>

    <xsl:for-each select="$mads-files">
      <xsl:value-of select="substring-before(.,$regex)"/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
