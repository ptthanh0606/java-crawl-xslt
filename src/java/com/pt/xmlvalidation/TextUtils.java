/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pt.xmlvalidation;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

/**
 *
 * @author phant
 */
public class TextUtils {

//    public static void main(String[] args) throws MalformedURLException, IOException {
//        URL url = new URL("https://classic.vn/cua-hang/cham-soc-toc/pomade/");
//        URLConnection connection = url.openConnection();
//        connection.setReadTimeout(8 * 1000);
//        connection.setConnectTimeout(8 * 1000);
//
//        String textContent = getString(connection.getInputStream());
//
//        textContent = TextUtils.refineHTML(textContent);
//
//        if (checkWellformedXML(textContent) != null) {
//            System.out.println("https://classic.vn/cua-hang/cham-soc-toc/pomade/" + " is well-formed!");
//        }
//    }
    public static String refineHTML(String src) {
        src = getBody(src);
        src = removeMiscellaneousTags(src);

        XmlSyntaxChecker xmlSyntaxChecker = new XmlSyntaxChecker();
        src = xmlSyntaxChecker.check(src);

        src = getBody(src);

        return src;
    }

    private static String getBody(String src) {
        String result = src;

        String expression = "<body.*?</body>";
        Pattern pattern = Pattern.compile(expression);

        Matcher matcher = pattern.matcher(result);

        if (matcher.find()) {
            result = matcher.group(0);
        }

        return result;
    }

    public static String removeMiscellaneousTags(String src) {
        String result = src;

        // Remove all script tags
        String expression = "<script.*?</script>";
        result = result.replaceAll(expression, "");

        // Remove all comments
        expression = "<!--.*?-->";
        result = result.replaceAll(expression, "");

        // Remove all whitespaces
        expression = "&nbsp;?";
        result = result.replaceAll(expression, "");

        // Remove all bullshit
        expression = "?";
        result = result.replaceAll(expression, "");

        // Remove all bullshit
        expression = "?";
        result = result.replaceAll(expression, "");

        return result;
    }

    public static String getString(InputStream stream) {
        StringBuilder stringBuilder = new StringBuilder();
        String line;

        try {
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(stream, StandardCharsets.UTF_8));
            while ((line = bufferedReader.readLine()) != null) {
                stringBuilder.append(line);
            }
        } catch (Exception e) {
        }

        return stringBuilder.toString();
    }

    public static boolean checkWellformedXML(String src) {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setValidating(false);
        factory.setNamespaceAware(true);

        DocumentBuilder builder;
        try {
            builder = factory.newDocumentBuilder();
        } catch (Exception e) {
            e.printStackTrace();

            return false;
        }

        builder.setErrorHandler(new ErrorHandler() {
            @Override
            public void warning(SAXParseException exception) throws SAXException {
            }

            @Override
            public void error(SAXParseException exception) throws SAXException {
            }

            @Override
            public void fatalError(SAXParseException exception) throws SAXException {
            }
        });

        try {
            InputStream stream = new ByteArrayInputStream(src.getBytes(StandardCharsets.UTF_8));
            builder.parse(stream);

            return true;
        } catch (SAXException | IOException e) {
            System.out.println("abc");
            return false;
        }
    }
}
