package servlet;

import entity.*;
import dao.*;
import java.util.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException{	
        HttpSession session = request.getSession();       
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("test");
        LocationDAO locationDAO = new LocationDAO();
        
        String[] buildingTypes = request.getParameterValues("buildingType");
        String buildingName = request.getParameter("buildingName");
        for(String str: buildingTypes){
            out.println(str);
        }
       List<Location> locations = locationDAO.retrieveByConditions(buildingTypes, buildingName);
       
        for(int i=0;i<locations.size();i++){
           out.println(locations.get(i) + "</br>");
        }
    }   
}