<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>    
    <xsl:template match="/">
        <xsl:element name="expression_identifiers">
            <xsl:for-each select="//*[@type='constituent']/*[@otherType='expression']/*[@type='ctsurn']">
                <ctsurn>
                    <xsl:value-of select="."/>
                </ctsurn>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
<!-- This script can be used to pull a list of expression level cts identifiers and save it as an
XML file entitled expression_identifiers -->