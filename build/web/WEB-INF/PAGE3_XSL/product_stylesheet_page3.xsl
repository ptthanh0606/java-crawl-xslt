<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : product_stylesheet_page3.xsl
    Created on : July 19, 2020, 3:08 PM
    Author     : phant
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:page3="https://www.page3.com"
                version="1.0">

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    
    <xsl:template match="page3:products">
        <xsl:for-each select="page3:product">
            <xsl:call-template name="page3ProductTemplate">
                <xsl:with-param name="forwardLink" select="@link"/>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="page3ProductTemplate">
        <xsl:param name="forwardLink"/>
        <xsl:variable name="bodyDom" select="document($forwardLink)"/>
        <xsl:for-each select="$bodyDom//div[@id='products_filter']//div[@class='inner-top']">
            <xsl:variable name="productName" select="div[@class='product-bottom']//a/text()"/>
            <xsl:variable name="productPrice" select="div[@class='product-bottom']//span[@class='special-price']//span[@class='money']/text()"/>
            <xsl:variable name="productImageUrl" select="div[@class='product-top']//img/@src"/>
            <xsl:variable name="productLink" select="div[@class='product-bottom']//a/@href"/>
            <xsl:variable name="detailDom" select="document($productLink)"/>
            <xsl:variable name="storeName" select="$bodyDom//a[@class='navbar-brand domain']/text()"/>
            <xsl:element name="product">
                <xsl:element name="name">
                    <xsl:value-of select="$productName"/>
                </xsl:element>
                <xsl:element name="price">
                    <xsl:value-of select="translate(translate($productPrice, ',', ''), ' VNĐ', '')"/>
                </xsl:element>
                <xsl:element name="img-src">
                    <xsl:value-of select="$productImageUrl"/>
                </xsl:element>
                <xsl:element name="link-url">
                    <xsl:value-of select="$productLink"/>
                </xsl:element>
                <xsl:variable name="productBrand" select="$detailDom//*[@id='canvas']//div[@class='product-infor']/p[2]//span/text()"/>
                <xsl:element name="brand">
                    <xsl:value-of select="$productBrand"/>
                </xsl:element>
                <xsl:element name="store-name">
                    <xsl:value-of select="$storeName"/>                        
                </xsl:element>
            </xsl:element>
        </xsl:for-each>
        
        <xsl:variable name="nextPageLink" select="$bodyDom//div[@class='pages']//li[@class='last']/a/@href"/>
        
        <xsl:if test="$nextPageLink != ''">
            <xsl:call-template name="page3ProductTemplate">
                <xsl:with-param name="forwardLink" select="$nextPageLink"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
