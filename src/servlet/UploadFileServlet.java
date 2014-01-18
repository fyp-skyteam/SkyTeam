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


public class UploadFileServlet extends HttpServlet{
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
                       //uploadManager.removeAll(); 
                       LocationDAO locationDAO = new LocationDAO();	
                        locationDAO.removeAll();
                        
                       
                        HashMap<String,ArrayList<String>> locationDatasets = new HashMap<String,ArrayList<String>>();
                        ArrayList<String> fileErrors = new ArrayList<String>();
                        while (ze != null){
                                String datasetName = ze.getName();
                                out.println(datasetName);
                                out.println(datasetName.substring(datasetName.length()-3,datasetName.length()));
                                if(!datasetName.substring(datasetName.length()-3,datasetName.length()).equals("csv")){
                                    fileErrors.add("("+datasetName+")");
                                }else{
                                    ArrayList<String> locationData = new ArrayList<String>();
                                    locationData.addAll(uploadManager.readCSV(zis));
                                    out.println(locationData.size());
                                    locationDatasets.put(datasetName, locationData);
                                }
                                ze = zis.getNextEntry();
                                
                        }
                        zis.close();
                        
                    
                       
                        out.println("test5");
                        Iterator iterator = locationDatasets.keySet().iterator();
                        int datasetNumber = 1;
                       
                        while(iterator.hasNext()){
                                String datasetName = (String)iterator.next();
                                ArrayList<String> dataset = locationDatasets.get(datasetName);
                                out.println(dataset.size());
                                for(int i=0;i<dataset.size();i++){
                                    out.println(dataset.get(i));
                                }
                                out.println(datasetName + " " + datasetNumber);
                                out.println("abc");
                                ArrayList<Location> locations = uploadManager.convertDataToLocations(dataset,datasetName,datasetNumber,currency);
                                datasetNumber++;
                                out.println(" def");
                                out.println(locations.size());
                                out.println("test");
                                //for(int i=0;i<locations.size();i++){
                                  //  locationDAO.create(locations.get(i)); 
                                   
                                //}
                                locationDAO.addLocations(locations);
                        }
                        
                        out.println("final test");
                        HashMap<String,ArrayList<String>> locationErrors = uploadManager.getLocationErrors();
                        out.println(locationErrors.size());
                        
                        
                        if(!locationErrors.isEmpty() || !fileErrors.isEmpty()){
                            
                            out.println("test error");
                            request.setAttribute("locationErrors",locationErrors);
                            request.setAttribute("fileErrors",fileErrors);
                            RequestDispatcher dispatcher = request.getRequestDispatcher("welcome.jsp");
                           // dispatcher.forward(request, response);
                        }else{
                           //response.sendRedirect("welcome.jsp");
                        }
                       
                        
                       
                    }
                }
        }catch(Exception e){
            e.printStackTrace();
        }
	out.close();
        out.println("end");
	}	
}
