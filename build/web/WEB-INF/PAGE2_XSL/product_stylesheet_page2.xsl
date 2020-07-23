<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : product_stylesheet_page2.xsl
    Created on : July 10, 2020, 11:01 PM
    Author     : phant
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:page2="https://www.page2.com"
                version="1.0">

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    
    <xsl:template match="page2:products">
        <xsl:for-each select="page2:product">
            <xsl:call-template name="page2ProductTemplate">
                <xsl:with-param name="forwardLink" select="@link"/>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="page2ProductTemplate">
        <xsl:param name="forwardLink"/>
        <xsl:variable name="bodyDom" select="document($forwardLink)"/>
        <xsl:for-each select="$bodyDom//div[@class='product-small box ']">
            <xsl:variable name="productName" select="div[@class='box-text box-text-products text-center grid-style-2']//p[@class='name product-title']/a/text()"/>
            <xsl:variable name="productPrice" select="div[@class='box-text box-text-products text-center grid-style-2']//span[@class='price']/span[@class='woocommerce-Price-amount amount'][1]/text()[normalize-space()]|./div[@class='box-text box-text-products text-center grid-style-2']//span[@class='price']/ins/span[@class='woocommerce-Price-amount amount'][1]/text()[normalize-space()]"/>
            <xsl:variable name="productImageUrl" select="div[@class='box-image']//div[@class='image-fade_in_back']/a/img/@data-src"/>
            <xsl:variable name="productLink" select="div[@class='box-image']//div[@class='image-fade_in_back']//a/@href"/>
            <xsl:variable name="detailDom" select="document($productLink)"/>
            <xsl:variable name="productCategory" select="$detailDom//nav[@class='woocommerce-breadcrumb breadcrumbs uppercase']/*[last()-2]/text()"/>
            <xsl:variable name="productSubCategory" select="$detailDom//nav[@class='woocommerce-breadcrumb breadcrumbs uppercase']/*[last()]/text()"/>
            <xsl:variable name="storeName" select="$detailDom//*[@class='footer-text inline-block small-block']//a/text()"/>
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
                <xsl:variable name="productBrand" select="$detailDom//main//span[@class='posted_in'][last()]/a/text()"/>
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
            <xsl:call-template name="page2ProductTemplate">
                <xsl:with-param name="forwardLink" select="$nextPageLink"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
