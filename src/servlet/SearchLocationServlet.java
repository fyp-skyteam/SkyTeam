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
		LocationDAO locationDAO = new LocationDAO();
		String[] buildingTypes = request.getParameterValues("buildingType");
		String buildingName = request.getParameter("buildingName");
		String username = request.getParameter("username");
		String strMinHeight = request.getParameter("minHeight");
		String strMaxHeight = request.getParameter("maxHeight");
		String strMinYearBuilt = request.getParameter("minYearBuilt");
		String strMaxYearBuilt = request.getParameter("maxYearBuilt");
		String strMinCapacity = request.getParameter("minCapacity");
		String strMaxCapacity = request.getParameter("maxCapacity");
		String strMinPremium = request.getParameter("minPremium");
		String strMaxPremium = request.getParameter("maxPremium");
		String strMinProCovLimit = request.getParameter("minPropertyCoverageLimit");
		String strMaxProCovLimit = request.getParameter("maxPropertyCoverageLimit");
		String strMinLossCovLimit = request.getParameter("minLossCoverageLimit");
		String strMaxLossCovLimit = request.getParameter("maxLossCoverageLimit");
		String[] foundationTypes = request.getParameterValues("foundationType");
		String[] datasets = request.getParameterValues("datasets");
		String remark = request.getParameter("remark");		
		
		/**
		out.println(buildingName);
		for(String str: buildingTypes){
			out.println(str);
		}
		out.println(strMinHeight);
		out.println(strMaxHeight);
		out.println(strMinYearBuilt);
		out.println(strMaxYearBuilt);
		out.println(strMinCapacity);
		out.println(strMaxCapacity);
		out.println(strMinPremium);
		out.println(strMaxPremium);
		out.println(strMinProCovLimit);
		out.println(strMaxProCovLimit);
		out.println(strMinLossCovLimit);
		out.println(strMaxLossCovLimit);
		for(String str: foundationTypes){
			out.println(str);
		}
		for(String str: datasets){
			out.println(str);
		}
		out.println(remark);
		out.println("</br></br>");
		*/
		
		double minHeight = Double.parseDouble(strMinHeight);
		double maxHeight = Double.parseDouble(strMaxHeight);
		int minYearBuilt = Integer.parseInt(strMinYearBuilt);
		int maxYearBuilt = Integer.parseInt(strMaxYearBuilt);
		int minCapacity = Integer.parseInt(strMinCapacity);
		int maxCapacity = Integer.parseInt(strMaxCapacity);
		double minPremium = Double.parseDouble(strMinPremium);
		double maxPremium = Double.parseDouble(strMaxPremium);
		double minProCovLimit = Double.parseDouble(strMinProCovLimit);
		double maxProCovLimit = Double.parseDouble(strMaxProCovLimit);
		double minLossCovLimit = Double.parseDouble(strMinLossCovLimit);
		double maxLossCovLimit = Double.parseDouble(strMaxLossCovLimit);
		
		List<Location> locations = locationDAO.retrieveByUsername(username);
		locations.addAll(locationDAO.retrieveByUsername("admin"));
		locations = locationDAO.retrieveByBuildingName(buildingName,locations);
		locations = locationDAO.retrieveByBuildingType(buildingTypes,locations);
		locations = locationDAO.retrieveByHeight(minHeight, maxHeight,locations);
		locations = locationDAO.retrieveByYearBuilt(minYearBuilt, maxYearBuilt,locations);
		locations = locationDAO.retrieveByCapacity(minCapacity, maxCapacity,locations);
		locations = locationDAO.retrieveByPremium(minPremium, maxPremium,locations);
		locations = locationDAO.retrieveByPropertyCoverageLimit(minProCovLimit, maxProCovLimit,locations);
		locations = locationDAO.retrieveByLossCoverageLimit(minLossCovLimit, maxLossCovLimit,locations);
		locations = locationDAO.retrieveByFoundationType(foundationTypes,locations);
		locations = locationDAO.retrieveByDataset(datasets,locations);
		locations = locationDAO.retrieveByRemark(remark,locations);
		
		/**
		out.println(locations.size());
		for(int i=0;i<locations.size();i++){
			out.println(locations.get(i).toString()+"</br>");
		}
		out.println("</br></br></br>");*/

		session.setAttribute("locationSearchResult",locations);
		session.setAttribute("currentView","filter");
		response.sendRedirect("welcome.jsp");
		
		
		
	}
	
}
