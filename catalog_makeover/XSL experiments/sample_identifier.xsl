<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="mods">
        <xsl:for-each select="relatedItem[@type='constituent' and @otherType='expression']">
            <xsl:copy-of select="identifier"/>
            <xsl:text> </xsl:text>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>

