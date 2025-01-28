<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xlf12="urn:oasis:names:tc:xliff:document:1.2"
    exclude-result-prefixes="xs"
    version="2.0">

    <xsl:output method="text" indent="no"></xsl:output>
    <xsl:template match="xlf12:trans-unit[not(@translate)]/xlf12:target/xlf12:mrk[@mtype='seg']//text()[normalize-space()]">
        <xsl:value-of select="translate(.,'&#x0a;', '')"/>
    </xsl:template>

    <xsl:template match="xlf12:trans-unit[not(@translate)]/xlf12:target/xlf12:mrk[@mtype='seg']">
        <xsl:apply-templates select="node()"/>
        <xsl:text>&#x0a;</xsl:text>
    </xsl:template>
    <xsl:template match="xlf12:header"/>
    
    <xsl:template match="node()"><xsl:apply-templates select="node()"/></xsl:template>
</xsl:stylesheet>