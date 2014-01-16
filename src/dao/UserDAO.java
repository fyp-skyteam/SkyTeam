package dao;

import entity.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO {
  
  public User retrieve(String username) {
    User user = null;
    try {
      Connection conn = ConnectionManager.getConnection();
      PreparedStatement stmt = 
              conn.prepareStatement("SELECT username, name, password FROM user WHERE username = ?");
      stmt.setString(1, username);
      ResultSet rs = stmt.executeQuery();
      while (rs.next()){
        String username1 = rs.getString(1);
        String name = rs.getString(2);
        String password = rs.getString(3);
        user = new User(username1, name, password);
      }
    } catch (SQLException ex) {
      Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, 
              "Unable to retrieve username = '"+username + "'", ex);
    }
    
    return user;
  }
  
}
