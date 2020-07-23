/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pt.utils;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

/**
 *
 * @author phant
 */
public class HttpUtils {

    public static InputStream getHttp(String href) throws MalformedURLException, IOException {
        if (href.indexOf("http://") == 0 | href.indexOf("https://") == 0) {

            URL url = new URL(href);
            URLConnection connection = url.openConnection();
            connection.setReadTimeout(8 * 1000);
            connection.setConnectTimeout(8 * 1000);
            
            return connection.getInputStream();
        }

        return null;
    }

}
