package dao;

import entity.*;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.*;
import java.util.zip.ZipInputStream;
import java.util.Calendar;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.Query;

public class UploadManager {

	private HashMap<String,ArrayList<String>> locationErrors = new HashMap<String,ArrayList<String>>();
	private HashMap<String,ArrayList <String>> userErrors = new HashMap<String,ArrayList<String>>();
	
	public ArrayList<String> readCSV(ZipInputStream zin) {
		BufferedReader in = new BufferedReader(new InputStreamReader(zin));
		String str;
		ArrayList<String> output = new ArrayList<String>();
		
		try {
			//int count = 0;
			while ((str = in.readLine()) != null) {
				//count++;
				//if (count > 1) {
					output.add(str);
				//}
			}
		} catch (Exception e) {

		}
		return output;
	}
	
	public ArrayList<String> readCSV(InputStream stream) {
		BufferedReader in = new BufferedReader(new InputStreamReader(stream));
		String str;
		ArrayList<String> output = new ArrayList<String>();
		
		try {
			//int count = 0;
			while ((str = in.readLine()) != null) {
				//count++;
				//if (count > 1) {
					output.add(str);
				//}
			}
		} catch (Exception e) {

		}
		return output;
	}
		
	public ArrayList<LocationMetadata> convertDataToLocationMetadata(ArrayList<String> locationMetadata, String datasetName){
		ArrayList<LocationMetadata> output = new ArrayList<LocationMetadata>();
        for(int i=1;i<locationMetadata.size();i++){
			String[] data = locationMetadata.get(i).split(",",-1);
			String columnName = data[0].trim();
			String requiredStr = data[1].trim();
            String value = data[2].trim().toLowerCase();
            String vIndexStr = data[3].trim();
            //ArrayList<String> userErrorStr = getUserErrorStr(users,username,name,password);
            //if(userErrorStr.isEmpty()){
            boolean required = Boolean.parseBoolean(requiredStr);
            if(value.equals("")||value==null){
            	LocationMetadata aLocationMetadata = new LocationMetadata(columnName, required);
            	output.add(aLocationMetadata);
            }else{
                double vIndex = Double.parseDouble(vIndexStr);
            	LocationMetadata aLocationMetadata = new LocationMetadata(columnName, required, value, vIndex);
            	output.add(aLocationMetadata);
            }  
            //}else{
            	//this.userErrors.put("("+datasetName + ", line " + (i+2)+")", userErrorStr);
            //}     
		}
        return output;
	}
	
	public ArrayList<User> convertDataToUsers(ArrayList<String> locationData, String datasetName){
		ArrayList<User> users = new ArrayList<User>();
		ArrayList<String> widgetList = new ArrayList<String>();
		widgetList.add("Upload New File");
		widgetList.add("Points of Interest");
		widgetList.add("Filter Data");
		widgetList.add("Hazard Map");
		widgetList.add("Risk Calculation");
		widgetList.add("Comparison");
		widgetList.add("Simulation");
		widgetList.add("Historical Analysis");
		for(int i=1;i<locationData.size();i++){
			String[] data = locationData.get(i).split(",",-1);
			String username = data[0].trim();
			String name = data[1].trim();
            String password = data[2].trim();
            //String access = data[3].trim();
            ArrayList<String> userErrorStr = getUserErrorStr(users,username,name,password);
            if(userErrorStr.isEmpty()){	
            	User user = new User(username, name, password, widgetList);
            	users.add(user);
            }else{
            	this.userErrors.put("("+datasetName + ", line " + (i+2)+")", userErrorStr);
            }     
		}
            return users;
	}
	
	public ArrayList<String> getUserErrorStr(ArrayList<User> users,String username, String name, String password){
		ArrayList<String> output = new ArrayList<String>();
		if(username.isEmpty()||username==null){
			output.add("username field is empty");
		}else if(duplicateUsername(users,username)){
			output.add("duplicate username");
		}
		if(name.isEmpty()||name==null){
			output.add("name field is empty");
		}
		if(password.isEmpty()||password==null){
			output.add("password field is empty");
		}
		/*if(access.isEmpty()||access==null){
			output.add("access field is empty");
		}*/
		return output;
	}
	
	public boolean duplicateUsername(ArrayList<User> users, String username){
		for(User u: users){
			if(u.getUsername().equals(username)){
				return true;
			}
		}
		return false;
	}
	
	public HashMap<String,ArrayList<String>> getUserErrors(){
		return userErrors;
	}
	
	public ArrayList<Location> convertDataToLocations(ArrayList<String> locationData, String datasetName, String currency, String username){
		ArrayList<Location> locations = new ArrayList<Location>();
		String columnsStr = locationData.get(0);
		String[] columns = columnsStr.split(",",-1);
        for(int i=1;i<locationData.size();i++){
			String[] data = locationData.get(i).split(",",-1);
			int where = Arrays.asList(columns).indexOf("Latitude");
			String latitudeStr = data[where].trim();
			where = Arrays.asList(columns).indexOf("Longitude");
			String longitudeStr = data[where].trim();
			where = Arrays.asList(columns).indexOf("Building Name");
            String buildingName = data[where].trim();
            where = Arrays.asList(columns).indexOf("Building Type");
            String buildingType = data[where].trim();
            where = Arrays.asList(columns).indexOf("Building Height");
            String buildingHeightStr = data[where].trim();
            where = Arrays.asList(columns).indexOf("Year Built");
            String yearBuiltStr = data[where].trim();
            where = Arrays.asList(columns).indexOf("Capacity");
            String capacityStr = data[where].trim();
            where = Arrays.asList(columns).indexOf("Premium");
            String premiumStr = data[where].trim();
            where = Arrays.asList(columns).indexOf("Property Coverage Limit");
            String propertyCoverageLimitStr = data[where].trim();
            where = Arrays.asList(columns).indexOf("Loss Coverage Limit");
            String lossCoverageLimitStr = data[where].trim();
            where = Arrays.asList(columns).indexOf("Foundation Type");
            String foundationType = data[where].trim();
            where = Arrays.asList(columns).indexOf("Remark");
            String remarks = data[where].trim();
            where = Arrays.asList(columns).indexOf("Masonry");
            String masonry = data[where].trim();
            where = Arrays.asList(columns).indexOf("Roof");
            String roof = data[where].trim();

            ArrayList<String> locationErrorStr = getLocationErrorStr(locations,latitudeStr, longitudeStr, buildingName, 
                   buildingType,buildingHeightStr, yearBuiltStr,capacityStr,premiumStr, propertyCoverageLimitStr,
                  lossCoverageLimitStr, foundationType, masonry, roof, username, remarks);
            if(locationErrorStr.isEmpty()){
                double latitude = Double.parseDouble(latitudeStr);
                double longitude = Double.parseDouble(longitudeStr);
                double buildingHeight = -1;
                if(buildingHeightStr!=null && !buildingHeightStr.equals("")){
                	buildingHeight = Double.parseDouble(buildingHeightStr);
                }
                int yearBuilt = -1;
                if(yearBuiltStr!=null && !yearBuiltStr.equals("")){
                	yearBuilt = Integer.parseInt(yearBuiltStr);
                }
                int capacity = -1;
                if(capacityStr!=null && !capacityStr.equals("")){
                	capacity = Integer.parseInt(capacityStr);
                }
                double premium = -1;
                if(premiumStr!=null && !premiumStr.equals("")){
                	premium = Double.parseDouble(premiumStr);
                }   
                double propertyCoverageLimit = -1;
                if(propertyCoverageLimitStr!=null && !propertyCoverageLimitStr.equals("")){
                	propertyCoverageLimit = Double.parseDouble(propertyCoverageLimitStr);
                }
                double lossCoverageLimit = -1;
                if(lossCoverageLimitStr!=null && lossCoverageLimitStr.equals("")){
                	lossCoverageLimit = Double.parseDouble(lossCoverageLimitStr);
                }

                double vulnerabilityIndex = calculateVulnerability(buildingType, yearBuilt, foundationType,masonry, roof );
                Location location = new Location (latitude, longitude, buildingName, buildingType,
                buildingHeight,yearBuilt,capacity,premium,propertyCoverageLimit,
                lossCoverageLimit, currency, foundationType, remarks, masonry, roof, vulnerabilityIndex, datasetName,username);
                locations.add(location);
			}else{                      
				this.locationErrors.put("("+datasetName + ", line " + (i+2)+")", locationErrorStr);
			}
		}
        return locations;
	}
        
    public HashMap<String,ArrayList<String>> getLocationErrors(){
            return locationErrors;
    }

    public double calculateVulnerability(String buildingType, int yearBuilt, String foundationType, String masonryType, String roofType){
    	LocationMetadataDAO dao = new LocationMetadataDAO();
    	HashMap<String,Double> vIndexMap = dao.retrieveVIndexByColumnName("Building Type");
    	double buildingTypeIndex = vIndexMap.get(buildingType.toLowerCase());
    	
    	int year = Calendar.getInstance().get(Calendar.YEAR);
    	int buildingAge = year - yearBuilt;
    	vIndexMap = dao.retrieveVIndexByColumnName("Building Age");
    	Comparator cmp = Collections.reverseOrder();  
    	List<String> sortedKeys=new ArrayList(vIndexMap.keySet());
    	Collections.sort(sortedKeys, cmp);
    	String benchmark = "";
    	for(String str: sortedKeys){
    		int age = Integer.parseInt(str);
    		if(buildingAge >= age){
	    		benchmark = str.toString();
	    		break;
    		}
    	}
    	double buildingAgeIndex = vIndexMap.get(benchmark);
    	/*double buildingAgeIndex = -1;
    	int year = Calendar.getInstance().get(Calendar.YEAR);
    	int buildingAge = year - yearBuilt;
    	if(buildingAge<25){
    		buildingAgeIndex = 0.6;
    	}else if(buildingAge>=25 && buildingAge<=50){
    		buildingAgeIndex = 1.2;
    	}else{
    		buildingAgeIndex = 2;
    	}*/
    	
    	vIndexMap = dao.retrieveVIndexByColumnName("Foundation Type");
    	double buildingFoundationIndex = vIndexMap.get(foundationType.toLowerCase());
    	
    	vIndexMap = dao.retrieveVIndexByColumnName("Masonry");
    	double buildingMasonryIndex = vIndexMap.get(masonryType.toLowerCase());
    	
    	vIndexMap = dao.retrieveVIndexByColumnName("Roof");
    	double buildingRoofIndex = vIndexMap.get(roofType.toLowerCase());
    	
    	double output = buildingTypeIndex + buildingAgeIndex + buildingFoundationIndex + buildingMasonryIndex + buildingRoofIndex;
    	return Math.round(output * 100.0) / 100.0;
    }
    
    public ArrayList<String> getLocationErrorStr(ArrayList<Location> locations,String latitudeStr, String longitudeStr, String buildingName, String buildingType,String buildingHeightStr,
                               String yearBuiltStr,String capacityStr, String premiumStr, String propertyCoverageLimitStr,
                               String lossCoverageLimitStr, String foundationType, String masonry, String roof, String username, String remarks){ 
		ArrayList<String> locationErrorStr = new ArrayList<String>();
        if(!invalidDoubleStr(latitudeStr)&&!invalidDoubleStr(longitudeStr)){
            if(duplicateLocation(locations, latitudeStr, longitudeStr)){
                locationErrorStr.add("duplicate latitude and longitude in the same uploading dataset");
            }
            if(duplicateLocationAcrossDatasets(username, latitudeStr, longitudeStr)){
                locationErrorStr.add("duplicate latitude and longitude across your uploaded datasets");
            }
        }
        if(latitudeStr.isEmpty()){
    		locationErrorStr.add("latitude field is empty");
        }else if(invalidDoubleStr(latitudeStr)){
            locationErrorStr.add("invalid latitude");
        }        
		if(longitudeStr.isEmpty()){
			locationErrorStr.add("longitude field is empty");
		}else if(invalidDoubleStr(longitudeStr)){
                        locationErrorStr.add("invalid longitude");
        }
		
		LocationMetadataDAO locationMetadataDAO = new LocationMetadataDAO();
		LocationMetadata l = locationMetadataDAO.retrieveByColumnName("Building Name").get(0);
		if(l.getRequired()){
			if(buildingName.isEmpty()){
                locationErrorStr.add("building name field is empty");
			}
		}
		
		l = locationMetadataDAO.retrieveByColumnName("Remark").get(0);
		if(l.getRequired()){
			if(remarks.isEmpty()){
                locationErrorStr.add("remark field is empty");
			}
		}
		
		l = locationMetadataDAO.retrieveByColumnName("Building Type").get(0);
		if(l.getRequired()){
			if(buildingType.isEmpty()){
                locationErrorStr.add("building type field is empty");
			}else if(invalidBuildingType(buildingType)){
                locationErrorStr.add("invalid building type");
			}
		}
        
		l = locationMetadataDAO.retrieveByColumnName("Building Height").get(0);
		if(l.getRequired()){
			if(buildingHeightStr.isEmpty()){
	            locationErrorStr.add("building height is empty");
	        }else if(invalidPositiveDoubleStr(buildingHeightStr)){
	            locationErrorStr.add("invalid building height");
	        }
		}
        
		l = locationMetadataDAO.retrieveByColumnName("Year Built").get(0);
		if(l.getRequired()){
			if(yearBuiltStr.isEmpty()){
	            locationErrorStr.add("year built field is empty");
	        }else if(invalidYearBuilt(yearBuiltStr)){
	            locationErrorStr.add("invalid year built");
	        } 
		}
        
		l = locationMetadataDAO.retrieveByColumnName("Capacity").get(0);
		if(l.getRequired()){
			if(capacityStr.isEmpty()){
	            locationErrorStr.add("capacity field is empty");
	        }else if(invalidPositiveIntegerStr(capacityStr)){
	            locationErrorStr.add("invalid capacity");
	        }
		}

		l = locationMetadataDAO.retrieveByColumnName("Premium").get(0);
		if(l.getRequired()){
			if(premiumStr.isEmpty()){
	            locationErrorStr.add("premium field is empty");
	        }else if(invalidPositiveDoubleStr(premiumStr)){
	            locationErrorStr.add("invalid premium");
	        }
		}
        
		l = locationMetadataDAO.retrieveByColumnName("Property Coverage Limit").get(0);
		if(l.getRequired()){
			if(propertyCoverageLimitStr.isEmpty()){
	            locationErrorStr.add("property coverage limit field is empty");
	        }else if(invalidPositiveDoubleStr(propertyCoverageLimitStr)){
	            locationErrorStr.add("invalid property coverage limit");
	        }
		}
        
		l = locationMetadataDAO.retrieveByColumnName("Loss Coverage Limit").get(0);
		if(l.getRequired()){
			if(lossCoverageLimitStr.isEmpty()){
	            locationErrorStr.add("loss coverage limit field is empty");
	        }else if(invalidPositiveDoubleStr(lossCoverageLimitStr)){
	            locationErrorStr.add("invalid loss coverage limit");
	        }
		}
		
		l = locationMetadataDAO.retrieveByColumnName("Foundation Type").get(0);
		if(l.getRequired()){
			if(foundationType.isEmpty()){
	            locationErrorStr.add("foundation type field is empty");
	        }else if(invalidFoundationType(foundationType)){
	            locationErrorStr.add("invalid foundation type");
	        }
		}
        
		l = locationMetadataDAO.retrieveByColumnName("Masonry").get(0);
		if(l.getRequired()){
			if(masonry.isEmpty()){
	            locationErrorStr.add("masonry type field is empty");
	        }else if(invalidMasonryType(masonry)){
	            locationErrorStr.add("invalid masonry type");
	        }
		}
        
		l = locationMetadataDAO.retrieveByColumnName("Roof").get(0);
		if(l.getRequired()){
			if(roof.isEmpty()){
	            locationErrorStr.add("roof type field is empty");
	        }else if(invalidRoofType(roof)){
	            locationErrorStr.add("invalid roof type");
	        }
		}
        
		return locationErrorStr;
	}
                
    public boolean invalidDoubleStr(String inputStr){
		try{
			double temp = Double.parseDouble(inputStr);
                        return false;
		}catch(NumberFormatException e){
			return true;
		}
	} 
        
    public boolean invalidPositiveDoubleStr(String inputStr){
		try{
			double temp = Double.parseDouble(inputStr);
            if(temp>0){
                return false;
            }else{
                return true;
            }
		}catch(NumberFormatException e){
			return true;
		}
	} 
        
    public boolean invalidIntegerStr(String inputStr){
		try{
			int temp = Integer.parseInt(inputStr);
                        return false;
		}catch(NumberFormatException e){
			return true;
		}
	} 
        
    public boolean invalidPositiveIntegerStr(String inputStr){
		try{
			int temp = Integer.parseInt(inputStr);
                        if(temp>0){
                            return false;
                        }else{
                            return true;
                        }
		}catch(NumberFormatException e){
			return true;
		}
	}
    
    public boolean invalidYearBuilt(String inputStr){
    	try{
			int temp = Integer.parseInt(inputStr);
            if(temp>0){
            	int year = Calendar.getInstance().get(Calendar.YEAR);
            	if(temp>year){
            		return true;
            	}
            	return false;
            }else{
                return true;
            }
		}catch(NumberFormatException e){
			return true;
		}
	} 
        
    public boolean invalidBuildingType(String buildingType){
    		LocationMetadataDAO dao = new LocationMetadataDAO();
            ArrayList<String> types = dao.retrieveValuesByColumnName("Building Type");
            boolean isInvalid = true;
            for(int i=0;i<types.size();i++){
                if(buildingType.equalsIgnoreCase(types.get(i))){
                    isInvalid = false;
                    break;
                }
            }
            return isInvalid;
        }
        
    public boolean invalidFoundationType(String foundationType){
    	LocationMetadataDAO dao = new LocationMetadataDAO();
        ArrayList<String> types = dao.retrieveValuesByColumnName("Foundation Type");
        boolean isInvalid = true;
        for(int i=0;i<types.size();i++){
            if(foundationType.equalsIgnoreCase(types.get(i))){
                isInvalid = false;
                break;
            }
        }
        return isInvalid;
    }
    
    public boolean invalidMasonryType(String masonryType){
    	LocationMetadataDAO dao = new LocationMetadataDAO();
        ArrayList<String> types = dao.retrieveValuesByColumnName("Masonry");
        boolean isInvalid = true;
        for(int i=0;i<types.size();i++){
            if(masonryType.equalsIgnoreCase(types.get(i))){
                isInvalid = false;
                break;
            }
        }
        return isInvalid;
    }
    
    public boolean invalidRoofType(String roofType){
    	LocationMetadataDAO dao = new LocationMetadataDAO();
        ArrayList<String> types = dao.retrieveValuesByColumnName("Roof");
        boolean isInvalid = true;
        for(int i=0;i<types.size();i++){
            if(roofType.equalsIgnoreCase(types.get(i))){
                isInvalid = false;
                break;
            }
        }
        return isInvalid;
    }
        
    public boolean duplicateLocation(ArrayList<Location> locations, String latitudeStr, String longitudeStr){
        double latitude = Double.parseDouble(latitudeStr);
        double longitude = Double.parseDouble(longitudeStr);
        for(int i=0;i<locations.size();i++){
            Location l = locations.get(i);
            if(latitude==l.getLatitude() && longitude==l.getLongitude()){
                return true;
            }
        }
        return false;
    }
    
    public boolean duplicateLocationAcrossDatasets(String username, String latitudeStr, String longitudeStr){
        double latitude = Double.parseDouble(latitudeStr);
        double longitude = Double.parseDouble(longitudeStr);
        LocationDAO locationDAO = new LocationDAO();
        List<Location> locations = locationDAO.retrieveByUsername(username);
        for(int i=0;i<locations.size();i++){
            Location l = locations.get(i);
            if(latitude==l.getLatitude() && longitude==l.getLongitude()){
                return true;
            }
        }
        return false;
    }
       
}