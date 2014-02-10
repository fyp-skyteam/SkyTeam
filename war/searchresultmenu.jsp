<%@page import="entity.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@include file="protect.jsp"%>

<%@page import="dao.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import ="java.io.Serializable" %>

<!-- JAVA INITIALIZATION -->
<%
User user = (User) session.getAttribute("authenticated.user");
String username = user.getUsername();
out.println("Welcome back " + username);

List<Location> searchResults = (List<Location>)session.getAttribute("locationSearchResult");
if(searchResults==null || searchResults.isEmpty()){
	out.println("There is no matching locations");
}else{
	out.println(searchResults.size());
	for(int i=0;i<searchResults.size();i++){
		out.println(searchResults.get(i).toString()+"</br>");
	}	
}
out.println("</br></br></br>");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Insert title here</title>
</head>
<body>

</body>
</html>