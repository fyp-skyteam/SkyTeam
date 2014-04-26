<%@page import="entity.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import ="java.io.Serializable" %>
<%
String errorMsg=(String)request.getParameter("errorMsg");
if(errorMsg ==null){
	errorMsg = "";
}
String name=(String)request.getParameter("name");
String username=(String)request.getParameter("username");
String password=(String)request.getParameter("password");
String idStr=(String)request.getParameter("id");
Long id = Long.parseLong(idStr);
UserDAO uDao = new UserDAO();
User user = uDao.retrieve(id);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Account</title>
</head>
<body>
<h1>Edit Account</h1>
<form method="post" action="edit-user">
	<div id="name">
	Name: 
	<%if(name!=null){ %>
		<input type="text" name="name" value="<%=name %>"/>
	<%} else{%>
		<input type="text" name="name" value="<%=user.getName() %>"/>
	<%} %>
	</div>
	<div id="username">
	Username: 
	<%if(username!=null){ %>
		<input type="text" name="username" value="<%=username %>"/>
	<%} else{%>
		<input type="text" name="username" value="<%=user.getName() %>"/>
	<%} %>
	</div>
	<div id="password">
	Password: 
	<%if(password!=null){ %>
		<input type="text" name="password" value="<%=password %>"/>
	<%} else{%>
		<input type="text" name="password" value="<%=user.getPassword() %>"/>
	<%} %>
	</div>
	<input type="hidden" name="id" value="<%=id%>"/>
	<button type="submit">Submit</button>
	<br/>
	<font color="red"><%=errorMsg %></font>
</form>

</body>
</html>