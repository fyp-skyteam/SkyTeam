package servlet;

import entity.*;  
import dao.*;

import java.io.*; 
import java.net.URLConnection;
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
        LocationMetadataDAO locationMetadataDAO = new LocationMetadataDAO();
        ArrayList<String> fileErrors = new ArrayList<String>();
        //ArrayList<String> locationData = new ArrayList<String>();
        ArrayList<String> userData = new ArrayList<String>();
        ArrayList<String> locationMetadata = new ArrayList<String>();
        //HashMap<String,ArrayList<String>> locationDatasets = new HashMap<String,ArrayList<String>>();
        try{
            FileItemIterator iter = upload.getItemIterator(request);
         
            while (iter.hasNext()) {
                FileItemStream item = iter.next();
                InputStream stream = item.openStream();
                    if (item.isFormField()) {
                    	 currency = Streams.asString(stream);           
                    } else { 
                    	String fileName = item.getName();
                    	//String fileType = FacesContext.getCurrentInstance().getEexternalContext().getMimeType(fileName);
                    	
                    	 if (fileName.substring(fileName.length()-3,fileName.length()).equals("zip")){
                    		 ZipInputStream zis = new ZipInputStream(stream);
                             ZipEntry ze = zis.getNextEntry();      	
                             locationDAO.removeAll();
                             userDAO.removeAll();                    	
                             locationMetadataDAO.removeAll();
                             while (ze != null){
                                     String datasetName = ze.getName();      
                                     if(!datasetName.substring(datasetName.length()-3,datasetName.length()).equals("csv")){
                                         fileErrors.add(datasetName+": invalid file type");
                                     }else if(!datasetName.equals("locations metadata.csv")&&!datasetName.equals("users.csv")){
                                     	fileErrors.add(datasetName+": invalid file name");
                                     }else if(datasetName.equals("locations metadata.csv")){
                                    	 locationMetadata.addAll(uploadManager.readCSV(zis));
                                     }else if(datasetName.equals("users.csv")){
                                         userData.addAll(uploadManager.readCSV(zis));
                                     }
                                     ze = zis.getNextEntry();
                                     
                             }
                             zis.close();
                    	 }else if(fileName.substring(fileName.length()-3,fileName.length()).equals("csv")){
                    		 locationDAO.removeAll();
                             userDAO.removeAll();  
                    		 userData.addAll(uploadManager.readCSV(stream));
                    		  /*BufferedReader reader = new BufferedReader(new InputStreamReader(stream));
	                	        StringBuilder strBuilder  = new StringBuilder();
	                	        String line;
	                	        while ((line = reader.readLine()) != null) {
	                	            strBuilder.append(line);
	                	        }
	                	        out.println(strBuilder.toString());   //Prints the string content read from input stream
	                	        reader.close();*/
                    	 }else{
                    		 fileErrors.add("Invalid file type: please upload either zip or csv file");
                    	 }
                    }
            }                       
  
            ArrayList<User> users = uploadManager.convertDataToUsers(userData,"system user dataset");
            ArrayList<LocationMetadata> locationMetadataObject = uploadManager.convertDataToLocationMetadata(locationMetadata,"system user dataset");
            userDAO.addUser(users);
            locationMetadataDAO.addLocationMetadata(locationMetadataObject);
            //HashMap<String,ArrayList<String>> locationErrors = uploadManager.getLocationErrors();
            HashMap<String,ArrayList<String>> userErrors = uploadManager.getUserErrors();
            if(!fileErrors.isEmpty()||!userErrors.isEmpty()){
            	String errorMsg = "";
            	/*if(!locationErrors.isEmpty()){
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
            	}*/
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
            	errorMsg = "The following data is invalid and therefore, was not bootstraped completely: </br>" + errorMsg;
            	RequestDispatcher dispatcher = request.getRequestDispatcher("bootstrap-menu.jsp?errorMsg="+errorMsg);
                dispatcher.forward(request, response);
            	//out.println("The following data is invalid and therefore, was not bootstraped completely: </br>");
            	//out.println(errorMsg);
            }else{
                RequestDispatcher dispatcher = request.getRequestDispatcher("bootstrap-menu.jsp?errorMsg=The data was successfully bootstraped completely");
                dispatcher.forward(request, response);
            }   
        }catch(Exception e){
            e.printStackTrace();
        }
        out.close();
	}	
}

