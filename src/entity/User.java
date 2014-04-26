package entity;
import javax.persistence.*;
import java.util.*;

public class User implements java.io.Serializable{
  private static final long serialVersionUID = 1;
	@Id private Long id;
	private String username;  
	private String name;
	private String password;
	private ArrayList<String> widgets;
  
  
  public User() {
  } 

  
  /**
  public User(String username, String name, String password) {
    this(-1,username, name,password);
  }*/
  
  public User(String username, String name, String password, ArrayList<String> widgets) {
	  	//this.id = id;  
	  	this.username = username;
	    this.name = name;
	    this.password = password;
	    this.widgets = widgets;
 }

  public String getUsername(){
      return username;
  }
  
  public String getName() {
    return name;
  } // getName

  public String getPassword(){
	  return password;
  }
  
  public Long getId(){
	  return id;
  }
  
  public ArrayList<String> getWidgets(){
	  return widgets;
  }
  
  public void setName(String name) {
    this.name = name;
  } // setName

  public void setUsername(String username){
     this.username = username;
  }
  
  public void setPassword(String password) {
    this.password = password;
  } // setPassword
  
  public void setWidgets(ArrayList<String> widgets){
	  this.widgets = widgets;
  }

  public boolean authenticate(String password) {
    return password.equals(this.password);
  } // authenticate
  
} /* class User */
