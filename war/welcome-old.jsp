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
//String errorMsg = request.getParameter("errorMsg");
String errorMsg="no error";
HashMap<String,ArrayList<String>> locationErrors = (HashMap<String,ArrayList<String>>)request.getAttribute("locationErrors");
ArrayList<String> fileErrors = (ArrayList<String>)request.getAttribute("fileErrors");
// if this page is not forwarded, errorMsg would be null, we set it to an empty
// String to prevent displaying null
//if (errorMsg == null) {
  //errorMsg = "";
//}
if(locationErrors!=null){
    Iterator iterator1 = locationErrors.keySet().iterator();
    while(iterator1.hasNext()){
        String errorLine = (String)iterator1.next();
        //out.println(errorLine);
        errorMsg += errorLine+": ";
        ArrayList<String> errorStr = locationErrors.get(errorLine);
        for(int i=0;i<errorStr.size();i++){
             errorMsg += errorStr.get(i)+ ", ";
             //out.println(errors.get(i));
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

%>

<%
LocationDAO locationDAO = new LocationDAO();
List<Location> locations = locationDAO.retrieveAll();
%>
<%=errorMsg%>
<!DOCTYPE html>
<html>
<head>
    <title>GeoIntel</title>
    <!-- Initialize OpenLayers -->
    <script src="OpenLayers.js"></script>
    
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
          <%if(!user.getUsername().equals("admin")){%>
       <form class="form-inline navbar-form navbar-left" name="upload-file" action="upload" method="post" enctype="multipart/form-data" role="form">
         <div class="form-group">
             <input type="file" name="data">
         </div>
         <div class="form-group">  
            <select class="selectpicker" data-width="auto">
                <option>USD</option>
                <option>SGD</option>
                <option>AUS</option>
              </select> 
         </div>
         <div class="form-group">
            
               
            
           <button type="submit" value="Upload" class="btn btn btn-primary">Submit</button>
         </div>
       </form>
           <%}else{%>
           <form class="form-inline navbar-form navbar-left" name="upload-shapefile" action="http://ogre.adc4gis.com/convert" method="post" enctype="multipart/form-data" role="form">
         <div class="form-group">
             <input type="file" name="upload">
         </div>
         <div class="form-group">  
            <select class="selectpicker" data-width="auto">
                <option>USD</option>
                <option>SGD</option>
                <option>AUS</option>
              </select> 
         </div>
         <div class="form-group">
            
                
            
           <button type="submit" value="Upload" class="btn btn btn-primary">Submit</button>
         </div>
       </form>
           <%}%>
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
                                          [<%=l.getLatitude()%>,<%=l.getLongitude()%>,<%=l.getDatasetNumber()%>],
                        <%}%>
                    ];

                    // Setup the different icons and shadows
                    var iconURLPrefix = 'http://maps.google.com/mapfiles/ms/icons/';

                    var icons = [
                      iconURLPrefix + 'red-dot.png',
                      iconURLPrefix + 'green-dot.png',
                      iconURLPrefix + 'blue-dot.png',
                      iconURLPrefix + 'orange-dot.png',
                      iconURLPrefix + 'purple-dot.png',
                      iconURLPrefix + 'pink-dot.png',      
                      iconURLPrefix + 'yellow-dot.png'
                    ]
                    var icons_length = icons.length;


                    var shadow = {
                      anchor: new google.maps.Point(15,33),
                      url: iconURLPrefix + 'msmarker.shadow.png'
                    };

                    var map = new google.maps.Map(document.getElementById('map'), {
                      mapTypeId: 'roadmap',
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
                        draggable : true
                      });

                      markers.push(marker);
                      
                      //Hover Function for info window
                      google.maps.event.addListener(marker, 'mouseover', (function(marker, i) {
                        return function() {
                          infowindow.setContent('Latitude: ' + locations[i][0] + '<br /> ' +' Longitude: ' + locations[i][1]);
                          infowindow.open(map, marker);
                        };
                      })(marker, i));
                      
                      //Hover out Function for info window
                      google.maps.event.addListener(marker, 'mouseout', (function() {
                        return function() {
                          infowindow.close();
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
                                markers[i].setVisible(true)
                            }
                        }
                        }
                    }
                  </script>
                 </div>
                  <div class="row">
                         <input type="checkbox" id="markerCheckbox" onclick="toggleData(1)" checked/> Data # 1
                         <input type="checkbox" id="markerCheckbox" onclick="toggleData(2)" checked/> Data # 2
                         <input type="checkbox" id="markerCheckbox" onclick="toggleData(3)" checked/> Data # 3
                  </div>
                  <div class="row">
                      <center><h5>widgets here</h5></center>
                   </div>
             </div>
             
         </div>
             <div class="col-lg-3">
                 <div class=" col-lg-10 panel panel-default">
                <div class="panel-body">
                 <div class="row">
                     <div class="col-lg-12">
                            <select class="selectpicker show-tick" data-style="btn-default" data-width="100%">
                           <option>All Data</option>
                           <optgroup label="Data">
                               <option>Dataset # 1</option>
                           </optgroup>
                           <optgroup label="Layers">
                               <option>Flood</option>
                           </optgroup>
                         </select> 
                     </div>
                 </div>
                    <hr />
                 <div class="row"> 
                     <div class="col-lg-12 alert alert-success"  style="height:200px">Data regarding the selected dataset</div>
                 </div>
                    <hr />
                 <div class="row"> 
                     <div class="col-lg-12 well well-lg" style="height:150px">WIDGET # 1</div>
                 </div>
                 <div class="row"> 
                     <div class="col-lg-12 well well-lg" style="height:150px">WIDGET # 2</div>
                 </div>
                    <hr />
                 <div class="row"> 
                     <div class="col-lg-12 alert alert-info" style="height:100px">ADD NEW WIDGET HERE</div>
                 </div>
               </div>  
             </div>
             </div>
     </div>
                    
<div class="row">
    <div class="col-md-4 col-md-offset-4" style="position: absolute; top: 50px">
        <div class="alert alert-danger alert-dismissable">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
            <strong>Warning!</strong> This error appears if something bad happens.
        </div>
    </div>
</div>

</body>
</html>
