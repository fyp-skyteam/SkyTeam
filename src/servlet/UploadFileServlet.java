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
import org.apache.commons.fileupload.util.*;

public class UploadFileServlet extends HttpServlet{
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException{	
        String currency = "";  
        String username = "";
        boolean clearUserData = false;
		HttpSession session = request.getSession();
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        ServletFileUpload upload = new ServletFileUpload();
        UploadManager uploadManager = new UploadManager();            
       	LocationDAO locationDAO = new LocationDAO();	
        HashMap<String,ArrayList<String>> locationDatasets = new HashMap<String,ArrayList<String>>();
        try{
            FileItemIterator iter = upload.getItemIterator(request);   
            ArrayList<String> fileErrors = new ArrayList<String>();
            while (iter.hasNext()) {
                FileItemStream item = iter.next();
                InputStream stream = item.openStream();
                if (item.isFormField()) {
                	String str = Streams.asString(stream);
                	if(str.equals("SGD")||str.equals("AUD")||str.equals("CAD")||str.equals("CHF")
                				||str.equals("CNY")||str.equals("EUR")||str.equals("GBP")||str.equals("HKD")
                				||str.equals("INR")||str.equals("JPY")||str.equals("USD")){
                		currency = str.toString();
                	}else if(str.equals("clear-data")){
                		clearUserData = true;
                	}else{
                		username = str.toString();
                	}
                } else {   
                	String fileName = item.getName();
                	 if (fileName.substring(fileName.length()-3,fileName.length()).equals("zip")){
                		 ZipInputStream zis = new ZipInputStream(stream);
                         ZipEntry ze = zis.getNextEntry(); 
                         while (ze != null){ 
                        	 String datasetName = ze.getName();      
                             if(!datasetName.substring(datasetName.length()-3,datasetName.length()).equals("csv")){
                            	 fileErrors.add(datasetName+": invalid file type");
                             }else{
                            	 ArrayList<String> locationData = new ArrayList<String>();
                                 locationData.addAll(uploadManager.readCSV(zis));
                                 locationDatasets.put(datasetName, locationData);
                                 
                             }      
                             ze = zis.getNextEntry();
                         }
                         zis.close();
                	 }else if (fileName.substring(fileName.length()-3,fileName.length()).equals("csv")){
                		 ArrayList<String> locationData = new ArrayList<String>();
                         locationData.addAll(uploadManager.readCSV(stream));
                         locationDatasets.put(fileName, locationData);
                	 }else{
                		 RequestDispatcher dispatcher = request.getRequestDispatcher("welcome.jsp?locationErrors=Invalid file type! Please upload either a zip or csv file");
                         dispatcher.forward(request, response);
                	 }    
                }
            }

            ArrayList<Location> allLocations = new ArrayList<Location>();
            if(clearUserData){
            	locationDAO.removeUserLocations(username);  
            } 
            Iterator<String> iterator = locationDatasets.keySet().iterator();
            while(iterator.hasNext()){
                    String datasetName = (String)iterator.next();
                    ArrayList<String> dataset = locationDatasets.get(datasetName);
      
                    ArrayList<Location> locations = uploadManager.convertDataToLocations(dataset,datasetName,currency,username);
                    locationDAO.addLocations(locations);
                    allLocations.addAll(locations);
            }           
            HashMap<String,ArrayList<String>> locationErrors = uploadManager.getLocationErrors();  
            
            if(!locationErrors.isEmpty() || !fileErrors.isEmpty()){      
                //out.println("test error");
                String errorMsg = "<strong>You have successuflly uploaded " + allLocations.size() + " building locations on the map</strong></br>";
                if(!fileErrors.isEmpty()){
                	errorMsg += "<strong>Warning! The following files have not been uploaded. Please upload either a csv file or a zip file containing only csv files:</strong></br>";
                    for(int i=0;i<fileErrors.size();i++){
                        if(i==(fileErrors.size()-1)){
                        	errorMsg += fileErrors.get(i);
                        }else{
                        	errorMsg += fileErrors.get(i)+ ", ";
                        }
                    }
                    errorMsg += "</br>";
                }
                if(!locationErrors.isEmpty()){
                	 errorMsg += "<strong>Warning! The following building locations have not been uploaded due to the following errors:</strong></br>";
                     Iterator<String> iterator1 = locationErrors.keySet().iterator();
                     while(iterator1.hasNext()){
                         String errorLine = iterator1.next();
                         errorMsg += errorLine+": ";
                         ArrayList<String> errorStr = locationErrors.get(errorLine);
                         for(int i=0;i<errorStr.size();i++){
                             if(i==(errorStr.size()-1)){
                             	errorMsg += errorStr.get(i);
                             }else{
                             	errorMsg += errorStr.get(i)+ ", ";
                             }
                         }
                         errorMsg += "</br>";

                     }
                }
                RequestDispatcher dispatcher = request.getRequestDispatcher("welcome.jsp?locationErrors="+errorMsg);
                dispatcher.forward(request, response);
            }else{
            	RequestDispatcher dispatcher = request.getRequestDispatcher("welcome.jsp?locationErrors="+"<strong>You have successuflly uploaded " + allLocations.size() + " building locations on the map</strong>");
                dispatcher.forward(request, response);
            }                     
        }catch(Exception e){
            e.printStackTrace();
        }
        out.close();
        out.println("end upload");
	}	
}
