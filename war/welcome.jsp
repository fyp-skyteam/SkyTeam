<%@page import="entity.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@include file="protect.jsp"%>

<%@page import="dao.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import ="java.io.Serializable" %>

<%
User user = (User) session.getAttribute("authenticated.user");
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
LocationDAO locationDAO = new LocationDAO();
List<Location> locations = locationDAO.retrieveAll();
for(Location l: locations){
	out.println(l.toString()+"</br>");
}
ArrayList<String> datasetList = locationDAO.getDatasetList();
for(String dataset: datasetList){
	out.println(dataset);
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>GeoIntel</title>
    <!-- Initialize GeoXML3 -->
    <script src="assets/geoxml3/geoxml3.js"></script>
    
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
    
    <!-- Initialize Google Maps -->
    <script src="http://maps.google.com/maps/api/js?sensor=false"></script>
</head>
 <body style="padding-top: 50px; padding-bottom: 20px">

    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
<!-- Brand and toggle get grouped for better mobile display -->
     <div class="navbar-header">
       <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
         <span class="sr-only">Toggle navigation</span>
         <span class="icon-bar"></span>
         <span class="icon-bar"></span>
         <span class="icon-bar"></span>
       </button>
       <a class="navbar-brand">GeoIntel</a>
     </div>

     <!-- Collect the nav links, forms, and other content for toggling -->
     <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
         <form class="form-inline navbar-form navbar-left" name="upload-file" action="upload" method="post" enctype="multipart/form-data" role="form">
           <div class="form-group">
             <input type="file" name="data">
         </div>
          
         <div class="form-group">
           <button type="submit" value="Upload" class="btn btn btn-primary">Submit</button>
         </div>
             <a class="btn btn btn-default" data-toggle="modal" data-target="#myModal">Search</a>
             <!-- Button trigger modal -->
       </form>
         
       <ul class="nav navbar-nav navbar-right">
         <li class="dropdown">
           <a href="#" class="dropdown-toggle" data-toggle="dropdown">Welcome, <%=user.getName()%><b class="caret"></b></a>
           <ul class="dropdown-menu">
             <li><a href="logout.jsp">Logout</a></li>
           </ul>
         </li>
       </ul>
     </div><!-- /.navbar-collapse -->
    </nav>
     <br />
     <div class="row">
         <div class="col-lg-12">
             <div class="col-lg-9">
                 <div class="row" id="map" style="height: 800px">
                 <script type="text/javascript">
  
                    // Setup markers based on CSV
                    var locations = [
                        <%for(int i=0;i<locations.size(); i++) { 
                                Location l=locations.get(i);%>
                                          [<%=l.getLatitude()%>,<%=l.getLongitude()%>,<%=l.getCSVName()%>,"<%=l.getBuildingName()%>", <%=l.getPremium()%> + " <%=l.getCurrency()%>",<%=(int)l.getId()%>],
                        <%}%>
                    ];
                    
                    var details = [
                        <%for(int i=0;i<locations.size(); i++) { 
                                Location l=locations.get(i);%>
                                ["<%=l.getBuildingName()%>","<%=l.getBuildingType()%>",<%=l.getBuildingHeight()%>,<%=l.getYearBuilt()%>,<%=l.getCapacity()%>,
                                <%=l.getPropertyCoverageLimit()%>,<%=l.getLossCoverageLimit()%>,"<%=l.getFoundationType()%>","<%=l.getRemarks()%>",<%=l.getPremium()%> + " <%=l.getCurrency()%>"],
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


                    var shadow = {
                      anchor: new google.maps.Point(15,33),
                      url: iconURLPrefix + 'msmarker.shadow.png'
                    };

                    var map = new google.maps.Map(document.getElementById('map'), {
                      mapTypeId: 'roadmap',
                      zoom: 1
                    });

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
                        id: locations[i][2],
                        icon : icons[locations[i][2]-1],
                        dbID: locations[i][5]
                      });

                      markers.push(marker);
                      
                      //Hover Function for info window
                      google.maps.event.addListener(marker, 'mouseover', (function(marker, i) {
                        return function() {
                          infowindow.setContent('<h4>' + locations[i][3] + '<br />(' + locations[i][4] + ')</h4>' + '<b>Latitude:</b> ' + locations[i][0] + '<br /> ' +' <b>Longitude:</b> ' + locations[i][1]);
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
                    
                    function displayData(array) {
                       infowindow.setContent(
                    "<h4> " + array[0] + "<br /> (" + array[9] + ")</h4>" + "<b>Type:</b> " + array[1] + "<br />" + "<b>Height:</b> " + array[2] + "<br />" + 
                    "<b>Year Built:</b> " + array[3] + "<br />" + "<b>Capacity:</b> " + array[4] +
                    "<br />" + "<b>Property Coverage Limit:</b> " + array[5] + "<br />" + "<b>Loss Coverage Limit:</b> " + array[6] +
                    "<br />" + "<b>Foundation Type:</b> " + array[7] + "<br />" + "<b>Remarks:</b> " + array[8]);
        }
                  </script>
                 </div>
              <% if (locationDAO.getDatasetList().size() > 0) { %>
                  <div class="row">
                     <% 
                     for (int i = 0; i < datasetList.size(); i++) {%>
                    <input type="checkbox" id="markerCheckbox"/> Dataset <%=datasetList.get(i)%>
                    <%}%>
                  </div>
               <%}%>
                  <div class="row jumbotron">
                      <center><h5>Select new widgets from here</h5></center>
                   </div>
             </div>
             
         </div>
             <div class="col-lg-3">
                 <div class=" col-lg-10 panel panel-default">
                <div class="panel-body">
                 <!--<div class="row">
                     <div class="col-lg-12">
                         
                            <select class="selectpicker show-tick" id="datalist" data-style="btn-default" data-width="100%">
                           
                                <option value="all">All Data</option>
                                <% if (locationDAO.getDatasetList().size() > 0) { %>
                           <optgroup label="Data">
                               <%
                               for (int a = 0; a < datasetList.size(); a++) {%>
                               <option value="<%=datasetList.get(a)%>">Dataset <%=datasetList.get(a)%></option>
                               <%}%>
                           </optgroup>
                           <%}%>
                         </select>
                     </div>
                 </div>
                    <hr />-->
         <% if (locationDAO.getDatasetList().size() > 0) { %>
                 <div class="row"> 
                     <div class="panel panel-primary" style="height:auto">
                          <div class="panel-body" id="details">
                              <%for (int a=0; a < locations.size(); a++) {%> 
                                <a id="datamarker" href="#" onclick="centerData(<%=locations.get(a).getId()%>);return false;" data-setnumber="<%=a+1%>"><%=locations.get(a).getBuildingName()%></a>
                                <br />
                              <%}%>
                          </div>
                     </div>
                 </div>
                    <hr />
            <%}%>
                 <div class="row"> 
                     <div class="col-lg-12 well well-lg" style="height:150px">WIDGET # 1</div>
                 </div>
                 <div class="row"> 
                     <div class="col-lg-12 well well-lg" style="height:150px">WIDGET # 2</div>
                 </div>
                    <hr />
                 <div class="row"> 
                     <div class="col-lg-12 alert alert-info" style="height:100px">Drag new widgets here</div>
                 </div>
               </div>  
             </div>
             </div>
     </div>
<% if (!errorMsg.equals("")) {%>                
<div class="row">
    <div class="col-md-4 col-md-offset-4" style="position: absolute; top: 50px">
        <div class="alert alert-danger alert-dismissable">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
            <strong>Error! Your upload was no successful due to the following errors:</strong><br /> <%=errorMsg%>
        </div>
    </div>
</div>
<%}%>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
              <h4 class="modal-title" id="myModalLabel">Search</h4>
            </div>
            <div class="modal-body">

<%
List<String> buildingTypes = locationDAO.retrieveAllBuildingTypes();
double minHeight = locationDAO.getMinimumHeight();
double maxHeight = locationDAO.getMaximumHeight();
%>
    <form name="search_location" method="post" action="search">
    <table>
        <tr>
            <td>
                Building Type:
            </td>
            <td>
               <%for (int i=0;i<buildingTypes.size();i++){%>
                <input name="buildingType" type="checkbox" value="<%=buildingTypes.get(i)%>"/>
                <%=buildingTypes.get(i)%>
            <%}%>
            </td>
        </tr>
        <tr>
            <td>
                Building Name:
            </td>
            <td>
                <input name="buildingName" type="text" value="Any">
            </td>
        </tr>
        
    </table>  
            <input type="submit" class="btn btn-primary" value="Search"/>
    </form>
            </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </div><!-- /.modal -->
</body>
</html>
