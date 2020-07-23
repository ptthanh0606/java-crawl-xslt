/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pt.servlets;

import com.pt.beans.ProductType;
import com.pt.beans.Products;
import com.pt.products.ProductsDAO;
import com.pt.utils.CrawlerUltimate;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

/**
 *
 * @author phant
 */
public class InitDataServlet extends HttpServlet {

    private static final String XML_CONFIG_FILE_NAME = "WEB-INF/XML/master_config.xml";
    private static final String XSL_FILE_NAME = "WEB-INF/XML/master_stylesheet.xsl";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/xml;charset=UTF-8");
        ProductsDAO dao = new ProductsDAO();
        try {
            if (!dao.isDataExistInDB()) {
                crawlData();
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServletDispatcher.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            dao.getAllProducts(response.getOutputStream());
        }
    }

    private void crawlData() {
        String realPath = this.getServletContext().getRealPath("/");
        try {
            DOMResult rs = CrawlerUltimate.crawl(realPath + XML_CONFIG_FILE_NAME, realPath + XSL_FILE_NAME);
            TransformerFactory factory = TransformerFactory.newInstance();
            Transformer transformer = factory.newTransformer();

            StreamResult result = new StreamResult(new FileOutputStream(realPath + "crawl_result.xml"));
            DOMSource dOMSource = new DOMSource(rs.getNode());

            transformer.transform(dOMSource, result);
            jaxbUnmarshallResult();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private boolean jaxbUnmarshallResult() throws SQLException {
        String realPath = this.getServletContext().getRealPath("/");
        try {
            JAXBContext jaxbc = JAXBContext.newInstance(Products.class);
            Unmarshaller u = jaxbc.createUnmarshaller();
            File f = new File(realPath + "crawl_result.xml");
            Products products = (Products) u.unmarshal(f);
            ProductsDAO dao = new ProductsDAO();

            for (int i = 0; i < products.getProduct().size(); i++) {
                ProductType productType = products.getProduct().get(i);
                productType.setName(filterProductName(productType.getName()));
                productType.setBrand(filterProductName(productType.getBrand()));

                dao.addProductsToDB(productType);
            }

            return true;
        } catch (JAXBException e) {
            e.printStackTrace();
        }
        return false;
    }

    private String filterProductName(String name) {
        String expression = "&.*;";
        name = name.replaceAll(expression, "");

        return name;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
