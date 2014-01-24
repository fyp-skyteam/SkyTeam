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


public class BootstrapServlet extends HttpServlet{
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException{	
        String currency = "USD";
		HttpSession session = request.getSession();
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        //out.println("test1");
        ServletFileUpload upload = new ServletFileUpload();
        try{
            //out.println("test2");
            FileItemIterator iter = upload.getItemIterator(request);
         
            while (iter.hasNext()) {
                FileItemStream item = iter.next();
                InputStream stream = item.openStream();
                    if (item.isFormField()) {
                        //out.println("form field");             
                    } else { 
                        ZipInputStream zis = new ZipInputStream(stream);
                        ZipEntry ze = zis.getNextEntry();
                        UploadManager uploadManager = new UploadManager();
                        LocationDAO locationDAO = new LocationDAO();	
                        locationDAO.removeAll();
                        UserDAO userDAO = new UserDAO();
                        userDAO.removeAll();
                    	//HashMap<String,ArrayList<String>> locationDatasets = new HashMap<String,ArrayList<String>>();
                        ArrayList<String> fileErrors = new ArrayList<String>();
                        ArrayList<String> locationData = new ArrayList<String>();
                        ArrayList<String> userData = new ArrayList<String>();
                        while (ze != null){
                                String datasetName = ze.getName();
                                //out.println(datasetName);
                                //out.println(datasetName.substring(datasetName.length()-3,datasetName.length()));
                                if(!datasetName.substring(datasetName.length()-3,datasetName.length()).equals("csv")){
                                    fileErrors.add(datasetName+": invalid file type");
                                    //out.println("invalid file type");
                                }else if(!datasetName.equals("locations.csv")&&!datasetName.equals("users.csv")){
                                	fileErrors.add(datasetName+": invalid file name");
                                }else if(datasetName.equals("locations.csv")){  
                                    locationData.addAll(uploadManager.readCSV(zis));
                                    //out.println(locationData.size());
                                    //locationDatasets.put(datasetName, locationData);
                                }else if(datasetName.equals("users.csv")){
                                    userData.addAll(uploadManager.readCSV(zis));
                                    //out.println(userData.size());
                                }
                                ze = zis.getNextEntry();
                                
                        }
                        zis.close();
                        
                        ArrayList<Location> locations = uploadManager.convertDataToLocations(locationData, "bootstrap location dataset" , "USD");                
                        locationDAO.addLocations(locations);
                        
                        ArrayList<User> users = uploadManager.convertDataToUsers(userData,"bootstrap user dataset");
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
                	}
                }
            	
        }catch(Exception e){
            e.printStackTrace();
        }
        out.close();

	}	
}

