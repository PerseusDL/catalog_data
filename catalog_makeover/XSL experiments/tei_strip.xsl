<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="text"/>
    <xsl:template match="/">
        <xsl:apply-templates select="//text()"/>
    </xsl:template>
    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>
    <!--  -->
</xsl:stylesheet>
<!-- Sure, here is a line-by-line explanation of the XSLT code:

    The first line declares the XML version and encoding of the XSLT stylesheet.
    The second line declares the namespace for the XSLT stylesheet.
    The third line specifies that the output of the XSLT transformation should be plain text.
    The fourth line defines a template that matches the root element of the XML document.
    The fifth line applies the templates in the sixth line to all text nodes in the XML document.
    The sixth line defines a template that matches text nodes.
    The seventh line outputs the value of the text node to the output stream.

So, the XSLT stylesheet first declares that it is using XML version 1.0 
and is encoded in UTF-8. Then, it specifies that the output of 
the transformation should be plain text. Next, 
it defines a template that matches the root element of the XML document. 
This template then applies another template to all text nodes in the XML document.
The final template simply outputs the value of the text node to the output stream. -->