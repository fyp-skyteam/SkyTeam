package entity;
import javax.persistence.*;

public class LocationMetadata implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id private Long id;
	private String columnName; 
	private boolean required;
    private String value;
    private double vIndex;
    
    public LocationMetadata(){
    	
    }
 
	
    public LocationMetadata(String columnName, boolean required, String value, double vIndex){
        this.columnName = columnName;
        this.required = required;
        this.value = value;
        this.vIndex = vIndex;
    }
    
    public LocationMetadata(String columnName, boolean required){
        this.columnName = columnName;
        this.required = required;
    }
    
    public Long getId(){
    	return id;
    }
    
    public String getColumnName(){
    	return columnName;
    }
    
    public boolean getRequired(){
    	return required;
    }
    
    public String getValue(){
    	return value;
    }
    
    public double getVIndex(){
    	return vIndex;
    }
    
    public void setColumnName(String columnName){
    	this.columnName = columnName;
    }
    
    public void setRequired(boolean required){
    	this.required = required;
    }
    
    public void setValue(String value){
    	this.value = value;
    }
    
    public void setVIndex(double vIndex){
    	this.vIndex = vIndex;
    }
    
    @Override
    public String toString(){
        return "columnName=" + columnName + ", required=" + required + ", value=" + value + ", vIndex=" + vIndex;
    }
}    
        