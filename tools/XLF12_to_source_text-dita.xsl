<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xlf12="urn:oasis:names:tc:xliff:document:1.2"
    exclude-result-prefixes="xs"
    version="2.0">

    <xsl:output method="text" indent="no"></xsl:output>
    <xsl:template match="xlf12:trans-unit[@translate='no']/xlf12:source//text()[normalize-space()]">
        <xsl:value-of select="normalize-space()"/><xsl:text>&#x0a;</xsl:text>
    </xsl:template>
    <xsl:template match="xlf12:trans-unit[not(@translate)]/xlf12:seg-source/xlf12:mrk//xlf12:ph[contains(./@id, 'locked')]">
        <xsl:text>&lt;xref id="</xsl:text><xsl:value-of select="@xid"/><xsl:text>"/&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="xlf12:trans-unit[not(@translate)]/xlf12:seg-source/xlf12:mrk//text()[normalize-space()]">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template match="xlf12:trans-unit[not(@translate)]/xlf12:seg-source/xlf12:mrk">
        <xsl:apply-templates select="node()"/>
        <xsl:text>&#x0a;</xsl:text>
    </xsl:template>
    <xsl:template match="xlf12:header"/>
    
    <xsl:template match="node()"><xsl:apply-templates select="node()"/></xsl:template>
</xsl:stylesheet>