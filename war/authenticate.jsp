<%@page import="java.util.*"%>
<%@page import="entity.*,dao.*"%>
<%
  // initial declarations
  String userName = request.getParameter("username");
  String password = request.getParameter("password");
  User currentUser;

  if (password != null) {
    //UserDAO dao = new UserDAO();
    //currentUser = (User) dao.retrieve(userName);
    //if ((currentUser != null)
      //      && (currentUser.authenticate(password))) {
      // display authenticated info 
     if(userName.equals("admin") && password.equals("pass")){
 		currentUser  = new User("admin","Administration","pass");
    	 session.setAttribute("authenticated.user", currentUser);
         response.sendRedirect("welcome.jsp");
     }
      
    } else {
      // inform user to re-enter
%>
<jsp:forward page="login.jsp">
  <jsp:param name="errorMsg" value="Invalid username/password" />
</jsp:forward>
<%    }
  
%>
