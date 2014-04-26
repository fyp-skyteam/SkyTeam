package dao;

import com.googlecode.objectify.*;

import entity.*;

import java.util.*;

public class UserDAO implements java.io.Serializable{
    private static final long serialVersionUID = 1L;
    //private static final String TBLNAME = "location";
    
    public User authenticate(String username, String password){
		User user = retrieveByUsername(username);
		if(user!=null){			
			if (user.authenticate(password)){
				return user;
			}
		}
		return null;
	}
    
    public User retrieveByUsername(String username){
    	return (User)OfyService.getOfy().query(User.class).filter("username =",username).get();
    }
    
    public User retrieve(Long id) {
		try{
			return OfyService.getOfy().get(User.class, id);    
		}catch(Exception e){
			return null;
		}
    }

    public List<User> retrieveAll() {
    	Query<User> q = OfyService.getOfy().query(User.class);
    	return q.list();    
    }
    
    public void modify(User user){
    	OfyService.getOfy().put(user);
    }
    
    public void addUser(ArrayList<User> users){
		OfyService.getOfy().put(users);
	}
		
	public void removeAll(){
	    Objectify ofy = OfyService.getOfy();
	    Iterable<Key<User>> allUserKeys = ofy.query(User.class).fetchKeys();
	    ofy.delete(allUserKeys); 
	}
	
	public void removeUserById(Long id){
	    Objectify ofy = OfyService.getOfy();
		ofy.delete(User.class, id); 
	}
	
	public ArrayList<String> getError(String name, String password){
		ArrayList<String> output = new ArrayList<String>();
		if(name.trim().isEmpty()){
			output.add("Name field is empty");
		}
		/*if(username.trim().isEmpty()){
			output.add("Username field is empty");
		}else if(duplicateUsername(username)){
			output.add("Duplicate username");
		}*/
		if(password.trim().isEmpty()){
			output.add("Password field is empty");
		}
		
		return output;
	}
	
	/*public boolean duplicateUsername(String username){
		List<User> users = retrieveAll();
		boolean duplicate = false;
		for(User u: users){
			if(u.getUsername().trim().equals(username.trim())){
				duplicate = true;
				break;
			}
		}
		return duplicate;
	}*/
}	
