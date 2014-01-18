package dao;

import com.googlecode.objectify.*;

import entity.*;

import java.util.*;

public class LocationDAO implements java.io.Serializable{
    private static final long serialVersionUID = 1L;
    //private static final String TBLNAME = "location";
    
    
    
    public Location retrieve(Long id) {
		try{
			return OfyService.getOfy().get(Location.class, id);    
		}catch(Exception e){
			return null;
		}
    }

    public List<Location> retrieveAll() {
    	Query<Location> q = OfyService.getOfy().query(Location.class);
    	return q.list();    
    }
    
    public void modify(Location location){
    	OfyService.getOfy().put(location);
    }
    
    public void addLocations(ArrayList<Location> locations){
		OfyService.getOfy().put(locations);
	}
		
	public void removeAll(){
	    Objectify ofy = OfyService.getOfy();
	    Iterable<Key<Location>> allLocationKeys = ofy.query(Location.class).fetchKeys();
	    ofy.delete(allLocationKeys);
	   
	    
	}
  
}
