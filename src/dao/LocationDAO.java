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
	
	public int getNumberOfDataset(){
		List<Location> locations = retrieveAll();
		int output = 0;
		if(locations.size()!=0 || locations!=null){
			for(Location l:locations){
				if(l.getDatasetNumber()>output){
					output = l.getDatasetNumber();
				}
			}
		}
		return output;
	}
	
	public List<String> retrieveAllBuildingTypes(){
		ArrayList<String> duplicateBuildingTypes = new ArrayList<String>();
		List<Location> locations = retrieveAll();
		if(locations.size()!=0 || locations!=null){
			for(Location l: locations){
				duplicateBuildingTypes.add(l.getBuildingType());
			}
			Set set = new HashSet(duplicateBuildingTypes);
			ArrayList uniqueBuildingTypes = new ArrayList(set);
			return uniqueBuildingTypes;
		}else{
			return duplicateBuildingTypes;
		}
		
	}
	
	public double getMinimumHeight(){
		List<Location> locations = retrieveAll();
		double output = 0;
		if(locations.size()!=0 || locations!=null){
			output = locations.get(1).getBuildingHeight();
			for(Location l: locations){
				if(l.getBuildingHeight()<output){
					output = l.getBuildingHeight();
				}
			}
		}
		return output;
	}
	
	public double getMaximumHeight(){
		List<Location> locations = retrieveAll();
		double output = 0;
		if(locations.size()!=0 || locations!=null){
			output = locations.get(1).getBuildingHeight();
			for(Location l: locations){
				if(l.getBuildingHeight()>output){
					output = l.getBuildingHeight();
				}
			}
		}
		return output;
	}
	
	public List<Location> retrieveByConditions(String[] buildingTypes, String buildingName){
		List<Location> locations = retrieveAll();
		for(String buildingType: buildingTypes){
			locations = retrieveByBuildingType(buildingType, locations);
		}
		locations = retrieveByBuildingName(buildingName, locations);
		return locations;
	}
	
	public List<Location> retrieveByBuildingType(String buildingType, List<Location> locations){
		List<Location> output = new ArrayList<Location>();
		for(Location l: locations){
			if(l.getBuildingType().equals(buildingType)){
				output.add(l);
			}
		}
		return output;
	}
	
	public List<Location> retrieveByBuildingName(String buildingName, List<Location> locations){
		List<Location> output = new ArrayList<Location>();
		for(Location l: locations){
			if(l.getBuildingName().equals(buildingName)){
				output.add(l);
			}
		}
		return output;
	}
  
}
