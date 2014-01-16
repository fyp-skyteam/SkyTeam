<%@page import="entity.*"%>"
<%@page import="dao.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import ="java.io.Serializable" %>
<%@include file="protect.jsp" %>
<%
LocationDAO locationDAO = new LocationDAO();
List<Location> locations = locationDAO.retrieveAll();
for(int i=0; i<locations.size();i++){
      out.println(locations.get(i).getRemarks());
}
%>

<!DOCTYPE html>
<html> 
<head> 
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" /> 
  <title>Google Maps Multiple Markers</title> 
  <script src="http://maps.google.com/maps/api/js?sensor=false"></script>
  <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.10.1.min.js"></script>
</head> 
<body>
  <div id="map" style="width: 800px; height: 600px;"></div>

  <script type="text/javascript">
  
    // Setup markers based on CSV
    var locations = [
			<%for(int i=0;i<locations.size(); i++) { 
				Location l=locations.get(i);%>
					  [<%=l.getLatitude()%>,<%=l.getLongitude()%>],
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
      //center: new google.maps.LatLng(-37.92, 151.25),
      mapTypeId: 'roadmap'

    });

    var infowindow = new google.maps.InfoWindow({
      maxWidth: 160
    });

    var marker;
    var markers = new Array();
    
    var iconCounter = 0;
    
    // Add the markers and infowindows to the map
    for (var i = 0; i < locations.length; i++) {  
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(locations[i][0], locations[i][1]),
        map: map,
        icon : icons[iconCounter],
      });

      markers.push(marker);

      google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function() {
          infowindow.setContent('Latitude: ' + locations[i][0] + ' Longitude: ' + locations[i][1]);
          infowindow.open(map, marker);
        }
      })(marker, i));
      
      iconCounter++;
      // We only have a limited number of possible icon colors, so we may have to restart the counter
      if(iconCounter >= icons_length){
        iconCounter = 0;
      }
    }

    function AutoCenter() {
        //  Create a new viewpoint bound
        var bounds = new google.maps.LatLngBounds();
        //  Go through each...
        $.each(markers, function (index, marker) {
          bounds.extend(marker.position);
        });
        //  Fit these bounds to the map
        map.fitBounds(bounds);
      }
      AutoCenter();
  </script> 
 
  
</body>
</html>