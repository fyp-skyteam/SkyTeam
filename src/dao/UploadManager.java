package dao;

import entity.*;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.zip.ZipInputStream;
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
	
	public ArrayList<User> convertDataToUsers(ArrayList<String> locationData){
		ArrayList<User> users = new ArrayList<User>();
        for(int i=0;i<locationData.size();i++){
			String[] data = locationData.get(i).split(",",-1);
			String username = data[0].trim();
			String name = data[1].trim();
            String password = data[2].trim();
            User user = new User(username, name, password);
            users.add(user);
		}
            return users;
	}
	
	public ArrayList<Location> convertDataToLocations(ArrayList<String> locationData, String datasetName, int datasetNumber, String currency){
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
            ArrayList<String> locationErrorStr = getLocationErrorStr(locations,latitudeStr, longitudeStr, buildingName, 
                   buildingType,buildingHeightStr, yearBuiltStr,capacityStr,premiumStr, propertyCoverageLimitStr,
                  lossCoverageLimitStr, foundationType);
            if(locationErrorStr.isEmpty()){
                double latitude = Double.parseDouble(latitudeStr);
                double longitude = Double.parseDouble(longitudeStr);
                double buildingHeight = Double.parseDouble(buildingHeightStr);
                int yearBuilt = Integer.parseInt(yearBuiltStr);
                int capacity = Integer.parseInt(capacityStr);
                double premium = Double.parseDouble(premiumStr);
                double propertyCoverageLimit = Double.parseDouble(propertyCoverageLimitStr);
                double lossCoverageLimit = Double.parseDouble(lossCoverageLimitStr);
                Location location = new Location (latitude, longitude, buildingName, buildingType,
                buildingHeight,yearBuilt,capacity,premium,propertyCoverageLimit,
                lossCoverageLimit, currency, foundationType, remarks,datasetNumber, datasetName);
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

    public ArrayList<String> getLocationErrorStr(ArrayList<Location> locations,String latitudeStr, String longitudeStr, String buildingName, String buildingType,String buildingHeightStr,
                               String yearBuiltStr,String capacityStr, String premiumStr, String propertyCoverageLimitStr,
                               String lossCoverageLimitStr, String foundationType){ 
		ArrayList<String> locationErrorStr = new ArrayList<String>();
                if(!invalidDoubleStr(latitudeStr)&&!invalidDoubleStr(longitudeStr)){
                    if(duplicateLocation(locations, latitudeStr, longitudeStr)){
                        locationErrorStr.add("duplicate latitude and longitude");
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
        }else if(invalidPositiveIntegerStr(yearBuiltStr)){
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
        
    public boolean invalidBuildingType(String buildingType){
            ArrayList<String> types = new ArrayList<String>();
            types.add("Commercial");
            types.add("Government");
            types.add("Residential");
            types.add("School");
            types.add("Industrial");
            types.add("Religious Building");
            types.add("Transport");
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
        types.add("slab");
        types.add("raised");
        types.add("other");
        boolean isInvalid = true;
        for(int i=0;i<types.size();i++){
            if(foundationType.equalsIgnoreCase(types.get(i))){
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
       
}
