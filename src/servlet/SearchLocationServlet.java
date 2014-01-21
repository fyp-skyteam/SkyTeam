package servlet;

import entity.*;
import dao.*;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class SearchLocationServlet extends HttpServlet{
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("test");
		LocationDAO locationDAO = new LocationDAO();
		
		String[]buildingTypes = request.getParameterValues("buildingType");
		String buildingName = request.getParameter("buidlingName");
		for(String str: buildingTypes){
			out.println(str);
		}
		
		List<Location> locations = locationDAO.retrieveByConditions(buildingTypes, buildingName);
		for(int i=0;i<locations.size();i++){
			out.println(locations.get(i)+"</br>");
			
		}
		
		
	}
	
}
