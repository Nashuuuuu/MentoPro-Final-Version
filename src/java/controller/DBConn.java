package controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConn {
    public static Connection getConnection() throws SQLException {
        try {
            
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            return DriverManager.getConnection("jdbc:derby://localhost:1527/mentopro_db", "app", "app");
        } catch (ClassNotFoundException e) {
            
            throw new SQLException("JDBC Driver not found: " + e.getMessage());
        }
    }
}