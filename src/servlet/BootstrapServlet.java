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
        out.println("test1");
        ServletFileUpload upload = new ServletFileUpload();
        try{
            out.println("test2");
            FileItemIterator iter = upload.getItemIterator(request);
         
            while (iter.hasNext()) {
                FileItemStream item = iter.next();
                InputStream stream = item.openStream();
                    if (item.isFormField()) {
                        out.println("form field");             
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
                                out.println(datasetName);
                                out.println(datasetName.substring(datasetName.length()-3,datasetName.length()));
                                if(!datasetName.substring(datasetName.length()-3,datasetName.length()).equals("csv")){
                                    fileErrors.add("("+datasetName+")");
                                    out.println("invalid file type");
                                }else if(datasetName.equals("locations.csv")){  
                                    locationData.addAll(uploadManager.readCSV(zis));
                                    out.println(locationData.size());
                                    //locationDatasets.put(datasetName, locationData);
                                }else if(datasetName.equals("users.csv")){
                                    userData.addAll(uploadManager.readCSV(zis));
                                    out.println(userData.size());
                                }
                                ze = zis.getNextEntry();
                                
                        }
                        zis.close();
                        
                        ArrayList<Location> locations = uploadManager.convertDataToLocations(locationData, "bootstrap location",-1 , "USD");
                        for(Location l: locations){
                        	out.println(l.toString()+ "</br> ");
                        }
                        locationDAO.addLocations(locations);
                        List<Location> testData = locationDAO.retrieveAll();
                        for(Location l: testData){
                        	out.println(l.toString()+ "</br> ");
                        }
                        
                        ArrayList<User> users = uploadManager.convertDataToUsers(userData);
                        for(User u: users){
                        	out.println(u.toString()+ "</br> ");
                        }
                        userDAO.addUser(users);
                        List<User> testData1 = userDAO.retrieveAll();
                        for(User u: testData1){
                        	out.println(u.toString()+ "</br> ");
                        }
                	}
                }
            	
        }catch(Exception e){
            e.printStackTrace();
        }
        out.close();

	}	
}

