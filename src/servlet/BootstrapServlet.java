package servlet;

import entity.*;  
import dao.*;

import java.io.*; 
import java.util.*;
import java.util.zip.*;

import javax.servlet.*;
import javax.servlet.http.*; 

import org.apache.commons.fileupload.*; 
import org.apache.commons.fileupload.servlet.*;
import org.apache.commons.fileupload.util.Streams;


public class BootstrapServlet extends HttpServlet{
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException{	
        String currency = "";
		HttpSession session = request.getSession();
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        ServletFileUpload upload = new ServletFileUpload();
        UploadManager uploadManager = new UploadManager();            
       	LocationDAO locationDAO = new LocationDAO();	
        UserDAO userDAO = new UserDAO();
        ArrayList<String> fileErrors = new ArrayList<String>();
        ArrayList<String> locationData = new ArrayList<String>();
        ArrayList<String> userData = new ArrayList<String>();
        //HashMap<String,ArrayList<String>> locationDatasets = new HashMap<String,ArrayList<String>>();
        try{
            FileItemIterator iter = upload.getItemIterator(request);
         
            while (iter.hasNext()) {
                FileItemStream item = iter.next();
                InputStream stream = item.openStream();
                    if (item.isFormField()) {
                    	 currency = Streams.asString(stream);           
                    } else { 
                        ZipInputStream zis = new ZipInputStream(stream);
                        ZipEntry ze = zis.getNextEntry();      	
                        locationDAO.removeAll();
                        userDAO.removeAll();                    	
                        
                        while (ze != null){
                                String datasetName = ze.getName();      
                                if(!datasetName.substring(datasetName.length()-3,datasetName.length()).equals("csv")){
                                    fileErrors.add(datasetName+": invalid file type");
                                }else if(!datasetName.equals("locations.csv")&&!datasetName.equals("users.csv")){
                                	fileErrors.add(datasetName+": invalid file name");
                                }else if(datasetName.equals("locations.csv")){  
                                    locationData.addAll(uploadManager.readCSV(zis));            
                                }else if(datasetName.equals("users.csv")){
                                    userData.addAll(uploadManager.readCSV(zis));
                                }
                                ze = zis.getNextEntry();
                                
                        }
                        zis.close();
                    }
            }                       
            ArrayList<Location> locations = uploadManager.convertDataToLocations(locationData, "system location dataset" , currency,"admin");                
            locationDAO.addLocations(locations);  
            ArrayList<User> users = uploadManager.convertDataToUsers(userData,"system user dataset");
            userDAO.addUser(users);
            HashMap<String,ArrayList<String>> locationErrors = uploadManager.getLocationErrors();
            HashMap<String,ArrayList<String>> userErrors = uploadManager.getUserErrors();
            if(!locationErrors.isEmpty()||!fileErrors.isEmpty()||!userErrors.isEmpty()){
            	String errorMsg = "";
            	if(!locationErrors.isEmpty()){
            		Iterator iterator = locationErrors.keySet().iterator();         	
                	while(iterator.hasNext()){
                		String errorLine = (String)iterator.next();
                		errorMsg += errorLine + ": ";
                		ArrayList<String> errorStr = locationErrors.get(errorLine);
                		for(int i=0;i<errorStr.size();i++){
                			if(i==errorStr.size()-1){
                				errorMsg += errorStr.get(i);
                			}else{
                				errorMsg += errorStr.get(i) + ", ";
                			}			
                		}
                		errorMsg += "</br>";
                	}
            	}
            	if(!userErrors.isEmpty()){
            		Iterator iterator = userErrors.keySet().iterator();         	
                	while(iterator.hasNext()){
                		String errorLine = (String)iterator.next();
                		errorMsg += errorLine + ": ";
                		ArrayList<String> errorStr = userErrors.get(errorLine);
                		for(int i=0;i<errorStr.size();i++){
                			if(i==errorStr.size()-1){
                				errorMsg += errorStr.get(i);
                			}else{
                				errorMsg += errorStr.get(i) + ", ";
                			}			
                		}
                		errorMsg += "</br>";
                	}
            	}
            	if(!fileErrors.isEmpty()){
            		for(int i=0;i<fileErrors.size();i++){
            	        errorMsg += fileErrors.get(i) + "</br>";
            	    }
            	}
            	out.println("The following data is invalid and therefore, was not bootstraped completely: </br>");
            	out.println(errorMsg);
            }else{
            	out.println("The data was successfully bootstraped completely");
            }            	
        }catch(Exception e){
            e.printStackTrace();
        }
        out.close();
	}	
}

