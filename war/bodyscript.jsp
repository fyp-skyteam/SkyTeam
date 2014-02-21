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
	    

	    $( "#close1" ).click(function() {
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

	    
	    $( "#widget1" ).hide();
	    $( "#widget2" ).hide();
	    $( "#widget3" ).hide();
	
	
	});      
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
	                 

	                 var icons = [
	                   'assets/markers/blu-blank.png',
	                   'assets/markers/pink-blank.png',
	                   'assets/markers/yel-blank.png',
	                   'assets/markers/grn-blank.png',
	                   'assets/markers/red-blank.png',
	                   'assets/markers/wht-blank.png',
	                   'assets/markers/purp-blank.png'
	                 ];
	                 var icons_length = icons.length;
	                 
	                 var infowindow = new google.maps.InfoWindow({
	                     maxWidth: 160
	                   });
	                 
	                 var infowindow2 = new google.maps.InfoWindow({
	                     maxWidth: 160
	                   });

	                   var marker;
	                   var markers = new Array();

	                   // Add the markers and infowindows to the map
	                   for (var i = 0; i < locations.length; i++) {
	                	   var number = locations[i][4]
	                     marker = new google.maps.Marker({
	                       position: new google.maps.LatLng(locations[i][0], locations[i][1]),
	                       map: map,
	                       name: locations[i][2],
	                       icon: icons[number - 1],
	                       id: locations[i][4]
	                     });

	                     markers.push(marker);
	                 
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
	                     

	                     
	                     google.maps.event.addListener(marker, 'click', (function(marker, i) {
	                       return function() {
	                    	   infowindow.close();
	                         displayData(details[i]);
	                         infowindow2.open(map, marker);
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
	                      infowindow2.setContent(
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
	        map: map
	      });
	      centerMarker.setVisible(false);
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