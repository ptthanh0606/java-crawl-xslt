/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pt.products;

import com.pt.beans.ProductType;
import com.pt.beans.response.Products;
import com.pt.utils.DatabaseConnectionUtil;
import com.pt.utils.MarshallerToTransfer;
import java.io.OutputStream;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author phant
 */
public class ProductsDAO implements Serializable {

    public void addProductsToDB(ProductType product) throws SQLException {
        Connection con = null;
        PreparedStatement ps = null;
        String query = "INSERT INTO tblProducts values (?, ?, ?, ?, ?, ?)";

        try {
            con = DatabaseConnectionUtil.getDatabaseConnection();
            if (con != null) {
                ps = con.prepareStatement(query);
                ps.setString(1, product.getName());
                ps.setBigDecimal(2, product.getPrice());
                ps.setString(3, product.getImgSrc());
                ps.setString(4, product.getLinkUrl());
                ps.setString(5, product.getBrand());
                ps.setString(6, product.getStoreName());

                ps.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                ps.close();
            }

            if (con != null) {
                con.close();
            }
        }
    }

    public boolean isDataExistInDB() throws SQLException {
        Statement s = null;
        ResultSet rs = null;
        Connection con = null;

        String query = "select top 1 * from tblProducts";
        try {
            con = DatabaseConnectionUtil.getDatabaseConnection();
            if (con != null) {
                s = con.createStatement();
                rs = s.executeQuery(query);

                if (rs.next()) {
                    return true;
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (s != null) {
                    s.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public void getAllProducts(OutputStream os) {
        Statement s = null;
        ResultSet rs = null;
        Connection con = null;

        String query = "select top 15 * from tblProducts order by NEWID()";
        try {
            con = DatabaseConnectionUtil.getDatabaseConnection();
            if (con != null) {
                s = con.createStatement();
                rs = s.executeQuery(query);

                Products productList = new Products();

                while (rs.next()) {
                    com.pt.beans.response.ProductType product = new com.pt.beans.response.ProductType();

                    product.setId(rs.getString("id"));
                    product.setName(rs.getString("name"));
                    product.setPrice(rs.getBigDecimal("price"));
                    product.setImgSrc(rs.getString("imageUrl"));
                    product.setLinkUrl(rs.getString("linkUrl"));
                    product.setBrand(rs.getString("brand"));
                    product.setStoreName(rs.getString("storeName"));

                    productList.getProduct().add(product);
                }

                MarshallerToTransfer.marshallerToTransfer(productList, os);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (s != null) {
                    s.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void searchProduct(String requestParam, OutputStream os) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        Connection con = null;

        String query = "select * from tblProducts p where p.name LIKE ?";

        try {

            con = DatabaseConnectionUtil.getDatabaseConnection();
            if (con != null) {
                ps = con.prepareStatement(query);
                ps.setString(1, "%" + requestParam + "%");
                rs = ps.executeQuery();

                Products productList = new Products();

                while (rs.next()) {
                    com.pt.beans.response.ProductType product = new com.pt.beans.response.ProductType();

                    product.setId(rs.getString("id"));
                    product.setName(rs.getString("name"));
                    product.setPrice(rs.getBigDecimal("price"));
                    product.setImgSrc(rs.getString("imageUrl"));
                    product.setLinkUrl(rs.getString("linkUrl"));
                    product.setBrand(rs.getString("brand"));
                    product.setStoreName(rs.getString("storeName"));

                    productList.getProduct().add(product);
                }

                MarshallerToTransfer.marshallerToTransfer(productList, os);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void getAllProductNameAndStore(String storeName, String productName, OutputStream os) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        Connection con = null;

        String query = "select * \n"
                + "from tblProducts p\n"
                + "where p.storeName != ? and p.name LIKE ?\n"
                + "order by p.price ASC";

        try {

            con = DatabaseConnectionUtil.getDatabaseConnection();
            if (con != null) {
                ps = con.prepareStatement(query);
                ps.setString(1, storeName);
                ps.setString(2, "%" + productName + "%");
                rs = ps.executeQuery();

                Products productList = new Products();

                while (rs.next()) {
                    com.pt.beans.response.ProductType product = new com.pt.beans.response.ProductType();

                    product.setId(rs.getString("id"));
                    product.setName(rs.getString("name"));
                    product.setPrice(rs.getBigDecimal("price"));
                    product.setImgSrc(rs.getString("imageUrl"));
                    product.setLinkUrl(rs.getString("linkUrl"));
                    product.setBrand(rs.getString("brand"));
                    product.setStoreName(rs.getString("storeName"));

                    productList.getProduct().add(product);

                }
                MarshallerToTransfer.marshallerToTransfer(productList, os);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
