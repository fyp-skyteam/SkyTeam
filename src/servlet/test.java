package controller;
import model.*;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;


public class SearchDisplayFacilityServlet extends HttpServlet{
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		response.setContentType("text/html");
		//PrintWriter out = response.getWriter();
		FacilityManager fManager = new FacilityManager();
		BookingManager bManager = new BookingManager();
		TimeManager tManager = new TimeManager();
		
		String building = request.getParameter("building");
		String level = request.getParameter("floor");
		String facilityType = request.getParameter("facilityType");
		String capMin = request.getParameter("minCapacity");
		String capMax = request.getParameter("maxCapacity");
		String facility = request.getParameter("facility");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String availability = request.getParameter("available");
		String formName = request.getParameter("formName");
		String resultName = "DisplayFacilityMenu.jsp";
		if(formName.equals("SearchFacilityMenuNonLogIn.jsp")){
			resultName = "DisplayFacilityMenuNonLogIn.jsp";
		}
		
		int minCapacity = -1;
		int maxCapacity = -1;
		int floor = -1;
		if(!capMin.equals("any")){
			minCapacity = Integer.parseInt(capMin);
		}
		if(!capMax.equals("any")){
			maxCapacity = Integer.parseInt(capMax);
		}
		if(!level.equals("any")){
			floor = Integer.parseInt(level);
		}
		
		String errorMsg = "";
		boolean valid = true;
		if(building.equals("any") && level.equals("any") && facilityType.equals("any") &&
				minCapacity==-1 && maxCapacity==-1 && facility.equals("any") && availability.equals("any")){
			errorMsg += "Please specify one of the following fields: location (building or floor or facility), facility type, capacity (min or max) and availability.<br/>";
			valid = false;
		}
		Calendar startCalendar = tManager.convertToCalendar(startDate, startTime);
		Calendar endCalendar = tManager.convertToCalendar(endDate, endTime);
		
		if(startCalendar.compareTo(endCalendar)>=0){
			errorMsg += "Start time and start date must be before end time and end date.<br/>";
			valid = false;
		}
		if(minCapacity!=-1 && maxCapacity!=-1){
			if(minCapacity>maxCapacity){
				errorMsg += "Max capacity must be larger than or equal to min capacity. <br/>";
				valid = false;
			}
		}
		if(!valid){
			RequestDispatcher dispatcher = request.getRequestDispatcher(formName + "?building=" + building + 
					"&level=" + level + "&facilityType=" + facilityType + "&capMin=" + capMin + "&capMax=" + capMax +
					"&facility=" + facility + "&startDate=" + startDate + "&startTime=" + startTime + "&endDate=" + endDate +
					"&endTime=" + endTime + "&availability=" + availability + "&errorMsg=" + errorMsg);
			dispatcher.forward(request, response);
			
		}else{
			HashMap<String,ArrayList<Booking>> map = new HashMap<String,ArrayList<Booking>>();
			if(facility.equals("any")){
				List<Facility> facilities = fManager.retrieveByCondition(building,floor,facilityType,minCapacity, maxCapacity);
				//out.println(facilities.size());
				if(facilities.size()==0){
					RequestDispatcher dispatcher = request.getRequestDispatcher(formName + "?building=" + building + 
							"&level=" + level + "&facilityType=" + facilityType + "&capMin=" + capMin + "&capMax=" + capMax +
							"&facility=" + facility + "&startDate=" + startDate + "&startTime=" + startTime + "&endDate=" + endDate +
							"&endTime=" + endTime + "&availability=" + availability + "&errorMsg=" + "There is no matching facility");
					dispatcher.forward(request, response);
				}else{
					for(Facility f: facilities){
						//out.println(f.getName());
						ArrayList<Booking> bookings = bManager.retrieveByConditions(f.getName(),startCalendar,endCalendar);
						
						map.put(f.getName(), bookings);
					}
				}	
			}else{
				ArrayList<Booking> bookings = bManager.retrieveByConditions(facility,startCalendar,endCalendar);
				map.put(facility,bookings);
			}
			Set<String> list = map.keySet();
			if(list.isEmpty()){
				RequestDispatcher dispatcher = request.getRequestDispatcher(formName + "?building=" + building + 
						"&level=" + level + "&facilityType=" + facilityType + "&capMin=" + capMin + "&capMax=" + capMax +
						"&facility=" + facility + "&startDate=" + startDate + "&startTime=" + startTime + "&endDate=" + endDate +
						"&endTime=" + endTime + "&availability=" + availability + "&errorMsg=" + "There is no matching facility");
				dispatcher.forward(request, response);
			} else{
				if(availability.equals("available")){
					ArrayList<String> availableFacilities = new ArrayList<String>();
					Iterator<String> faciIterator = list.iterator();
					while(faciIterator.hasNext()){
						String f = faciIterator.next();
						ArrayList<Booking> bookingList = map.get(f);
						if(bookingList.isEmpty()){
							availableFacilities.add(f);
						}
					}
					if(availableFacilities.isEmpty()){
						RequestDispatcher dispatcher = request.getRequestDispatcher(formName + "?building=" + building + 
								"&level=" + level + "&facilityType=" + facilityType + "&capMin=" + capMin + "&capMax=" + capMax +
								"&facility=" + facility + "&startDate=" + startDate + "&startTime=" + startTime + "&endDate=" + endDate +
								"&endTime=" + endTime + "&availability=" + availability + "&errorMsg=" + "There is no matching facility");
						dispatcher.forward(request, response);
					}else{
						HttpSession session = request.getSession();
						session.setAttribute("startCalendar",startCalendar);
						session.setAttribute("endCalendar", endCalendar);
						session.setAttribute("availability", availability);
						session.setAttribute("availableFacilities",availableFacilities );
						response.sendRedirect(resultName);	
					}
				}else{
					HttpSession session = request.getSession();
					session.setAttribute("matchingFacilities", map);
					session.setAttribute("availability", availability);
					session.setAttribute("startCalendar",startCalendar);
					session.setAttribute("endCalendar", endCalendar);
					response.sendRedirect(resultName);	
				}
			}
		}	
	}
}


