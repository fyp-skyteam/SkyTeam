package dao;

import entity.*;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
			int count = 0;
			while ((str = in.readLine()) != null) {
				count++;
				if (count > 1) {
					output.add(str);
				}
			}
		} catch (Exception e) {

		}
		return output;
	}
	
	public ArrayList<User> convertDataToUsers(ArrayList<String> locationData, String datasetName){
		ArrayList<User> users = new ArrayList<User>();
        for(int i=0;i<locationData.size();i++){
			String[] data = locationData.get(i).split(",",-1);
			String username = data[0].trim();
			String name = data[1].trim();
            String password = data[2].trim();  
            ArrayList<String> userErrorStr = getUserErrorStr(users,username,name,password);
            if(userErrorStr.isEmpty()){
            	User user = new User(username, name, password);
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
        for(int i=0;i<locationData.size();i++){
			String[] data = locationData.get(i).split(",",-1);
			String latitudeStr = data[0].trim();
			String longitudeStr = data[1].trim();
            String buildingName = data[2].trim();
            String buildingType = data[3].trim();
            String buildingHeightStr = data[4].trim();
            String yearBuiltStr = data[5].trim();
            String capacityStr = data[6].trim();
            String premiumStr = data[7].trim();
            String propertyCoverageLimitStr = data[8].trim();
            String lossCoverageLimitStr = data[9].trim();
            String foundationType = data[10].trim();
            String remarks = data[11].trim();
            String masonry = data[12].trim();
            String roof = data[13].trim();
            ArrayList<String> locationErrorStr = getLocationErrorStr(locations,latitudeStr, longitudeStr, buildingName, 
                   buildingType,buildingHeightStr, yearBuiltStr,capacityStr,premiumStr, propertyCoverageLimitStr,
                  lossCoverageLimitStr, foundationType, masonry, roof, username);
            if(locationErrorStr.isEmpty()){
                double latitude = Double.parseDouble(latitudeStr);
                double longitude = Double.parseDouble(longitudeStr);
                double buildingHeight = Double.parseDouble(buildingHeightStr);
                int yearBuilt = Integer.parseInt(yearBuiltStr);
                int capacity = Integer.parseInt(capacityStr);
                double premium = Double.parseDouble(premiumStr);
                double propertyCoverageLimit = Double.parseDouble(propertyCoverageLimitStr);
                double lossCoverageLimit = Double.parseDouble(lossCoverageLimitStr);
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
    	double buildingTypeIndex = -1;
    	if(buildingType.equalsIgnoreCase("residential")){
    		buildingTypeIndex = 2;
    	}else if(buildingType.equalsIgnoreCase("commercial")){
    		buildingTypeIndex = 1.2;
    	}else{
    		buildingTypeIndex = 0.6;
    	}
    	
    	double buildingAgeIndex = -1;
    	int year = Calendar.getInstance().get(Calendar.YEAR);
    	int buildingAge = yearBuilt - year;
    	if(buildingAge<25){
    		buildingAgeIndex = 0.6;
    	}else if(buildingAge>=25 && buildingAge<=50){
    		buildingAgeIndex = 1.2;
    	}else{
    		buildingAgeIndex = 2;
    	}
    	
    	double buildingFoundationIndex = -1;
    	if(foundationType.equalsIgnoreCase("slurry wall") || foundationType.equalsIgnoreCase("pile")){
    		buildingFoundationIndex = 0.6;
    	}else if(foundationType.equalsIgnoreCase("well foundation") || foundationType.equalsIgnoreCase("cofferdam")){
    		buildingFoundationIndex = 1.2;
    	}else{
    		buildingFoundationIndex = 2;
    	}
    	
    	double buildingMasonryIndex = -1;
    	if(masonryType.equalsIgnoreCase("brick") || masonryType.equalsIgnoreCase("concrete") || masonryType.equalsIgnoreCase("corrugated iron") ){
    		buildingMasonryIndex = 0.6;
    	}else if(masonryType.equalsIgnoreCase("tempered glass")){
    		buildingMasonryIndex = 2;
    	}else{
    		buildingMasonryIndex = 1.2;
    	}
    	
    	double buildingRoofIndex = -1;
    	if(roofType.equalsIgnoreCase("tiles")||roofType.equalsIgnoreCase("metal sheets")||roofType.equalsIgnoreCase("fibro")){
    		buildingRoofIndex = 1;
    	}else{
    		buildingRoofIndex = 2;
    	}
    	double output = buildingTypeIndex + buildingAgeIndex + buildingFoundationIndex + buildingMasonryIndex + buildingRoofIndex;
    	return Math.round(output * 100.0) / 100.0;
    }
    
    public ArrayList<String> getLocationErrorStr(ArrayList<Location> locations,String latitudeStr, String longitudeStr, String buildingName, String buildingType,String buildingHeightStr,
                               String yearBuiltStr,String capacityStr, String premiumStr, String propertyCoverageLimitStr,
                               String lossCoverageLimitStr, String foundationType, String masonry, String roof, String username){ 
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
        if(buildingName.isEmpty()){
                locationErrorStr.add("building name field is empty");
        }
        if(buildingType.isEmpty()){
                locationErrorStr.add("building type field is empty");
        }else if(invalidBuildingType(buildingType)){
                locationErrorStr.add("invalid building type");
        }
        if(buildingHeightStr.isEmpty()){
            locationErrorStr.add("building height is empty");
        }else if(invalidPositiveDoubleStr(buildingHeightStr)){
            locationErrorStr.add("invalid building height");
        }
        if(yearBuiltStr.isEmpty()){
            locationErrorStr.add("year built field is empty");
        }else if(invalidYearBuilt(yearBuiltStr)){
            locationErrorStr.add("invalid year built");
        }    
        if(capacityStr.isEmpty()){
            locationErrorStr.add("capacity field is empty");
        }else if(invalidPositiveIntegerStr(capacityStr)){
            locationErrorStr.add("invalid capacity");
        }
        if(premiumStr.isEmpty()){
            locationErrorStr.add("premium field is empty");
        }else if(invalidPositiveDoubleStr(premiumStr)){
            locationErrorStr.add("invalid premium");
        }
        if(propertyCoverageLimitStr.isEmpty()){
            locationErrorStr.add("property coverage limit field is empty");
        }else if(invalidPositiveDoubleStr(propertyCoverageLimitStr)){
            locationErrorStr.add("invalid property coverage limit");
        }
        if(lossCoverageLimitStr.isEmpty()){
            locationErrorStr.add("loss coverage limit field is empty");
        }else if(invalidPositiveDoubleStr(lossCoverageLimitStr)){
            locationErrorStr.add("invalid loss coverage limit");
        }
        if(foundationType.isEmpty()){
            locationErrorStr.add("foundation type field is empty");
        }else if(invalidFoundationType(foundationType)){
            locationErrorStr.add("invalid foundation type");
        }
        if(masonry.isEmpty()){
            locationErrorStr.add("masonry type field is empty");
        }else if(invalidMasonryType(masonry)){
            locationErrorStr.add("invalid masonry type");
        }
        if(roof.isEmpty()){
            locationErrorStr.add("roof type field is empty");
        }else if(invalidRoofType(roof)){
            locationErrorStr.add("invalid roof type");
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
            ArrayList<String> types = new ArrayList<String>();
            types.add("Commercial");
            types.add("Residential");
            types.add("Industrial");
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
        ArrayList<String> types = new ArrayList<String>();
        types.add("slurry wall");
        types.add("pile");
        types.add("well foundation");
        types.add("cofferdam");
        types.add("strip");
        types.add("pad");
        types.add("beam");
        types.add("mat");
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
        ArrayList<String> types = new ArrayList<String>();
        types.add("brick");
        types.add("concrete");
        types.add("corrugated iron");
        types.add("tempered glass");
        types.add("stone");
        types.add("timber");
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
        ArrayList<String> types = new ArrayList<String>();
        types.add("tiles");
        types.add("metal sheets");
        types.add("fibro");
        types.add("slate");
        types.add("glass");
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
