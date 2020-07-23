<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : websiteTargetStyleSheet.xsl
    Created on : July 5, 2020, 6:02 PM
    Author     : phant
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:page1="https://www.page1.com"
                xmlns:page2="https://www.page2.com"
                xmlns:page3="https://www.page3.com"
                version="1.0">
    <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
    
    <xsl:template match="products-breakpoint">
        <xsl:element name="products">
            <xsl:apply-templates select="page1:products"/>
            <xsl:apply-templates select="page2:products"/>
            <xsl:apply-templates select="page3:products"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:include href="../PAGE1_XSL/product_stylesheet_page1.xsl"/>
    <xsl:include href="../PAGE2_XSL/product_stylesheet_page2.xsl"/>
    <xsl:include href="../PAGE3_XSL/product_stylesheet_page3.xsl"/>
</xsl:stylesheet>
