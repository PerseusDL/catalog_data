<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="csv" omit-xml-declaration="yes" />
    <xsl:variable name="csv_header" select="'expression URN'" />
    
    <xsl:template match="/">
        <xsl:value-of select="$csv_header" />
        <xsl:for-each select="//relatedItem[@type='constituent']/relatedItem[@otherType='expression']/identifier[@type='ctsurn']">
            <xsl:value-of select="."/>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>