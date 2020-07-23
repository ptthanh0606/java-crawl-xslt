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
                version="1.0">
    
    <xsl:template match="page1:products">
        <xsl:for-each select="page1:product">
            <xsl:call-template name="page1ProductTemplate">
                <xsl:with-param name="forwardLink" select="@link"/>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="page1ProductTemplate">
        <xsl:param name="forwardLink"/>
        <xsl:variable name="bodyDom" select="document($forwardLink)"/>
        <xsl:for-each select="$bodyDom//div[@class='product-small box ']">
            <xsl:variable name="productName" select="div[@class='box-text box-text-products text-center grid-style-2']//p[@class='name product-title']//a[normalize-space(text())]"/>
            <xsl:variable name="productPrice" select="div[@class='box-text box-text-products text-center grid-style-2']//span[@class='price']/span[@class='woocommerce-Price-amount amount'][1]/text()[normalize-space()]|./div[@class='box-text box-text-products text-center grid-style-2']//span[@class='price']/ins/span[@class='woocommerce-Price-amount amount'][1]/text()[normalize-space()]"/>
            <xsl:variable name="productImageUrl" select="div[@class='box-image']//div[@class='image-fade_in_back']//a//img/@src"/>
            <xsl:variable name="productLink" select="div[@class='box-image']//div[@class='image-fade_in_back']//a/@href"/>
            <xsl:variable name="detailDom" select="document($productLink)"/>
            <xsl:variable name="productCategory" select="$bodyDom//nav[@class='woocommerce-breadcrumb breadcrumbs uppercase']/*[5]/text()"/>
            <xsl:variable name="productSubCategory" select="$detailDom//*[@class='posted_in']/*[last()]/text()"/>
            <xsl:variable name="storeName" select="$detailDom//*[@class='copyright-footer']//a/text()"/>
            <xsl:element name="product">
                <xsl:element name="name">
                    <xsl:value-of select="$productName"/>
                </xsl:element>
                <xsl:element name="price">
                    <xsl:value-of select="translate($productPrice, ',', '')"/>
                </xsl:element>
                <xsl:element name="category">
                    <xsl:value-of select="$productCategory"/>
                </xsl:element>
                <xsl:element name="subCategory">
                    <xsl:value-of select="$productSubCategory"/>
                </xsl:element>
                <xsl:element name="img-src">
                    <xsl:value-of select="$productImageUrl"/>
                </xsl:element>
                <xsl:element name="link-url">
                    <xsl:value-of select="$productLink"/>
                </xsl:element>
                <xsl:variable name="productBrand" select="$detailDom//div[@class='page-title shop-page-title product-page-title']//nav[@class='woocommerce-breadcrumb breadcrumbs uppercase']/*[last()]/text()"/>
                <xsl:element name="brand">
                    <xsl:value-of select="$productBrand"/>
                </xsl:element>
                <xsl:element name="store-name">
                    <xsl:value-of select="$storeName"/>                        
                </xsl:element>
            </xsl:element>
        </xsl:for-each>
        
        <xsl:variable name="nextPageLink" select="$bodyDom//a[@class='next page-number']/@href"/>
        
        <xsl:if test="$nextPageLink != ''">
            <xsl:call-template name="page1ProductTemplate">
                <xsl:with-param name="forwardLink" select="$nextPageLink"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
