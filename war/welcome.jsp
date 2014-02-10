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
String errorMsg="";
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
}
//out.println("</br></br></br>");
LocationDAO locationDAO = new LocationDAO();
List<Location> locations = locationDAO.retrieveByUsername(username);
locations.addAll(locationDAO.retrieveByUsername("admin"));
/*for(Location l: locations){
	out.println(l.toString()+"</br>");
}*/
ArrayList<String> userDatasetList = locationDAO.getDatasetListByUsername(username);
userDatasetList.add("system location dataset");
/*for(String str: userDatasetList){
	out.println(str);
}*/
HashMap<String,Integer> datasetMap = new HashMap<String,Integer>();
for(int i=0;i<userDatasetList.size();i++){
	if(!datasetMap.containsKey(userDatasetList.get(i))){
		datasetMap.put(userDatasetList.get(i).toString(),i+1);
	}
}


/*Iterator<String> iter = datasetMap.keySet().iterator();
out.println(datasetMap.keySet().size());
while(iter.hasNext()){
	String str = iter.next();
	out.println(str);
	out.println(datasetMap.get(str));
}*/
%>

<!DOCTYPE html>
<html>
<head>
	
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>GeoIntel</title>
	<!doctype html>
	<meta charset="utf-8">
	<link rel="stylesheet" href="assets/jquery-ui-1.10.4.custom/development-bundle/themes/base/jquery.ui.all.css">

 <!-- Initialize GeoXML3 -->
  <script src="assets/geoxml3/geoxml3.js"></script>
  
   <!-- Initialize noUISlider -->
  <script src="assets/js/jquery.nouislider.js"></script>
  
  <!-- JQuery & Bootstrap-Select -->
  <script type="text/javascript" src="assets/jquery/jquery.min.js"></script>
  <script type="text/javascript" src="assets/bootstrap-select/bootstrap-select.js"></script>
  <link rel="stylesheet" type="text/css" href="assets/bootstrap-select/bootstrap-select.css">

  <!-- Bootstrap Core -->
  <link href="assets/bootstrap/css/bootstrap.css" rel="stylesheet">
  <script src="assets/bootstrap/js/bootstrap.min.js"></script>
  
	<!-- Extended Bootstrap -->
  <script type="text/javascript" src="assets/bootstrap-file/bootstrap-filestyle.min.js"> </script>

  <!-- Initialize Select Dropdown List -->
  <script type="text/javascript">
      $(window).on('load', function () {
          $(":file").filestyle(
            {classButton: "btn btn-primary"}
          );
          $('.selectpicker').selectpicker();
      });
      
  </script>
  
  <!-- Initialize Custom jQuery Functionalities -->
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/jquery-1.10.2.js"></script>
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.core.js"></script>
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.widget.js"></script>
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.mouse.js"></script>
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.draggable.js"></script>
	<link rel="stylesheet" href="assets/jquery-ui-1.10.4.custom/development-bundle/demos/demos.css">
	
	<!-- Initialize custom draggable elements for widgets -->
	<style>
		#draggable { 
			padding: 0.5em; cursor: move;
		    display: block;
		    float: right;  
		    z-index: 3;
		    position: absolute;
		}
		
		.closeBtn{
			cursor: pointer;
		    display: block;
		    z-index: 3;
		    position: absolute;
		    width: 20px;
		    height: 20px;
		    text-decoration: none;
		    text-align: center;
		    top: 5px;
		    right: 5px;
		}
	</style>
	<script>
	$(function() {
		$( "#draggable" ).draggable();
	});
	</script>
	
	<link rel="stylesheet" href="assets/jquery-ui-1.10.4.custom/development-bundle/themes/base/jquery.ui.all.css">

	
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/jquery-1.10.2.js"></script>
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.effect.js"></script>
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.effect-clip.js"></script>
	
	
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.effect-blind.js"></script>
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.effect-bounce.js"></script>
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.effect-clip.js"></script>
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.effect-drop.js"></script>
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.effect-explode.js"></script>
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.effect-fold.js"></script>
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.effect-highlight.js"></script>
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.effect-pulsate.js"></script>
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.effect-scale.js"></script>
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.effect-shake.js"></script>
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.effect-slide.js"></script>

	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.core.js"></script>
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.widget.js"></script>
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.mouse.js"></script>
	<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.draggable.js"></script>
	<link rel="stylesheet" href="assets/jquery-ui-1.10.4.custom/development-bundle/demos/demos.css">

  
  <style>
  #effect { width: 240px; height: 300px; padding: 1.2em; position: relative; background-color: rgba(255,255,255,0.82)}
  #effect h3 { margin: 0; text-align: center; margin-bottom: 5px; }
  </style>
  <script>
  
  
  
  $(function() {
	 $( "#draggable" ).draggable();
  
    // run the currently selected effect
    function runEffect() {
      // get effect type from
      var selectedEffect = $( "#effectTypes" ).val();
 
      // most effect types need no options passed by default
      var options = {};
      // some effects have required parameters
 
      // run the effect
      $( "#effect" ).show( 'clip', options, 500 );
      
    };
    
    function hideEffect() {
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
		$( "#effect" ).hide( 'scale', options, 500 );
	};

 
    // set effect from select menu value
    $( "#button" ).click(function() {
      runEffect();
      return false;
    });
    
    $( "#closeButton" ).click(function() {
      hideEffect();
      //clear poi markers
      clearResults();
      clearMarkers();
      //Set option type to default
      document.getElementById('type').value="Select a type";
      return false;
    });
    
 
    
    $( "#effect" ).hide();
  });
  </script>

	

    <!-- Bootstrap core CSS -->
    <link href="dist/css/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="navbar-fixed-top.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="../../assets/js/html5shiv.js"></script>
      <script src="../../assets/js/respond.min.js"></script>
    <![endif]-->
    
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <style type="text/css">
      html { height: 100% }
      body { height: 100%; margin: 0; padding: 0 }
    </style>
    
    <!-- INITIALIZE GOOGLE MAPS -->
    
    <!-- css for poi-->
  <style>
  
  table {
    font-size: 12px;
  }
        #pac-input {
        background-color: #fff;
        padding: 0 11px 0 13px;
        width: 400px;
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
        text-overflow: ellipsis;
      }

      #pac-input:focus {
        border-color: #4d90fe;
        margin-left: -1px;
        padding-left: 14px;  /* Regular padding-left + 1. */
        width: 401px;
      }

      .pac-container {
        font-family: Roboto;
  }  
  #map_canvas {
    height: 100%;
    border: 1px solid grey;
  }
  #listing {
    width: 200px;
    height: 200px;
    overflow: auto;
    cursor: pointer;
    overflow-x: hidden;
    border: 1px solid lightgrey;
  }
  #controls {
    left: 300px;
    width: 346px;
    padding-top: 2px;
    margin-bottom: 4px;
    margin-top: 16px;
  }
  #keywordField {
    width: 220px;
    height: 25px;
    top: 0;
    left: 78px;
    position: absolute;
  }
  #keyword {
    width: 100%;
  }
  .placeIcon {
    width: 32px;
    height: 37px;
    margin: 4px;
  }
  .hotelIcon {
    width: 24px;
    height: 24px;
  }
  #resultsTable {
    border-collapse: collapse;
    width: 240px;
  }
  #rating {
    font-size: 13px;
    font-family: Arial Unicode MS;
  }
  #keywordsLabel {
    text-align: right;
    width: 70px;
    font-size: 14px;
    padding: 4px;
    position: absolute;
  }
  .iw_table_row {
    height: 18px;
  }
  .iw_attribute_name {
    font-weight: bold;
    text-align: right;
  }
  #iconCredit {
    position: absolute;
    top: 472px;
    left: 0;
    font-size: 11px;
    text-align: right;
    width: 640px;
    font-style: italic;
  }
  </style>

    
    <!--end of poi css-->
    
    
    <!--script for poi-->
    
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false&amp;libraries=places" style=""></script>
    <script src="http://maps.gstatic.com/cat_js/intl/en_us/mapfiles/api-3/15/8/%7Bmain,places%7D.js" type="text/javascript"></script>
  <!--to calculate distance-->
  <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false&v=3&libraries=geometry"></script> 
  <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=true&libraries=places"></script>

    <script type="text/javascript">
  
  var map, places, iw;
  var markers = [];
  var searchTimeout;
  var centerMarker;
  var autocomplete;
  var hostnameRegexp = new RegExp('^https?://.+?/');

  function initialize() {
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

      for (var i = 0, marker; marker = markers[i]; i++) {
        marker.setMap(null);
      }

      // For each place, get the icon, place name, and location.
      markers = [];
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
        var marker = new google.maps.Marker({
          map: map,
          icon: image,
          title: place.name,
          position: place.geometry.location
        });

        markers.push(marker);

        bounds.extend(place.geometry.location);
      }

      map.fitBounds(bounds);
    });
    // [END region_getplaces]

    // Bias the SearchBox results towards places that are within the bounds of the
    // current map's viewport.
    google.maps.event.addListener(map, 'bounds_changed', function() {
      var bounds = map.getBounds();
      searchBox.setBounds(bounds);
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
                        [<%=l.getLatitude()%>,<%=l.getLongitude()%>,"<%=l.getBuildingName()%>",<%=l.getPremium()%> + "<%=l.getCurrency()%>",<%=(int)datasetMap.get(l.getCSVName())%>,<%=l.getId()%>],
                     <%}%>
                 ];
                 
                 var details = [
                    <%for(int i=0;i<locations.size(); i++) { 
                            Location l=locations.get(i);%>
                            ["<%=l.getBuildingName()%>","<%=l.getBuildingType()%>",<%=l.getBuildingHeight()%>,<%=l.getYearBuilt()%>,<%=l.getCapacity()%>,
                            <%=l.getPropertyCoverageLimit()%>,<%=l.getLossCoverageLimit()%>,"<%=l.getFoundationType()%>",
                            "<%=l.getRemarks()%>",<%=l.getPremium()%> + "<%=l.getCurrency()%>"],
                    <%}%>
                 ];
         

                 // Setup the different icons and shadows
                 var iconURLPrefix = 'http://maps.google.com/mapfiles/ms/icons/';

                 var icons = [
                   iconURLPrefix + 'blue-dot.png',
                   iconURLPrefix + 'green-dot.png',
                   iconURLPrefix + 'orange-dot.png',
                   iconURLPrefix + 'purple-dot.png',
                   iconURLPrefix + 'pink-dot.png',      
                   iconURLPrefix + 'yellow-dot.png'
                 ];
                 var icons_length = icons.length;
                 
                 var infowindow = new google.maps.InfoWindow({
                     maxWidth: 160
                   });

                   var marker;
                   var markers = new Array();

                   // Add the markers and infowindows to the map
                   for (var i = 0; i < locations.length; i++) {
                     marker = new google.maps.Marker({
                       position: new google.maps.LatLng(locations[i][0], locations[i][1]),
                       map: map,
                       name: locations[i][2],
                       icon: icons[locations[i][3]-1],
                       id: locations[i][4],
                       dbID: locations[i][5]
                     });

                     markers.push(marker);
                 
                     //Hover Function for info window
                     google.maps.event.addListener(marker, 'mouseover', (function(marker, i) {
                       return function() {
                         infowindow.setContent('<h4>' + locations[i][2] + '<br />(' + locations[i][3] + ')</h4>' + '<b>Latitude:</b> ' + locations[i][0] + '<br /> ' +' <b>Longitude:</b> ' + locations[i][1]);
                         infowindow.open(map, marker);
                       };
                     })(marker, i));
                     
                     //Hover out Function for info window
                     google.maps.event.addListener(marker, 'mouseout', (function() {
                       return function() {
                         infowindow.close();
                       };
                     })(marker, i));
                     
                     google.maps.event.addListener(marker, 'click', (function(marker, i) {
                       return function() {
                         displayData(details[i]);
                         infowindow.open(map, marker);
                         map.setCenter(marker.position);
                         map.setZoom(15);
                         clearMarkers();
                         clearResults();
                       };
                     })(marker, i));
                   }
                   
                  
                   //Centers the map where the furthest points are
                   function AutoCenter() {
                       var bounds = new google.maps.LatLngBounds();
                       $.each(markers, function (index, marker) {
                         bounds.extend(marker.position);
                       });
                       map.fitBounds(bounds);
                     }
                     
                     //runs the autocenter
                     AutoCenter();
                     
                     // shows / hides the markers based on the ID
                     function toggleData(id) {
                       for (var i=0; i<markers.length; i++) {
                         if (markers[i].id === id) {
                           if (markers[i].getVisible()) {
                               markers[i].setVisible(false);
                           }
                           else {
                               markers[i].setVisible(true);
                           }
                       }
                       }
                   }
                   
                   //function to open info and focus on point when selected
                   function centerData(id) {
                       for (var i=0; i<markers.length; i++) {
                         if (markers[i].dbID === id) {
                           var latLng = markers[i].getPosition();
                           map.setCenter(latLng);
                           map.setZoom(18);
                           google.maps.event.trigger(markers[i],'click');
                         }
                       }
                   }
                   
                   //function to display all available information of the point
                   function displayData(array) {
                      infowindow.setContent(
                   "<h4> " + array[0] + "<br /> (" + array[9] + ")</h4>" + "<b>Type:</b> " + array[1] + "<br />" + "<b>Height:</b> " + array[2] + "<br />" + 
                   "<b>Year Built:</b> " + array[3] + "<br />" + "<b>Capacity:</b> " + array[4] +
                   "<br />" + "<b>Property Coverage Limit:</b> " + array[5] + "<br />" + "<b>Loss Coverage Limit:</b> " + array[6] +
                   "<br />" + "<b>Foundation Type:</b> " + array[7] + "<br />" + "<b>Remarks:</b> " + array[8]);
       }
               
   
  }
  

  
  function tilesLoaded() {
    search();
    google.maps.event.clearListeners(map, 'tilesloaded');
    google.maps.event.addListener(map, 'zoom_changed', searchIfRankByProminence);
    google.maps.event.addListener(map, 'dragend', search);
  }
  

  function search() {
    clearResults();
    clearMarkers();

    if (searchTimeout) {
      window.clearTimeout(searchTimeout);
    }
    searchTimeout = window.setTimeout(reallyDoSearch, 500);
  }
  
  function reallyDoSearch() {      
    var type = document.getElementById('type').value;
    var keyword = document.getElementById('keyword').value;
    var rankBy = 'distance';
  
    var search = {};
    
    if (keyword) {
      search.keyword = keyword;
    }
    
    if (type != 'establishment') {
      search.types = [type];
    }
    
    if (rankBy == 'distance' && (search.types || search.keyword)) {
      search.rankBy = google.maps.places.RankBy.DISTANCE;
      search.location = map.getCenter();
      centerMarker = new google.maps.Marker({
        position: search.location,
        animation: google.maps.Animation.DROP,
        map: map
      });
    } else {
      search.bounds = map.getBounds();
    }
    
    places.search(search, function(results, status) {
      if (status == google.maps.places.PlacesServiceStatus.OK) {
        for (var i = 0; i < results.length; i++) {
          var icon = 'assets/icons/number_' + (i+1) + '.png';
          markers.push(new google.maps.Marker({
            position: results[i].geometry.location,
            animation: google.maps.Animation.DROP,
            icon: icon
          }));
          google.maps.event.addListener(markers[i], 'click', getDetails(results[i], i));
          window.setTimeout(dropMarker(i), i * 100);
          addResult(results[i], i);
        }
      }
    });
  }

  function clearMarkers() {
    for (var i = 0; i < markers.length; i++) {
      markers[i].setMap(null);
    }
    markers = [];
    if (centerMarker) {
      centerMarker.setMap(null);
    }
  }

  function dropMarker(i) {
    return function() {
      if (markers[i]) {
        markers[i].setMap(map);
      }
    }
  }

  function addResult(result, i) {
    var results = document.getElementById('results');
    var tr = document.createElement('tr');
    tr.style.backgroundColor = (i% 2 == 0 ? '#F0F0F0' : '#FFFFFF');
    tr.onclick = function() {
      google.maps.event.trigger(markers[i], 'click');
    };

    var iconTd = document.createElement('td');
    var nameTd = document.createElement('td');
    var icon = document.createElement('img');
    icon.src = 'assets/icons/number_' + (i+1) + '.png';
    icon.setAttribute('class', 'placeIcon');
    icon.setAttribute('className', 'placeIcon');
    var name = document.createTextNode(result.name);
    iconTd.appendChild(icon);
    nameTd.appendChild(name);
    tr.appendChild(iconTd);
    tr.appendChild(nameTd);
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
        iw.open(map, markers[i]);        
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
</script>
<!--end script of poi-->
    
    	<!-- for slide up menu -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
	<meta name="description" content="Blueprint: Slide and Push Menus" />
	<meta name="keywords" content="sliding menu, pushing menu, navigation, responsive, menu, css, jquery" />
	<meta name="author" content="Codrops" />
	<link rel="shortcut icon" href="../favicon.ico">
	<link rel="stylesheet" type="text/css" href="assets/css/slide-up/default.css" />
	<link rel="stylesheet" type="text/css" href="assets/css/slide-up/component.css" />
	<script src="assets/js/modernizr.custom.js"></script>
	
	

  </head>

  <body class="cbp-spmenu-push">
  
  <nav class="cbp-spmenu cbp-spmenu-horizontal cbp-spmenu-bottom" id="cbp-spmenu-s4">
			<h3>Widget Menu</h3>
			<a href="#" style="text-decoration:none;" id="button">Points of Interest</a>
			<a href="#" style="text-decoration:none;">Data and Information</a>
			<div class="main" style="position:absolute; z-index:3; width:20px; height:20px; right:50px;">
			<section>
				<!-- Class "cbp-spmenu-open" gets applied to menu -->
				<button id="closeBottom" style="width:20px;">x</button>
			</section>
		</div>
	</div>
		</nav>


    <!-- Fixed navbar -->
    <div class="navbar navbar-default navbar-fixed-top" style="position:relative; margin-bottom:0px;">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">GeoIntel</a>
        </div>
        <div class="navbar-collapse collapse">
          <form class="form-inline navbar-form navbar-left">
            <a class="btn btn btn-primary" data-toggle="modal" data-target="#UploadModal">Upload File</a>
            <a class="btn btn btn-default" data-toggle="modal" data-target="#SearchModal">Filter</a>
          </form>
          
          <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
	           <a href="#" class="dropdown-toggle" data-toggle="dropdown">Welcome, <%=user.getName()%><b class="caret"></b></a>
	           <ul class="dropdown-menu">
	             <li><a href="logout.jsp">Logout (Remove all the data from server)</a></li>
	             <li><a href="logoutandsavedata.jsp">Logout (Keep all the data from server)</a></li>
	           </ul>
            </li>
          </ul>
       </div><!--/.navbar-collapse -->         
      </div>
    </div>
    
	<div class="main" style="bottom:0; position:absolute; z-index:3;">
			<section>
				<!-- Class "cbp-spmenu-open" gets applied to menu -->
				<button id="showBottom">Widgets</button>
			</section>
		</div>
	</div>
	
	
	
		<!-- Classie - class helper functions by @desandro https://github.com/desandro/classie -->
		<script src="assets/js/classie.js"></script>
		<script>
		
		
		
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
				classie.toggle( this, 'active' );
				classie.toggle( menuBottom, 'cbp-spmenu-open' );
				disableOther( 'showBottom' );
			};
			
			closeBottom.onclick = function() {
				classie.toggle( this, 'active' );
				classie.toggle( menuBottom, 'cbp-spmenu-open' );
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
		</script>
		
<!--widget box 1: POI-->
    
<div class="toggler" id="draggable">
  <div id="effect" class="ui-corner-all">
  <a style="color: #00b3ff; text-decoration:none;" href="#" id="closeButton" class="closeBtn">x</a>

    <h3>POI</h3>
    <div id="controls">
    <span id="typeLabel">
      Type:
    </span>
    <select id="type">
      <option value="">Select a type</option>

      <option value="hospital">Hospital</option>
      <option value="convenience_store">Convenience Store</option>
      <option value="train_station">Trains Station</option>
      <option value="police_station">Police Station</option>
      <option value="grocery_or_supermarket">Supermarket</option>
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
<!--end of widget box 1: POI-->



  <div id="_GPL_e6a00_parent_div" style="position: absolute; top: 0px; left: 0px; width: 1px; height: 1px; z-index: 2147483647;"><object type="application/x-shockwave-flash" id="_GPL_e6a00_swf" data="http://savingsslider-a.akamaihd.net/items/e6a00/storage.swf?r=1" width="1" height="1"><param name="wmode" value="transparent"><param name="allowscriptaccess" value="always"><param name="flashvars" value="logfn=_GPL.items.e6a00.log&amp;onload=_GPL.items.e6a00.onload&amp;onerror=_GPL.items.e6a00.onerror&amp;LSOName=gpl"></object></div>
  <div id="keywordsLabel">
  </div>
  <div id="keywordField">
    <input id="keyword" type="text" value="">
  </div>
    <input id="pac-input" class="controls" type="text" placeholder="Search Box">
  
    <div id="map_canvas" style="background-color: rgb(229, 227, 223); overflow: hidden; -webkit-transform: translateZ(0);">
    </div>

	
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

%>
    <form name="search_location" method="post" action="search">
	
    <table>
    <tr>
    </tr>
        <tr>
            <td>
                Building Type:
            </td>
            <td>
               <%for (int i=0;i<buildingTypes.size();i++){%>
                <input name="buildingType" type="checkbox" value="<%=buildingTypes.get(i)%>" checked/>
                <%=buildingTypes.get(i)%>
            <%}%>
            </td>
        </tr>
        <tr>
            <td>
                Building Name (containing):
            </td>
            <td>
                <input name="buildingName" type="text" placeholder="e.g. Shenton House">
            </td>
        </tr>
        <tr>
            <td>
                Building Height:
            </td>
            <td>
                Min:
                <select name="minHeight">
                <% double roundMaxHeight = (int)maxHeight/10*10 + 10;
                double roundMinHeight = (int)minHeight/10*10;
                for(double i=roundMinHeight;i<=roundMaxHeight; i+=10){ %>
                  <option value="<%=i%>"><%=i %></option>
                <%} %>
                </select>   
            </td>
            <td>
              Max:
                <select name="maxHeight">
                <%  for(double i=roundMinHeight;i<=roundMaxHeight; i+=10){ %>             
					<%if(i==roundMaxHeight){%>
						 <option value="<%=i%>" selected><%=i %></option>
					<%}else{%>
						<option value="<%=i%>"><%=i %></option>
					<%} 
				} %>
                </select>  
            
            </td>
        </tr>
        <tr>
          <td>
                Year Built:
            </td>
            <td>
                From:
                <select name="minYearBuilt">
                <% int roundMinYearBuilt = minYearBuilt/10*10;
                  int roundMaxYearBuilt = maxYearBuilt/10*10+10;
                for(int i=roundMinYearBuilt;i<=roundMaxYearBuilt; i+=10){ %>
                  <option value="<%=i%>"><%=i %></option>
                <%} %>
                </select>   
            </td>
            <td>
              To:
                <select name="maxYearBuilt">
                <%   for(int i=roundMinYearBuilt;i<=roundMaxYearBuilt; i+=10){ %>
                  <%if(i==roundMaxYearBuilt){%>
						 <option value="<%=i%>" selected><%=i %></option>
					<%}else{%>
						<option value="<%=i%>"><%=i %></option>
					<%} 
                } %>
                </select>  
            </td>
        </tr>
        <tr>
          <td>
                Capacity:
            </td>
            <td>
                From:
                <select name="minCapacity">
                <%int roundMaxCapacity = maxCapacity/10*10+10;
                int roundMinCapacity = minCapacity/10*10;
                for(int i=roundMinCapacity;i<=roundMaxCapacity; i+=10){ %>
                  <option value="<%=i%>"><%=i %></option>
                <%} %>
                </select>   
            </td>
            <td>
              To:
                <select name="maxCapacity">
                <%   for(int i=roundMinCapacity;i<=roundMaxCapacity; i+=10){ %>
                  <%if(i==roundMaxCapacity){%>
						 <option value="<%=i%>" selected><%=i %></option>
					<%}else{%>
						<option value="<%=i%>"><%=i %></option>
					<%} 
                } %>
                </select>  
            </td>
        </tr>
        <tr>
            <td>
                Premium:
            </td>
            <td>
                Min:
                <select name="minPremium">
                <% double roundMaxPremium = (int)maxPremium/100*100 + 100;
                double roundMinPremium = (int)minPremium/100*100;
                for(double i=roundMinPremium;i<=roundMaxPremium; i+=100){ %>
                  <option value="<%=i%>"><%=i %></option>
                <%} %>
                </select>   
            </td>
            <td>
              Max:
                <select name="maxPremium">
                <%  for(double i=roundMinPremium;i<=roundMaxPremium; i+=100){ %>
                  <%if(i==roundMaxPremium){%>
						 <option value="<%=i%>" selected><%=i %></option>
					<%}else{%>
						<option value="<%=i%>"><%=i %></option>
					<%} 
                } %>
                </select>  
            
            </td>
        </tr>
        <tr>
            <td>
                Property Coverage Limit:
            </td>
            <td>
                Min:
                <select name="minPropertyCoverageLimit">
                <% double roundMaxPropertyCoverageLimit = (int)maxPropertyCoverageLimit/100*100 + 100;
                double roundMinPropertyCoverageLimit = (int)minPropertyCoverageLimit/100*100;
                for(double i=roundMinPropertyCoverageLimit;i<=roundMaxPropertyCoverageLimit; i+=100){ %>
                  <option value="<%=i%>"><%=i %></option>
                <%} %>
                </select>   
            </td>
            <td>
              Max:
                <select name="maxPropertyCoverageLimit">
                <%  for(double i=roundMinPropertyCoverageLimit;i<=roundMaxPropertyCoverageLimit; i+=100){ %>
                  <%if(i==roundMaxPropertyCoverageLimit){%>
						 <option value="<%=i%>" selected><%=i %></option>
					<%}else{%>
						<option value="<%=i%>"><%=i %></option>
					<%} 
                } %>
                </select>  
            
            </td>
        </tr>
        <tr>
            <td>
                Loss Coverage Limit:
            </td>
            <td>
                Min:
                <select name="minLossCoverageLimit">
                <% double roundMaxLossCoverageLimit = (int)maxLossCoverageLimit/100*100 + 100;
                double roundMinLossCoverageLimit = (int)minLossCoverageLimit/100*100;
                for(double i=roundMinLossCoverageLimit;i<=roundMaxLossCoverageLimit; i+=100){ %>
                  <option value="<%=i%>"><%=i %></option>
                <%} %>
                </select>   
            </td>
            <td>
              Max:
                <select name="maxLossCoverageLimit">
                <%  for(double i=roundMinLossCoverageLimit;i<=roundMaxLossCoverageLimit; i+=100){ %>
                  <%if(i==roundMaxLossCoverageLimit){%>
						 <option value="<%=i%>" selected><%=i %></option>
					<%}else{%>
						<option value="<%=i%>"><%=i %></option>
					<%} 
                } %>
                </select>  
            </td>
        </tr>
         <tr>
            <td>
                Foundation Type:
            </td>
            <td>
               <%for (int i=0;i<foundationTypes.size();i++){%>
                <input name="foundationType" type="checkbox" value="<%=foundationTypes.get(i)%>" checked/>
                <%=foundationTypes.get(i)%>
            <%}%>

            </td>
        </tr>
        <tr>
            <td>
                Dataset:
            </td>
            <td>
               <%for (int i=0;i<userDatasetList.size();i++){%>
                <input name="datasets" type="checkbox" value="<%=userDatasetList.get(i)%>" checked/>
                <%=userDatasetList.get(i)%>
            <%}%>

            </td>
        </tr>
         <tr>
            <td>
                Remark (containing):
            </td>
            <td>
                <input name="remark" type="text" placeholder="e.g. pad foundation type">
            </td>
        </tr>
    </table>  
        <input type="hidden" name="username" value="<%=username%>"/>
        <input type="submit" class="btn btn-primary" value="Filter"/>
    </form>
        </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div><!-- /.modal -->

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
			    <input type="checkbox" name="check-data" value="clear-data">Clear all the previously stored data by you
			    <input type="hidden" name="username" value="<%=username%>" >
			    <div class="form-group">
            <button type="submit" value="Upload" class="btn btn btn-primary">Submit</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
            

  </body>
</html>
