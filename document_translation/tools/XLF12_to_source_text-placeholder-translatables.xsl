<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xlf12="urn:oasis:names:tc:xliff:document:1.2"
    exclude-result-prefixes="xs"
    version="2.0">

    <xsl:output method="text" indent="no"></xsl:output>
    <xsl:template match="xlf12:seg-source/xlf12:mrk[@mtype='seg']//xlf12:mrk[@mtype='protected']">
        <xsl:text>&lt;mrk mtype="protected"&gt;</xsl:text>
        <xsl:apply-templates select="node()"/>
        <xsl:text>&lt;/mrk&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="xlf12:trans-unit[not(@translate)]/xlf12:seg-source/xlf12:mrk[@mtype='seg']">
        <xsl:apply-templates select="node()"/>
        <xsl:text>&#x0a;</xsl:text>
    </xsl:template>
    <xsl:template match="xlf12:trans-unit[not(@translate)]/xlf12:seg-source/xlf12:mrk[@mtype='seg']//text()[normalize-space()]">
        <xsl:value-of select="translate(.,'&#x0a;', '')"/>
    </xsl:template>
    <xsl:template match="xlf12:trans-unit[not(@translate)]/xlf12:seg-source/xlf12:mrk[@mtype='seg']//xlf12:ph">
        <xsl:text>&lt;x id="</xsl:text><xsl:value-of select="@id"/><xsl:text>"</xsl:text>
        <xsl:if test="@xid">
            <xsl:text> xid="</xsl:text><xsl:value-of select="@xid"/><xsl:text>"</xsl:text>
        </xsl:if>
        <xsl:text>/&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="xlf12:trans-unit[not(@translate)]/xlf12:seg-source/xlf12:mrk[@mtype='seg']//xlf12:bpt">
        <xsl:text>&lt;g id="</xsl:text><xsl:value-of select="@id"/><xsl:text>"&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="xlf12:trans-unit[not(@translate)]/xlf12:seg-source/xlf12:mrk[@mtype='seg']//xlf12:ept">
        <xsl:text>&lt;/g&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="xlf12:header"/>
    
    <xsl:template match="node()"><xsl:apply-templates select="node()"/></xsl:template>
</xsl:stylesheet>