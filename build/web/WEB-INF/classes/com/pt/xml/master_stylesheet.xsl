<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : websiteTargetStyleSheet.xsl
    Created on : July 5, 2020, 6:02 PM
    Author     : phant
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:page1="https://www.facebook.com/xml"
                xmlns:page2="https://www.pt.com/xml"
                version="1.0">
    <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
    
    <xsl:template match="products-breakpoint">
        <xsl:element name="products">
            <xsl:apply-templates select="page1:products"/>
            <xsl:apply-templates select="page2:products"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:include href="page1/product_stylesheet_page1.xsl"/>
    <xsl:include href="page2/product_stylesheet_page2.xsl"/>
</xsl:stylesheet>
