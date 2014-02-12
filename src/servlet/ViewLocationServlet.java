package servlet;

import entity.*;
import dao.*;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class ViewLocationServlet extends HttpServlet{
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		LocationDAO locationDAO = new LocationDAO();
		String username = (String)request.getParameter("username");
		out.println(username);
		List<Location> locations = locationDAO.retrieveByUsername(username);
		locations.addAll(locationDAO.retrieveByUsername("admin"));
		ArrayList<String> userDatasetList = locationDAO.getDatasetListByUsername(username);
		userDatasetList.add("system location dataset");
		//String chosenDataset = null;
		String chosenDataset = request.getParameter("dataset");
		out.println(chosenDataset);
		
		if(!chosenDataset.equals("all")){
			//for(String dataset: userDatasetList){
				//chosenDataset = request.getParameter(dataset);
				//if(chosenDataset!=null){
					//break;
				//}
			//}
			Iterator<Location> iter = locations.iterator();
			while(iter.hasNext()){
				Location l = iter.next();
				if(!l.getCSVName().equals(chosenDataset)){
					iter.remove();
				}
			}
			session.setAttribute("locationSearchResult",locations);
		}
		else {
			session.removeAttribute("locationSearchResult");
			
		}
		session.setAttribute("currentView",chosenDataset);
		response.sendRedirect("welcome.jsp");
		
	}
}