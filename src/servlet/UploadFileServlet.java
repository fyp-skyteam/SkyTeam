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
                	//out.println("error: stuck at servlet");
                    ZipInputStream zis = new ZipInputStream(stream);
                    ZipEntry ze = zis.getNextEntry();
                  
                                         
                    while (ze != null){
                        String datasetName = ze.getName();   
                        ArrayList<String> locationData = new ArrayList<String>();
                        locationData.addAll(uploadManager.readCSV(zis));
                        locationDatasets.put(datasetName, locationData);
                        ze = zis.getNextEntry();
                            
                    }
                    zis.close();
                }
            }
            //out.println(currency);
            //out.println(clearUserData);
            //out.println(username);
            if(clearUserData){
            	locationDAO.removeUserLocations(username);  
            } 
            Iterator<String> iterator = locationDatasets.keySet().iterator();
            while(iterator.hasNext()){
                    String datasetName = (String)iterator.next();
                    ArrayList<String> dataset = locationDatasets.get(datasetName);
                    //out.println(dataset.size());
                    //for(int i=0;i<dataset.size();i++){
                      //  out.println(dataset.get(i));
                    //}        
                    ArrayList<Location> locations = uploadManager.convertDataToLocations(dataset,datasetName,currency,username);
                    locationDAO.addLocations(locations);
            }           
            HashMap<String,ArrayList<String>> locationErrors = uploadManager.getLocationErrors();  
            
            if(!locationErrors.isEmpty()){      
                //out.println("test error");
                String errorMsg="";
                //HashMap<String,ArrayList<String>> locationErrors = (HashMap<String,ArrayList<String>>)request.getAttribute("locationErrors");
                //ArrayList<String> fileErrors = (ArrayList<String>)request.getAttribute("fileErrors");
               
                Iterator<String> iterator1 = locationErrors.keySet().iterator();
                while(iterator1.hasNext()){
                    String errorLine = iterator1.next();
                    errorMsg += errorLine+": ";
                    ArrayList<String> errorStr = locationErrors.get(errorLine);
                    for(int i=0;i<errorStr.size();i++){
                        if(i==errorStr.size()){
                        	errorMsg += errorStr.get(i);
                        }else{
                        	errorMsg += errorStr.get(i)+ ", ";
                        }
                    }
                    errorMsg += "</br>";

                }
                //out.println(errorMsg);
                RequestDispatcher dispatcher = request.getRequestDispatcher("welcome.jsp?locationErrors="+errorMsg);
               dispatcher.forward(request, response);
            }else{
               response.sendRedirect("welcome.jsp");
            }                     
        }catch(Exception e){
            e.printStackTrace();
        }
        out.close();
        out.println("end upload");
	}	
}
