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
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String idStr = request.getParameter("id");
		String[] widgets = request.getParameterValues("widgets");
		Long id = Long.parseLong(idStr);
		UserDAO uDao = new UserDAO();
		
		ArrayList<String> error = uDao.getError(name, password);
		if(error ==null || error.isEmpty()){
			User user = uDao.retrieve(id);
			ArrayList<String> userWidgets = new ArrayList<String>();
			if(widgets!=null){
				for(String str: widgets){
					userWidgets.add(str);
				}
			}
			user.setName(name);
			user.setPassword(password);
			user.setWidgets(userWidgets);
			uDao.modify(user);
			response.sendRedirect("bootstrap-menu.jsp");
		}else{
			String errorMsg = "";
			for(String str: error){
				errorMsg += str + "<br/>";
			}
			RequestDispatcher dispatcher = request.getRequestDispatcher("edit-user.jsp?password=" + password + 
					"&id=" + id + "&name=" + name + "&errorMsg=" + errorMsg);
			dispatcher.forward(request, response);
		}
		
		
		
	}
}
