package entity;
//import javax.persistence.*;

public class Location{
	/**
	 * 
	 */
	//private static final long serialVersionUID = 1L;
	//@Id private Long id;
        private long id;
	private double latitude; 
	private double longitude;
        private String buildingName;
        private String buildingType;
        private double buildingHeight;
        //private String buildingName;
        private int yearBuilt;
        private int capacity;
        private double premium;
        private double propertyCoverageLimit;
        private double lossCoverageLimit;
        private String currency;
        private String foundationType;
        private String remarks;
        private int datasetNumber;
        private String csvName;
	
        public Location(double latitude, double longitude, String buildingName, String buildingType, double buildingHeight,int yearBuilt, int capacity,
                double premium, double propertyCoverageLimit, double lossCoverageLimit, String currency, String foundationType, String remarks,
                int datasetNumber, String csvName){
            this(-1,latitude,longitude,buildingName,buildingType,buildingHeight,yearBuilt,capacity,premium,
                    propertyCoverageLimit, lossCoverageLimit, currency, foundationType, remarks, datasetNumber, csvName);
        }
	
        public Location(long id, double latitude, double longitude, String buildingName, String buildingType, double height, int yearBuilt, int capacity,
                double premium, double propertyCoverageLimit, double lossCoverageLimit, String currency, String foundationType, String remarks,
        int datasetNumber, String csvName){
            this.id=id;
            this.latitude=latitude;
            this.longitude=longitude;
            this.buildingName=buildingName;
            this.buildingType=buildingType;
            this.buildingHeight=height;
            this.yearBuilt=yearBuilt;
            this.capacity=capacity;
            this.premium=premium;
            this.propertyCoverageLimit=propertyCoverageLimit;
            this.lossCoverageLimit=lossCoverageLimit;
            this.currency=currency;
            this.foundationType=foundationType;
            this.remarks=remarks;
            this.datasetNumber=datasetNumber;
            this.csvName=csvName;
        }
        
        public long getId(){
            return id;
        }
        
	public double getLatitude(){
            return latitude;
	}
	
	public double getLongitude(){
            return longitude;
	}
        
        public String getBuildingName(){
            return buildingName;
        }
        
        public String getBuildingType(){
            return buildingType;
        }
        
        public double getBuildingHeight(){
            return buildingHeight;
        }
        
        public int getYearBuilt(){
            return yearBuilt;
        }
        
        public int getCapacity(){
            return capacity;
        }
        
        public double getPremium(){
            return premium;
        }
        
        public double getPropertyCoverageLimit(){
            return propertyCoverageLimit;
        }
        
        public double getLossCoverageLimit(){
            return lossCoverageLimit;
        }
        
        public String getCurrency(){
            return currency;
        }
        
        public String getFoundationType(){
            return foundationType;
        }
        
        public String getRemarks(){
            return remarks;
        }
        
        public int getDatasetNumber(){
            return datasetNumber;
        }
        
        public String getCSVName(){
            return csvName;
        }
        
        public void setId(long id){
            this.id=id;
        }
	
	public void setLatitude(double latitude){
		this.latitude=latitude;
	}
	
	public void setLongitude(double longitude){
		this.longitude=longitude;
	}
        
        public void setPremium(double premium){
            this.premium = premium;
        }
        
        @Override
        public String toString(){
            return "id=" + id + "building name=" + buildingName + ", latitude=" + latitude + ", longitude=" + longitude + ", premium= "+ premium + ", file=" + csvName;
        }
}
