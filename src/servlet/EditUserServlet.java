package servlet;
import entity.*;
import dao.*;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class EditUserServlet extends HttpServlet{
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException{
		response.setContentType("text/html");
		//PrintWriter out = response.getWriter();
		String name = request.getParameter("name");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String idStr = request.getParameter("id");

		Long id = Long.parseLong(idStr);
		UserDAO uDao = new UserDAO();
		
		ArrayList<String> error = uDao.getError(name, username, password);
		if(error ==null || error.isEmpty()){
			User user = uDao.retrieve(id);
			user.setName(name);
			user.setUsername(username);
			user.setPassword(password);
			uDao.modify(user);
			response.sendRedirect("bootstrap-menu.jsp");
		}else{
			String errorMsg = "";
			for(String str: error){
				errorMsg += str + "<br/>";
			}
			RequestDispatcher dispatcher = request.getRequestDispatcher("edit-user.jsp?username=" + username
					+ "&password=" + password + "&id=" + id + "&name=" + name + "&errorMsg=" + errorMsg);
			dispatcher.forward(request, response);
		}
		
		
		
	}
}
