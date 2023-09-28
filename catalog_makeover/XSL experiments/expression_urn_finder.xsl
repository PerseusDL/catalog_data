<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>    
    <xsl:template match="/">
        <xsl:for-each select="//relatedItem[@type='constituent']/relatedItem[@otherType='expression']/identifier[@type='ctsurn']">
            <ctsurn>
                <xsl:value-of select="."/>
            </ctsurn>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>