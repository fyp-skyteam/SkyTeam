<div style="text-align:center">
<nav class="cbp-spmenu cbp-spmenu-horizontal cbp-spmenu-bottom" id="cbp-spmenu-s4" style="margin: auto;">
	<a href="#" style="text-decoration:none;" id="button1">Points of Interest</a>
	<a href="#" style="text-decoration:none;" id="button2">Data Information</a>
	<a href="#" style="text-decoration:none;" id="button3" data-toggle="modal" data-target="#UploadModal">Upload New File</a>
	<a href="#" style="text-decoration:none;" id="button4">Hazard Map</a>
	<a href="#" style="text-decoration:none;" id="button5">Risk Calculation</a>
	<a href="#" style="text-decoration:none;" id="button6">Historical Analysis</a>
	<div class="main" style="position:absolute; z-index:3; width:20px; height:20px; right:20px;">
	<section>
	<!-- Class "cbp-spmenu-open" gets applied to menu -->
	<button id="closeBottom" style="width:20px;right:0; background: rgba(32,153,223,0.91);">x</button>
	</section>
</nav>
</div>
<!-- test test -->

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
 <%if (errorMsg != null) {%><div class="alert alert-danger alert-dismissable" style="z-index:1; position:absolute; width:100%">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <strong>Warning! The following markers have not been uploaded due to the following errors:</strong><br /><%=errorMsg%>
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
<!-- POINT OF INTEREST WIDGET-->
	<div class="toggler draggable">
  <div id="widget1" class="ui-corner-all resizable">
  <a style="color: #00b3ff; text-decoration:none;" href="#" id="close1" class="closeBtn">x</a>

    <h3>POI</h3>
    <br/>
    <div id="controls">
    
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
    <div id="listing">
    <table id="resultsTable" style="background-color:none;">
    <tbody id="results">
      <tr style="background-color: rgb(240, 240, 240);">
        <td><img src="assets/icons/number_1.png" class="placeIcon" classname="placeIcon"></td>
        <td></td>
      </tr><tr style="background-color: rgb(255, 255, 255);">
        <td><img src="assets/icons/number_2.png" class="placeIcon" classname="placeIcon">
        </td><td></td>
      </tr><tr style="background-color: rgb(240, 240, 240);">
        <td><img src="assets/icons/number_3.png" class="placeIcon" classname="placeIcon"></td>
        <td></td>
      </tr><tr style="background-color: rgb(255, 255, 255);">
        <td><img src="assets/icons/number_4.png" class="placeIcon" classname="placeIcon"></td>
        <td></td>
      </tr><tr style="background-color: rgb(240, 240, 240);">
        <td><img src="assets/icons/number_5.png" class="placeIcon" classname="placeIcon"></td>
        <td></td>
      </tr>
      <tr style="background-color: rgb(255, 255, 255);">
        <td><img src="assets/icons/number_6.png" class="placeIcon" classname="placeIcon"></td>
        <td></td>
      </tr>
      <tr style="background-color: rgb(240, 240, 240);">
        <td><img src="assets/icons/number_7.png" class="placeIcon" classname="placeIcon"></td>
        <td></td>
      </tr>
      <tr style="background-color: rgb(255, 255, 255);">
        <td><img src="assets/icons/number_8.png" class="placeIcon" classname="placeIcon"></td>
        <td></td>
      </tr>
      <tr style="background-color: rgb(240, 240, 240);">
        <td><img src="assets/icons/number_9.png" class="placeIcon" classname="placeIcon"></td>
        <td></td>
      </tr>
      <tr style="background-color: rgb(255, 255, 255);">
        <td><img src="assets/icons/number_10.png" class="placeIcon" classname="placeIcon"></td>
        <td></td>
      </tr>
      <tr style="background-color: rgb(240, 240, 240);">
        <td><img src="assets/icons/number_11.png" class="placeIcon" classname="placeIcon"></td>
        <td></td>
      </tr><tr style="background-color: rgb(255, 255, 255);">
        <td><img src="assets/icons/number_12.png" class="placeIcon" classname="placeIcon"></td>
        <td></td>
      </tr><tr style="background-color: rgb(240, 240, 240);">
        <td><img src="assets/icons/number_13.png" class="placeIcon" classname="placeIcon"></td>
        <td></td>
      </tr><tr style="background-color: rgb(255, 255, 255);">
        <td><img src="assets/icons/number_14.png" class="placeIcon" classname="placeIcon"></td>
        <td></td>
      </tr><tr style="background-color: rgb(240, 240, 240);">
        <td><img src="assets/icons/number_15.png" class="placeIcon" classname="placeIcon"></td>
        <td></td>
      </tr><tr style="background-color: rgb(255, 255, 255);">
        <td><img src="assets/icons/number_16.png" class="placeIcon" classname="placeIcon"></td>
        <td></td>
      </tr><tr style="background-color: rgb(240, 240, 240);">
        <td><img src="assets/icons/number_17.png" class="placeIcon" classname="placeIcon"></td>
        <td></td>
      </tr><tr style="background-color: rgb(255, 255, 255);">
        <td><img src="assets/icons/number_18.png" class="placeIcon" classname="placeIcon"></td><td></td>
      </tr><tr style="background-color: rgb(240, 240, 240);"><td><img src="assets/icons/number_19.png" class="placeIcon" classname="placeIcon"></td><td></td>
      </tr><tr style="background-color: rgb(255, 255, 255);"><td><img src="assets/icons/number_20.png" class="placeIcon" classname="placeIcon"></td><td></td>
      </tr>
    </tbody>
    </table>
  </div>

  </div>
</div>
<!--END OF POINT OF INTERESTS WIDGET-->

<!-- HISTORICAL ANALYSIS WIDGET -->
  <div class="toggler draggable">
  <div id="widget6" class="ui-corner-all resizable">
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
 
<!-- RISK CALCULATION WIDGET -->
  <div class="toggler draggable">
  <div id="widget5" class="ui-corner-all resizable">
    <a style="color: #00b3ff; text-decoration:none;" href="#" id="close5" class="closeBtn">x</a>
  
	<h3>Risk Calculation</h3>
  </div>
  </div>
<!-- END OF RISK CALCULATION WIDGET -->

<!--  HAZARD MAP WIDGET -->
  <div class="toggler draggable">
  <div id="widget4" class="ui-corner-all resizable">
  	<a style="color: #00b3ff; text-decoration:none;" href="#" id="close4" class="closeBtn">x</a>
  
	<h3>Hazard Map</h3>
	<div id="legendWrapper"></div>
	<form>
      <label>Sector </label>
      <select id="sector">
        <option value="Flood">Flood</option>
        <option value="Fire">Fire</option>
        <option value="Earthquake">Earthquake</option>
        <option value="Total">Total</option>
      </select>
      <label>County</label>
      <select id="county">
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
    </form>
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
<%@include file="filterform.jsp"%>
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

<script>

for (var i = 0; i < 5; i++) {	
  var results = document.getElementById('results2');
  var tr = document.createElement('tr');
  tr.style.backgroundColor = (i% 2 == 0 ? '#F0F0F0' : '#FFFFFF');
  var iconTd = document.createElement('td');
  var nameTd = document.createElement('td');
  var icon = document.createElement('img');
  icon.src = 'assets/markers/blu-blank.png';
  icon.setAttribute('class', 'placeIcon');
  icon.setAttribute('className', 'placeIcon');
  var name = document.createTextNode("abcd");
  iconTd.appendChild(icon);
  nameTd.appendChild(name);
  tr.appendChild(iconTd);
  tr.appendChild(nameTd);
  results.appendChild(tr);
}
</script>
<%@include file="bodyscript.jsp"%>
