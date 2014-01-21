package entity;
import javax.persistence.*;

public class User implements java.io.Serializable{
  private static final long serialVersionUID = 1;
	@Id private Long id;
  private String username;  
	private String name;
	private String password;
  
  
  public User() {
  } 

  
  /**
  public User(String username, String name, String password) {
    this(-1,username, name,password);
  }*/
  
  public User(String username, String name, String password) {
	  	//this.id = id;  
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
    this.password = password;
  } // setPassword

  public boolean authenticate(String password) {
    return password.equals(this.password);
  } // authenticate
  
} /* class User */
