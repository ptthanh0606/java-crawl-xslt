/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pt.utils;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.stream.StreamSource;
import com.pt.utils.UltimateURIResolver;

/**
 *
 * @author phant
 */
public class CrawlerUltimate {

    public static DOMResult crawl(String configPath, String xslPath) throws TransformerConfigurationException, TransformerException, FileNotFoundException, IOException {
        StreamSource xslCate = new StreamSource(xslPath);
        InputStream is = new FileInputStream(configPath);

        TransformerFactory factory = TransformerFactory.newInstance();
        DOMResult domRs = new DOMResult();
        UltimateURIResolver resolver = new UltimateURIResolver();

        factory.setURIResolver(resolver);
        Transformer transformer = factory.newTransformer(xslCate);

        StreamSource source = new StreamSource(is);
        transformer.transform(source, domRs);

        return domRs;
    }

}
