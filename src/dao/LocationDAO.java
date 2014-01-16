/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package dao;

import entity.Location;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.HashSet;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author lehung
 */
public class LocationDAO {
    
    private static final String TBLNAME = "location";

    
    private void handleSQLException(SQLException ex, String sql, String... parameters) {
    String msg = "Unable to access data; SQL=" + sql + "\n";
    for (String parameter : parameters) {
      msg += "," + parameter;
    }
    Logger.getLogger(LocationDAO.class.getName()).log(Level.SEVERE, msg, ex);
    throw new RuntimeException(msg, ex);
  }

  /**
   * Create a new Location object given its details. Auto-generate its id.
   *
   * @param Location Location object that represents the new location.
   */
  public void create(Location newLocation) {
    Connection conn = null;
    PreparedStatement stmt = null;
    String sql = "";
    try {
      conn = ConnectionManager.getConnection();

      sql = "INSERT INTO " + TBLNAME
              + " (latitude,longitude,building_name,building_type, building_height,"
              + "year_built, capacity, premium, property_coverage_limit, loss_coverage_limit,currency, foundation_type,"
              + "remarks, dataset_number, csv_name) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
      stmt = conn.prepareStatement(sql);

      stmt.setDouble(1,newLocation.getLatitude());
      stmt.setDouble(2,newLocation.getLongitude());
      stmt.setString(3,newLocation.getBuildingName());
      stmt.setString(4,newLocation.getBuildingType());
      stmt.setDouble(5,newLocation.getBuildingHeight());
      stmt.setInt(6,newLocation.getYearBuilt());
      stmt.setInt(7,newLocation.getCapacity());
      stmt.setDouble(8,newLocation.getPremium());
      stmt.setDouble(9,newLocation.getPropertyCoverageLimit());
      stmt.setDouble(10,newLocation.getLossCoverageLimit());
      stmt.setString(11, newLocation.getCurrency());
      stmt.setString(12,newLocation.getFoundationType());
      stmt.setString(13,newLocation.getRemarks());
      stmt.setInt(14,newLocation.getDatasetNumber());
      stmt.setString(15,newLocation.getCSVName());
      stmt.executeUpdate();

    } catch (SQLException ex) {
      handleSQLException(ex, sql, "Location={" + newLocation + "}");
    } finally {
      ConnectionManager.close(conn, stmt);
    }
  }

  /**
   * Update a Location object. If there is no location with the given id, do
   * nothing.
   *
   * @param toBeUpdated Location object that contains the id and updated details.
   */
  /*public void update(Location toBeUpdated) {
    Connection conn = null;
    PreparedStatement stmt = null;
    String sql = "";
    try {
      conn = ConnectionManager.getConnection();

      sql = "UPDATE " + TBLNAME
              + " set latitude=?, longitude=?, claim=? where id = ? ";
      stmt = conn.prepareStatement(sql);

      stmt.setString(1, Double.toString(toBeUpdated.getLatitude()));
      stmt.setString(2, Double.toString(toBeUpdated.getLongitude()));
      stmt.setString(3, Double.toString(toBeUpdated.getClaim()));
      stmt.setLong(4, toBeUpdated.getId());
   
      stmt.executeUpdate();

    } catch (SQLException ex) {
      handleSQLException(ex, sql, "Location={" + toBeUpdated + "}");
    } finally {
      ConnectionManager.close(conn, stmt);
    }
  }*/

  /**
   * Delete a Location object given its id. If there is no contact with the given
   * id, do nothing.
   *
   * @param id
   */
  /**public void delete(long id) {
    Connection conn = null;
    PreparedStatement stmt = null;
    String sql = "";
    try {
      conn = ConnectionManager.getConnection();

      sql = "DELETE FROM " + TBLNAME + " where id = ? ";
      stmt = conn.prepareStatement(sql);

      stmt.setLong(1, id);

      stmt.executeUpdate();

    } catch (SQLException ex) {
      handleSQLException(ex, sql, "id=" + id);
    } finally {
      ConnectionManager.close(conn, stmt);
    }
  }*/

  public void deleteAll() {
    Connection conn = null;
    PreparedStatement stmt = null;
    String sql = "";
    try {
      conn = ConnectionManager.getConnection();

      sql = "DELETE FROM " + TBLNAME;
      stmt = conn.prepareStatement(sql);

      stmt.executeUpdate();

    } catch (SQLException ex) {
      handleSQLException(ex, sql);
    } finally {
      ConnectionManager.close(conn, stmt);
    }
  }
  
  /**
   * Retrieve all Contact objects
   *
   * @return List object.
   */
  public List<Location> retrieveAll() {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String sql = "";
    List<Location> results = new ArrayList<Location>();

    try {
      conn = ConnectionManager.getConnection();

      sql = "SELECT id,latitude,longitude,building_name,building_type,building_height,"
              + "year_built, capacity, premium, property_coverage_limit, loss_coverage_limit,currency,"
              + "foundation_type, remarks, dataset_number, csv_name FROM " + TBLNAME;
      stmt = conn.prepareStatement(sql);

      rs = stmt.executeQuery();

      while (rs.next()) {
        //Retrieve by column name
        long id = rs.getLong("id");
        double latitude = rs.getDouble("latitude");
        double longitude = rs.getDouble("longitude");
        String buildingName = rs.getString("building_name");
        String buildingType = rs.getString("building_type");
        double buildingHeight = rs.getDouble("building_height");
        int yearBuilt = rs.getInt("year_built");
        int capacity = rs.getInt("capacity");
        double premium = rs.getDouble("premium");
        double propertyCoverageLimit = rs.getDouble("property_coverage_limit");
        double lossCoverageLimit = rs.getDouble("loss_coverage_limit");
        String currency = rs.getString("currency");
        String foundationType = rs.getString("foundation_type");
        String remarks = rs.getString("remarks");
        int datasetNumber = rs.getInt("dataset_number");
        String csvName = rs.getString("csv_name");
        Location loc = new Location(id, latitude, longitude, buildingName, buildingType, buildingHeight,
        yearBuilt, capacity, premium, propertyCoverageLimit, lossCoverageLimit,currency, foundationType,
        remarks, datasetNumber, csvName);
        results.add(loc);
      }

    } catch (SQLException ex) {
      handleSQLException(ex, sql);
    } finally {
      ConnectionManager.close(conn, stmt, rs);

    }
    return results;
  }
  
  public List<String> retrieveAllBuildingTypes(){
      List<Location> locations = retrieveAll();
      List<String> buildingTypes = new ArrayList<String>();
      for(int i=0;i<locations.size();i++){
          buildingTypes.add(locations.get(i).getBuildingType());
      }
      Set<String> set = new HashSet<String>(buildingTypes);
      List<String> uniqueBuildingTypes = new ArrayList(set);
      return uniqueBuildingTypes;
  }
  
  public ArrayList<Location> retrieveByConditions(String[] buildingTypes, String buildingName){
       ArrayList<Location> locations1 = retrieveByBuildingTypes(buildingTypes);
       ArrayList<Location> locations2 = retrieveByBuildingName(locations1, buildingName);
       return locations2;
  }
  
  public ArrayList<Location> retrieveByBuildingName(ArrayList<Location> locations, String buildingName){
      if(buildingName.equals("Any")){
          return locations;
      }
      ArrayList<Location> output = new ArrayList<Location>();
      for(Location l: locations){
          if(buildingName.equals(l.getBuildingName())){
              output.add(l);
          }
      }
      return output;
  }
  
  public ArrayList<Location> retrieveByHeight(ArrayList<Location> locations, double min, double max){
        if(min!=-1 || max!=-1){
                ArrayList<Location> output = new ArrayList<Location>();
                if(min==-1){
                   min = 0;
                }
                if(max==-1){
                   max = Double.MAX_VALUE;
                }
                for(Location l: locations){
                    double height = l.getBuildingHeight();
                    if(height<=max && height>=min){
                            output.add(l);
                    }
                }
                return output;	
        }
        return locations;
		
}
  
  public ArrayList<Location> retrieveByBuildingTypes(String[] buildingTypes){
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String sql = "";
    
    //Location result = null;
    ArrayList<Location> locations = new ArrayList<Location>();
    try {
      conn = ConnectionManager.getConnection();

       sql = "SELECT id, latitude, longitude, building_name, building_type,building_height,"
              + "year_built, capacity, premium, property_coverage_limit, loss_coverage_limit,currency,"
              + "foundation_type, remarks, dataset_number, csv_name FROM " 
               + TBLNAME + " WHERE ";
        for (int i=0;i<buildingTypes.length;i++){
            sql +=" building_type=? ";
            if(i!=buildingTypes.length-1){
                sql += " OR ";
            }
        }
      stmt = conn.prepareStatement(sql);
      for (int i=0;i<buildingTypes.length;i++){
          stmt.setString(i+1,buildingTypes[i]);
      }
      
      rs = stmt.executeQuery();
      
      while (rs.next()) {
        //Retrieve by column name
        Long id = rs.getLong("id");
        double latitude = rs.getDouble("latitude");
        double longitude = rs.getDouble("longitude");
        String buildingName = rs.getString("building_name");
        String buildingType = rs.getString("building_type");
        double buildingHeight = rs.getDouble("building_height");
        int yearBuilt = rs.getInt("year_built");
        int capacity = rs.getInt("capacity");
        double premium = rs.getDouble("premium");
        double propertyCoverageLimit = rs.getDouble("property_coverage_limit");
        double lossCoverageLimit = rs.getDouble("loss_coverage_limit");
        String currency = rs.getString("currency");
        String foundationType = rs.getString("foundation_type");
        String remarks = rs.getString("remarks");
        int datasetNumber = rs.getInt("dataset_number");
        String csvName = rs.getString("csv_name");
        Location l = new Location(id, latitude, longitude, buildingName, buildingType, buildingHeight,
        yearBuilt, capacity, premium, propertyCoverageLimit, lossCoverageLimit, currency, foundationType,
        remarks, datasetNumber, csvName);  
        locations.add(l);
      }

    } catch (SQLException ex) {
      handleSQLException(ex, sql, "building_type");
    } finally {
      ConnectionManager.close(conn, stmt, rs);
    }
    return locations;
  }

  /**
   * Retrieve a Location object given its id.
   *
   * @param id
   * @return Location object. If there is no location with the given id, return
   * null.
   */
  public Location retrieve(long id) {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String sql = "";
    Location result = null;

    try {
      conn = ConnectionManager.getConnection();

       sql = "SELECT latitude,longitude,building_name, building_type,building_height,"
              + "year_built, capacity, premium, property_coverage_limit, loss_coverage_limit,currency,"
              + "foundation_type, remarks, dataset_number, csv_name FROM " 
               + TBLNAME
               + "WHERE id=?";
      stmt = conn.prepareStatement(sql);
      stmt.setLong(1, id);

      rs = stmt.executeQuery();

      while (rs.next()) {
        //Retrieve by column name
        double latitude = rs.getDouble("latitude");
        double longitude = rs.getDouble("longitude");
        String buildingName = rs.getString("building_name");
        String buildingType = rs.getString("building_type");
        double buildingHeight = rs.getDouble("building_height");
        int yearBuilt = rs.getInt("year_built");
        int capacity = rs.getInt("capacity");
        double premium = rs.getDouble("premium");
        double propertyCoverageLimit = rs.getDouble("property_coverage_limit");
        double lossCoverageLimit = rs.getDouble("loss_coverage_limit");
        String currency = rs.getString("currency");
        String foundationType = rs.getString("foundation_type");
        String remarks = rs.getString("remarks");
        int datasetNumber = rs.getInt("dataset_number");
        String csvName = rs.getString("csv_name");
        result = new Location(id, latitude, longitude, buildingName, buildingType, buildingHeight,
        yearBuilt, capacity, premium, propertyCoverageLimit, lossCoverageLimit, currency, foundationType,
        remarks, datasetNumber, csvName);  
      }

    } catch (SQLException ex) {
      handleSQLException(ex, sql, "id=" + id);
    } finally {
      ConnectionManager.close(conn, stmt, rs);
    }
    return result;
  }
  
   public Location retrieve(double latitude,double longitude) {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String sql = "";
    Location result = null;

    try {
      conn = ConnectionManager.getConnection();

       sql = "SELECT id,building_name, building_type,building_height,"
              + "year_built, capacity, premium, property_coverage_limit, loss_coverage_limit,currency,"
              + "foundation_type, remarks, dataset_number, csv_name FROM " 
               + TBLNAME
               + "WHERE latitude=?,longitude=?";
      stmt = conn.prepareStatement(sql);
      stmt.setDouble(1, latitude);
      stmt.setDouble(2, longitude);

      rs = stmt.executeQuery();

      while (rs.next()) {
        //Retrieve by column name
        Long id = rs.getLong("id");  
        String buildingName = rs.getString("building_name");
        String buildingType = rs.getString("building_type");
        double buildingHeight = rs.getDouble("building_height");
        int yearBuilt = rs.getInt("year_built");
        int capacity = rs.getInt("capacity");
        double premium = rs.getDouble("premium");
        double propertyCoverageLimit = rs.getDouble("property_coverage_limit");
        double lossCoverageLimit = rs.getDouble("loss_coverage_limit");
        String currency = rs.getString("currency");
        String foundationType = rs.getString("foundation_type");
        String remarks = rs.getString("remarks");
        int datasetNumber = rs.getInt("dataset_number");
        String csvName = rs.getString("csv_name");
        result = new Location(id, latitude, longitude, buildingName, buildingType, buildingHeight,
        yearBuilt, capacity, premium, propertyCoverageLimit, lossCoverageLimit, currency, foundationType,
        remarks, datasetNumber, csvName);  
      }

    } catch (SQLException ex) {
      handleSQLException(ex, sql, "latitude=" + latitude + " longitude" + longitude);
    } finally {
      ConnectionManager.close(conn, stmt, rs);
    }
    return result;
  }
   
   public ArrayList<Location> retrieve(int datasetNumber) {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String sql = "";
    //Location result = null;
    ArrayList<Location> locations = new ArrayList<Location>();
    try {
      conn = ConnectionManager.getConnection();

       sql = "SELECT id, latitude, longitude, building_name, building_type,building_height,"
              + "year_built, capacity, premium, property_coverage_limit, loss_coverage_limit,currency,"
              + "foundation_type, remarks, dataset_number, csv_name FROM " 
               + TBLNAME
               + "WHERE dataset_number=?";
      stmt = conn.prepareStatement(sql);
      stmt.setInt(1, datasetNumber);
      

      rs = stmt.executeQuery();
      
      while (rs.next()) {
        //Retrieve by column name
        Long id = rs.getLong("id");
        double latitude = rs.getDouble("latitude");
        double longitude = rs.getDouble("longitude");
        String buildingName = rs.getString("building_name");
        String buildingType = rs.getString("building_type");
        double buildingHeight = rs.getDouble("building_height");
        int yearBuilt = rs.getInt("year_built");
        int capacity = rs.getInt("capacity");
        double premium = rs.getDouble("premium");
        double propertyCoverageLimit = rs.getDouble("property_coverage_limit");
        double lossCoverageLimit = rs.getDouble("loss_coverage_limit");
        String currency = rs.getString("currency");
        String foundationType = rs.getString("foundation_type");
        String remarks = rs.getString("remarks");
        //int datasetNumber = rs.getInt("dataset_number");
        String csvName = rs.getString("csv_name");
        Location l = new Location(id, latitude, longitude, buildingName, buildingType, buildingHeight,
        yearBuilt, capacity, premium, propertyCoverageLimit, lossCoverageLimit, currency, foundationType,
        remarks, datasetNumber, csvName);  
        locations.add(l);
      }

    } catch (SQLException ex) {
      handleSQLException(ex, sql, "dataset_number=" + datasetNumber);
    } finally {
      ConnectionManager.close(conn, stmt, rs);
    }
    return locations;
  }
   
   public int getNumberOfDataset() {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String sql = "";
    int output = -1;
    //Location result = null;
   // ArrayList<Location> locations = new ArrayList<Location>();
    try {
      conn = ConnectionManager.getConnection();

       sql = "SELECT max(dataset_number) as output FROM " 
               + TBLNAME;
      stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();
      
      while (rs.next()) {
        //Retrieve by column name
       
        output = rs.getInt("output");
    
      }

    } catch (SQLException ex) {
      handleSQLException(ex, sql, "get dataset number");
    } finally {
      ConnectionManager.close(conn, stmt, rs);
    }
    return output;
  }
   
   public double getMinimumHeight() {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String sql = "";
    double output = -1;
    //Location result = null;
   // ArrayList<Location> locations = new ArrayList<Location>();
    try {
      conn = ConnectionManager.getConnection();

       sql = "SELECT min(building_height) as output FROM " 
               + TBLNAME;
      stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();
      
      while (rs.next()) {
        //Retrieve by column name
       
        output = rs.getDouble("output");
    
      }

    } catch (SQLException ex) {
      handleSQLException(ex, sql, "get minimum building height");
    } finally {
      ConnectionManager.close(conn, stmt, rs);
    }
    return output;
  }
   
   public double getMaximumHeight() {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String sql = "";
    double output = -1;
    //Location result = null;
   // ArrayList<Location> locations = new ArrayList<Location>();
    try {
      conn = ConnectionManager.getConnection();

       sql = "SELECT max(building_height) as output FROM " 
               + TBLNAME;
      stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();
      
      while (rs.next()) {
        //Retrieve by column name
       
        output = rs.getDouble("output");
    
      }

    } catch (SQLException ex) {
      handleSQLException(ex, sql, "get minimum building height");
    } finally {
      ConnectionManager.close(conn, stmt, rs);
    }
    return output;
  }
   
}
