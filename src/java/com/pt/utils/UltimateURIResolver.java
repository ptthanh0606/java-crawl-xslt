/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pt.utils;

import com.pt.xmlvalidation.TextUtils;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import javax.xml.transform.Source;
import javax.xml.transform.TransformerException;
import javax.xml.transform.URIResolver;
import javax.xml.transform.stream.StreamSource;

/**
 *
 * @author phant
 */
public class UltimateURIResolver implements URIResolver {

    @Override
    public Source resolve(String href, String base) throws TransformerException {
        if (href != null) {
            try {
                InputStream inputStream = HttpUtils.getHttp(href);
                String textContent = TextUtils.getString(inputStream);
                textContent = TextUtils.refineHTML(textContent);
                if (TextUtils.checkWellformedXML(textContent)) {
                    System.out.println("Wellformed Href: " + href);
                    StreamSource source = new StreamSource(new ByteArrayInputStream(textContent.getBytes(StandardCharsets.UTF_8)));

                    return source;
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return null;
    }
}
