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
/* Collections.sort(metadata, new Comparator<LocationMetadata>(){
    public int compare(LocationMetadata m1, LocationMetadata m2) {
        return m1.getColumnName().compareToIgnoreCase(m2.getColumnName());
    }
});  */
%>
<html>
<head>
<title>Administrative Service</title>
<link href="assets/bootstrap/css/bootstrap.css" rel="stylesheet">
</head>
<body>
<div class="alert alert-info alert-dismissable" style="font:20px; text-align:center;">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <strong>Welcome back administrator!</strong>
</div>
<div class="container">
<br/>
<br/>
<h2> Bootstrap Data </h2>
<hr/>
<form action="bootstrap" method="post" enctype="multipart/form-data">
<!-- later implement current date to be submitted instead of static -->
<table>
	<tr>
		<td>
			<b>Filename:</b>
		</td>
		<td>
			<b>Currency:</b>
		</td>
	</tr>
	<tr>
		<td>
			<br/>
			<input type="file" name="data" /> 
		</td>
		<td>
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
		</td>
	</tr>
</table>
 
 
    <br/>
 <input type="submit" value="Bootstrap" class="btn btn-success"/>

 <font color="green"><%=bootstrapMsg %></font>
 <br/>
 <hr/>
 
</form>
Data that has been bootstraped: <br/>
<h3>User Data:</h3>
<table class="table">
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
<table class="table">
	<tr>
		<th>Attribute</th>
		<th>Required?</th>
		<th>Value</th>
		<th>Vulnerability Index</th>
	</tr>
	<%for (int i=0; i<metadata.size(); i++){ %>
		
			<%if(metadata.get(i).getColumnName().equalsIgnoreCase("Foundation Type")
					|| metadata.get(i).getColumnName().equalsIgnoreCase("Building Type")
					|| metadata.get(i).getColumnName().equalsIgnoreCase("Masonry")
					|| metadata.get(i).getColumnName().equalsIgnoreCase("Roof")
					|| metadata.get(i).getColumnName().equalsIgnoreCase("Building Age")){%>
					<tr style="background:#fffcea">
			<%
			}else{
			%>
				<tr>
			<%
			}
			%>
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
<br/>
</div>
<script src="assets/jquery/jquery.min.js"></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>