<%@page import="entity.*"%>
<%
User _user;

// check if user is authenticated
_user = (User)session.getAttribute("authenticated.user");
if (_user == null) {
  // not authenticated, force user to authenticate
  response.sendRedirect("login.jsp");
  return;
} 
%>
