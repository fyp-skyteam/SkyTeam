<%@ include file="Protect.jsp" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*"%>
<%@ page import ="java.io.Serializable" %>
<%
	//TimeManager tManager = new TimeManager();
	
	Long id = _currentStudent.getId();
	StudentManager sManager = new StudentManager();
	Student currentStudent = sManager.retrieve(id);
	FacilityManager fManager = new FacilityManager();
	TimeManager tManager = new TimeManager();
	Calendar currentTime = tManager.getCurrentTime();
	Calendar currentDate = (Calendar)currentTime.clone();
	//out.println("Now is " + currentTime.getTime());
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	String today = df.format(currentTime.getTime());
	currentTime.add(Calendar.DAY_OF_MONTH,1);
	String tomorrow = df.format(currentTime.getTime());
	ArrayList<String> schools = fManager.getBuildings();
	int highestFloor = fManager.getHighestFloor();
	int highestCapacity = fManager.getHighestCapacity();
	List<Facility> facilities = fManager.retrieveAll();
	String building = request.getParameter("building");
	String level = request.getParameter("level");
	String facilityType = request.getParameter("facilityType");
	String capMin = request.getParameter("capMin");
	String capMax = request.getParameter("capMax");
	String facility = request.getParameter("facility");
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
	String startTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");
	String availability = request.getParameter("availability");
	String errorMsg = request.getParameter("errorMsg");
	if(errorMsg==null || errorMsg.isEmpty()){
		errorMsg = "";
		building = "";
		level = "";
		facilityType = "";
		capMin = "";
		capMax = "";
		facility = "";
		startDate = "";
		endDate = "";
		startTime = "";
		endTime = "";
		availability = "";
	}
%>
<html>

	<head>	
	
		<meta charset="utf-8"/>
		<title>SMU Facility Application</title>
		 <link rel="shortcut icon" href="/favicon.ico" />
		  <link rel="apple-touch-icon" href="/apple-touch-icon.png" />
		 <link rel="stylesheet" type="text/css" href="css/jqClock.css" />
		<link rel="stylesheet" media="all" href="css/style.css"/>
		
		<!-- JS -->
		<script src="js/jquery-1.6.4.min.js"></script>
		<script src="js/css3-mediaqueries.js"></script>
		<script src="js/custom.js"></script>
		<script src="js/tabs.js"></script>
			
		<!-- superfish -->
		<link rel="stylesheet" media="screen" href="css/superfish.css" /> 
		<script  src="js/superfish-1.4.8/js/hoverIntent.js"></script>
		<script  src="js/superfish-1.4.8/js/superfish.js"></script>
		<script  src="js/superfish-1.4.8/js/supersubs.js"></script>
		<!-- ENDS superfish -->
		
		<!-- GOOGLE FONTS -->
		<link href='http://fonts.googleapis.com/css?family=Yanone+Kaffeesatz:400,300' rel='stylesheet' type='text/css'>
		
		<!-- SKIN -->
		<link rel="stylesheet" media="all" href="css/skin.css"/>
		
		<script type="text/javascript">
		function validateForm(){

			var building = document.getElementById("building").value;
 			var floor = document.getElementById("floor").value;
 			var facilityType = document.getElementById("facilityType").value;
 			var minCapacity = document.getElementById("minCapacity").value;
 			var maxCapacity = document.getElementById("maxCapacity").value;
 			var facility = document.getElementById("facility").value;
 			var available = document.getElementById("available").value;
 			
 			
 			if(building == "any" && facilityType == "any" && minCapacity == "" && maxCapacity == "" && facility == "any" && available == "any"){
 				alert("Please specify one of the following fields: location (building or floor or facility), facility type, capacity (min or max) and availability.");
 				return false;
 			}
			
			var minCapacity = document.getElementById("minCapacity").value;   
			var maxCapacity = document.getElementById("maxCapacity").value;
			var minC = parseInt(minCapacity, 10);
 			var maxC = parseInt(maxCapacity, 10);
 			
 			if(minC > maxC){
 				alert("Maximum capacity should be greater than minimum capacity."); 
				return false;
 			}
 			
 			if(minC < 0 || maxC < 0){
 				alert("The capacity should be 0 or greater."); 
				return false;
 			}
 			
 			if(minCapacity != "" && maxCapacity == ""){
 				alert("Please enter maximum capacity."); 
				return false;
 			}
 			
 			if(minCapacity == "" && maxCapacity != ""){
 				alert("Please enter minimum capacity."); 
				return false;
 			}
 
 			return true;
		}
		
		function validateDateAndTime(){
     		var StartD = document.getElementById("startDate").value;   
 			var EndD = document.getElementById("endDate").value;

 			var startDateParts = StartD.match(/(\d+)/g);
 			var endDateParts = EndD.match(/(\d+)/g);
			
 			var startDate = new Date(startDateParts[0],startDateParts[1]-1,startDateParts[2]);
 			var endDate = new Date(endDateParts[0], endDateParts[1]-1, endDateParts[2]);		
			
 			var StartT = document.getElementById("startTime").value;   
 			var EndT = document.getElementById("endTime").value;
			
 			var startTime = parseInt(StartT, 10);
 			var endTime = parseInt(EndT, 10);
			
			//var todayDate=new Date();
			//var currentDate = new Date(todayDate.getFullYear(),todayDate.getMonth(),todayDate.getDate());
			
			//if(startDate.getTime() < currentDate.getTime() || endDate.getTime() < currentDate.getTime()){
				//alert("You cannot make a search for before current date"); 
				  //return false;
			//}
			
 			if(StartD != "" && EndD != "" && startDate > endDate ){
 				  alert("Search start date must be before search end date."); 
 				  return false;
 			}
			
			
			if(startDate.getTime() == endDate.getTime()){
				if(startTime > endTime || startTime == endTime){
					alert("End Time should be greater than Start Time.");
					return false;
				}
			}
			
			//if(((endDate-startDate) / (1000*60*60*24)) >7){
				//alert("Search can be performed up for 7 days only.");
				//return false;
			//}
			
 			return true;
    		
     	}

		function isIntegerMin(){
	 		var minCapacity = document.search_display_facility.minCapacity;
	 		if (isNaN(minCapacity.value) == true){
	 			alert("Minimum capacity must be a number.");
	 			minCapacity.focus();
	 			minCapacity.select();
	 		}
		}
		
		function isIntegerMax(){
	 		var maxCapacity = document.search_display_facility.maxCapacity;
	 		if (isNaN(maxCapacity.value) == true){
	 			alert("Maximum capacity must be a number.");
	 			maxCapacity.focus();
	 			maxCapacity.select();
	 		}
		}
		</script>
		
	</head>
	<body>
		<header class="clearfix">
		<div class="wrapper">
		<script type="text/javascript">
			function resizeImg(img, height, width) {
			    img.height = height;
			    img.width = width;
			}
		</script>
<a href="LogInMenu.jsp" id="logo"><img  src="img/smulogo1.png" height="real_height" width="real_width"
   				 onload="resizeImg(this, 100, 175);"></a>
				
				<nav>
					<ul id="nav" class="sf-menu">
					<li><a href="MainMenu.jsp">ADD BOOKING</a></li>
					<li><a href="/ViewBooking?id=<%=id%>">MY BOOKINGS</a></li>
					<li><a href ="MyNotificationMenu.jsp">MY NOTIFICATIONS</a></li>
					<li class = "current-menu-item"><a href="SearchFacilityMenu.jsp">SEARCH</a>
						</li>
						<li><a href="LogOut.jsp">LOGOUT</a></li>
					</ul>
					<div id="combo-holder"></div>
				</nav>
				
			</div>
		</header>
		
		
		<!-- MAIN -->
<div id="main">	
	<div class="wrapper">
		<!-- slider holder -->
<div id="slider-holder" class="clearfix">
 	
<!-- Headline -->
<div id="headline2">
<ul><h3>Hi <%=currentStudent.getName()%>,</ul></h3><p>
<ul>
<li class="block">
<h2>BALANCE</h2><p>
<h3>KS$<%=currentStudent.getKSBal()%></h3>
<%
Calendar instance = Calendar.getInstance();
instance.add(Calendar.HOUR_OF_DAY,8);
Long i = tManager.getMilliSecondDiff(instance, currentDate);
%>
</li>

  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
  <script type="text/javascript" src="js/jqClock.min.js"></script>
  <script type="text/javascript">
    $(document).ready(function(){
    
      customtimestamp = new Date();
      customtimestamp = customtimestamp.getTime();
      customtimestamp = customtimestamp+<%=i%>;
      $("#clock5").clock({"timestamp":customtimestamp});                          
    });    
  </script>
  _____________________________________
<li class="block"><p>
<h2>TIME</h2><p>
 
  <div style="clear:both;">
    <div id="clock5"></div>
  </div>
</li>				        		
</ul></div>

<h1>Search</h1>
</br>
<!-- ENDS headline2 -->
<font color="red"><%=errorMsg %></font>
<form name="search_display_facility" method="post" onsubmit="return validateForm() && validateDateAndTime();" action="/SearchDisplayFacility">

<style>
table {
	font: 13px;
 	border-collapse: collapse; 
	width: 650px;
	}

th {
	border-bottom: 1px solid #CCC;
	padding: 0 0.5em;
	text-align: left;
	}

tr.yellow td {
	border-top: 1px solid #FB7A31;
	border-bottom: 1px solid #FB7A31;
	background: #FFC;
	}

td {
	border-bottom: 1px solid #CCC;
	padding: 0 0.5em;
	}

td.width {
	width: 190px;
	}

td.adjacent {
	border-left: 1px solid #CCC;
	text-align: center;
	}
</style>


<table>
<tr>
<td>
Building:
</td>
<td>
<select name="building" id="building">
<%if(building.isEmpty() || building.equals("any")){ %>
	<option value="any" selected>Any</option>
	<%for(String str: schools){%>
		<option value = "<%=str%>"><%=str%></option>
	<%}
} else{%>
	<option value="any">Any</option>
	<%for(String str: schools){
		if(building.equals(str)){%>
			<option value = "<%=str%>" selected><%=str%></option>
		<%} else{%>
			<option value = "<%=str%>"><%=str%></option>
		<%} 
	}
}%>
</select>
</td>
</tr>
<tr>
<td>
Floor:
</td>
<td>
<select name="floor" id="floor">
<%if(level.isEmpty() || level.equals("any")){ %>
	<option value="any" selected>Any</option>
	<%for(int num1 = 1;num1<=highestFloor;num1++){%>
		<option value = "<%=num1%>"><%=num1%></option>
	<%}
}else{
	int previousLevel = Integer.parseInt(level);%>
	<option value="any">Any</option>
	<%for(int num2 = 1;num2<=highestFloor;num2++){
		if(previousLevel == num2){%>
			<option value = "<%=num2%>" selected><%=num2%></option>
		<%}else{ %>
			<option value = "<%=num2%>"><%=num2%></option>
		<%}
	}
}%>		
</select>
</td>
</tr>
<tr>
<td>
Facility Type:
</td>
<td>
<%String[] types= {"Group Study Room","Class Room","Seminar Room","Project Room"}; 
if(facilityType.isEmpty() || facilityType.equals("any")){%>
	<input name = "facilityType" type="radio" id="facilityType" value="any" checked/>Any
	<%for (int num3=0;num3<types.length;num3++){ %>
		<input name = "facilityType" type="radio" id="facilityType" value="<%=types[num3]%>"/><%=types[num3]%>
	<%} 
} else{%>
	<input name = "facilityType" type="radio" id="facilityType" value="any"/>Any
	<%for (int num4=0;num4<types.length;num4++){ %>
		<%if(facilityType.equals(types[num4])){ %>
			<input name = "facilityType" type="radio" id="facilityType" value="<%=types[num4]%>" checked/><%=types[num4]%>
		<%}else{ %>
			<input name = "facilityType" type="radio" id="facilityType" value="<%=types[num4]%>"/><%=types[num4]%>
		<%}
	} 
}%>
</td>
</tr>
<tr>
<td>
Capacity:
</td>
<td> 
Min
<select name="minCapacity" id="minCapacity" >
<%if(capMin.isEmpty() || capMin.equals("any")){ %>
	<option value="any" selected>Any</option>
	<%for(int temp1 = 1;temp1<=highestCapacity;temp1++){%>
		<option value = "<%=temp1%>"><%=temp1%></option>
	<%}
}else{
	int previousCapMin = Integer.parseInt(capMin);%>
	<option value="any">Any</option>
	<%for(int temp2 = 1;temp2<=highestCapacity;temp2++){
		if(previousCapMin == temp2){%>
			<option value = "<%=temp2%>" selected><%=temp2%></option>
		<%}else{ %>
			<option value = "<%=temp2%>"><%=temp2%></option>
		<%}
	}
}%>		
</select>
Max
<select name="maxCapacity" id="maxCapacity" >
<%if(capMax.isEmpty() || capMax.equals("any")){ %>
	<option value="any" selected>Any</option>
	<%for(int temp3 = 1;temp3<=highestCapacity;temp3++){%>
		<option value = "<%=temp3%>"><%=temp3%></option>
	<%}
}else{
	int previousCapMax = Integer.parseInt(capMax);%>
	<option value="any">Any</option>
	<%for(int temp4 = 1;temp4<=highestCapacity;temp4++){
		if(previousCapMax == temp4){%>
			<option value = "<%=temp4%>" selected><%=temp4%></option>
		<%}else{ %>
			<option value = "<%=temp4%>"><%=temp4%></option>
		<%}
	}
}%>		
</select>
<br/>(to search for exact match, put min equal to max)
</td>
</tr>
<tr>
<td>
Facility:
</td>
<td>
<select name="facility" id="facility">
<%if(facility.isEmpty() || facility.equals("any")){ %>
	<option value="any" selected>Any</option>
	<%for(Facility f: facilities){ %>
		<option value = "<%=f.getName()%>"><%=f.getName()%></option>
	<%} %>
<%}else{ %>
	<option value="any">Any</option>
	<%for(Facility f: facilities){
		if(facility.equals(f)){%>
			<option value = "<%=f.getName()%>" selected><%=f.getName()%></option>
		<%} else{%>
			<option value = "<%=f.getName()%>"><%=f.getName()%></option>
		<%} 
	}
} %>
</select>
</td>
</tr>
<tr>
<td>
Start Date
</td>
<td>
<%if(startDate.isEmpty()){ %>
	<input type="date" name="startDate" id="startDate" value="<%=today%>" onfocus="this.blur()"/>
<%} else{%>
	<input type="date" name="startDate" id="startDate" value="<%=startDate%>" onfocus="this.blur()"/>
<%} %>

Start Time&nbsp&nbsp
<select name="startTime" id="startTime">
								<option value="0000">0000</option>
								<option value="0030">0030</option>
								<option value="0100">0100</option>
								<option value="0130">0130</option>
								<option value="0200">0200</option>
								<option value="0230">0230</option>
								<option value="0300">0300</option>
								<option value="0330">0330</option>
								<option value="0400">0400</option>
								<option value="0430">0430</option>
								<option value="0500">0500</option>
								<option value="0530">0530</option>
								<option value="0600">0600</option>
								<option value="0630">0630</option>
								<option value="0700">0700</option>
								<option value="0730">0730</option>
								<option value="0800">0800</option>
								<option value="0830">0830</option>
								<option value="0900">0900</option>
								<option value="0930">0930</option>
								<option value="1000">1000</option>
								<option value="1030">1030</option>
								<option value="1100">1100</option>
								<option value="1130">1130</option>
								<option value="1200">1200</option>
								<option value="1230">1230</option>
								<option value="1300">1300</option>
								<option value="1330">1330</option>
								<option value="1400">1400</option>
								<option value="1430">1430</option>
								<option value="1500">1500</option>
								<option value="1530">1530</option>
								<option value="1600">1600</option>
								<option value="1630">1630</option>
								<option value="1700">1700</option>
								<option value="1730">1730</option>
								<option value="1800">1800</option>
								<option value="1830">1830</option>
								<option value="1900">1900</option>
								<option value="1930">1930</option>
								<option value="2000">2000</option>
								<option value="2030">2030</option>
								<option value="2100">2100</option>
								<option value="2130">2130</option>
								<option value="2200">2200</option>
								<option value="2230">2230</option>
								<option value="2300">2300</option>
								<option value="2330">2330</option>
</select>
</td>
</tr>
<tr>
<td>
End Date
</td>
<td>
<%if(endDate.isEmpty()){ %>
	<input type="date" name="endDate" id="endDate" value="<%=today%>" onfocus="this.blur()"/>
<%} else{%>
	<input type="date" name="endDate" id="endDate" value="<%=endDate%>" onfocus="this.blur()"/>
<%} %>

End Time&nbsp&nbsp&nbsp&nbsp
<select name="endTime" id="endTime">						
								<option value="0000">0000</option>
								<option value="0030">0030</option>
								<option value="0100">0100</option>
								<option value="0130">0130</option>
								<option value="0200">0200</option>
								<option value="0230">0230</option>
								<option value="0300">0300</option>
								<option value="0330">0330</option>
								<option value="0400">0400</option>
								<option value="0430">0430</option>
								<option value="0500">0500</option>
								<option value="0530">0530</option>
								<option value="0600">0600</option>
								<option value="0630">0630</option>
								<option value="0700">0700</option>
								<option value="0730">0730</option>
								<option value="0800">0800</option>
								<option value="0830">0830</option>
								<option value="0900">0900</option>
								<option value="0930">0930</option>
								<option value="1000">1000</option>
								<option value="1030">1030</option>
								<option value="1100">1100</option>
								<option value="1130">1130</option>
								<option value="1200">1200</option>
								<option value="1230">1230</option>
								<option value="1300">1300</option>
								<option value="1330">1330</option>
								<option value="1400">1400</option>
								<option value="1430">1430</option>
								<option value="1500">1500</option>
								<option value="1530">1530</option>
								<option value="1600">1600</option>
								<option value="1630">1630</option>
								<option value="1700">1700</option>
								<option value="1730">1730</option>
								<option value="1800">1800</option>
								<option value="1830">1830</option>
								<option value="1900">1900</option>
								<option value="1930">1930</option>
								<option value="2000">2000</option>
								<option value="2030">2030</option>
								<option value="2100">2100</option>
								<option value="2130">2130</option>
								<option value="2200">2200</option>
								<option value="2230">2230</option>
								<option value="2300">2300</option>
								<option value="2330">2330</option>
</select>
</td>
</tr>
<tr>
<td>
Availability:
</td>
<td>
<%if(availability.isEmpty() || availability.equals("any")){ %>
	<input name = "available" id="available" type="radio" value="any" checked/>Any
	<input name = "available" id="available" type="radio" value="available"/>Available
<%}else{ %>
	<input name = "available" id="available" type="radio" value="any"/>Any
	<input name = "available" id="available" type="radio" value="available" checked/>Available
<%} %>
</td>
<td>

</td>
</tr>
</table>
<input type="hidden" name="formName" value="SearchFacilityMenu.jsp"/>
<br>
<input type="submit" value="Search"/>
</form>      	
      	
</div>
<!-- ENDS slider holder -->


	
					
				</div>	        	
	        	<!--  page content-->
	        	
	        	

	        	
			</div>
		<!-- ENDS MAIN -->
		
		<footer>
			<div class="wrapper"></div>
		</footer>		
	</body>
</html>
