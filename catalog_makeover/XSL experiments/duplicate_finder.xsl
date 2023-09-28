<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes"/>
    <xsl:key name="ctsurns" match="ctsurn" use="."/>
    <xsl:template match="/">
        <duplicate>
            <xsl:for-each-group select="//ctsurn" group-by=".">
                <xsl:if test="count(current-group()) > 1">
                    <xsl:variable name="first" select="current-group()[1]"/>
                    <cts-urn>
                        <xsl:value-of select="$first"/>
                    </cts-urn>
                </xsl:if>
            </xsl:for-each-group>
        </duplicate>
    </xsl:template>
</xsl:stylesheet>