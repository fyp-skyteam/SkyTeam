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
                       	LocationDAO locationDAO = new LocationDAO();	
                       locationDAO.removeUserLocations();
                        HashMap<String,ArrayList<String>> locationDatasets = new HashMap<String,ArrayList<String>>();
                        boolean invalidFileType = false;
                        while (ze != null){
                            String datasetName = ze.getName();   
                            ArrayList<String> locationData = new ArrayList<String>();
                            locationData.addAll(uploadManager.readCSV(zis));
                            locationDatasets.put(datasetName, locationData);
                            ze = zis.getNextEntry();
                                
                        }
                        zis.close();
                        Iterator<String> iterator = locationDatasets.keySet().iterator();
                        while(iterator.hasNext()){
                                String datasetName = (String)iterator.next();
                                ArrayList<String> dataset = locationDatasets.get(datasetName);
                                out.println(dataset.size());
                                for(int i=0;i<dataset.size();i++){
                                    out.println(dataset.get(i));
                                }        
                                ArrayList<Location> locations = uploadManager.convertDataToLocations(dataset,datasetName,currency);
                                locationDAO.addLocations(locations);
                        }           
                        HashMap<String,ArrayList<String>> locationErrors = uploadManager.getLocationErrors();       
                        if(!locationErrors.isEmpty()){      
                            out.println("test error");
                            request.setAttribute("locationErrors",locationErrors);
                            RequestDispatcher dispatcher = request.getRequestDispatcher("welcome.jsp");
                           dispatcher.forward(request, response);
                        }else{
                           response.sendRedirect("welcome.jsp");
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
