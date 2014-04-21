package servlet;
import entity.*;
import dao.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LogInServlet extends HttpServlet{
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException{
		response.setContentType("text/html");
		String username = request.getParameter("username").toLowerCase().trim();
		String password = request.getParameter("password");
		if(username.equals("admin") && password.equals("admin")){
			response.sendRedirect("bootstrap-menu.jsp");
		}else{
			UserDAO userDAO = new UserDAO();
			User user= userDAO.authenticate(username, password); 
			if (user==null){
				RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp?username=" + username + "&LogInErrorMsg=" + "Invalid username/password");
				dispatcher.forward(request, response);
			}else{
				HttpSession session = request.getSession();
				session.setAttribute("authenticated.user",user);  
				response.sendRedirect("welcome.jsp");
			}	
		}
	}
}
