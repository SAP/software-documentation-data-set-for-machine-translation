<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xlf12="urn:oasis:names:tc:xliff:document:1.2"
    exclude-result-prefixes="xs"
    version="2.0">

    <xsl:output method="text" indent="no"></xsl:output>
    <xsl:template match="xlf12:trans-unit[not(@translate)]/xlf12:seg-source/xlf12:mrk[@mtype='seg']//xlf12:ph">
        <xsl:if test="contains(., 'xref') or contains(., 'keyref')">
            <xsl:text>&lt;locked-ref&gt;</xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="xlf12:trans-unit[not(@translate)]/xlf12:seg-source/xlf12:mrk[@mtype='seg']">
        <xsl:apply-templates select="node()"/>
        <xsl:text>&#x0a;</xsl:text>
    </xsl:template>
    <xsl:template match="xlf12:trans-unit[not(@translate)]/xlf12:seg-source/xlf12:mrk[@mtype='seg']//text()[normalize-space()]">
        <xsl:value-of select="replace(., '[&#xe000;-&#xF8FF;&#x0a;]', '')"/>
    </xsl:template>
    
    <xsl:template match="xlf12:trans-unit[not(@translate)]/xlf12:seg-source/xlf12:mrk[@mtype='seg']//xlf12:bpt">
        <xsl:if test="contains(., 'sap-icon-font-character')">
            <xsl:text>&lt;locked-ref&gt;</xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="xlf12:trans-unit[not(@translate)]/xlf12:seg-source/xlf12:mrk[@mtype='seg']//xlf12:ept" />
    <xsl:template match="xlf12:header"/>
    
    <xsl:template match="node()"><xsl:apply-templates select="node()"/></xsl:template>
</xsl:stylesheet>