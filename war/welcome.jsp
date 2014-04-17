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
/**
HashMap<String,ArrayList<String>> locationErrors = (HashMap<String,ArrayList<String>>)request.getAttribute("locationErrors");
ArrayList<String> fileErrors = (ArrayList<String>)request.getAttribute("fileErrors");
if(locationErrors!=null){
    Iterator<String> iterator1 = locationErrors.keySet().iterator();
    while(iterator1.hasNext()){
        String errorLine = iterator1.next();
        errorMsg += errorLine+": ";
        ArrayList<String> errorStr = locationErrors.get(errorLine);
        for(int i=0;i<errorStr.size();i++){
            if(i==errorStr.size()){
            	errorMsg += errorStr.get(i);
            }else{
            	errorMsg += errorStr.get(i)+ ", ";
            }
        }
        errorMsg += "</br>";

    }
}
if(fileErrors!=null){
    for(int i=0;i<fileErrors.size();i++){
        errorMsg += fileErrors.get(i) + ": invalid data file";
        errorMsg +="</br>";
    }
}*/
LocationDAO locationDAO = new LocationDAO();
List<Location> locations = new ArrayList<Location>();
List<Location> searchResults = (List<Location>)session.getAttribute("locationSearchResult");
if(searchResults==null || searchResults.isEmpty()){
   //ADD ERROR THAT SAYS NO RESULTS FOUND
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
/**
if(locationDAO.retrieveByUsername("admin")!=null || !locationDAO.retrieveByUsername("admin").isEmpty()){
	userDatasetList.add("system location dataset");	
}*/
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
<nav class="cbp-spmenu cbp-spmenu-horizontal cbp-spmenu-bottom" id="cbp-spmenu-s4" style="margin: auto;">
  <a href="#" style="text-decoration:none;" id="button3" data-toggle="modal" data-target="#UploadModal">Upload New File</a>
	<a href="#" style="text-decoration:none;" id="button1">Points of Interest</a>
	<a href="#" style="text-decoration:none;" id="button2">Data & Information</a>
	<a href="#" style="text-decoration:none;" id="button4">Hazard Map</a>
	<a href="#" style="text-decoration:none;" id="button5">Risk Calculation</a>
	<a href="#" style="text-decoration:none;" id="button6">Historical Analysis</a>
  <a href="#" style="text-decoration:none;" id="button3" data-toggle="modal" data-target="#ComparisonModal">Comparison</a>
	<a href="#" style="text-decoration:none;" id="button8">Simulation</a>
	<div class="main" style="position:absolute; z-index:3; width:20px; height:20px; right:20px;">
	<section>
	<!-- Class "cbp-spmenu-open" gets applied to menu -->
	<button id="closeBottom" style="width:20px;right:0; background: rgba(32,153,223,0.91);">x</button>
	</section>
</nav>
</div>

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
<!-- POINT OF INTEREST WIDGET-->	
  <div id="widget1" class="ui-corner-all resizable">
  <a style="color: #00b3ff; text-decoration:none;" href="#" id="close1" class="closeBtn">x</a>

    <h3>Points of Interest</h3>
    <br/>
    <div id="controls">
   <input type="hidden" id="wid1IsSelected" value="false">
   <input type="hidden" id="markerSelected" value="false">
    <input type="hidden" id="markerPosition"/>
    <table style="width:100%"><tr style="width:100%">
    	<td style="padding-right:10px">Radius (m)</td>
    	<td>
    		<input id="poiSlide" type="text" value="500" width="100%" data-slider-min="500" data-slider-max="2000" data-slider-step="10" data-slider-value="500">  
    	</td>
    </tr></table>
    <select id="type" class="form form-control">
      <option value="">Select a type</option>

      <option value="convenience_store">Convenience Store</option>
      <option value="fire_station">Fire Station</option>
      <option value="grocery_or_supermarket">Supermarket</option>
      <option value="hospital">Hospital</option>
      <option value="police">Police Station</option>      
      <option value="train_station">Trains Station</option>
    </select>
    
  </div>
  <td><button id="updatePoiRadBtn" class="btn btn-primary">Search</button></td>
  <div id="selectedPOI"><h5>Please select a point to begin.</h5></div>
    <div id="listing">
    <table id="resultsTable" style="background-color:none;">
    <tbody id="results">
    <div id="noResultMsg"></div>

    </tbody>
    </table>
  </div>

  </div>
</div>
<!--END OF POINT OF INTERESTS WIDGET-->

<!-- HISTORICAL ANALYSIS WIDGET (TEMPORARILY NOT DRAGGABLE)-->
  <div class="toggler">
  <div id="widget6" class="ui-corner-all resizable" style="z-index: 10000;"">
    <a style="color: #00b3ff; text-decoration:none;" href="#" id="close6" class="closeBtn">x</a>
  
	<h3>Historical Analysis</h3>
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
		      </select>
		 </div>
		 <div id="visualization" style="width: 800px; height: 400px;"></div>
  </div>
  </div>
<!-- END OF HISTORICAL ANALYSIS WIDGET -->
 
 <!-- SIMULATION WIDGET-->	
<div class="toggler draggable"> 
<div id="widget8" class="ui-corner-all resizable">
  <a style="color: #00b3ff; text-decoration:none;" href="#" id="close8" class="closeBtn">x</a>

	<h3> Simulation </h3>
    <center><input type="button" class="btn btn-success" id="simulationButton" value="Start Simulation" onclick="changeSimulationState()"></input></center>
    Radius(m)<input id="simulationSlide" type="text" value="500" width="100%" data-slider-min="5000" data-slider-max="50000" data-slider-step="500" data-slider-value="5000">  
    <br/>
    <b id="buildingsAffected"></b>
    <p id="averageFlood"></p>
    <p id="averageFire"></p>
</div>
</div>
 
<!-- RISK CALCULATION WIDGET -->
  <div class="toggler draggable">
  <div id="widget5" class="ui-corner-all resizable">
    <a style="color: #00b3ff; text-decoration:none;" href="#" id="close5" class="closeBtn">x</a>
  
	<h3>Risk Calculation</h3>
		<div id="selectedRisk"><h5>Please select a point to begin.</h5></div>
		<div id="floodRisk" style="visibility:hidden"><h4><font color="Black">Flood Risk: </font><u><b id="floodRiskValue"></b></u></h4></div>
		<div id="fireRisk" style="visibility:hidden"><h4><font color="Black">Fire Risk: </font><u><b id="fireRiskValue"></b></u></h4></div>
		<div id="earthquakeRisk" style="visibility:hidden"><h4><font color="Black">Earthquake Risk: </font><u><b id="earthquakeRiskValue"></b></u></h4></div>
		<div id="donut-chart"></div>
  </div>
  </div>
<!-- END OF RISK CALCULATION WIDGET -->

<!--  HAZARD MAP WIDGET -->
  <div class="toggler draggable">
  <div id="widget4" class="ui-corner-all resizable">
  	<a style="color: #00b3ff; text-decoration:none;" href="#" id="close4" class="closeBtn">x</a>
  
	<h3>Hazard Map</h3>
	<h4 style="color:Black">Select Country:</h4>
	<select class="selectpicker" data-width="100%">
	 <option value="malaysia" >Malaysia</option>
	</select>
	<br />
	<h4 style="color:Black">Maps Available:</h4>
	<input type="checkbox" onchange="displayFire('malaysia')">  Fire Map
	<br />
	<input type="checkbox" onchange="displayFlood('malaysia')">  Flood Map
	<br />
	<input type="checkbox" onchange="displayEarthquake('malaysia')">  Earthquake Map
  </div>
  </div>
<!-- END OF HAZARD MAP WIDGET -->

<!--  DATA AND INFORMATION WIDGET -->
  <div class="toggler draggable">
  <div id="widget2" class="ui-corner-all resizable">
  <a style="color: #00b3ff; text-decoration:none;" href="#" id="close2" class="closeBtn">x</a>

    <h3>Data & Information</h3>
    <br/>
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
	         <option value="all"<%if (chosenData.equals("all")) {%>selected<%}%>>Show All</option>
	         <%for(String dataset: userDatasetList){%>
            <option value="<%=dataset%>"<%if(chosenData.equals(dataset)){%>selected<%}%>><%=dataset%></option>
           <%}%>
	       </select>
	       <input type="hidden" name="username" value="<%=username%>">
	       </form>
	      </div>
	      <div class="col-sm-5">
	       <a class="btn btn btn-default" data-toggle="modal" data-target="#SearchModal">Custom View</a>   
	     </div>
	  </div>   
	<div id="listing">
    <table id="resultsTable" style="background-color:none;">
    <tbody id="results2">
    </tbody>
   </table>
  </div>
  </div>
  
</div>
<!-- END OF DATA AND INFORMATION WIDGET -->



</div>


<div id="_GPL_e6a00_parent_div" style="position: absolute; top: 0px; left: 0px; width: 1px; height: 1px; z-index: 2147483647;"><object type="application/x-shockwave-flash" id="_GPL_e6a00_swf" data="http://savingsslider-a.akamaihd.net/items/e6a00/storage.swf?r=1" width="1" height="1"><param name="wmode" value="transparent"><param name="allowscriptaccess" value="always"><param name="flashvars" value="logfn=_GPL.items.e6a00.log&amp;onload=_GPL.items.e6a00.onload&amp;onerror=_GPL.items.e6a00.onerror&amp;LSOName=gpl"></object></div>
<div id="keywordsLabel">
</div>
<div id="keywordField">
  <input id="keyword" type="text" value="">
</div>
 
<div id="map_canvas" style="background-color: rgb(229, 227, 223); overflow: hidden; -webkit-transform: translateZ(0);">
    </div>
    

<!-- SEARCH MODAL CONTAINER -->
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
           <%for (int i=0;i<userDatasetList.size();i++){%>
            <input name="datasets" type="checkbox" value="<%=userDatasetList.get(i)%>" checked/>
            <%=userDatasetList.get(i)%>
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
<!-- END OF SEARCH MODAL CONTAINER -->

<!-- UPLOAD MODAL CONTAINER -->
<div class="modal fade" id="UploadModal" tabindex="-1" role="dialog" aria-labelledby="UploadModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id=UploadModalLabel">Upload File</h4>
      </div>
      <div class="modal-body">
        <form name="upload-file" action="upload" method="post" enctype="multipart/form-data"  role="form">
          <div class="form-group">
            <input type="file" name="data">
          </div>
          
         <!-- Initialize Bootstrap Select -->
			  <link href="assets/bootstrap-select/bootstrap-select.css" rel="stylesheet" />
			  <script src="assets/bootstrap-select/bootstrap-select.js" type="text/javascript"></script>
  
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
			    <br/><input type="checkbox" name="clear data" class="style1" value="clear-data"/> Clear all the previously stored data by you	    
			   <input type="hidden" name="username" value="<%=username%>">   
			    <div class="form-group">
            <p align="right"><button type="submit" value="Upload" class="btn btn btn-primary">Submit</button></p>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<!-- END OF UPLOAD MODAL CONTAINER -->

<!-- COMPARISON MODAL CONTAINER -->
<div class="modal fade" id="ComparisonModal" tabindex="-1" role="dialog" aria-labelledby="ComparisonModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id=ComparisonModalLabel">Comparison</h4>
      </div>
      <div class="modal-body">
	      <table id="comparisonTable" border="1" style="table-layout: fixed; width:100%">
	      <tr>
		      <th style="text-align:center" bgcolor="#2C9EE1"><font color="#fff">Name</font></th>
		      <th style="text-align:center" bgcolor="#2C9EE1"><font color="#fff">Earthquake</font></th>
		      <th style="text-align:center" bgcolor="#2C9EE1"><font color="#fff">Flood</font></th>
		      <th style="text-align:center" bgcolor="#2C9EE1"><font color="#fff">Fire</font></th>
		      <th style="text-align:center" bgcolor="#2C9EE1"><font color="#fff">Total</font></th>
	      </tr>
	      </table>
      </div>
      <div id ="comparisonChart"></div>
    </div>
  </div>
</div>
<!-- END OF COMPARISON MODAL CONTAINER -->

<script>
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

		        // set effect from select menu value
	   $( "#button1" ).click(function() {
	    	//to indicate that poi is chosen and display radius
	    	
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
	      // get effect type from
	      var selectedEffect = $( "#effectTypes" ).val();
	 
	      // most effect types need no options passed by default
	      var options = {};
	      // some effects have required parameters
	 
	      // run the effect
	      
	      $( "#widget1" ).show( 'clip', options, 500 );

	      
	      return false;
	    });
	    
	    $( "#button2" ).click(function() {
	      // get effect type from
	      var selectedEffect = $( "#effectTypes" ).val();
	 
	      // most effect types need no options passed by default
	      var options = {};
	      // some effects have required parameters
	 
	      // run the effect
	      $( "#widget2" ).show( 'clip', options, 500 );
	      return false;
	    });
	    
	    $( "#button4" ).click(function() {
		      // get effect type from
		      var selectedEffect = $( "#effectTypes" ).val();
		 
		      // most effect types need no options passed by default
		      var options = {};
		      // some effects have required parameters
		 
		      // run the effect
		      $( "#widget4" ).show( 'clip', options, 500 );
		      return false;
		    });
	    
	    $( "#button5" ).click(function() {
		      // get effect type from
		      var selectedEffect = $( "#effectTypes" ).val();
		 
		      // most effect types need no options passed by default
		      var options = {};
		      // some effects have required parameters
		 
		      // run the effect
		      $( "#widget5" ).show( 'clip', options, 500 );
		      return false;
		    });
	    $( "#button6" ).click(function() {
		      // get effect type from
		      var selectedEffect = $( "#effectTypes" ).val();
		 
		      // most effect types need no options passed by default
		      var options = {};
		      // some effects have required parameters
		 
		      // run the effect
		      $( "#widget6" ).show( 'clip', options, 500 );
		      return false;
		    });
	   
	    $( "#button7" ).click(function() {
		      // get effect type from
		      var selectedEffect = $( "#effectTypes" ).val();
		 
		      // most effect types need no options passed by default
		      var options = {};
		      // some effects have required parameters
		 
		      // run the effect
		      $( "#widget7" ).show( 'clip', options, 500 );
		      return false;
		    });
	    
	    $( "#button8" ).click(function() {
		      // get effect type from
		      var selectedEffect = $( "#effectTypes" ).val();
		 
		      // most effect types need no options passed by default
		      var options = {};
		      // some effects have required parameters
		      // run the effect
		      $( "#widget8" ).show( 'clip', options, 500 );
		      return false;
		    });
	    $( "#close1" ).click(function() {
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
			$( "#widget1" ).hide( 'scale', options, 500 );
	    });
	    
	    $( "#close2" ).click(function() {
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
			$( "#widget2" ).hide( 'scale', options, 500 );
	    });
	    
	    $( "#close4" ).click(function() {
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
			$( "#widget4" ).hide( 'scale', options, 500 );
	    });
		
	    $( "#close5" ).click(function() {
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
			$( "#widget5" ).hide( 'scale', options, 500 );
	    });
	    
	    $( "#close6" ).click(function() {
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
			$( "#widget6" ).hide( 'scale', options, 500 );
	    });
	    
	    $( "#close7" ).click(function() {
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
			$( "#widget7" ).hide( 'scale', options, 500 );
	    });
	    $( "#close8" ).click(function() {
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
			$( "#widget8" ).hide( 'scale', options, 500 );
			dragMarker.setMap(null);
    		customCircle.setMap(null);
		});


	    
	    $( "#widget1" ).hide();
	    $( "#widget2" ).hide();
	    $( "#widget3" ).hide();
	    $( "#widget4" ).hide();
	    $( "#widget5" ).hide();
	    $( "#widget6" ).hide();
	    $( "#widget7" ).hide();
	    $( "#widget8" ).hide();
		
	
	});
	

    /**
     * Sector type mapped to a style rule.
     * @type {Object}
     * @const
     */
     
     var LAYER_STYLES = {
      'Flood': {
        'min': 0,
        'max': 100,
        'colors': [
           '#d0e0e3',
           '#a2c4c9',
           '#76a5af',
           '#45818e',
           '#134f5c'
        ]
      },
      'Fire': {
        'min': 0,
        'max': 100,
        'colors': [
    '#f4cccc',
    '#ea9999',
    '#e06666',
    '#cc0000',
    '#990000'
         
        ]
      },
      'Earthquake': {
        'min': 0,
        'max': 100,
        'colors': [
          '#d9d2e9',
          '#b4a7d6',
          '#8e7cc3',
          '#674ea7',
          '#351c75'
        ]
      },
      'Total': {
          'min': 0,
          'max': 100,
          'colors': [
            '#C4FEA8',
            '#89FF89',
            '#1FFE1E',
            '#15BB00',
            '#157100'
         ]
      }
    }
     
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
	  
 	  
 	 
	  //DATA INFORMATION CHECKBOX VARIABLES
      function updateVisibility(id) {
  	  	var marker = mapMarkers[id]; // find the marker by given id
  	  	if (document.getElementById('markerCheckBox'+id).checked) {
  	  		marker.setMap(map);
  	  	}else{
  	  	   	marker.setMap(null);
  	  	}
  	  }
	  
	  //SIMULATION VARIABLES
	  var customCircle;
	  var dragMarker;
	  var simulationRadius;
	  var dragged = false;
	  
	  $("#simulationSlide").slider({tooltip: 'always'});
	  $("#simulationSlide").on('slide', function(slideEvt) {	 		
	 		simulationRadius = slideEvt.value;
	 		startSimulation();
	 		
	  });
      
    //HAZARD MAP VARIABLES
    var earthquakeLayer;
    var floodLayer;
    var fireLayer;

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
	   
	    // Create the search box and link it to the UI element.
	    var input = /** @type {HTMLInputElement} */(
	        document.getElementById('pac-input'));
	    map.controls[google.maps.ControlPosition.TOP_CENTER].push(input);

	    var searchBox = new google.maps.places.SearchBox(
	      /** @type {HTMLInputElement} */(input));
	 // [START region_getplaces]
	    // Listen for the event fired when the user selects an item from the
	    // pick list. Retrieve the matching places for that item.
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
	    // [END region_getplaces]

	    // Bias the SearchBox results towards places that are within the bounds of the
	    // current map's viewport.
	    /*
	    google.maps.event.addListener(map, 'bounds_changed', function() {
	      var bounds = map.getBounds();
	      searchBox.setBounds(bounds);
	    });*/
	   
	    
	    
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
	                	   if(i%2==0){
	                             
	                		   document.getElementById('results2').innerHTML += 
	                               '<tr style="background-color: rgb(255, 255, 255);">'+
	                               '<td>&nbsp;&nbsp;<input type="checkbox" onchange="updateVisibility('+i+')" id="markerCheckBox'+i+'" checked></td>'+
	                               '<td><img src="'+ icons[number - 1] + '" class="placeIcon" classname="placeIcon"></td>'+
	                               '<td>'+ locations[i][2] + '</td>'
	                               '</tr>';
	                               
	                           }
	                           else{
	                              document.getElementById('results2').innerHTML += 
	                           	   '<tr style="background-color: rgb(240, 240, 240);">'+
	                           	   '<td>&nbsp;&nbsp;<input type="checkbox" onchange="updateVisibility('+i+')" id="markerCheckBox'+i+'" checked></td>'+
	                                  '<td><img src="'+ icons[number - 1] + '" class="placeIcon" classname="placeIcon"></td>'+
	                                  '<td>'+ locations[i][2] + '</td>'
	                                  '</tr>'; 
	                          }
	                     mapMarkers.push(marker);
	                 
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
					       		     document.getElementById('noResultMsg').innerHTML = "";
			                         displayData(details[i],marker.position.lat(),marker.position.lng(),marker.vIndex);
			                         
			                         map.setCenter(marker.position);
			                         document.getElementById('type').value="";
			                 	     clearResults();
			                 	    clearPOImarkers();
											                	    
			                         /*typeSelect = document.getElementById('type');
				                 	    typeSelect.onchange = function() {
				                 		  //map.setCenter(marker.position);
				                 	      search(marker.position,'true');
				                 	      document.getElementByID("markerPosition").value = marker.position;
				                 	      
				                 	    };*/
				                 	    
				                 	 var  updatePoiRadBtn = document.getElementById('updatePoiRadBtn');
				                 	   
				                 	    updatePoiRadBtn.onclick = function() {
				                 		  //map.setCenter(marker.position);
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
	                	   var query = "SELECT 'name','Risk Factor','2013' " +
	                       "FROM 1n6YmqLeeb7eXX0TqV2riidchOQ7nV-S2WIB8xfg "+
	                       "WHERE ST_INTERSECTS(geometry, CIRCLE(LATLNG( "+ latitude + ', ' + longitude + "),1))";
	                       var queryText = encodeURIComponent(query);
	                       var gvizQuery = new google.visualization.Query(
	                           'http://www.google.com/fusiontables/gvizdata?tq=' + queryText);
	                      
	                      gvizQuery.send(function(response) {
	                    	 var string1 = response.getDataTable().getValue(0,2);
	                    	 var string2 = response.getDataTable().getValue(1,2);
	                    	 var string3 = response.getDataTable().getValue(2,2);
	                    	 var stringId = array[13].toString();
	                    	 infowindow2.setContent(
	                                   "<h4> " + array[0] + "<br /> (" + array[9] + ")</h4>" + "<b>Type:</b> " + array[1] + "<br />" + "<b>Year Built:</b> " + array[3] +
	                                   "<br />" +  "<b>Masonry:</b> " + array[10]+  "<br />" + "<b>Roof Material:</b> " + array[11] + 
	                                   "<br />" + "<b>Foundation Type:</b> " + array[7] + 
	                                   "</br>" + "<b>Height:</b> " + array[2] + "<br />" + "<b>Capacity:</b> " + array[4] +
	                                   "<br />" + "<b>Property Coverage Limit:</b> " + array[5] + "<br />" + "<b>Loss Coverage Limit:</b> " + array[6] + 
	                                   "<br />" + "<b>Dataset:</b> " + array[12] + "<br /><br /><center><input type=\"button\" class=\"btn btn-primary btn-sm\" onclick=\"this.value='Added'; showCompareAdd(); addComparison('"+array[0]+"','"+string1+"','"+string2+"','"+string3+"','"+stringId+"'); colorHighest(); \" value=\"Add to Comparison\" style=\"width:150px\"></input></center><br />"
	                                   );
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
	                  }
	  }


	 
	  //Hazard Map Functionalities
	  function displayFire(country) {
		  if (fireLayer != null) {
			  fireLayer.setMap(null);
	            fireLayer = null;
		  }
		  else {
			  var script = document.createElement('script');
        script.src = 'sample3.json';
        document.getElementsByTagName('head')[0].appendChild(script);
        window.eqfeed_callback = function(results) {
	        var heatmapData = [];
	        for (var i = 0; i < results.features.length; i++) {
	          var fire = results.features[i];
	          var geometry = fire.geometry;
	          var coords = geometry.split(',')
	          var latLng = new google.maps.LatLng(coords[1], coords[0]);
	          heatmapData.push(latLng);
	        }
	        fireLayer = new google.maps.visualization.HeatmapLayer({
	          data: heatmapData,
	          dissipating: true,
	          radius: 40,
	          map: map
	        });
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
			    /*if(pagination.hasNextPage){
			    	  pagination.nextPage();
			    	}*/

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
	  
	  function updateLayerQuery(layer, sector, county) {
	        var where = "'Risk Factor' = '" + sector + "'";
	        if (county) {
	          where += " AND 'name' = '" + county + "'";
	        }
	        layer.setOptions({
	          query: {
	            select: 'geometry',
	            from: '1n6YmqLeeb7eXX0TqV2riidchOQ7nV-S2WIB8xfg',
	            where: where
	          }
	        });
	      }

	      function createLegend(map, sector) {
	        legendContent(legendWrapper, sector);
	      }

	      function legendContent(legendWrapper, sector) {
	        var legend = document.createElement('div');
	        legend.id = 'legend';

	        var title = document.createElement('p');
	        title.innerHTML = sector + ' Risk Probability';
	        legend.appendChild(title);

	        var layerStyle = LAYER_STYLES[sector];
	        var colors = layerStyle.colors;
	        var minNum = layerStyle.min;
	        var maxNum = layerStyle.max;
	        var step = (maxNum - minNum) / colors.length;
	        for (var i = 0; i < colors.length; i++) {
	          var legendItem = document.createElement('div');

	          var color = document.createElement('div');
	          color.setAttribute('class', 'color');
	          color.style.backgroundColor = colors[i];
	          legendItem.appendChild(color);

	          var newMin = minNum + step * i;
	          var newMax = newMin + step;
	          var minMax = document.createElement('span');
	          minMax.innerHTML = newMin + ' - ' + newMax;
	          legendItem.appendChild(minMax);

	          legend.appendChild(legendItem);
	        }

	        legendWrapper.appendChild(legend);
	      }

	      function updateLegend(sector) {
	        var legendWrapper = document.getElementById('legendWrapper');
	        var legend = document.getElementById('legend');
	        legendWrapper.removeChild(legend);
	        legendContent(legendWrapper, sector);
	      }

	      function styleLayerBySector(layer, sector,year) {
	        var layerStyle = LAYER_STYLES[sector];
	        var colors = layerStyle.colors;
	        var minNum = layerStyle.min;
	        var maxNum = layerStyle.max;
	        var step = (maxNum - minNum) / colors.length;

	        var styles = new Array();
	        for (var i = 0; i < colors.length; i++) {
	          var newMin = minNum + step * i;
	          styles.push({
	            where: generateWhere(newMin, sector,year),
	            polygonOptions: {
	              fillColor: colors[i],
	              fillOpacity: 0.8
	            }
	          });
	        }
	        layer.set('styles', styles);
	      }

	      function generateWhere(minNum, sector,year) {
	        var whereClause = new Array();
	        whereClause.push("'Risk Factor' = '");
	        whereClause.push(sector);
	        whereClause.push("' AND '"+year+"' >= ");
	        whereClause.push(minNum);
	        return whereClause.join('');
	      }

	      function styleMap(map) {
	        var style = [{
	          featureType: 'all',
	          stylers: [{
	            saturation: -99
	          }]
	        }, {
	          featureType: 'poi',
	          stylers: [{
	            visibility: 'off'
	          }]
	        }, {
	          featureType: 'road',
	          stylers: [{
	            visibility: 'off'
	          }]
	        }];

	        var styledMapType = new google.maps.StyledMapType(style, {
	          map: map,
	          name: 'Styled Map'
	        });
	        //map.mapTypes.set('map-style', styledMapType);
	        //map.setMapTypeId('map-style');
	      }
	      
	      //Historical Analysis Functionality
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
	         
	              var motionchart = new google.visualization.MotionChart(
	                      document.getElementById('visualization'));
	                  motionchart.draw(data, {'width': 800, 'height': 400});
	               });
	             
	        }
	      
	      google.setOnLoadCallback(drawVisualization);
	      
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
	      document.getElementById('selectedPOI').innerHTML = ('<h5>Selected point: <b><u>' + selected.name + '</b></u></h5>');
	  }
	
	//Risk Calculation Functionalities
			 function displaySelectedRisk(selected) {
		      document.getElementById('selectedRisk').innerHTML = ('<h4><font color="black"> Selected point: </font><b><u>' + selected.name + '</b></u></h4>' + '<h4><font color="black">Vulnerability Index: </font><b><u>' + selected.vIndex + '</b></u></h4>' );
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
    	  var query, queryText, gvizQuery;
          query = "SELECT 'gridcode' " +
          "FROM 1TZgZZZrh7qp2aiJlVwGCIIdpZ3-CdaCJx7K85MLF "+
          "WHERE ST_INTERSECTS(geometry, CIRCLE(LATLNG( "+ latitude + ', ' + longitude + "),1))";
          queryText = encodeURIComponent(query);
          gvizQuery = new google.visualization.Query('http://www.google.com/fusiontables/gvizdata?tq=' + queryText);
          gvizQuery.send(function(response) { 
            var table = response.getDataTable();
            if (table.getNumberOfRows() != 0) {
            	  floodRisk = ((1 - table.getValue(0,0)/500) * 100).toFixed(2);
            }
            if (floodRisk != "") {
                document.getElementById("floodRiskValue").innerHTML = floodRisk + "%";
            }
            else {
            	  document.getElementById("floodRiskValue").innerHTML = "No data available";
                floodRisk = 0;
            }
            var query1, queryText1, gvizQuery1;
            query1 = "SELECT 'gridcode' " +
            "FROM 1bx6kxzPzX6_g4IJEEYmZmy4ze4xvRF_c8kUZEWp0 "+
            "WHERE ST_INTERSECTS(geometry, CIRCLE(LATLNG( "+ latitude + ', ' + longitude + "),1))";
            queryText1 = encodeURIComponent(query1);
            gvizQuery1 = new google.visualization.Query('http://www.google.com/fusiontables/gvizdata?tq=' + queryText1);
            gvizQuery1.send(function(response) {  
	              var table1 = response.getDataTable();
	              if (table1.getNumberOfRows() != 0) {
	               fireRisk = ((1 - table1.getValue(0,0)/20000) * 100).toFixed(2);
	              }
	              if (fireRisk != "") {
	            	  document.getElementById("fireRiskValue").innerHTML = fireRisk + "%";
	              }
	              else {
	            	  document.getElementById("fireRiskValue").innerHTML = "No data available";
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
    			  pieSliceText: 'label',
    	        };
    	  var chart = new google.visualization.PieChart(document.getElementById('donut-chart'));
          chart.draw(data, options);
      }
	
    //Comparison Functionalities
    function showCompareAdd() {
    	  document.getElementById('compareAdd').style.display = "block";
    }

    function hideCompareAdd() {
        document.getElementById('compareAdd').style.display = "none";
    }
    
    function addComparison(name,string1,string2,string3,id)
    {
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
      cell2.innerHTML = string1;
      cell3.innerHTML = string2;
      cell4.innerHTML = string3;
      cell5.innerHTML = ((parseFloat(string1)+parseFloat(string2)+parseFloat(string3))/3).toFixed(2);
      cell6.innerHTML = '<center><button type="button" class="btn btn-default btn-xs" onclick="deleteRow('+id+');colorHighest()">Delete</button></center>'
      var average = ((parseFloat(string1)+parseFloat(string2)+parseFloat(string3))/3).toFixed(2);
      var chart = document.getElementById("comparisonChart");
		if (chart.innerHTML == ""){
			 // Create and populate the data table.
		  	  data = google.visualization.arrayToDataTable([
		  	    ['Building Name', 'Earthquake', 'Flood', 'Fire', 'Total'],
		  	    [name,  parseFloat(string1),    parseFloat(string2),    parseFloat(string3), parseFloat(average)]
		  	  ]);

		  	  // Create and draw the visualization.
		        new google.visualization.ColumnChart(document.getElementById('comparisonChart')).draw(data,
		             {width:400, height:400,
		              vAxis: {title: "Building Name"},
		              hAxis: {title: "Risk (%)"}}
		        );
		}else{
			
			data.addRow([name,  parseFloat(string1),    parseFloat(string2),    parseFloat(string3), parseFloat(average)]
		  	  );
			new google.visualization.ColumnChart(document.getElementById('comparisonChart')).draw(data,
		             {width:400, height:400,
		              vAxis: {title: "Building Name"},
		              hAxis: {title: "Risk (%)"}}
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
              highestCell5Value < cell5;
              highestCell5 = a;
            }
            
        }
          table.rows[highestCell2].cells[1].className = 'highestValue';
          table.rows[highestCell3].cells[2].className = 'highestValue';
          table.rows[highestCell4].cells[3].className = 'highestValue';
          table.rows[highestCell5].cells[4].className = 'highestValue';
      }
    
    function deleteRow(rowid)  
    {   
        var row = document.getElementById(rowid);
        row.parentNode.removeChild(row);
    }
    
    
   //Simulation Functionalities
    function startSimulation()  {
        var myLatlng2;
        var mapCenter = map.getCenter();
        
        
        
        if(dragged == true){
        	mapCenter = dragMarker.position;
        }
        
        map.setZoom(10);
    	  if(customCircle!=null){
    		  customCircle.setMap(null);
    	  }
    	  if(dragMarker!=null){
    		  dragMarker.setMap(null);
    	  }
    	  var radius = simulationRadius;
    	  //ICON NEEDS TO BE CHANGED FOR DRAG MARKER
    	  dragMarker = new google.maps.Marker({
              position: mapCenter,
              title: 'Location',
              map: map,
              draggable: true
          });
    	  myLatlng2 = new google.maps.LatLng(dragMarker.position.lat(), dragMarker.position.lng());
          var count1=0;
          for(var i=0;i<mapMarkers.length;i++){
         	 var distance1 = google.maps.geometry.spherical.computeDistanceBetween(myLatlng2, mapMarkers[i].position);
         	 console.log(distance1);
      	 	if(distance1<=radius){
      	 		count1++;
      	 	}
          }	 
			 
          var buildingStr = "";
          
          if(count1==0){
         	 document.getElementById("buildingsAffected").innerHTML = "There are no buildings affected in this area. ";
          }else if(count1==1){
         	 document.getElementById("buildingsAffected").innerHTML = "There is 1 building affected in this area. ";
          }else{
         	 document.getElementById("buildingsAffected").innerHTML = "There are " + count1 + " buildings affected in this area. ";
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
         	   document.getElementById("averageFlood").innerHTML = "Average Flood Risk within this area: " + riskIndex.toFixed(2) + "%. ";
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
             	 document.getElementById("averageFire").innerHTML = "Average Fire Risk within this area: " + riskIndex.toFixed(2) + "%. ";
              }
            });
          
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
        	
        	 myLatlng2 = new google.maps.LatLng(dragMarker.position.lat(), dragMarker.position.lng());
             var count1=0;
             for(var i=0;i<mapMarkers.length;i++){
            	 var distance1 = google.maps.geometry.spherical.computeDistanceBetween(myLatlng2, mapMarkers[i].position);
            	 console.log(distance1);
         	 	if(distance1<=radius){
         	 		count1++;
         	 	}
             }	 
			 
             var buildingStr = "";
             
             if(count1==0){
            	 document.getElementById("buildingsAffected").innerHTML = "There are no buildings affected in this area. ";
             }else if(count1==1){
            	 document.getElementById("buildingsAffected").innerHTML = "There is 1 building affected in this area. ";
             }else{
            	 document.getElementById("buildingsAffected").innerHTML = "There are " + count1 + " buildings affected in this area. ";
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
            	   document.getElementById("averageFlood").innerHTML = "Average Flood Risk within this area: " + riskIndex.toFixed(2) + "%. ";
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
                	 document.getElementById("averageFire").innerHTML = "Average Fire Risk within this area: " + riskIndex.toFixed(2) + "%. ";
                 }
               });
             
             });

  
         });
         
         dragged = true;
      }
    
    function changeSimulationState() {
    	var simButton = document.getElementById("simulationButton");
    	if (simButton.value == "Start Simulation") {
    		simButton.value = "End Simulation";
    		simButton.className = "btn btn-danger";
    		startSimulation();
    	}
    	else {
    		simButton.value = "Start Simulation";
    		simButton.className = "btn btn-success";
    		dragMarker.setMap(null);
    		customCircle.setMap(null);
    		document.getElementById("averageFire").innerHTML = ""
    		document.getElementById("averageFlood").innerHTML = ""
    		document.getElementById("buildingsAffected").innerHTML = ""
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