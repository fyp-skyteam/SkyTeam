package dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

/**
 * To create a Connection object for use
 */
public class GISConnectionManager {

  private Connection connection = null;
    public void establishConnection()
    {
        if (connection != null)
            return;
        String url = "Jdbc:postgresql://localhost:5432/";
        try
        {
           Class.forName("org.postgresql.Driver");
          
           
           connection = DriverManager.getConnection(url, "postgres", "postgres");
           
           if (connection != null) {
               System.out.println("Connecting to database...");
           }
        } catch(Exception e){
            System.out.println("Problem when connecting to the database 1");
        }
    }
          public ResultSet giveName()
    {
        ResultSet rs = null;
        Statement s = null;
        try
        {
            s = connection.createStatement();
            
            rs = s.executeQuery("SELECT * FROM geointel");
        }catch(Exception e)
        {
            System.out.println("Problem in searching the database 1");
        }
        return rs;
    }
public void closeConnection()
    {
        try
        {
            connection.close();
        }catch(Exception e)
        {
            System.out.println("Problem to close the connection to the database");
        }
    }

}
