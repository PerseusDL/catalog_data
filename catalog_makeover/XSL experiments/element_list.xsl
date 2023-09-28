<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes" />
    
    <xsl:template match="/">
        <xsl:for-each select="relatedItem">
            <xsl:variable name="identifier" select="identifier/@type" />
            <xsl:value-of select="$identifier" />
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>

