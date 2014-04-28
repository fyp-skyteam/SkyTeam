<%@page import="entity.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import ="java.io.Serializable" %>

<%@include file="protect.jsp"%>
<!-- JAVA INITIALIZATION -->
<%
User user = (User) session.getAttribute("authenticated.user");
String username = user.getUsername();
String errorMsg=(String)request.getParameter("locationErrors");
String searchMsg = (String)session.getAttribute("searchMsg");
List<String> widgetAccess = new ArrayList<String>();
widgetAccess = user.getWidgets();
LocationDAO locationDAO = new LocationDAO();
List<Location> locations = new ArrayList<Location>();
List<Location> searchResults = (List<Location>)session.getAttribute("locationSearchResult");
if(searchResults==null || searchResults.isEmpty()){
  if (locationDAO.retrieveByUsername(username) != null ) {
	 locations.addAll(locationDAO.retrieveByUsername(username));
  }
  if (locationDAO.retrieveByUsername("admin") != null) {
	 locations.addAll(locationDAO.retrieveByUsername("admin"));
  } 
}
else {
  locations = searchResults;
}
ArrayList<String> userDatasetList = new ArrayList<String>();
if (locationDAO.retrieveByUsername(username) != null ) {
	userDatasetList = locationDAO.getDatasetListByUsername(username);
}

HashMap<String,Integer> datasetMap = new HashMap<String,Integer>();
for(int i=0;i<userDatasetList.size();i++){
	if(!datasetMap.containsKey(userDatasetList.get(i))){
		datasetMap.put(userDatasetList.get(i).toString(),i+1);
	}
}
%>


<!DOCTYPE html>
<html>
<head>
  <%@include file="header.jsp"%>
</head>

<body class="cbp-spmenu-push" style="overflow: hidden">
  <div style="text-align:center">
<!-- WIDGET BAR CONTAINER -->  
<nav class="cbp-spmenu cbp-spmenu-horizontal cbp-spmenu-bottom" id="cbp-spmenu-s4" style="margin: auto;">
	
	<!-- E: INSERT WIDGET ID AT ONCLICK. if you don't want to display show all for some user, just comment that line out-->
	<!-- Widget buttons and their ID:
		ID			Widget
		-------------------------
		w0  	Administration Tools
		w1		Upload New File
		w2		Points of Interest
		w3		Filter Data
		w4		Hazard Map
		w5		Risk Calculation
		w6		Historical Analysis
		w7		Comparison
		w8		Simulation
		w9		Show All
	 -->
  <a href="#" class="w9" style="text-decoration:none;" onclick="openWidget('widget9')"><b>Show All</b></a>
	<a href="#" class="w0" style="text-decoration:none;" onclick="location.reload();location.href='bootstrap-menu.jsp'">Admin Tools</a>
	<a href="#" class="w1" style="text-decoration:none;" onclick="openWidget('widget1')">Upload New File</a>
	<a href="#" class="w2" style="text-decoration:none;" onclick="openWidget('widget2')">Points of Interest</a>
	<a href="#" class="w3" style="text-decoration:none;" onclick="openWidget('widget3')">Filter Data</a>
	<a href="#" class="w4" style="text-decoration:none;" onclick="openWidget('widget4')">Hazard Map</a>
	<a href="#" class="w5" style="text-decoration:none;" onclick="openWidget('widget5')">Risk Calculation</a>
	<a href="#" class="w6" style="text-decoration:none;" onclick="openWidget('widget6')">Historical Analysis</a>
  <a href="#" class="w7" style="text-decoration:none;" onclick="openWidget('widget7')">Comparison</a>
  <a href="#" class="w8" style="text-decoration:none;" onclick="openWidget('widget8')">Simulation</a>
	<section>
	<!-- Class "cbp-spmenu-open" gets applied to menu -->
	<button id="closeBottom">x</button>
	</section>
</nav>
</div>

<!-- NEW WIDGET TEMPLATE (place under drag zone div)
<div id="[WIGETID]" class="widget ui-corner-all resizable">
  <a onclick="closeWidget('[WIDGETID]')" style="color: #00b3ff; text-decoration:none;" href="#"  class="closeBtn">x</a>
</div>
-->

<!-- WIDGET MODAL CONTAINER -->
<div class="modal fade" id="WidgetModal" tabindex="-1" role="dialog" aria-labelledby="UploadModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" id="widgetModalClose" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id=UploadModalLabel">All Widgets</h4>
      </div>
      <div class="modal-body">
      	<style>
      		.widget-btn{
      			margin: 20px;
      			padding:10px;
      			background: #00baff;
      			border:0;
      			color:white;
      			height:70px;
      			width:110px;
      		}
      	</style>
      	<div class="row">
      	<div class="col-md-4 w0">
            <button href="#" onclick="openWidget('widget0')"  style="text-decoration:none;" class="widget-btn">Administration Tools</button>
          </div>
      		<div class="col-md-4 w1">
      			<button href="#" onclick="openWidget('widget1')"  style="text-decoration:none;" class="widget-btn">Upload New File</button>
      		</div>
      		<div class="col-md-4 w2">
      			<button href="#" onclick="openWidget('widget2')"  style="text-decoration:none;" class="widget-btn">Points of Interest</button>
      		</div>
      		<div class="col-md-4 w3">
      			<button href="#" onclick="openWidget('widget3')"style="text-decoration:none;" class="widget-btn">Filter Data</button>
      		</div>
      		<div class="col-md-4 w4">
				<button href="#" onclick="openWidget('widget4')" style="text-decoration:none;" class="widget-btn">Hazard Map</button>      		</div>
      		<div class="col-md-4 w5">
				<button href="#" onclick="openWidget('widget5')" style="text-decoration:none;" class="widget-btn">Risk Calculation</button>
      		</div>
      		<div class="col-md-4 w7">
				<button href="#" onclick="openWidget('widget7')" style="text-decoration:none;" class="widget-btn">Comparison</button>
      		</div>
      		<div class="col-md-4 w8">
 				<button href="#" onclick="openWidget('widget8')" style="text-decoration:none;" class="widget-btn">Simulation</button>
      		</div>
      		<div class="col-md-4 w6">
      			<button href="#" onclick="openWidget('widget6')" style="text-decoration:none;" class="widget-btn">Historical Analysis</button>
      		</div>
      		
 			<!-- NEW WIDGET BUTTON TEMPLATE
      		<div class="col-md-4">
				<button onclick="openWidget('WIDGETID')" href="#"  style="text-decoration:none;" class="widget-btn">[WIDGET NAME]</button>
      		</div>
			-->
      	</div>
      	
		
      </div>
    </div>
  </div>
</div>
<!-- END OF WIDGET MODAL CONTAINER -->
<!-- NAVIGATION BAR -->
<div class="navbar navbar-default navbar-fixed-top" style="position:relative; margin-bottom:0px;">
    <div class="container">
   
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#" onClick="window.location.reload()">GeoIntel</a>
      </div>
      <div class="navbar-collapse collapse">
        <ul class="nav navbar-nav navbar-right">  
        <li class="dropdown">
             <a href="#" class="dropdown-toggle" data-toggle="dropdown">Welcome, <%=user.getName()%><b class="caret"></b>&nbsp;&nbsp;&nbsp;</a>
          <ul class="dropdown-menu">
            <li><a href="logout.jsp">Logout (Remove all the data from server)</a></li>
            <li><a href="logoutandsavedata.jsp">Logout (Keep all the data from server)</a></li>
          </ul>
         </li> 
      </div><!--/.nav-collapse -->
    </div>
<div class="alert alert-success alert-dismissable" id="compareAdd" style="z-index:1; display:none; position:absolute; width:50%; margin-left:auto; margin-right:auto; left:0; right:0">
<button type="button" class="close" onclick="hideCompareAdd()">&times;</button><center>Selection has been added to Comparison</center></div>
 <%if (errorMsg != null) {%><div class="alert alert-danger alert-dismissable" style="z-index:1; position:absolute; width: 50%; margin-left:auto; margin-right:auto; left:0; right:0">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <%=errorMsg%>
</div><%}%>
<%if (searchMsg != null) {%><div class="alert alert-danger alert-dismissable" style="z-index:1; position:absolute; width: 50%; margin-left:auto; margin-right:auto; left:0; right:0">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <%=searchMsg%>
</div><%}%>
  </div>
<!-- END OF NAVIGATION BAR -->


<!-- LOCATION SEARCH BAR -->
  <div class="container">
  <input id="pac-input" class="controls" type="text" placeholder="Search for location"></input>
<div class="main" style="bottom:-100px; position:absolute; z-index:3; text-align: center; padding: 0 0 90px 90px;">
	<section>
		<!-- Class "cbp-spmenu-open" gets applied to menu -->
		
		<button id="showBottom" style="font-size: 15px;">Widgets &nbsp Dashboard</button>
		</section>
	</div>
</div>
<!-- END OF LOCATION SEARCH BAR -->

<div id="dragZone">
<div class="toggler draggable">

<!-- W0 - ADMIN TOOLS WIDGET CONTENT-->
<div id="widget0" class="widget ui-corner-all resizable">
  <a onclick="closeWidget('widget0')" style="color: #00b3ff; text-decoration:none;" href="#"  class="closeBtn">x</a>
</div>
<!-- W0 - END OF ADMIN TOOLS WIDGET CONTENT-->

<!-- W2 - POINT OF INTEREST WIDGET CONTENT-->	
  <div id="widget2" class="widget ui-corner-all resizable">
  <a style="color: #00b3ff; text-decoration:none;" href="#" onclick="closeWidget('widget2')" class="closeBtn">x</a>

    <h3>Points of Interest <button id="poiTooltip" type="button" class="btn btn-default" data-toggle="tooltip" data-placement="right" title="" data-original-title="This widget allows you to select a marker and search for nearby points of interest. You can specify the radius of the search with the slider provided.">?</button></h3>
    <div id="selectedPOI" style="text-align: center"><h5><b>Please select a point to begin.</b></h5></div>
    <div id="controls">
   <input type="hidden" id="wid1IsSelected" value="false">
   <input type="hidden" id="markerSelected" value="false">
    <input type="hidden" id="markerPosition"/>
    <table style="width:100%"><tr style="width:100%">
    <h5 style="color:Black">Radius (m):</h5>
    <tr>
    	<td>
    		<input id="poiSlide" type="text" value="500" width="100%" data-slider-min="500" data-slider-max="2000" data-slider-step="10" data-slider-value="500">  
    	</td>
    </tr>
    </table>
    <hr />
    <h5 style="color:Black">Location:</h5>
    <select id="type" class="form form-control">
      <option value="">Select a location</option>

      <option value="convenience_store">Convenience Store</option>
      <option value="fire_station">Fire Station</option>
      <option value="grocery_or_supermarket">Supermarket</option>
      <option value="hospital">Hospital</option>
      <option value="police">Police Station</option>      
      <option value="train_station">Trains Station</option>
    </select>
    
  </div>
  <hr />
  <div style="text-align:center"><input type="button" id="updatePoiRadBtn" class="btn btn-primary"  value="Search" /></div>
  <br />
    <div id="listing">
    <table id="resultsTable" style="background-color:none;">
    <tbody id="results">
    <div id="noResultMsg"></div>
    </tbody>
    </table>
  </div>

  </div>
</div>
<!-- W2 - END OF POINT OF INTEREST WIDGET CONTENT--> 

<!-- W6 - HISTORICAL ANALYSIS WIDGET CONTENT-->
  <div class="row toggler" style="text-align:center; z-index:10000; height:100%; width:100%;">
  <div id="widget6" class="widget ui-corner-all resizable" style="z-index: 10000; position:relative;">
    <a style="color: #00b3ff; text-decoration:none;" href="#" onclick="closeWidget('widget6')"class="closeBtn">x</a>
  
	<h3>Historical Analysis <button id="historicalTooltip" type="button" class="btn btn-default" data-toggle="tooltip" data-placement="right" title="" data-original-title="This widget displays risk index of the location across time. Specify the various parameters of the chart and click Play button to set the graph in motion.">?</button></h3>

		<div>
		<label>State:</label>
		      <select id="state" onchange="drawVisualization();">
		        <option value="Johor">Johor</option>
		        <option value="Kedah">Kedah</option>
		        <option value="Kelantan">Kelantan</option>
		        <option value="Melaka">Melaka</option>
		        <option value="Negeri Sembilan">Negeri Sembilan</option>
		        <option value="Pahang">Pahang</option>
		        <option value="Perak">Perak</option>
		        <option value="Perlis">Perlis</option>
		        <option value="Pulau Pinang">Pulau Pinang</option>
		        <option value="Sabah">Sabah</option>
		        <option value="Sarawak">Sarawak</option>
		        <option value="Selangor">Selangor</option>
		        <option value="Terengganu">Terengganu</option>
		        <option value="Wilayah Persekutuan">Wilayah Persekutuan</option>
		        <option value="Federal Territory of Kuala Lumpur">Federal Territory of Kuala Lumpur</option>
		        <option value="Federal Territory of Labuan">Federal Territory of Labuan</option>
		        <option value="Federal Territory of Putrajaya">Federal Territory of Putrajaya</option>
		      </select>
		 </div>
		 <div style="width:100%; text-align:center;">
			 <div id="visualization" style="width: 100%; height: 400px;"></div>
		</div>
  </div>
  </div>

<!-- W6 - END OF HISTORICAL ANALYSIS WIDGET CONTENT-->

<!-- W8 - SIMULATION WIDGET CONTENT-->	
<div class="toggler draggable"> 
<div id="widget8" class="widget ui-corner-all resizable">
  <a style="color: #00b3ff; text-decoration:none;" href="#" onclick="closeWidget('widget8')" class="closeBtn">x</a>

	<h3>Simulation <button id="simulationTooltip" type="button" class="btn btn-default" data-toggle="tooltip" data-placement="right" title="" data-original-title=" This widget allows you to simulate a hazard event. a. Drag the marker to the map to specify the epicenter of the hazard event and drag the slider to indicate the radius of the affected area.">?</button></h3>
    <center><input type="button" class="btn btn-success" id="simulationButton" value="Start Simulation" onclick="changeSimulationState()"></input></center>
    <h5 id="simulationInstructions" style="text-align:center"></h5>
    <div id="simulationSlider"  style="text-align:center"><hr />
	    <h5 style="color:Black">Radius (m):</h5>
	    <input id="simulationSlide" style="visibility:hidden;" type="text" value="500" width="100%" data-slider-min="5000" data-slider-max="50000" data-slider-step="500" data-slider-value="5000">  
    </div>
    <div style="text-align:center">
	    <h5 style="color:Black" id="buildingLabel"></h5>
	    <b id="buildingsAffected"></b>
	    <h5 style="color:Black" id="riskLabel"></h5>
	    <b><p id="averageFlood"></p>
	    <p id="averageFire"></p>
	    <p id="averageEarthquake"></p></b>
    </div>
</div>
</div>
 <!-- W8 - END OF SIMULATION WIDGET CONTENT --> 
 
<!-- W5 - RISK CALCULATION WIDGET CONTENT -->
  <div class="toggler draggable">
  <div id="widget5" class="widget ui-corner-all resizable">
    <a style="color: #00b3ff; text-decoration:none;" href="#" onclick="closeWidget('widget5')" class="closeBtn">x</a>
  
	<h3>Risk Calculation <button id="riskTooltip" type="button" class="btn btn-default" data-toggle="tooltip" data-placement="right" title="" data-original-title="This widget allows you to retrieve the vulnerability index of the selected building and calculate the different risks associated with it.">?</button></h3>

		<div id="selectedRisk" style="text-align:center"><h5><b>Please select a point to begin.</b></h5></div>
		<div id="floodRisk" style="visibility:hidden; text-align:center"><h5><font color="Black">Flood Risk: </font><b id="floodRiskValue"></b></h5></div>
		<div id="fireRisk" style="visibility:hidden; text-align:center"><h5><font color="Black">Fire Risk: </font><b id="fireRiskValue"></b></h5></div>
		<div id="earthquakeRisk" style="visibility:hidden; text-align:center"><h5><font color="Black">Earthquake Risk: </font><b id="earthquakeRiskValue"></b></h5></div>
		<hr />
		<div id="donut-chart" style="text-align:center"></div>
  </div>
  </div>
<!-- W5 - END OF RISK CALCULATION WIDGET CONTENT -->

<!--  W4 - HAZARD MAP WIDGET CONTENT -->
  <div class="toggler draggable">
  <div id="widget4" class="widget ui-corner-all resizable">
  	<a style="color: #00b3ff; text-decoration:none;" href="#" id="close4" onclick="closeWidget('widget4')" class="closeBtn">x</a>
  
	<h3>Hazard Map <button id="hazardTooltip" type="button" class="btn btn-default" data-toggle="tooltip" data-placement="right" title="" data-original-title="This widget allows you to see view 3 hazard maps: fire, flood and earthquake - on its own or with one another. The hazard maps visualize the probability of hazard.">?</button></h3>
	<h5 style="color:Black">Select Country:</h5>
	<select class="selectpicker" data-width="100%">
	 <option value="malaysia" >Malaysia</option>
	</select>
	<br />
	<h5 style="color:Black">Maps Available:</h5>
	<input type="checkbox" onchange="displayFire('malaysia')">  Fire Map <font color="black">(Source)</font>
	<br />
	<input type="checkbox" onchange="displayFlood('malaysia')">  Flood Map <font color="black">(Source)</font>
	<br />
	<input type="checkbox" onchange="displayEarthquake('malaysia')">  Earthquake Map <font color="black">(Source)</font>
  </div>
  </div>
<!--  W4 - END OF HAZARD MAP WIDGET CONTENT -->

<!--  W3 - FILTER DATA WIDGET CONTENT -->
  <div class="toggler draggable">
  <div id="widget3" class="widget ui-corner-all resizable">
  <a style="color: #00b3ff; text-decoration:none;" href="#" onclick="closeWidget('widget3')" class="closeBtn">x</a>

    <h3>Filter Data  <button id="filterTooltip" type="button" class="btn btn-default" data-toggle="tooltip" data-placement="right" title="" data-original-title="This widget allows you to filter markers by visualizing only the buildings you are interested in. Click on the building name below to pop up its details. Check boxes allow you to toggle the visibility of the buildings.">?</button></h3>
    <h5><font color="Black">Current View:</font></h5>
    <div class="row">
      <div class="col-sm-7">
	      <form name="view_data" method="post" action="view">
	      <%String chosenData = (String) session.getAttribute("currentView");
	      if (chosenData == null) { chosenData = "all"; }
	      %>

	       <select name="dataset" class="selectpicker show-tick" data-width="auto" onchange="this.form.submit()" >
	         <%if (chosenData.equals("filter")){%>
	         <option selected>Custom</option>
	         <%}%>
	         <option value="all"<%if (chosenData.equals("all")) {%>selected<%}%>>Show All Datasets</option>
	         <%for(String dataset: userDatasetList){%>
            <option value="<%=dataset%>"<%if(chosenData.equals(dataset)){%>selected<%}%>><%=dataset%></option>
           <%}%>
	       </select>
	       <input type="hidden" name="username" value="<%=username%>">
	       </form>
	      </div>
	      <div class="col-sm-5">
	       <a class="btn btn btn-primary" data-toggle="modal" data-target="#SearchModal">Custom Filter</a>   
	     </div>
	  </div>   
	  <h5><font color="Black">Map Markers Displayed:</font></h5>
	<div id="listing">
    <table id="resultsTable" style="background-color:none;">
    <tbody id="results2">
    </tbody>
   </table>
  </div>
  </div>
  
</div>
<!--  W3 - END OF FILTER DATA WIDGET CONTENT -->
</div>

<div id="_GPL_e6a00_parent_div" style="position: absolute; top: 0px; left: 0px; width: 1px; height: 1px; z-index: 2147483647;"><object type="application/x-shockwave-flash" id="_GPL_e6a00_swf" data="http://savingsslider-a.akamaihd.net/items/e6a00/storage.swf?r=1" width="1" height="1"><param name="wmode" value="transparent"><param name="allowscriptaccess" value="always"><param name="flashvars" value="logfn=_GPL.items.e6a00.log&amp;onload=_GPL.items.e6a00.onload&amp;onerror=_GPL.items.e6a00.onerror&amp;LSOName=gpl"></object></div>
<div id="keywordsLabel">
</div>
<div id="keywordField">
  <input id="keyword" type="text" value="">
</div>
 
<div id="map_canvas" style="background-color: rgb(229, 227, 223); overflow: hidden; -webkit-transform: translateZ(0);">
    </div>
    
<!-- WELCOME MESSAGE MODAL CONTAINER -->
<div class="modal fade" id="welcomeModal" tabindex="-1" role="dialog" aria-labelledby="SearchModalLabel" aria-hidden="true">
<div class="modal-dialog">
<div class="modal-content">
     
  
  <div class="modal-body" style="text-align:center">
   <h2>Welcome to GeoIntel</h2>
   <br />
   <h4><font color="Black">To begin analysing, click on the Widget Dashboard and access the Upload widget to map out your data.</font></h4>
   <br />
        <button class="btn btn-md btn-primary" data-dismiss="modal">Close</button>
  </div>
</div>
</div>
</div>

<!-- END OF WELCOME MESSAGE MODAL CONTAINER -->

<!-- FILTER DATA (CUSTOM SEARCH) MODAL CONTAINER -->
<div class="modal fade" id="SearchModal" tabindex="-1" role="dialog" aria-labelledby="SearchModalLabel" aria-hidden="true">
<div class="modal-dialog">
<div class="modal-content">
<div class="modal-header">
  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
  <h4 class="modal-title" id=SearchModalLabel">Filter Markers</h4>
</div>
<div class="modal-body">
<%
List<String> buildingTypes = locationDAO.retrieveAllBuildingTypes(locations);
double maxHeight = locationDAO.getMaximumHeight(locations);
double minHeight = locationDAO.getMinimumHeight(locations);
int maxYearBuilt = locationDAO.getMaximumYearBuilt(locations);
int minYearBuilt = locationDAO.getMinimumYearBuilt(locations);
int maxCapacity = locationDAO.getMaximumCapacity(locations);
int minCapacity = locationDAO.getMinimumCapacity(locations);
double maxPremium = locationDAO.getMaximumPremium(locations);
double minPremium = locationDAO.getMinimumPremium(locations);
double maxPropertyCoverageLimit =locationDAO.getMaximumPropertyCoverageLimit(locations);
double minPropertyCoverageLimit = locationDAO.getMinimumPropertyCoverageLimit(locations);
double maxLossCoverageLimit = locationDAO.getMaximumLossCoverageLimit(locations);
double minLossCoverageLimit = locationDAO.getMinimumLossCoverageLimit(locations);
ArrayList<String> foundationTypes = locationDAO.retrieveAllFoundationTypes(locations);
ArrayList<String> masonryTypes = locationDAO.retrieveAllMasonryTypes(locations);
ArrayList<String> roofTypes = locationDAO.retrieveAllRoofTypes(locations);
ArrayList<String> locationDatasets = locationDAO.retrieveAllDatasets(locations);
%>
<form name="search_location" method="post" action="search">
    <div class="row">
        <div class="col-md-5">
            Building Type:
        </div>
        <div class="col-md-7">
           <%for (int i=0;i<buildingTypes.size();i++){%>
            <input name="buildingType" type="checkbox" value="<%=buildingTypes.get(i)%>" checked/>
            <%=buildingTypes.get(i)%>
        <%}%>
        </div>
    </div>
    <br/>
    <div class="row">
        <div class="col-md-5">
            Building Name (containing):
        </div>
		<div class="col-md-7">
            <input name="buildingName" type="text" placeholder="e.g. Shenton House">
        </div>
    </div>
    <br/>
    
    <div class="row">
  		 <div class="col-md-5">
            Building Height:
        </div>
        <div class="col-md-7">
        	<div class="row">
	        	<div class="col-md-2">
	        		<b><%=(int)minHeight/10*10%></b>
	        	</div>
	        	<div class="col-md-7">
	        		 <input id="slideBuildingHeight" type="text" class="span2" value=""  style="width:180px;" data-slider-min="<%=(int)minHeight/10*10%>" data-slider-max="<%=(int)maxHeight/10*10 + 10 %>" data-slider-step="10" data-slider-value="[<%=(int)minHeight/10*10%>,<%=(int)maxHeight/10*10 + 10 %>]">
	        	</div>
		        <div class="col-md-3" style="text-align:right;">
		             <b><%=(int)maxHeight/10*10 + 10 %></b>
		        </div>
	            <input type="hidden" id="minHeight" name="minHeight" value="<%=(int)minHeight/10*10%>">
				<input type="hidden" id="maxHeight" name="maxHeight" value="<%=(int)maxHeight/10*10 + 10 %>">
        	</div>
        </div>    
    </div>
    <br/>
    
    <div class="row">
      <div class="col-md-5">
            Year Built:
      </div>
      <div class="col-md-7">
        	<div class="row">
        		<div class="col-md-2">
        			<b><%=minYearBuilt/10*10%></b>
        		</div>
        		<div class="col-md-7">
        			<input id="slideYearBuilt" type="text" class="span2" value=""  style="width:180px;" data-slider-min="<%=minYearBuilt/10*10%>" data-slider-max="<%=maxYearBuilt/10*10+10 %>" data-slider-step="10" data-slider-value="[<%=minYearBuilt/10*10%>,<%=maxYearBuilt/10*10+10 %>]">
        		</div>
        		<div class="col-md-3" style="text-align:right;">
        			<b><%=maxYearBuilt/10*10+10 %></b>
        		</div>
        	</div>
        	<input type="hidden" id="minYearBuilt" name="minYearBuilt" value="<%=minYearBuilt/10*10%>">
			<input type="hidden" id="maxYearBuilt" name="maxYearBuilt" value="<%=maxYearBuilt/10*10+10 %>">
		</div>
    </div>
   <br/>
    <div class="row">
      <div class="col-md-5">
            Capacity:
        </div>
       <div class="col-md-7">
       	<div class="row">
       	  <div class="col-md-2">
            <b><%=minCapacity/10*10%></b>
          </div><div class="col-md-7">
        	<input id="slideCapacity" type="text" class="span2" value=""  style="width:180px;" data-slider-min="<%=minCapacity/10*10%>" data-slider-max="<%=maxCapacity/10*10+10 %>" data-slider-step="10" data-slider-value="[<%=minCapacity/10*10%>,<%=maxCapacity/10*10+10 %>]">
          </div><div class="col-md-3" style="text-align:right;">  
            <b><%=maxCapacity/10*10+10 %></b>
          </div>
         </div>
            <input type="hidden" id="minCapacity" name="minCapacity" value="<%=minCapacity/10*10%>">
			<input type="hidden" id="maxCapacity" name="maxCapacity" value="<%=maxCapacity/10*10+10%>">
		 </div>
    </div>
    <br/>
    <div class="row">
        <div class="col-md-5">
            Premium:
       </div>
       <div class="col-md-7">
       		<div class="row">
       		 <div class="col-md-2">
	            <b><%=(int)minPremium/100*100%></b>
	         </div><div class="col-md-7">
	        	<input id="slidePremium" type="text" class="span2" value=""  style="width:180px;" data-slider-min="<%=(int)minPremium/100*100%>" data-slider-max="<%=(int)maxPremium/100*100 + 100 %>" data-slider-step="100" data-slider-value="[<%=(int)minPremium/100*100%>,<%=(int)maxPremium/100*100 + 100 %>]">
	         </div><div class="col-md-3" style="text-align:right;">   
	            <b><%=(int)maxPremium/100*100 + 100 %></b>
	         </div>
	        </div>
	            <input type="hidden" id="minPremium" name="minPremium" value="<%=(int)minPremium/100*100%>">
				<input type="hidden" id="maxPremium" name="maxPremium" value="<%=(int)maxPremium/100*100 + 100%>">
	    </div>
	</div>
	<br/>
    <div class="row">
        <div class="col-md-5">
            Property Coverage Limit:
        </div>
        <div class="col-md-7">
          <div class="row">
           <div class="col-md-2">
            <b><%=(int)minPropertyCoverageLimit/100*100%></b>
           </div><div class="col-md-7">
        	<input id="slidePropertyCoverageLimit" type="text" class="span2" value=""  style="width:180px;" data-slider-min="<%=(int)minPropertyCoverageLimit/100*100%>" data-slider-max="<%=(int)maxPropertyCoverageLimit/100*100 + 100 %>" data-slider-step="100" data-slider-value="[<%=(int)minPropertyCoverageLimit/100*100%>,<%=(int)maxPropertyCoverageLimit/100*100 + 100 %>]">
           </div><div class="col-md-3" style="text-align:right;"> 
            <b><%=(int)maxPropertyCoverageLimit/100*100 + 100 %></b>
           </div>
          </div>
            <input type="hidden" id="minPropertyCoverageLimit" name="minPropertyCoverageLimit" value="<%=(int)minPropertyCoverageLimit/100*100%>">
			<input type="hidden" id="maxPropertyCoverageLimit" name="maxPropertyCoverageLimit" value="<%=(int)maxPropertyCoverageLimit/100*100 + 100%>">
        </div>
    </div>
    <br/>
    <div class="row">
        <div class="col-md-5">
            Loss Coverage Limit:
        </div>
        <div class="col-md-7">
          <div class="row">
           <div class="col-md-2">
            <b><%=(int)minLossCoverageLimit/100*100%></b>
           </div><div class="col-md-7">
        	<input id="slideLossCoverageLimit" type="text" class="span2" value=""  style="width:180px;" data-slider-min="<%=(int)minLossCoverageLimit/100*100%>" data-slider-max="<%=(int)maxLossCoverageLimit/100*100 + 100 %>" data-slider-step="100" data-slider-value="[<%=(int)minLossCoverageLimit/100*100%>,<%=(int)maxLossCoverageLimit/100*100 + 100 %>]">
           </div><div class="col-md-3" style="text-align:right;">
			<b><%=(int)maxLossCoverageLimit/100*100 + 100 %></b>
		   </div>
		  </div> 
            <input type="hidden" id="minLossCoverageLimit" name="minLossCoverageLimit" value="<%=(int)minLossCoverageLimit/100*100%>">
			<input type="hidden" id="maxLossCoverageLimit" name="maxLossCoverageLimit" value="<%=(int)maxLossCoverageLimit/100*100 + 100%>">
         </div>
    </div>
    <br/>
    <div class="row">
        <div class="col-md-5">
            Foundation Type:
        </div>
       <div class="col-md-7">
           <%for (int i=0;i<foundationTypes.size();i++){%>
            <input name="foundationType" type="checkbox" value="<%=foundationTypes.get(i)%>" checked/>
            <%=foundationTypes.get(i)%>
        <%}%>
       </div>
    </div>
    <br/>
     <div class="row">
        <div class="col-md-5">
            Masonry Type:
        </div>
        <div class="col-md-7">
           <%for (int i=0;i<masonryTypes.size();i++){%>
            <input name="masonryType" type="checkbox" value="<%=masonryTypes.get(i)%>" checked/>
            <%=masonryTypes.get(i)%>
        <%}%>

        </div>
    </div>
     <div class="row">
        <div class="col-md-5">
            Roof Type:
         </div>
        <div class="col-md-7">
           <%for (int i=0;i<roofTypes.size();i++){%>
            <input name="roofType" type="checkbox" value="<%=roofTypes.get(i)%>" checked/>
            <%=roofTypes.get(i)%>
        <%}%>

        </div>
    </div>
    <br/>
    <div class="row">
        <div class="col-md-5">
            Dataset:
        </div>
        <div class="col-md-7">
           <%for (int i=0;i<locationDatasets.size();i++){%>
            <input name="datasets" type="checkbox" value="<%=locationDatasets.get(i)%>" checked/>
            <%=locationDatasets.get(i)%>
        <%}%>

        </div>
    </div>
    <br/>
    <div class="row">
        <div class="col-md-5">
            Remark (containing):
        </div>
        <div class="col-md-7">
            <input name="remark" type="text" placeholder="e.g. pad foundation type">
        </div>
    </div>
    <br/>
    <input type="hidden" name="username" value="<%=username%>"/>
    <input type="submit" class="btn btn-primary" value="Filter"/>
    <button type="reset" class="btn btn-default" value="Reset">Reset</button>
</form>

</div>
</div>
</div>
</div>
<!-- END OF FILTER DATA (CUSTOM SEARCH) MODAL CONTAINER -->

<!-- W1 - UPLOAD NEW FILE WIDGET MODAL CONTENT -->
<div class="modal fade" id="UploadModal" tabindex="-1" role="dialog" aria-labelledby="UploadModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id=UploadModalLabel">Upload File <button id="uploadTooltip" type="button" class="btn btn-default" data-toggle="tooltip" data-placement="right" title="" data-original-title="This widget allows you to upload data regarding the buildings you want to visualize in the map. File formats you can upload include .csv and .zip files">?</button></h4>
      </div>
      <div class="modal-body">
      <h4 style="color:Black">Upload map data </h4>
        <form name="upload-file" action="upload" method="post" enctype="multipart/form-data"  role="form">
          <div class="form-group">
            <input type="file" name="data">
          </div>
         <hr /> 
      <h4 style="color:Black">Select currency of map markers to be uploaded:</h4>    
          <select class="selectpicker" name="currency" data-size="11">
			      <option value="SGD" data-subtext="Singapore Dollar" selected>SGD</option>
			      <option value="AUD" data-subtext="Australian Dollar">AUD</option>
			      <option value="CAD" data-subtext="Canadian Dollar">CAD</option>
			      <option value="CHF" data-subtext="Swiss Franc">CHF</option>
			      <option value="CNY" data-subtext="Chinese Renminbi">CNY</option>
			      <option value="EUR" data-subtext="Euro">EUR</option>
			      <option value="GBP" data-subtext="British Pound">GBP</option>
			      <option value="HKD" data-subtext="Hong Kong Dollar">HKD</option>
			      <option value="INR" data-subtext="Indian Rupee">INR</option>
			      <option value="JPY" data-subtext="Japanese Yen">JPY</option>
			      <option value="USD" data-subtext="United States Dollar">USD</option>
          </select>
          <hr />
			 <input type="checkbox" name="clear data" class="style1" value="clear-data"/> Clear all the previously stored data by you	    
			   <input type="hidden" name="username" value="<%=username%>">   
			    <div class="form-group">
			    <hr />
            <p align="right"><button type="submit" value="Upload" class="btn btn btn-primary">Submit</button></p>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<!-- W1 - END OF UPLOAD NEW FILE WIDGET MODAL CONTENT -->

<!-- W7 - COMPARISON WIDGET MODAL CONTENT -->
<div class="modal fade" id="ComparisonModal" tabindex="-1" role="dialog" aria-labelledby="ComparisonModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id=ComparisonModalLabel">Comparison <button id="comparisonTooltip" type="button" class="btn btn-default" data-toggle="tooltip" data-placement="right" title="" data-original-title="This widget allows you to compare the different risks of the different buildings. Select the marker you wish to add to the comparison table and click “Add to Comparison” on the pop up.">?</button></h4>
      </div>
      <div class="modal-body">
        <div id="noComparisonLabel" style="text-align:center">No points have been added for comparison. <br />Please select a marker and click 'Add to Comparison' to begin.</div>
	      <div id="comparisonTableContainer" style="display:none">
	      <table id="comparisonTable" border="1" style="table-layout: fixed; width:100%; text-align:center">
	      <tr>
		      <th style="text-align:center" bgcolor="#2C9EE1"><font color="#fff">Name</font></th>
		      <th style="text-align:center" bgcolor="#2C9EE1"><font color="#fff">Earthquake</font></th>
		      <th style="text-align:center" bgcolor="#2C9EE1"><font color="#fff">Flood</font></th>
		      <th style="text-align:center" bgcolor="#2C9EE1"><font color="#fff">Fire</font></th>
		      <th style="text-align:center" bgcolor="#2C9EE1"><font color="#fff">Average</font></th>
	      </tr>
	      </table>
	      </div>
	      <div id ="comparisonChart"></div>
      </div>
      
    </div>
  </div>
</div>
<!-- W7 - END OF COMPARISON WIDGET MODAL CONTENT -->


<!-- JAVASCRIPT CONTENT -->
<script>

/* WIDGET ACTION FUNCTIONALITY */
function closeWidget(widgetID){
	
	if(widgetID == 'widget1'){
		//to hide radius
    	$("#wid1IsSelected").val("false");
    	$("#poiSlide").slider('setValue', 500);
    	if($("#markerSelected").val() =="true"){
    		circle.setMap(null);
    	}
		// get effect type from
		var selectedEffect = $( "#effectTypes" ).val();
		// most effect types need no options passed by default
		var options = {};
		// some effects have required parameters
		if ( selectedEffect === "scale" ) {
			options = { percent: 0 };
		} else if ( selectedEffect === "size" ) {
			options = { to: { width: 200, height: 60 } };
		}
	    clearResults();
	    clearPOImarkers();
		// run the effect
		
	}else if(widgetID=='widget8'){
		$( "#simulationSlider" ).hide();
    	document.getElementById("simulationButton").value = "Start Simulation";
    	document.getElementById("simulationButton").className = "btn btn-success";
    	if (dragMarker != null) {
    		  dragMarker.setMap(null);
    	}
    	if (customCircle != null) {
    		  customCircle.setMap(null);
    	}
	    document.getElementById("averageFire").innerHTML = "";
	    document.getElementById("averageFlood").innerHTML = "";
	    document.getElementById("buildingsAffected").innerHTML = "";
	    document.getElementById("buildingLabel").innerHTML = "";
	    document.getElementById("riskLabel").innerHTML = "";
	    document.getElementById("simulationInstructions").innerHTML = "";
	    document.getElementById("averageEarthquake").innerHTML = "";
    	// get effect type from
		var selectedEffect = $( "#effectTypes" ).val();
		  
		// most effect types need no options passed by default
		var options = {};
		// some effects have required parameters
		if ( selectedEffect === "scale" ) {
			options = { percent: 0 };
		} else if ( selectedEffect === "size" ) {
			options = { to: { width: 200, height: 60 } };
		}

	}
	
	// get effect type from
	var selectedEffect = $( "#effectTypes" ).val();

	// most effect types need no options passed by default
	var options = {};
	// some effects have required parameters
	if ( selectedEffect === "scale" ) {
		options = { percent: 0 };
	} else if ( selectedEffect === "size" ) {
		options = { to: { width: 200, height: 60 } };
	}
	// run the effect
	$( "#"+widgetID ).hide( 'scale', options, 500 );	
}


function openWidget(widgetID){
	if(widgetID=='widget1'){
		$('#UploadModal').modal('show'); 
	}else if(widgetID=='widget7'){
		$('#ComparisonModal').modal('show'); 
	}else if(widgetID=='widget9'){
		$('#WidgetModal').modal('show');
	}
	else{
		if(widgetID=='widget2'){
			$("#wid1IsSelected").val("true");
			$markerSelected = $("#markerSelected").val();
			if($markerSelected == "true"){
		    	circle = new google.maps.Circle({
			 			  center:currentMarker.position,
			 			  radius: 500,
			 			  strokeColor:"#0000FF",
			 			  strokeOpacity:0.8,
			 			  strokeWeight:2,
			 			  fillColor:"#0000FF",
			 			  fillOpacity:0.1
			 			  });
		
			 			circle.setMap(map);
			 		map.setZoom(14);
			 		map.setCenter(currentMarker.position);
			}
		}else if(widgetID=='widget6'){
		      $('#widgetModalClose').click();
		      $('.modal-backdrop').remove();
		}
		
		// get effect type from
	    var selectedEffect = $( "#effectTypes" ).val();
	
	    // most effect types need no options passed by default
	    var options = {};
	    // some effects have required parameters
	
	    // run the effect
	    $( "#"+widgetID ).show( 'clip', options, 500 );
	    return false;
	}
}
/* END OF WIDGET ACTION FUNCTIONALITY */

/* USER TOOLTIPS */
$("#uploadTooltip").tooltip();
$("#poiTooltip").tooltip({container: 'body'});
$("#filterTooltip").tooltip({container: 'body'});
$("#hazardTooltip").tooltip({container: 'body'});
$("#riskTooltip").tooltip({container: 'body'});
$("#historicalTooltip").tooltip({container: 'body'});
$("#comparisonTooltip").tooltip();
$("#simulationTooltip").tooltip({container: 'body'});
google.load("visualization", "1", {packages:["corechart"]});

//GLOBAL DATATABLE VARIABLE
var data;
//GLOBAL RISKDATA VARIABLE
var riskData = new Array();
//POI VARIABLE
var currentMarker;

  var menuLeft = document.getElementById( 'cbp-spmenu-s1' ),
	menuRight = document.getElementById( 'cbp-spmenu-s2' ),
	menuTop = document.getElementById( 'cbp-spmenu-s3' ),
	menuBottom = document.getElementById( 'cbp-spmenu-s4' ),
	showLeft = document.getElementById( 'showLeft' ),
	showRight = document.getElementById( 'showRight' ),
	showTop = document.getElementById( 'showTop' ),
	showBottom = document.getElementById( 'showBottom' ),
	closeBottom = document.getElementById( 'closeBottom' ),
	showLeftPush = document.getElementById( 'showLeftPush' ),
	showRightPush = document.getElementById( 'showRightPush' ),
	body = document.body;
	showBottom.onclick = function() {
		$('#showBottom').hide();
		classie.toggle( this, 'active' );
		classie.toggle( menuBottom, 'cbp-spmenu-open' );
		disableOther( 'showBottom' );
	};
	 
	closeBottom.onclick = function() {
		
		classie.toggle( this, 'active' );
		classie.toggle( menuBottom, 'cbp-spmenu-open' );
		$('#showBottom').show();
		disableOther( 'showBottom' );
	};		
	
	function disableOther( button ) {
		if( button !== 'showLeft' ) {
			classie.toggle( showLeft, 'disabled' );
		}
		if( button !== 'showRight' ) {
			classie.toggle( showRight, 'disabled' );
		}
		if( button !== 'showTop' ) {
			classie.toggle( showTop, 'disabled' );
		}
		if( button !== 'showBottom' ) {
			classie.toggle( showBottom, 'disabled' );
		}
		if( button !== 'showLeftPush' ) {
			classie.toggle( showLeftPush, 'disabled' );
		}
		if( button !== 'showRightPush' ) {
			classie.toggle( showRightPush, 'disabled' );
		}
	}

	$(document).ready(function() {
	    $('.selectpicker').selectpicker();
	    $( "#draggable" ).draggable();
	    $( "#simulationSlider" ).hide();
	    $(".w9").show();
	    $( ".w0" ).hide();
      $( ".w1" ).hide();
      $( ".w2" ).hide();
      $( ".w3" ).hide();
      $( ".w4" ).hide();
      $( ".w5" ).hide();
	    $( ".w6" ).hide();
	    $( ".w7" ).hide();
	    $( ".w8" ).hide();
	    
	    <%
	    for (int a = 0; a < widgetAccess.size(); a++) {
	      String widget = widgetAccess.get(a);
	      if (widget.equals("Administration Tools")){
	    	  %>$(".w0").show();<%
	      }
	      else if (widget.equals("Upload New File")) {
	    	  %>$(".w1").show();<%
	      }
	      else if (widget.equals("Filter Data")) {
	    	  %>$(".w2").show();<%
	      }
	      else if (widget.equals("Hazard Map")) {
	    	  %>$(".w3").show();<%
	      }
	      else if (widget.equals("Risk Calculation")) {
	    	  %>$(".w4").show();<%
	      }
	      else if (widget.equals("Comparison")) {
	    	  %>$(".w5").show();<%
	      }
	      else if (widget.equals("Simulation")) {
	    	  %>$(".w6").show();<%
	      }
	      else if (widget.equals("Historical Analysis")) {
	    	  %>$(".w7").show();<%
	      }
	    }
	    %>
	  });
	
	$(function() {
		var a = 3;
	    $('.draggable').draggable({
			start: function(event, ui) { $(this).css("z-index", a++); }
	   });
	    $('#dragZone div').click(function() {
	        $(this).addClass('top').removeClass('bottom');
	        $(this).siblings().removeClass('top').addClass('bottom');
	        $(this).css("z-index", a++);
	
	    });
	    
	    $( ".resizable" ).resizable();

 	    $( ".widget" ).hide();

	
	});

     
	var map, places, iw;
	  var poiMarkers = [];
	  var mapMarkers = [];
	  var searchmarkers = [];
	  var searchTimeout;
	  var centerMarker;
	  var autocomplete;
	  var hostnameRegexp = new RegExp('^https?://.+?/');
	  
	  //POI VARIABLES
	  var markerPos;
	  var curMarker;
	  var circle;
	  var newPoiRad = 500;
	  $("#poiSlide").slider({tooltip: 'always'});
 	 	$("#poiSlide").on('slide', function(slideEvt) {
 	 		newPoiRad = document.getElementById('poiSlide').value;
 	 		circle.setRadius(slideEvt.value);
 	 	});
	  
 	  
 	 
	  //DATA INFORMATION  FUNCTION
      function updateVisibility(id) {
  	  	var marker = mapMarkers[id]; // find the marker by given id
  	  	if (document.getElementById('markerCheckBox'+id).checked) {
  	  		marker.setMap(map);
  	  	}else{
  	  	   	marker.setMap(null);
  	  	}
  	  }
	  
      function popLocationInfo(markerID) {
	   		google.maps.event.trigger(mapMarkers[markerID], 'click');
	   }
	  
	  //SIMULATION VARIABLES
	  var customCircle;
	  var dragMarker;
	  var simulationRadius = 9000;
	  var dragged = false;
	  
	  $("#simulationSlide").on('slide', function(slideEvt) {	 		
	 		simulationRadius = slideEvt.value;
	 		startSimulation();
	 		
	  });
      
    //HAZARD MAP VARIABLES
    var earthquakeLayer;
    var floodLayer;
    var fireLayer;
    
    //COMPARISON VARIABLES
    var comparisonAdded = new Array();

	  function initialize() {
	  //intitialize Historical Analysis
	  drawVisualization();
	  // marker's longitude and langitude
      	    var myOptions = {
	      zoom: 15,
	      mapTypeId: google.maps.MapTypeId.ROADMAP
	    }
	    map = new google.maps.Map(document.getElementById('map_canvas'), myOptions);
	    places = new google.maps.places.PlacesService(map);
	    

	    google.maps.event.addListener(map, 'tilesloaded', tilesLoaded);

	    var input = (document.getElementById('pac-input'));
	    map.controls[google.maps.ControlPosition.TOP_CENTER].push(input);

	    var searchBox = new google.maps.places.SearchBox((input));

	    google.maps.event.addListener(searchBox, 'places_changed', function() {
	      var places = searchBox.getPlaces();

	      for (var i = 0, searchmarker; searchmarker = searchmarkers[i]; i++) {
	        searchmarker.setMap(null);
	      }

	      // For each place, get the icon, place name, and location.
	      searchmarkers = [];
	      var bounds = new google.maps.LatLngBounds();
	      for (var i = 0, place; place = places[i]; i++) {
	        var image = {
	          url: place.icon,
	          size: new google.maps.Size(71, 71),
	          origin: new google.maps.Point(0, 0),
	          anchor: new google.maps.Point(17, 34),
	          scaledSize: new google.maps.Size(25, 25)
	        };

	        // Create a marker for each place.
	        var searchmarker = new google.maps.Marker({
	          map: map,
	          icon: image,
	          title: place.name,
	          position: place.geometry.location
	        });

	        searchmarkers.push(marker);

	        bounds.extend(place.geometry.location);
	      }

	      map.fitBounds(bounds);
	    });
 
	    document.getElementById('keyword').onkeyup = function(e) {
	      if (!e) var e = window.event;
	      if (e.keyCode != 13) return;
	      document.getElementById('keyword').blur();
	      search(document.getElementById('keyword').value);
	    }

	    var typeSelect = document.getElementById('type');
	    typeSelect.onchange = function() {
	      search();
	    };

	    var rankBySelect = 'distance';
	    rankBySelect.onchange = function() {
	      search();
	    };
	    
	    var locations = [
	                     <%for(int i=0;i<locations.size(); i++) { 
	                        Location l=locations.get(i);%>
	                        [<%=l.getLatitude()%>,<%=l.getLongitude()%>,"<%=l.getBuildingName()%>",<%=l.getPremium()%> + "<%=l.getCurrency()%>",<%=(int)datasetMap.get(l.getCSVName())%>,<%=l.getId()%>,<%=l.getVulnerabilityIndex()%>],
	                     <%}%>
	                 ];
	                 
	                 var details = [
	                    <%for(int i=0;i<locations.size(); i++) { 
	                            Location l=locations.get(i);%>
	                            ["<%=l.getBuildingName()%>","<%=l.getBuildingType()%>",<%=l.getBuildingHeight()%>,<%=l.getYearBuilt()%>,<%=l.getCapacity()%>,
	                            <%=l.getPropertyCoverageLimit()%>,<%=l.getLossCoverageLimit()%>,"<%=l.getFoundationType()%>",
	                            "<%=l.getRemarks()%>",<%=l.getPremium()%> + "<%=l.getCurrency()%>","<%=l.getMasonry()%>","<%=l.getRoof()%>","<%=l.getCSVName()%>","<%=l.getId()%>"],
	                    <%}%>
	                 ];
	         

	                 // Setup the different icons and shadows
	                 

	                 var icons = [
                     'assets/markers/pink-blank.png',        
	                   'assets/markers/blu-blank.png',
	                   'assets/markers/yel-blank.png',
	                   'assets/markers/grn-blank.png',
	                   'assets/markers/red-blank.png',
	                   'assets/markers/purp-blank.png'
	                 ];
	                 var icons_length = icons.length;
	                 
	                 var infowindow = new google.maps.InfoWindow({
	                     maxWidth: 160
	                   });
	                 
	                 var infowindow2 = new google.maps.InfoWindow({
	                     maxWidth: 160
	                   });

	                   

	                   // Add the markers and infowindows to the map
	                   for (var i = 0; i < locations.length; i++) {
	                	   var number = locations[i][4]
	                       marker = new google.maps.Marker({
	                       position: new google.maps.LatLng(locations[i][0], locations[i][1]),
	                       map: map,
	                       name: locations[i][2],
	                       icon: icons[number - 1],
	                       id: locations[i][5],
	                       vIndex: locations[i][6]
	                     });
	                	   mapMarkers.push(marker);
	                	   var results2 = document.getElementById('results2');
	                	   var tr = document.createElement('tr');
	                	   tr.style.backgroundColor = (i% 2 == 0 ? '#F0F0F0' : '#FFFFFF');
	                	   
	                	   
	                	   var checkboxTd = document.createElement('td');
	                	   var iconTd = document.createElement('td');
	                	   var nameTd = document.createElement('td');
	                	   
	                	   
	                	   
	                	   var checkbox = document.createElement('input');
	                	   checkbox.setAttribute('type', 'checkbox');
	                	   checkbox.setAttribute('onchange', 'updateVisibility('+i+')');
	                	   checkbox.setAttribute('id', 'markerCheckBox'+i);
	                	   checkbox.setAttribute('checked', 'true');
	                	   
	                	   var icon = document.createElement('img');
	                	   icon.src = icons[number-1];
	                	   icon.setAttribute('class', 'placeIcon');
	                	   icon.setAttribute('className', 'placeIcon');
	                	   
	                	   var name = document.createElement('p');
	                	   name.innerHTML = locations[i][2];
	                	   name.setAttribute('id','location'+i);
	                	   name.setAttribute('onClick','popLocationInfo('+i+')');
	                	   
	                	   
	                	   checkboxTd.appendChild(checkbox);
	                	   iconTd.appendChild(icon);
	                	   nameTd.appendChild(name);
	                	   
	                	   tr.appendChild(checkboxTd);
	                	   tr.appendChild(iconTd);
	                	   tr.appendChild(nameTd);
	                	   
	                	   
	                	   results2.appendChild(tr);  
	                 
	                     //Hover Function for info window
	                     google.maps.event.addListener(marker, 'mouseover', (function(marker, i) {
	                       return function() {
	                         infowindow.setContent('<h4>' + locations[i][2] + '<br />(' + locations[i][3] + ')</h4>' + '<b>Latitude:</b> ' + locations[i][0] + '<br /> ' +' <b>Longitude:</b> ' + locations[i][1]);
	                         if (!infowindow2.getMap()) {
	                         infowindow.open(map, marker);
	                         }
	                         google.maps.event.addListenerOnce(map, 'mousemove', function(){
	                             infowindow.close();
	                         });
	                       };
	                     })(marker, i));
             
	                     var selected;
		                  var selectedIcon;
		                  
		                     google.maps.event.addListener(marker, 'click', (function(marker, i) {
		                    	currentMarker = marker;
		                    	
		                       return function() {
		                    	   $("#poiSlide").slider('setValue', 500);
		                    	   $("#markerSelected").val("true");

		                    	 if(circle!=null){
		                    		 circle.setMap(null);
		                    	 }
		                    	 if(document.getElementById("wid1IsSelected").value=="true"){
			               	 		 circle = new google.maps.Circle({
			               	 			  center:marker.position,
			               	 			  radius: 500,
			               	 			  strokeColor:"#0000FF",
			               	 			  strokeOpacity:0.8,
			               	 			  strokeWeight:2,
			               	 			  fillColor:"#0000FF",
			               	 			  fillOpacity:0.1
			               	 			  });
		
			               	 			circle.setMap(map);
			               	 		map.setZoom(14);
			               	 		map.setCenter(marker.position);
		                    	 }
		               	 			
		                    	infowindow.close();   
		                    	infowindow2.open(map, marker);
		                       	if(currentMarker!=marker){  
			                    	 currentMarker = marker;
			                    	 curMarker = marker;
			                    	 infowindow.close();
			                    	 infowindow2.setContent("Loading data...");
					       		     document.getElementById('noResultMsg').innerHTML = "";
			                         displayData(details[i],marker.position.lat(),marker.position.lng(),marker.vIndex);
			                         
			                         map.setCenter(marker.position);
			                         document.getElementById('type').value="";
			                 	     clearResults();
			                 	    clearPOImarkers();
				                 	    
				                 	 var  updatePoiRadBtn = document.getElementById('updatePoiRadBtn');
				                 	   
				                 	    updatePoiRadBtn.onclick = function() {
				                 	      search(marker.position,'true',newPoiRad);
				                 	      markerPos = marker.position;
				                 	    };
				                 	   		
			                         if (selected) {
			                        	 selected.setIcon(selectedIcon);
			                         }
			                         
			                         selectedIcon = marker.getIcon();
			                         selected = marker;
			                         
			                         
			                         var txt = new String(marker.getIcon());
			                         marker.setIcon(txt.substring(0,txt.length-4)+"-1.png");
			                         displaySelectedPOI(selected);
			                         displaySelectedRisk(selected);
		                      	 }
		                       };
		                     })(marker, i));
		                   }
	                   

	                     
	                     // shows / hides the markers based on the ID
	                     function toggleData(id) {
	                    	 $.each(mapMarkers, function (index, marker) {
	                    		 if (marker.id === id) {
	                    			  if (marker.getVisible()) {
	                                 marker.setVisible(false);
	                             }
	                             else {
	                                 marker.setVisible(true);
	                             }
	                    		 }
	                       });
	                   }
	                  
	                   //function to display all available information of the point
	                   function displayData(array,latitude,longitude,vIndex) {
	                	   var floodValue;
	                	   var fireValue;
	                	   var earthquakeValue;
	                	   //Flood Query Table
	                	   var query, queryText, gvizQuery;
                       query = "SELECT 'gridcode' " +
                       "FROM 1TZgZZZrh7qp2aiJlVwGCIIdpZ3-CdaCJx7K85MLF "+
                       "WHERE ST_INTERSECTS(geometry, CIRCLE(LATLNG( "+ latitude + ', ' + longitude + "),1))";
                       queryText = encodeURIComponent(query);
                       gvizQuery = new google.visualization.Query('http://www.google.com/fusiontables/gvizdata?tq=' + queryText);
                       gvizQuery.send(function(response) { 
	                       var table = response.getDataTable();
	                       if (table.getNumberOfRows() != 0) {
	                           floodValue = parseFloat(((1 - table.getValue(0,0)/500) * 100).toFixed(1));
	                       }
	                       else {
	                           floodValue = 0;
	                       }
                         //Fire Query Table
                         var query1, queryText1, gvizQuery1;
                         query1 = "SELECT 'gridcode' " +
                         "FROM 1bx6kxzPzX6_g4IJEEYmZmy4ze4xvRF_c8kUZEWp0 "+
                         "WHERE ST_INTERSECTS(geometry, CIRCLE(LATLNG( "+ latitude + ', ' + longitude + "),1))";
                         queryText1 = encodeURIComponent(query1);
                         gvizQuery1 = new google.visualization.Query('http://www.google.com/fusiontables/gvizdata?tq=' + queryText1);
                         gvizQuery1.send(function(response) {  
	                         var table1 = response.getDataTable();
	                         if (table1.getNumberOfRows() != 0) {
	                          fireValue = parseFloat(((1 - table1.getValue(0,0)/20000) * 100).toFixed(1));
	                         }
	                         else {
	                           fireValue = 0;
	                         }
	                         //ADD QUERY TO EARTHQUAKE HERE
	                         earthquakeValue = 0;
	                         var stringId = array[13].toString();
	                         var number = comparisonAdded.indexOf(stringId);
                           if (number >= 0) {
                             infowindow2.setContent(
                                         "<h4> " + array[0] + "<br /> (" + array[9] + ")</h4>" + "<b>Type:</b> " + array[1] + "<br />" + "<b>Year Built:</b> " + array[3] +
                                         "<br />" +  "<b>Masonry:</b> " + array[10]+  "<br />" + "<b>Roof Material:</b> " + array[11] + 
                                         "<br />" + "<b>Foundation Type:</b> " + array[7] + 
                                         "</br>" + "<b>Height:</b> " + array[2] + "<br />" + "<b>Capacity:</b> " + array[4] +
                                         "<br />" + "<b>Property Coverage Limit:</b> " + array[5] + "<br />" + "<b>Loss Coverage Limit:</b> " + array[6] + 
                                         "<br />" + "<b>Dataset:</b> " + array[12] + "<br /><br /><center><input type=\"button\" class=\"btn btn-primary btn-sm\" value=\"Added\" style=\"width:150px\" disabled></input></center><br />"
                                         );
                           }
                           else {
                             infowindow2.setContent(
                                         "<h4> " + array[0] + "<br /> (" + array[9] + ")</h4>" + "<b>Type:</b> " + array[1] + "<br />" + "<b>Year Built:</b> " + array[3] +
                                         "<br />" +  "<b>Masonry:</b> " + array[10]+  "<br />" + "<b>Roof Material:</b> " + array[11] + 
                                         "<br />" + "<b>Foundation Type:</b> " + array[7] + 
                                         "</br>" + "<b>Height:</b> " + array[2] + "<br />" + "<b>Capacity:</b> " + array[4] +
                                         "<br />" + "<b>Property Coverage Limit:</b> " + array[5] + "<br />" + "<b>Loss Coverage Limit:</b> " + array[6] + 
                                         "<br />" + "<b>Dataset:</b> " + array[12] + "<br /><br /><center><input type=\"button\" class=\"btn btn-primary btn-sm\" onclick=\"this.value='Added'; this.disabled = true; showCompareAdd('"+stringId+"'); addComparison('"+array[0]+"','"+earthquakeValue+"','"+floodValue+"','"+fireValue+"','"+stringId+"'); colorHighest(); \" value=\"Add to Comparison\" style=\"width:150px\"></input></center><br />"
                                         );
                           }
                         });
                       });             
                     }
	                   //center map or center Malaysia
	                   if (mapMarkers.length > 0) {
	                	   AutoCenter();
	                   }
	                   
	                   else {
	                	  //Malaysia Coordinates
	                	  map.setCenter(new google.maps.LatLng(4.210484,101.97576600000002));
	                	  map.setZoom(8);
	                	  $('#welcomeModal').modal();

	                	  
	                  }
	  }

	  //Hazard Map Functionalities
	  var heatmapData = [];
	  var gradient = [
	                  'rgba(255, 170, 170, 0)',
	                  'rgba(255, 153, 153, 1)',
	                  'rgba(255, 136, 136, 1)',
	                  'rgba(255, 119, 119, 1)',
	                  'rgba(255, 102, 102, 1)',
	                  'rgba(255, 85, 85, 1)',
	                  'rgba(255, 68, 68, 1)',
	                  'rgba(255, 51, 51, 1)',
	                  'rgba(255, 34, 34, 1)',
	                  'rgba(255, 17, 17, 1)',
	                  'rgba(255, 0, 0, 1)',
	                 	'rgba(204, 0, 0, 1)',	                  
	                  'rgba(187, 0, 0, 1)',
	                  'rgba(170, 0, 0, 1)',
	                  'rgba(153, 0, 0, 1)'
	          	  ];
	   function displayFire(country) {
		  if (fireLayer != null) {
			  fireLayer.setMap(null);
	            fireLayer = null;
		  }
		  else {
			  var script = document.createElement('script');
        script.src = 'sample3.json';
        document.getElementsByTagName('head')[0].appendChild(script);
        
        var pointArray = new google.maps.MVCArray(heatmapData);
	    fireLayer = new google.maps.visualization.HeatmapLayer({
	        data: pointArray
	      });
	      fireLayer.set('radius',25);
	      fireLayer.set('gradient',gradient);
	      fireLayer.setMap(map);
        
        window.eqfeed_callback = function(results) {
	        for (var i = 0; i < results.features.length; i++) {
	          var fire = results.features[i];
	          var geometry = fire.geometry;
	          var coords = geometry.split(',')
	          var latLng = new google.maps.LatLng(coords[1], coords[0]);
	          heatmapData.push(latLng);
	        }
        }
		  }
	  }
	  
	  function displayFlood(country) {
		  if (floodLayer != null) {
		        floodLayer.setMap(null);
		        floodLayer = null;
      }
      else {
        floodLayer = new google.maps.FusionTablesLayer();
        floodLayer.setOptions({
           query: {
              select: 'geometry',
              from: '1HLg38j7a9sCtQhVJAj_fq6c647XY3qgDqiPMKj-Q'
           },
           heatmap:{
              enabled: true
           }
        });
        floodLayer.setMap(map);
      }
	  }
	  
	  function displayEarthquake(country) {
		  if (earthquakeLayer != null) {
			  earthquakeLayer.setMap(null);
			  earthquakeLayer = null;
		  }
		  else {
			  earthquakeLayer = new google.maps.FusionTablesLayer();
			  earthquakeLayer.setOptions({
			     query: {
			    	  select: 'geometry',
			        from: '1IQqqlXHchB1e5AQaQRqpZzbSAlUSSlZRzCls3Qrl'
			     },
			     heatmap:{
			    	  enabled: true
			     }
		    });
			  earthquakeLayer.setMap(map);
		  }
	  }
	  
	  //POI Functionalities
	  function tilesLoaded() {
	    google.maps.event.clearListeners(map, 'tilesloaded');
	    google.maps.event.addListener(map, 'dragend', search);
	  }
	  

	  function search(markerPosition, typeIsSelected, radius) {
		    clearResults();
		    clearPOImarkers();

		    if (searchTimeout) {
		      window.clearTimeout(searchTimeout);
		    }
		    searchTimeout = window.setTimeout(reallyDoSearch(markerPosition,typeIsSelected,radius), 500);
		  }
	  
	  function reallyDoSearch(markerPosition,typeIsSelected,rad) {      
		    var type = document.getElementById('type').value;
		    var keyword = document.getElementById('keyword').value;
		    var rankBy = 'distance';
		    var radString = rad-300;
		    var request = {
		    	    location: markerPosition,
		    	    radius: radString,
		    	    types: [type]
		    	  };

		    service = new google.maps.places.PlacesService(map);
		    
		    var bounds = new google.maps.LatLngBounds();
	        bounds.extend(markerPosition);

	        service.nearbySearch(request, function(results, status) {
		    	if(results.length==0 && typeIsSelected =="true"){
		  	    	  displayNoResultMsg();
		    	}
		    	 var distanceList = new Array();
		    	 var temp = 0;
		    	 var tempMarker = 0;
		      if (status == google.maps.places.PlacesServiceStatus.OK) {
		    	  for(var k = 0; k<20; k++){
		    	  	for (var i = 0; i < results.length; i++){
			        	var poiPosition = results[i].geometry.location;
				        var distance = google.maps.geometry.spherical.computeDistanceBetween(markerPosition,poiPosition);
		                distanceList.push(distance);
					        for (var j = 0; j < i; j++)
			                {
					        	var poiPosition = results[j].geometry.location;
						        var distance = google.maps.geometry.spherical.computeDistanceBetween(markerPosition,poiPosition);
				               
						        var poiPosition2 = results[j+1].geometry.location;
						        var distance2 = google.maps.geometry.spherical.computeDistanceBetween(markerPosition,poiPosition2);
				               
						        
			                    if (distance > distance2){
			                        temp = results[j];
			                        results[j] = results[j+1];
			                        results[j+1] = temp;
			                        

			                    }
			        	}
		    	  	  }
		            } 

		        for (var i = 0; i < results.length; i++) {
		          var icon = 'assets/icons/number_' + (i+1) + '.png';
		          var poiPosition = results[i].geometry.location;
		          var distance = google.maps.geometry.spherical.computeDistanceBetween(markerPosition,poiPosition);
		    	  document.getElementById('noResultMsg').innerHTML = "";
		          
		          poiMarkers.push(new google.maps.Marker({
		            position: results[i].geometry.location,
		            animation: google.maps.Animation.DROP,
		            icon: icon
		          }));
		          google.maps.event.addListener(poiMarkers[i], 'click', getDetails(results[i], i));
		          window.setTimeout(dropMarker(i), i * 100);
		          
			        bounds.extend(results[i].geometry.location);
			        addResult(results[i], i,distance);	          
		        }
			    map.fitBounds(bounds);

		      }
		      
		    });
		  }
	  
	  function displayNoResultMsg(){
		  document.getElementById('noResultMsg').innerHTML = "No nearby POIs found in the area";
	  }
	  
	  function clearPOImarkers() {
	    for (var i = 0; i < poiMarkers.length; i++) {
	      poiMarkers[i].setMap(null);
	    }
	    poiMarkers = [];
	    if (centerMarker) {
	      centerMarker.setMap(null);
	    }
	  }

	  function dropMarker(i) {
	    return function() {
	      if (poiMarkers[i]) {
	        poiMarkers[i].setMap(map);
	      }
	    }
	  }

	  function addResult(result, i,distanceInput) {
		    var results = document.getElementById('results');
		    var tr = document.createElement('tr');
		    tr.style.backgroundColor = (i% 2 == 0 ? '#F0F0F0' : '#FFFFFF');
		    tr.onclick = function() {
		      google.maps.event.trigger(poiMarkers[i], 'click');
		    };

		    var iconTd = document.createElement('td');
		    var nameTd = document.createElement('td');
		    var distanceTd = document.createElement('td');
		    var icon = document.createElement('img');
		    icon.src = 'assets/icons/number_' + (i+1) + '.png';
		    icon.setAttribute('class', 'placeIcon');
		    icon.setAttribute('className', 'placeIcon');
		    var name = document.createTextNode(result.name);
		    var distance = document.createTextNode(distanceInput.toFixed(0)+"m");
		    iconTd.appendChild(icon);
		    nameTd.appendChild(name);
		    distanceTd.appendChild(distance);
		    tr.appendChild(iconTd);
		    tr.appendChild(nameTd);
		    tr.appendChild(distanceTd);
		    results.appendChild(tr);
		  }

	  function clearResults() {
	    var results = document.getElementById('results');
	    while (results.childNodes[0]) {
	      results.removeChild(results.childNodes[0]);
	    }
	  }

	  function getDetails(result, i) {
	    return function() {
	      places.getDetails({
	          reference: result.reference
	      }, showInfoWindow(i));
	    }
	  }

	  function showInfoWindow(i) {
	    return function(place, status) {
	      if (iw) {
	        iw.close();
	        iw = null;
	      }
	      
	      if (status == google.maps.places.PlacesServiceStatus.OK) {
	        iw = new google.maps.InfoWindow({
	          content: getIWContent(place)
	        });
	        iw.open(map, poiMarkers[i]);        
	      }
	    }
	  }
	  
	  function getIWContent(place) {
	    var content = '';
	    content += '<table>';
	    content += '<tr class="iw_table_row">';
	    content += '<td style="text-align: right"><img class="hotelIcon" src="' + place.icon + '"/></td>';
	    content += '<td><b><a style="text-decoration:none; color:black;" href="' + place.url + '">' + place.name + '</a></b></td></tr>';
	    
	    content += '<tr class="iw_table_row"><td class="iw_attribute_name">Address:</td><td>' + place.vicinity + '</td></tr>';
	    if (place.formatted_phone_number) {
	      content += '<tr class="iw_table_row"><td class="iw_attribute_name">Telephone:</td><td>' + place.formatted_phone_number + '</td></tr>';      
	    }
	    if (place.rating) {
	      var ratingHtml = '';
	      for (var i = 0; i < 5; i++) {
	        if (place.rating < (i + 0.5)) {
	          ratingHtml += '&#10025;';
	        } else {
	          ratingHtml += '&#10029;';
	        }
	      }
	      content += '<tr class="iw_table_row"><td class="iw_attribute_name">Rating:</td><td><span id="rating">' + ratingHtml + '</span></td></tr>';
	    }
	    if (place.website) {
	      var fullUrl = place.website;
	      var website = hostnameRegexp.exec(place.website);
	      if (website == null) { 
	        website = 'http://' + place.website + '/';
	        fullUrl = website;
	      }
	      content += '<tr class="iw_table_row"><td class="iw_attribute_name">Website:</td><td><a href="' + fullUrl + '">' + website + '</a></td></tr>';
	    }
	    content += '</table>';
	    return content;
	  }
	  google.maps.event.addDomListener(window, 'load', initialize);
	      
	      /* W6 - HISTORICAL ANALYSIS WIDGET JAVASCRIPTS */
	      google.load('visualization', '1', {packages: ['motionchart']});
	      google.load('visualization', '1', { packages: ['table'] });
	      google.load("visualization", "1", {packages:["corechart"]});

	      
	      function drawVisualization() {
	          var state = 'Johor';  
	             if (document.getElementById('state').value) {
	               state = document.getElementById('state').value;
	             }
	           var query = "SELECT 'name','2006','2007','2008','2009','2010','2011','2012','2013','Risk Factor' " +
	             "FROM 1n6YmqLeeb7eXX0TqV2riidchOQ7nV-S2WIB8xfg where 'name'='"+ state + "'";
	             var queryText = encodeURIComponent(query);
	             var gvizQuery = new google.visualization.Query(
	                 'http://www.google.com/fusiontables/gvizdata?tq=' + queryText);
	             gvizQuery.send(function(response) {
	                 var numRows = response.getDataTable().getNumberOfRows();
	                 var data = new google.visualization.DataTable();
	                 data.addColumn('string', 'name');
	                 data.addColumn('date', 'Date');
	                 data.addColumn('number', 'Flood Risk');
	                 data.addColumn('number', 'Fire Risk');
	                 data.addColumn('number', 'Earthquake Risk');
	                 data.addColumn('number', 'Total Risk');
	                 
	                 var array = new Array(4);
	            for (var j = 0; j < 4; j++) {
	              array[j] = new Array(8);
	            }
	                 
	                 for (var i = 0; i < numRows; i++) {
	              var name = response.getDataTable().getValue(i,0); 
	              var riskType = response.getDataTable().getValue(i,9);
	                  
	              if(riskType=="Flood"){
	                for(var k=0;k<8;k++){
	                  array[0][k] = response.getDataTable().getValue(i,k+1);
	                }
	              }
	              if(riskType=="Fire"){
	                for(var k=0;k<8;k++){
	                  array[1][k] = response.getDataTable().getValue(i,k+1);
	                }
	              }
	              if(riskType=="Earthquake"){
	                for(var k=0;k<8;k++){
	                  array[2][k] = response.getDataTable().getValue(i,k+1);
	                }
	              }
	              if(riskType=="Total"){
	                for(var k=0;k<8;k++){
	                  array[3][k] = response.getDataTable().getValue(i,k+1);
	                }
	              }
	                 }  
	            data.addRows([
	                     [name, new Date(2006,11,31), array[0][0],array[1][0],array[2][0],array[3][0]],
	                     [name, new Date(2007,11,31), array[0][1],array[1][1],array[2][1],array[3][1]],
	                     [name, new Date(2008,11,31), array[0][2],array[1][2],array[2][2],array[3][2]],
	                     [name, new Date(2009,11,31), array[0][3],array[1][3],array[2][3],array[3][3]],
	                     [name, new Date(2010,11,31), array[0][4],array[1][4],array[2][4],array[3][4]],
	                     [name, new Date(2011,11,31), array[0][5],array[1][5],array[2][5],array[3][5]],
	                     [name, new Date(2012,11,31), array[0][6],array[1][6],array[2][6],array[3][6]],
	                     [name, new Date(2013,11,31), array[0][7],array[1][7],array[2][7],array[3][7]],
	             ]);  
	              var options = {};
	              options['state'] =
	              '{"yZoomedIn":false,"xLambda":1,"colorOption":"2","xZoomedIn":false,' +
	            	  '"xZoomedDataMax":1388448000000,"showTrails":true,"sizeOption":"2",' +
	            	  '"yAxisOption":"2","uniColorForNonSelected":false,' +
	            	  '"yZoomedDataMax":93.29,"orderedByX":false,"iconType":"BUBBLE",' +
	            	  '"xAxisOption":"_TIME","nonSelectedAlpha":0.4,"yZoomedDataMin":6.45,' +
	            	  '"dimensions":{"iconDimensions":["dim0"]},"yLambda":1,' +
	            	  '"iconKeySettings":[],"xZoomedDataMin":1167523200000,' +
	            	  '"playDuration":15000,"time":"2006-12-31","orderedByY":false,' +
	            	  '"duration":{"timeUnit":"D","multiplier":1}}';

      	          options['width'] = 800;
	              options['height'] = 400;
	              //chart.draw(data, options);	
	              var motionchart = new google.visualization.MotionChart(
	                      document.getElementById('visualization'));
	                  motionchart.draw(data,options );
	               });
	             
	        }
	      
	      google.setOnLoadCallback(drawVisualization);
	       /* W6 - END OF HISTORICAL ANALYSIS WIDGET JAVASCRIPTS */

	//SLIDER SCRIPT      
	$("#slideBuildingHeight").slider({});
	$("#slideBuildingHeight").on('slide', function(slideEvt) {
		var sliderValue = document.getElementById('slideBuildingHeight').value;
		var sepIndex = sliderValue.indexOf(",")
		document.getElementById('minHeight').value = sliderValue.substring(0,sepIndex);
		document.getElementById('maxHeight').value = sliderValue.substring(sepIndex+1, sliderValue.length);
	});
	
	$("#slideYearBuilt").slider({});
	$("#slideYearBuilt").on('slide', function(slideEvt) {
		var sliderValue = document.getElementById('slideYearBuilt').value;
		var sepIndex = sliderValue.indexOf(",")
		document.getElementById('minYearBuilt').value = sliderValue.substring(0,sepIndex);
		document.getElementById('maxYearBuilt').value = sliderValue.substring(sepIndex+1, sliderValue.length);
	});
	
	$("#slideCapacity").slider({});
	$("#slideCapacity").on('slide', function(slideEvt) {
		var sliderValue = document.getElementById('slideCapacity').value;
		var sepIndex = sliderValue.indexOf(",")
		document.getElementById('minCapacity').value = sliderValue.substring(0,sepIndex);
		document.getElementById('maxCapacity').value = sliderValue.substring(sepIndex+1, sliderValue.length);
	});
	
	$("#slidePremium").slider({});
	$("#slidePremium").on('slide', function(slideEvt) {
		var sliderValue = document.getElementById('slidePremium').value;
		var sepIndex = sliderValue.indexOf(",")
		document.getElementById('minPremium').value = sliderValue.substring(0,sepIndex);
		document.getElementById('maxPremium').value = sliderValue.substring(sepIndex+1, sliderValue.length);
	});
	 
	
	$("#slidePropertyCoverageLimit").slider({});
	$("#slidePropertyCoverageLimit").on('slide', function(slideEvt) {
		var sliderValue = document.getElementById('slidePropertyCoverageLimit').value;
		var sepIndex = sliderValue.indexOf(",")
		document.getElementById('minPropertyCoverageLimit').value = sliderValue.substring(0,sepIndex);
		document.getElementById('maxPropertyCoverageLimit').value = sliderValue.substring(sepIndex+1, sliderValue.length);
	});
	
	$("#slideLossCoverageLimit").slider({});
	$("#slideLossCoverageLimit").on('slide', function(slideEvt) {
		var sliderValue = document.getElementById('slideLossCoverageLimit').value;
		var sepIndex = sliderValue.indexOf(",")
		document.getElementById('minLossCoverageLimit').value = sliderValue.substring(0,sepIndex);
		document.getElementById('maxLossCoverageLimit').value = sliderValue.substring(sepIndex+1, sliderValue.length);
	});
	

	function displaySelectedPOI(selected) {
	      document.getElementById('selectedPOI').innerHTML = ('<h5><font color="black">Selected point: </font><br /><b><u>' + selected.name + '</b></u></h5>');
	  }
	
	//Risk Calculation Functionalities
			 function displaySelectedRisk(selected) {
		      document.getElementById('selectedRisk').innerHTML = ('<h5><font color="black"> Selected point: </font><b><u>' + selected.name + '</b></u></h5><hr />' + '<h5><font color="black">Vulnerability Index: </font><b><u>' + selected.vIndex + '</b></u></h4>' );
		      document.getElementById("fireRisk").style.visibility="visible";
		      document.getElementById("floodRisk").style.visibility="visible";
		      document.getElementById("earthquakeRisk").style.visibility="visible";
		      getRiskCalculation(selected.position.lat(),selected.position.lng());
		  }
  
      function getRiskCalculation(latitude,longitude) {
    	  document.getElementById("floodRiskValue").innerHTML = "";
    		document.getElementById("fireRiskValue").innerHTML = "";
    		document.getElementById("earthquakeRiskValue").innerHTML = "";
    		var fireRisk = "";
    		var floodRisk = "";
    		var earthquakeRisk = ""
    		//Flood Query Table
    	  var query, queryText, gvizQuery;
          query = "SELECT 'gridcode' " +
          "FROM 1TZgZZZrh7qp2aiJlVwGCIIdpZ3-CdaCJx7K85MLF "+
          "WHERE ST_INTERSECTS(geometry, CIRCLE(LATLNG( "+ latitude + ', ' + longitude + "),1))";
          queryText = encodeURIComponent(query);
          gvizQuery = new google.visualization.Query('http://www.google.com/fusiontables/gvizdata?tq=' + queryText);
          gvizQuery.send(function(response) { 
            var table = response.getDataTable();
            if (table.getNumberOfRows() != 0) {
            	  floodRisk = ((1 - table.getValue(0,0)/500) * 100).toFixed(1);
            }
            if (floodRisk != "") {
                document.getElementById("floodRiskValue").innerHTML = floodRisk + "%";
            }
            else {
            	  document.getElementById("floodRiskValue").innerHTML = 0;
                floodRisk = 0;
            }
            //Fire Query Table
            var query1, queryText1, gvizQuery1;
            query1 = "SELECT 'gridcode' " +
            "FROM 1bx6kxzPzX6_g4IJEEYmZmy4ze4xvRF_c8kUZEWp0 "+
            "WHERE ST_INTERSECTS(geometry, CIRCLE(LATLNG( "+ latitude + ', ' + longitude + "),1))";
            queryText1 = encodeURIComponent(query1);
            gvizQuery1 = new google.visualization.Query('http://www.google.com/fusiontables/gvizdata?tq=' + queryText1);
            gvizQuery1.send(function(response) {  
	              var table1 = response.getDataTable();
	              if (table1.getNumberOfRows() != 0) {
	               fireRisk = ((1 - table1.getValue(0,0)/20000) * 100).toFixed(1);
	              }
	              if (fireRisk != "") {
	            	  document.getElementById("fireRiskValue").innerHTML = fireRisk + "%";
	              }
	              else {
	            	  document.getElementById("fireRiskValue").innerHTML = 0;
	            	  fireRisk = 0;
	              }
	              earthquakeRisk = 0;
	              document.getElementById("earthquakeRiskValue").innerHTML = 0 + "%";
	              
	              displayChart(floodRisk,fireRisk,earthquakeRisk);
            });
          });
      }
      
      function displayChart(flood,fire,earthquake) {
    	  
    	  flood = parseFloat(flood);
    	  fire = parseFloat(fire);
    	  earthquake = parseFloat(earthquake);
    	  var data = google.visualization.arrayToDataTable([
	        ['Risk', 'Value'],
	        ['Flood',     flood],
	        ['Fire',      fire],
	        ['Earthquake',    earthquake]
    	  ]);
    	  var options = {
    			  chartArea:{width:"90%",height:"90%"},
    			  //pieSliceText: 'label',
    			  backgroundColor: "transparent"
    	        };
    	  var chart = new google.visualization.PieChart(document.getElementById('donut-chart'));
          chart.draw(data, options);
      }
	
    //Comparison Functionalities
    function showCompareAdd(id) {
    	  document.getElementById('comparisonTableContainer').style.display = "block";
    	  document.getElementById('noComparisonLabel').style.display= "none";
    	  document.getElementById('comparisonChart').style.display = "block";
    	  document.getElementById('compareAdd').style.display = "block";
    	  comparisonAdded.push(id);
    }

    function hideCompareAdd() {
        document.getElementById('compareAdd').style.display = "none";
    }
    
    function addComparison(name,earthquakeValue,floodValue,fireValue,id) {
    	var table = document.getElementById("comparisonTable");
    	var rowCount = table.rows.length;
      var row = table.insertRow(rowCount);
      row.id = id;
      var cell1 = row.insertCell(0);
      var cell2 = row.insertCell(1);
      var cell3 = row.insertCell(2);
      var cell4 = row.insertCell(3);
      var cell5 = row.insertCell(4);
      var cell6 = row.insertCell(5);
      cell1.innerHTML = name;
      cell2.innerHTML = earthquakeValue;
      cell3.innerHTML = floodValue;
      cell4.innerHTML = fireValue;
      cell5.innerHTML = ((parseFloat(earthquakeValue)+parseFloat(floodValue)+parseFloat(fireValue))/3).toFixed(1);
      cell6.innerHTML = '<center><button type="button" class="btn btn-default btn-xs" onclick="deleteRow('+id+','+rowCount+');colorHighest()">Delete</button></center>'
      var average = ((parseFloat(earthquakeValue)+parseFloat(floodValue)+parseFloat(fireValue))/3).toFixed(1);
      var chart = document.getElementById("comparisonChart");
			if (chart.innerHTML == ""){
				 // Create and populate the data table.
			  	  data = google.visualization.arrayToDataTable([
			  	    ['Building Name', 'Flood', 'Fire', 'Earthquake', 'Average','ID'],
			  	    [name,  parseFloat(floodValue),    parseFloat(fireValue),    parseFloat(earthquakeValue), parseFloat(average), parseFloat(id)]
			  	  ]);
			  	var view = new google.visualization.DataView(data);
			  	view.setColumns([0,1,2,3,4])
	
			  	  // Create and draw the visualization.
			        new google.visualization.BarChart(document.getElementById('comparisonChart')).draw(view,
			        		{width:550,height: 500,
			        	  chartArea: {top: 20},
	                    hAxis: {title: "Risk(%)"},
	                    vAxis: {textStyle: {fontSize: 11}},
	                      legend: { position: 'right', alignment: 'start',textStyle: {fontSize: 10} }
		                      }
			        );
			}
			else{
				
				data.addRow([name,  parseFloat(floodValue),    parseFloat(fireValue),    parseFloat(earthquakeValue), parseFloat(average), parseFloat(id)]
			  	  );
				var view = new google.visualization.DataView(data);
		        view.setColumns([0,1,2,3,4])
	
		          // Create and draw the visualization.
		        new google.visualization.BarChart(document.getElementById('comparisonChart')).draw(view,
		                  {width:550,height: 500,
		                  chartArea: {top: 20},
		                      hAxis: {title: "Risk(%)"},
		                      vAxis: {textStyle: {fontSize: 10}},
		                        legend: { position: 'right', alignment: 'start',textStyle: {fontSize: 10} }
		                          }
		              );
			}
    }
    function colorHighest() {
        var highestCell2Value = 0;
        var highestCell3Value = 0;
        var highestCell4Value = 0;
        var highestCell5Value = 0;
        var highestCell2;
        var highestCell3;
        var highestCell4;
        var highestCell5; 
        var table = document.getElementById("comparisonTable");
        var rowCount = table.rows.length;
        for (var a = 1; a < rowCount; a++) {
        	table.rows[a].cells[1].className = '';
        	var cell2 = parseFloat(table.rows[a].cells[1].innerHTML);
        	table.rows[a].cells[2].className = '';
        	var cell3 = parseFloat(table.rows[a].cells[2].innerHTML);
        	table.rows[a].cells[3].className = '';
        	var cell4 = parseFloat(table.rows[a].cells[3].innerHTML);
        	table.rows[a].cells[4].className = '';
        	var cell5 = parseFloat(table.rows[a].cells[4].innerHTML);
        	
            if (highestCell2Value < cell2) { 
              highestCell2Value = cell2;
              highestCell2 = a;
            }
            if (highestCell3Value < cell3) { 
              highestCell3Value = cell3;
              highestCell3 = a;
            }
            if (highestCell4Value < cell4) {
              highestCell4Value = cell4;
              highestCell4 = a;
            }
            if (highestCell5Value < cell5) {
              highestCell5Value = cell5;
              highestCell5 = a;
            }
            
        }
        for (var a = 1; a < rowCount; a++) {
        	table.rows[a].cells[1].className = '';
            var cell2 = parseFloat(table.rows[a].cells[1].innerHTML);
            table.rows[a].cells[2].className = '';
            var cell3 = parseFloat(table.rows[a].cells[2].innerHTML);
            table.rows[a].cells[3].className = '';
            var cell4 = parseFloat(table.rows[a].cells[3].innerHTML);
            table.rows[a].cells[4].className = '';
            var cell5 = parseFloat(table.rows[a].cells[4].innerHTML);
            
              if (highestCell2Value == cell2) { 
            	  table.rows[a].cells[1].className = 'highestValue';
              }
              if (highestCell3Value == cell3) { 
            	  table.rows[a].cells[2].className = 'highestValue';
              }
              if (highestCell4Value == cell4) {
            	  table.rows[a].cells[3].className = 'highestValue';
              }
              if (highestCell5Value == cell5) {
                table.rows[a].cells[4].className = 'highestValue';
              }
        }
      }
    
    function deleteRow(rowid)  
    {   
        var row = document.getElementById(rowid);
        row.parentNode.removeChild(row);
        var remove = comparisonAdded.indexOf(rowid);
        comparisonAdded.splice(remove,1);
        var dtRows = data.getNumberOfRows();
        for (var a = 0; a < dtRows; a++) {
        	var dtId = data.getValue(a,5);
        	if (rowid == dtId) {
        		data.removeRow(a);
        		break;
        	}
        }
        var view = new google.visualization.DataView(data);
        view.setColumns([0,1,2,3,4])

        // Create and draw the visualization.
          new google.visualization.BarChart(document.getElementById('comparisonChart')).draw(view,
                      {width:550,height: 500,
                      chartArea: {top: 20},
                          hAxis: {title: "Risk(%)"},
                          vAxis: {textStyle: {fontSize: 10}},
                            legend: { position: 'right', alignment: 'start',textStyle: {fontSize: 10} }
                              }
                  );
        if (comparisonAdded.length == 0) {
        	document.getElementById('comparisonTableContainer').style.display = "none";
            document.getElementById('noComparisonLabel').style.display= "block";
            document.getElementById('comparisonChart').style.display = "none";
        }
    }
    
   //Simulation Functionalities
    function startSimulation()  {
    	var simulationCenter = new google.maps.LatLng(3.139003,101.686855);  
        var myLatlng2;
        var mapCenter = map.getCenter();

        if(dragged == true){
        	mapCenter = dragMarker.position;
        }
        map.setCenter(simulationCenter);
        map.setZoom(9);
    	  if(customCircle!=null){
    		  customCircle.setMap(null);
    	  }
    	  if(dragMarker!=null){
    		  dragMarker.setMap(null);
    	  }
    	  var radius = simulationRadius;
    	  //ICON NEEDS TO BE CHANGED FOR DRAG MARKER
    	  dragMarker = new google.maps.Marker({
              position: simulationCenter,
              title: 'Location',
              map: map,
              draggable: true
          });
          

    	  customCircle = new google.maps.Circle({
              map: map,
              clickable: false,
              // metres
              radius: radius,              
              strokeColor: '#FF0000',
  		      strokeOpacity: 0.8,
  		      strokeWeight: 2,
  		      fillColor: '#FF0000',
  		      fillOpacity: 0.35,
          });
         // attach circle to marker
         customCircle.bindTo('center', dragMarker, 'position');

         var bounds = customCircle.getBounds();
         
         google.maps.event.addListener(dragMarker, 'dragend', function() {
        	 document.getElementById("buildingLabel").innerHTML = "<hr /># of Buildings affected within the simulation area:";
           document.getElementById("riskLabel").innerHTML = "<hr />Risk level within the simulation area:";
        	 myLatlng2 = new google.maps.LatLng(dragMarker.position.lat(), dragMarker.position.lng());
             var count1=0;
             for(var i=0;i<mapMarkers.length;i++){
            	 var distance1 = google.maps.geometry.spherical.computeDistanceBetween(myLatlng2, mapMarkers[i].position);
         	 	if(distance1<=radius){
         	 		count1++;
         	 	}
             }	 
			 
             var buildingStr = "";
             
             if(count1==0){
            	 document.getElementById("buildingsAffected").innerHTML = "No buildings affected";
             }else if(count1==1){
            	 document.getElementById("buildingsAffected").innerHTML = "1 building affected";
             }else{
            	 document.getElementById("buildingsAffected").innerHTML = "" + count1 + " buildings affected";
             }
                          
             var query, queryText, gvizQuery;
             query = "SELECT 'gridcode' " +
             "FROM 1TZgZZZrh7qp2aiJlVwGCIIdpZ3-CdaCJx7K85MLF "+
             "WHERE ST_INTERSECTS(geometry, CIRCLE(LATLNG( "+ myLatlng2.lat() + ', ' + myLatlng2.lng() + ")," + radius + "))";
             queryText = encodeURIComponent(query);
             gvizQuery = new google.visualization.Query(
                 'http://www.google.com/fusiontables/gvizdata?tq=' + queryText);
             gvizQuery.send(function(response) {	
               var table = response.getDataTable();
               var riskIndex = 0;
               for(var i=0;i<table.getNumberOfRows();i++){
            	   riskIndex += table.getValue(i,0);
               }
               riskIndex = riskIndex/table.getNumberOfRows();
               riskIndex = (1 - riskIndex/500)*100;
               if (riskIndex > 0) {
            	   document.getElementById("averageFlood").innerHTML = "Flood: " + riskIndex.toFixed(1) + "% ";
               }
               else {
            	   document.getElementById("averageFlood").innerHTML = "Flood: " + 0 + "% ";
               }
               
               //var floodRisk = (1 - table.getValue(0,0)/500) * 100;
               //document.getElementById("flood-risk").innerHTML = floodRisk.toFixed(2) + "%";  
               var query1, queryText1, gvizQuery1;
               query1 = "SELECT 'gridcode' " +
               "FROM 1bx6kxzPzX6_g4IJEEYmZmy4ze4xvRF_c8kUZEWp0 "+
               "WHERE ST_INTERSECTS(geometry, CIRCLE(LATLNG(" + myLatlng2.lat() + ", " + myLatlng2.lng() + ")," + radius + "))";
               queryText1 = encodeURIComponent(query1);
               gvizQuery1 = new google.visualization.Query(
                   'http://www.google.com/fusiontables/gvizdata?tq=' + queryText1);
               gvizQuery1.send(function(response) {	
                 var table1 = response.getDataTable();
                 var riskIndex = 0;
                 for(var i=0;i<table1.getNumberOfRows();i++){
              	   riskIndex += table1.getValue(i,0);
                 }
                 riskIndex = riskIndex/table1.getNumberOfRows();
                 riskIndex = (1 - riskIndex/20000)*100;
                 if (riskIndex > 0) {
                	 document.getElementById("averageFire").innerHTML = "Fire: " + riskIndex.toFixed(1) + "% ";
                 }
                 else {
                	 document.getElementById("averageFire").innerHTML = "Fire: " + 0 + "% ";
                 }
                 document.getElementById("averageEarthquake").innerHTML = "Earthquake: " + 0 + "% ";
               });
             
             });

  
         });
         
         dragged = true;
      }
    
    function changeSimulationState() {
    	var simButton = document.getElementById("simulationButton");
    	if (simButton.value == "Start Simulation") {
    		$( "#simulationText" ).show();
    		$( "#simulationSlider" ).show();
    		$( "#simulationSlide" ).show();
    		$("#simulationSlide").slider({tooltip: 'always'});
    		simButton.value = "End Simulation";
    		simButton.className = "btn btn-danger";
	      document.getElementById("simulationInstructions").innerHTML = "<b>Drag the created simulation marker to simulate.</b>";
	   		startSimulation();
    	}
    	else {
    		$( "#simulationSlider" ).hide();
    		simButton.value = "Start Simulation";
    		simButton.className = "btn btn-success";
    		dragMarker.setMap(null);
    		customCircle.setMap(null);
    		document.getElementById("averageFire").innerHTML = "";
    		document.getElementById("averageFlood").innerHTML = "";
    		document.getElementById("buildingsAffected").innerHTML = "";
    		document.getElementById("buildingLabel").innerHTML = "";
        document.getElementById("riskLabel").innerHTML = "";
    		document.getElementById("simulationInstructions").innerHTML = "";
    		document.getElementById("averageEarthquake").innerHTML = "";
    	}
    }
    
    function AutoCenter() {
        var bounds = new google.maps.LatLngBounds();
        $.each(mapMarkers, function (index, marker) {
          bounds.extend(marker.position);
        });
        map.fitBounds(bounds);
      }

</script>


</body>
</html>
