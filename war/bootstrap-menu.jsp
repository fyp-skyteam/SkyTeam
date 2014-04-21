<%@page import="entity.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import ="java.io.Serializable" %>
<%
String bootstrapMsg=(String)request.getParameter("bootstrapMsg");
if(bootstrapMsg==null){
	bootstrapMsg = "";
}
UserDAO uDAO = new UserDAO();
LocationMetadataDAO lDAO = new LocationMetadataDAO();
ArrayList<User> users = (ArrayList<User>)uDAO.retrieveAll();
ArrayList<LocationMetadata> metadata = (ArrayList<LocationMetadata>)lDAO.retrieveAll();
Collections.sort(metadata, new Comparator<LocationMetadata>(){
    public int compare(LocationMetadata m1, LocationMetadata m2) {
        return m1.getColumnName().compareToIgnoreCase(m2.getColumnName());
    }
}); 
%>
<html>
<head>
<title>Administrative Service</title>
</head>
<body>
Welcome Back Administrator!
<h2> Bootstrap Data </h2>
<form action="bootstrap" method="post" enctype="multipart/form-data">
<!-- later implement current date to be submitted instead of static -->

 <b>Filename:</b>
 <input type="file" name="data" />
 <br/>
 
 <select name="currency">
	<option value="SGD" selected>SGD</option>
	<option value="AUD">AUD</option>
	<option value="CAD">CAD</option>
	<option value="CHF">CHF</option>
	<option value="CNY">CNY</option>
	<option value="EUR">EUR</option>
	<option value="GBP">GBP</option>
	<option value="HKD">HKD</option>
	<option value="INR">INR</option>
	<option value="JPY">JPY</option>
	<option value="USD">USD</option>
</select>
 
 <input type="submit" value="Bootstrap" />
 <br/>
 <font color="red"><%=bootstrapMsg %></font>
</form>
Data that has been bootstraped: <br/>
<h3>User Data:</h3>
<table border="1">
	<tr>
		<th>Name</th>
		<th>Username</th>
		<th>Password</th>
	</tr>
	<%for (int i=0; i<users.size(); i++){ %>
		<tr>
			<td><%=users.get(i).getName()%></td>
			<td><%=users.get(i).getUsername()%></td>
			<td><%=users.get(i).getPassword()%></td>
		</tr>	
	<%} %>
</table>
<h3>Location Metadata (including the vulnerability index):</h3>
<table border="1">
	<tr>
		<th>Attribute</th>
		<th>Required?</th>
		<th>Value</th>
		<th>Vulnerability Index</th>
	</tr>
	<%for (int i=0; i<metadata.size(); i++){ %>
		<tr>
			<td><%=metadata.get(i).getColumnName()%></td>
			<td><%=metadata.get(i).getRequired()%></td>
			<%if(metadata.get(i).getValue()==null) {%>
				<td>N.A.</td>
				<td>N.A.</td>
			<%} else{%>
				<td><%=metadata.get(i).getValue()%></td>
				<td><%=metadata.get(i).getVIndex()%></td>
			<%} %>
			
		</tr>	
	<%} %>
</table>
<hr/>
Go Back to <a href="login.jsp">Log In Page</a>