/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pt.utils;

import java.sql.Connection;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 *
 * @author phant
 */
public class DatabaseConnectionUtil {

    public static Connection getDatabaseConnection() {
        try {
            Context c = new InitialContext();
            Context envContext = (Context) c.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("DBConnection");

            Connection con = ds.getConnection();

            return con;
        } catch (Exception e) {
        }
        return null;
    }

}
