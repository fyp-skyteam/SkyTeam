package servlet;
import entity.*;
import dao.*;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class RemoveUserServlet extends HttpServlet{
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException{
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String idStr = request.getParameter("id");
		Long id = Long.parseLong(idStr);
		UserDAO uDao = new UserDAO();
		LocationDAO lDao = new LocationDAO();
		User user = uDao.retrieve(id);
		String username = user.getUsername();
		lDao.removeUserLocations(username);
		uDao.removeUserById(id);
		response.sendRedirect("bootstrap-menu.jsp");
	}
}
