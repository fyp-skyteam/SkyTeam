package entity;

public class User {
  private String username;  
  private String name;
  private String password;
  
  
  public User() {
  } // default constructor
  // Constructor for easy creation

  public User(String username, String name, String password) {
    this.username = username;
    this.name = name;
    this.password = password;
  }

  public String getUsername(){
      return username;
  }
  
  public String getName() {
    return name;
  } // getName

  public void setName(String name) {
    this.name = name;
  } // setName

  public void setUsername(String username){
     this.username = username;
  }
  
  public void setPassword(String password) {
    // encryption here possible
    this.password = password;
  } // setPassword

  public boolean authenticate(String password) {
    return password.equals(this.password);
  } // authenticate
  
} /* class User */
