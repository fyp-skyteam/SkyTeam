<%@page import="entity.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import ="java.io.Serializable" %>
<%
String errorMsg=(String)request.getParameter("errorMsg");
if(errorMsg==null){
	errorMsg = "";
}
/* String successMsg = (String)session.getAttribute("successMsg");
if(successMsg==null){
	successMsg ="";
} */
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
<title>Administration Tools</title>
<link href="assets/bootstrap/css/bootstrap.css" rel="stylesheet">
</head>
<body>
<div class="navbar navbar-default navbar-fixed-top" style="position:relative; margin-bottom:0px;">
    <div class="container">
   
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#" onClick="location.reload();location.href='bootstrap-menu.jsp'">Administration Tools</a>
      </div>
      <div class="navbar-collapse collapse">
        <ul class="nav navbar-nav navbar-right">  
        <li class="dropdown">
             <a href="welcome.jsp">Back to<b> GeoIntel</b></a>
         </li>
         </ul>
         </div> 
      </div><!--/.nav-collapse -->
    </div>
<div class="container">
<br>
<h4><u>Bootstrap Data</u></h4>
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
 <font color="red"><%=errorMsg %></font>
<%--  <font color="red"><%=successMsg %></font> --%>
 <br/>
 <hr/>
 <br />
</form>
<h4><b>Data that has been bootstrapped:</b></h4>
<br />
<h4><u>User Data:</u></h4>
<table class="table">
	<tr>
		<th>Name</th>
		<th>Username</th>
		<th>Password</th>
		<th>Widget Access</th>
		<th>Action</th>
	</tr>
	<%for (int i=0; i<users.size(); i++){ %>
		<tr>
			<td><%=users.get(i).getName()%></td>
			<td><%=users.get(i).getUsername()%></td>
			<td><%=users.get(i).getPassword()%></td>
			<td>
			<% ArrayList<String> widgets = users.get(i).getWidgets();
			if(widgets!=null){
				for(String widget: widgets){
					%>
					  <%=widget %><br/>
					<%
				}
				 
			}%>
			</td>
			<%if(!users.get(i).getUsername().equals("admin")){%>
				<td>
					<a href="remove-user?id=<%=users.get(i).getId()%>" onclick="if (! confirm('Warning! This account (<%=users.get(i).getUsername() %>) will be removed together with any associated data (uploaded data, account info). Do you want to proceed this action? ')) return false;">Remove</a>
					&nbsp; &nbsp; 
					<a href="edit-user.jsp?id=<%=users.get(i).getId()%>">Edit</a>
				</td>
			<%}else{%>
				<td></td>
			<%} %>			
		</tr>	
	<%} %>
</table>
<hr />
<br />
<h4><u>Location Metadata:</u></h4>
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
					<tr style="background:#F78181">
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
<br/>
<br/>
<br/>
</div>
<script src="assets/jquery/jquery.min.js"></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>