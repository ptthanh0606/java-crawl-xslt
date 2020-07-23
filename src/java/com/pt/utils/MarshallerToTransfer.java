/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pt.utils;

import com.pt.beans.response.Products;
import java.io.OutputStream;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;

/**
 *
 * @author phant
 */
public class MarshallerToTransfer {

    public static void marshallerToTransfer(Products products, OutputStream os) {
        try {
            JAXBContext jaxbc = JAXBContext.newInstance(Products.class);
            Marshaller marshaller = jaxbc.createMarshaller();

            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
            marshaller.setProperty(Marshaller.JAXB_ENCODING, "UTF-8");

            marshaller.marshal(products, os);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
