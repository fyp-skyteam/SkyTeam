package dao;

import com.googlecode.objectify.*;

import entity.*;

import java.util.*;

public class LocationMetadataDAO implements java.io.Serializable{
    private static final long serialVersionUID = 1L;
    //private static final String TBLNAME = "location";
     
    public LocationMetadata retrieve(Long id) {
		try{
			return OfyService.getOfy().get(LocationMetadata.class, id);    
		}catch(Exception e){
			return null;
		}
    }

    public List<LocationMetadata> retrieveAll() {
    	Query<LocationMetadata> q = OfyService.getOfy().query(LocationMetadata.class);
    	return q.list();    
    }
    
    public void modify(LocationMetadata locationMetadata){
    	OfyService.getOfy().put(locationMetadata);
    }
    
    public void addLocationMetadata(ArrayList<LocationMetadata> locationMetadata){
		OfyService.getOfy().put(locationMetadata);
	}
		
	public void removeAll(){
	    Objectify ofy = OfyService.getOfy();
	    Iterable<Key<LocationMetadata>> allKeys = ofy.query(LocationMetadata.class).fetchKeys();
	    ofy.delete(allKeys); 
	}
	
	/*public LocationMetadata retrieveByColumnName(String columnName){
    	return (LocationMetadata)OfyService.getOfy().query(LocationMetadata.class).filter("columnName =",columnName).get();
    }*/

	public List<LocationMetadata> retrieveByColumnName(String columnName){
		List<LocationMetadata> output = new ArrayList<LocationMetadata>();
		Objectify ofy = OfyService.getOfy();
		Query<LocationMetadata> q = ofy.query(LocationMetadata.class);
		q.filter("columnName ==", columnName);
		if(q!=null){
			for(LocationMetadata l: q){
				output.add(l);
			}
		}
		return output;
	}
	
	public ArrayList<String> retrieveValuesByColumnName(String columnName){
		ArrayList<String> output = new ArrayList<String>();
		List<LocationMetadata> data = retrieveByColumnName(columnName);
		for(LocationMetadata l: data){
			output.add(l.getValue());
		}
		return output;
	}
	
	public HashMap<String,Double> retrieveVIndexByColumnName(String columnName){
		HashMap<String,Double> output = new HashMap<String,Double>();
		List<LocationMetadata> data = retrieveByColumnName(columnName);
		for(LocationMetadata l: data){
			output.put(l.getValue(),l.getVIndex());
		}
		return output;
	}
	
}	