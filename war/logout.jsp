<%@page import="entity.*" %>
<%@page import="dao.*" %>
<%
User user = (User) session.getAttribute("authenticated.user");
LocationDAO locationDAO= new LocationDAO();
locationDAO.removeUserLocations(user.getUsername());
session.removeAttribute("authenticated.user");
%>
<jsp:forward page="login.jsp" />
  