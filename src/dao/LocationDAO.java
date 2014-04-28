package dao;

import com.googlecode.objectify.*;

import entity.*;

import java.util.*;

public class LocationDAO implements java.io.Serializable{
    private static final long serialVersionUID = 1L;

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
	
	public void removeUserLocations(String username){
		Objectify ofy = OfyService.getOfy();
		Query<Location> q = ofy.query(Location.class);
		q.filter("username ==", username);
		Iterable<Key<Location>> allLocationKeys = q.fetchKeys();
		ofy.delete(allLocationKeys);
	}

	public ArrayList<String> getDatasetListByUsername(String username){
		ArrayList<String> duplicateDatasets = new ArrayList<String>();
		List<Location> locations = retrieveByUsername(username);
		if(locations.size()!=0 || locations!=null){
			for(Location l: locations){
				duplicateDatasets.add(l.getCSVName());
			}
			Set set = new HashSet(duplicateDatasets);
			ArrayList uniqueDatasets = new ArrayList(set);
			return uniqueDatasets;
		}else{
			return duplicateDatasets;
		}
	}
	
	public ArrayList<String> retrieveAllBuildingTypes(List<Location> locations){
		ArrayList<String> duplicateBuildingTypes = new ArrayList<String>();
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
	
	public ArrayList<String> retrieveAllFoundationTypes(List<Location> locations){
		ArrayList<String> duplicateFoundationTypes = new ArrayList<String>();
		if(locations.size()!=0 || locations!=null){
			for(Location l: locations){
				duplicateFoundationTypes.add(l.getFoundationType());
			}
			Set set = new HashSet(duplicateFoundationTypes);
			ArrayList uniqueFoundationTypes = new ArrayList(set);
			return uniqueFoundationTypes;
		}else{
			return duplicateFoundationTypes;
		}	
	}
	
	public ArrayList<String> retrieveAllMasonryTypes(List<Location> locations){
		ArrayList<String> duplicateMasonryTypes = new ArrayList<String>();
		if(locations.size()!=0 || locations!=null){
			for(Location l: locations){
				duplicateMasonryTypes.add(l.getMasonry());
			}
			Set set = new HashSet(duplicateMasonryTypes);
			ArrayList uniqueMasonryTypes = new ArrayList(set);
			return uniqueMasonryTypes;
		}else{
			return duplicateMasonryTypes;
		}	
	}
	
	public ArrayList<String> retrieveAllRoofTypes(List<Location> locations){
		ArrayList<String> duplicateRoofTypes = new ArrayList<String>();
		if(locations.size()!=0 || locations!=null){
			for(Location l: locations){
				duplicateRoofTypes.add(l.getRoof());
			}
			Set set = new HashSet(duplicateRoofTypes);
			ArrayList uniqueRoofTypes = new ArrayList(set);
			return uniqueRoofTypes;
		}else{
			return duplicateRoofTypes;
		}	
	}
	
	public ArrayList<String> retrieveAllDatasets(List<Location> locations){
		ArrayList<String> duplicateDatasets = new ArrayList<String>();
		if(locations.size()!=0 || locations!=null){
			for(Location l: locations){
				duplicateDatasets.add(l.getCSVName());
			}
			Set set = new HashSet(duplicateDatasets);
			ArrayList uniqueDatasets = new ArrayList(set);
			return uniqueDatasets;
		}else{
			return duplicateDatasets;
		}	
	}
	
	public double getMaximumHeight(List<Location> locations){
		double output = 0;
		try{
			if(!locations.isEmpty() || locations!=null){
				output = locations.get(0).getBuildingHeight();
				for(Location l: locations){
					if(l.getBuildingHeight()>output){
						output = l.getBuildingHeight();
					}
				}
			}
			return output;
		}catch(IndexOutOfBoundsException e){
			return output;
		}	
	}
	
	public double getMinimumHeight(List<Location> locations){
		double output = 0;
		try{
			if(locations.size()!=0 || locations!=null){
				output = locations.get(0).getBuildingHeight();
				for(Location l: locations){
					if(l.getBuildingHeight()<output){
						output = l.getBuildingHeight();
					}
				}
			}
			return output;
		}catch(IndexOutOfBoundsException e){
			return output;
		}	
	}
	
	public double getMaximumPremium(List<Location> locations){
		double output = 0;
		try{
			if(locations.size()!=0 || locations!=null){
				output = locations.get(0).getPremium();
				for(Location l: locations){
					if(l.getPremium()>output){
						output = l.getPremium();
					}
				}
			}
			return output;
		}catch(IndexOutOfBoundsException e){
			return output;
		}	
	}
	
	public double getMinimumPremium(List<Location> locations){
		double output = 0;
		try{
			if(locations.size()!=0 || locations!=null){
				output = locations.get(0).getPremium();
				for(Location l: locations){
					if(l.getPremium()<output){
						output = l.getPremium();
					}
				}
			}
			return output;
		}catch(IndexOutOfBoundsException e){
			return output;
		}	
	}
	
	public double getMaximumPropertyCoverageLimit(List<Location> locations){
		double output = 0;
		try{
			if(locations.size()!=0 || locations!=null){
				output = locations.get(0).getPropertyCoverageLimit();
				for(Location l: locations){
					if(l.getPropertyCoverageLimit()>output){
						output = l.getPropertyCoverageLimit();
					}
				}
			}
			return output;
		}catch(IndexOutOfBoundsException e){
			return output;
		}
		
	}
	
	public double getMinimumPropertyCoverageLimit(List<Location> locations){
		double output = 0;
		try{
			if(locations.size()!=0 || locations!=null){
				output = locations.get(0).getPropertyCoverageLimit();
				for(Location l: locations){
					if(l.getPropertyCoverageLimit()<output){
						output = l.getPropertyCoverageLimit();
					}
				}
			}
			return output;
		}catch(IndexOutOfBoundsException e){
			return output;
		}	
	}
	
	public double getMaximumLossCoverageLimit(List<Location> locations){
		double output = 0;
		try{
			if(locations.size()!=0 || locations!=null){
				output = locations.get(0).getLossCoverageLimit();
				for(Location l: locations){
					if(l.getLossCoverageLimit()>output){
						output = l.getLossCoverageLimit();
					}
				}
			}
			return output;
		}catch(IndexOutOfBoundsException e){
			return output;
		}		
	}
	
	public double getMinimumLossCoverageLimit(List<Location> locations){
		double output = 0;
		try{
			if(locations.size()!=0 || locations!=null){
				output = locations.get(0).getLossCoverageLimit();
				for(Location l: locations){
					if(l.getLossCoverageLimit()<output){
						output = l.getLossCoverageLimit();
					}
				}
			}
			return output;
		}catch(IndexOutOfBoundsException e){
			return output;
		}	
	}
	
	public int getMaximumCapacity(List<Location> locations){
		int output = 0;
		try{
			if(locations.size()!=0 || locations!=null){
				output = locations.get(0).getCapacity();
				for(Location l: locations){
					if(l.getCapacity()>output){
						output = l.getCapacity();
					}
				}
			}
			return output;
		}catch(IndexOutOfBoundsException e){
			return output;
		}	
	}
	
	public int getMinimumCapacity(List<Location> locations){
		int output = 0;
		try{
			if(locations.size()!=0 || locations!=null){
				output = locations.get(0).getCapacity();
				for(Location l: locations){
					if(l.getCapacity()<output){
						output = l.getCapacity();
					}
				}
			}
			return output;
		}catch(IndexOutOfBoundsException e){
			return output;
		}		
	}
	
	public int getMaximumYearBuilt(List<Location> locations){
		int output = 0;
		try{
			if(locations.size()!=0 || locations!=null){
				output = locations.get(0).getYearBuilt();
				for(Location l: locations){
					if(l.getYearBuilt()>output){
						output = l.getYearBuilt();
					}
				}
			}
			return output;
		}catch(IndexOutOfBoundsException e){
			return output;
		}	
	}
	
	public int getMinimumYearBuilt(List<Location> locations){
		int output = 0;
		try{
			if(locations.size()!=0 || locations!=null){
				output = locations.get(0).getYearBuilt();
				for(Location l: locations){
					if(l.getYearBuilt()<output){
						output = l.getYearBuilt();
					}
				}
			}
			return output;
		}catch(IndexOutOfBoundsException e){
			return output;
		}	
	}
	
	public List<Location> retrieveByBuildingType(String[] buildingTypes, List<Location> locations){
		List<Location> output = new ArrayList<Location>();
		for(Location l: locations){
			for(String str: buildingTypes){
				if(l.getBuildingType().equals(str)){
					output.add(l);
					break;
				}
			}	
		}
		return output;
	}
	
	public List<Location> retrieveByFoundationType(String[] foundationTypes, List<Location> locations){
		List<Location> output = new ArrayList<Location>();
		for(Location l: locations){
			for(String str: foundationTypes){
				if(l.getFoundationType().equals(str)){
					output.add(l);
					break;
				}
			}	
		}
		return output;
	}
	
	public List<Location> retrieveByMasonryType(String[] masonryTypes, List<Location> locations){
		List<Location> output = new ArrayList<Location>();
		for(Location l: locations){
			for(String str: masonryTypes){
				if(l.getMasonry().equals(str)){
					output.add(l);
					break;
				}
			}	
		}
		return output;
	}
	
	public List<Location> retrieveByRoofType(String[] roofTypes, List<Location> locations){
		List<Location> output = new ArrayList<Location>();
		for(Location l: locations){
			for(String str: roofTypes){
				if(l.getRoof().equals(str)){
					output.add(l);
					break;
				}
			}	
		}
		return output;
	}
	
	public List<Location> retrieveByDataset(String[] datasets, List<Location> locations){
		List<Location> output = new ArrayList<Location>();
		for(Location l: locations){
			for(String str: datasets){
				if(l.getCSVName().equals(str)){
					output.add(l);
					break;
				}
			}	
		}
		return output;
	}
	
	public List<Location> retrieveByBuildingName(String buildingName, List<Location> locations){
		List<Location> output = new ArrayList<Location>();
		buildingName = buildingName.toLowerCase();
		for(Location l: locations){
			if(l.getBuildingName().toLowerCase().indexOf(buildingName)>=0){
				output.add(l);
			}
		}
		return output;
	}
	
	public List<Location> retrieveByRemark(String remark, List<Location> locations){
		List<Location> output = new ArrayList<Location>();
		remark = remark.toLowerCase();
		for(Location l: locations){
			if(l.getRemarks().toLowerCase().indexOf(remark)>=0){
				output.add(l);
			}
		}
		return output;
	}
	
	public List<Location> retrieveByHeight(double minHeight, double maxHeight, List<Location> locations){
		List<Location> output = new ArrayList<Location>();
		for(Location l: locations){
			if(l.getBuildingHeight()>=minHeight && l.getBuildingHeight()<=maxHeight){
				output.add(l);
			}
		}
		return output;
	}
	
	public List<Location> retrieveByYearBuilt(int minYearBuilt, int maxYearBuilt, List<Location> locations){
		List<Location> output = new ArrayList<Location>();
		for(Location l: locations){
			if(l.getYearBuilt()>=minYearBuilt && l.getYearBuilt()<=maxYearBuilt){
				output.add(l);
			}
		}
		return output;
	}
	
	public List<Location> retrieveByCapacity(int minCapacity, int maxCapacity, List<Location> locations){
		List<Location> output = new ArrayList<Location>();
		for(Location l: locations){
			if(l.getCapacity()>=minCapacity && l.getCapacity()<=maxCapacity){
				output.add(l);
			}
		}
		return output;
	}
	
	public List<Location> retrieveByPremium(double minPremium, double maxPremium, List<Location> locations){
		List<Location> output = new ArrayList<Location>();
		for(Location l: locations){
			if(l.getPremium()>=minPremium && l.getPremium()<=maxPremium){
				output.add(l);
			}
		}
		return output;
	}
	
	public List<Location> retrieveByPropertyCoverageLimit(double minProCovLimit, double maxProCovLimit, List<Location> locations){
		List<Location> output = new ArrayList<Location>();
		for(Location l: locations){
			if(l.getPropertyCoverageLimit()>=minProCovLimit && l.getPropertyCoverageLimit()<=maxProCovLimit){
				output.add(l);
			}
		}
		return output;
	}
	
	public List<Location> retrieveByLossCoverageLimit(double minLossCovLimit, double maxLossCovLimit, List<Location> locations){
		List<Location> output = new ArrayList<Location>();
		for(Location l: locations){
			if(l.getLossCoverageLimit()>=minLossCovLimit && l.getLossCoverageLimit()<=maxLossCovLimit){
				output.add(l);
			}
		}
		return output;
	}
	
	public List<Location> retrieveByUsername(String username){
		List<Location> output = new ArrayList<Location>();
		Objectify ofy = OfyService.getOfy();
		Query<Location> q = ofy.query(Location.class);
		q.filter("username ==", username);
		if(q!=null){
			for(Location location: q){
				output.add(location);
			}
		}
		return output;
	}
  
}
