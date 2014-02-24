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



	    
	    $( "#widget1" ).hide();
	    $( "#widget2" ).hide();
	    $( "#widget3" ).hide();
	    $( "#widget4" ).hide();
	    $( "#widget5" ).hide();
	    $( "#widget6" ).hide();
	    $( "#widget7" ).hide();
		
	
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
	  var markers = [];
	  var searchTimeout;
	  var centerMarker;
	  var autocomplete;
	  var hostnameRegexp = new RegExp('^https?://.+?/');
	  
	  
	  function initialize() {
	  // marker's longitude and langitude
      
      displayMarkerInfo();
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
	                        [<%=l.getLatitude()%>,<%=l.getLongitude()%>,"<%=l.getBuildingName()%>",<%=l.getPremium()%> + "<%=l.getCurrency()%>",<%=(int)datasetMap.get(l.getCSVName())%>,<%=l.getId()%>,<%=l.getVulnerabilityIndex()%>],
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
	                       id: locations[i][5],
	                       vIndex: locations[i][6]
	                     });
	                	   if(i%2==0){
	                             
                       document.getElementById('results2').innerHTML += 
                            '<tr style="background-color: rgb(255, 255, 255);">'+
                            '<td>&nbsp;&nbsp;&nbsp;<input type="checkbox" checked="checked" onClick="'+ toggleData(locations[i][5])+'"/></td>'+
                            '<td><img src="'+ icons[number - 1] + '" class="placeIcon" classname="placeIcon"></td>'+
                            '<td>'+ locations[i][2] + '</td>'
                            '</tr>';
                            
                        }
                        else{
                           document.getElementById('results2').innerHTML += 
                        	   '<tr style="background-color: rgb(240, 240, 240);">'+
                               '<td>&nbsp;&nbsp;&nbsp;<input type="checkbox" checked="checked" onChange="'+ toggleData(locations[i][5])+'"/></td>'+
                               '<td><img src="'+ icons[number - 1] + '" class="placeIcon" classname="placeIcon"></td>'+
                               '<td>'+ locations[i][2] + '</td>'
                               '</tr>'; 
                       }
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
	                     

	                  var selected;
	                  var selectedIcon;
	                     google.maps.event.addListener(marker, 'click', (function(marker, i) {
	                       return function() {
	                    	   infowindow.close();
	                         displayData(details[i]);
	                         infowindow2.open(map, marker);
	                         map.setCenter(marker.position);
	                         clearMarkers();
	                         clearResults();
	                         if (selected) {
	                        	 selected.setIcon(selectedIcon);
	                         }
	                         
	                         selectedIcon = marker.getIcon();
	                         selected = marker;
	                         
	                         
	                         var txt = new String(marker.getIcon());
	                         marker.setIcon(txt.substring(0,txt.length-4)+"-1.png");
	                         displaySelectedPOI(selected);
	                         displaySelectedRisk(selected);
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
	                    	 $.each(markers, function (index, marker) {
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
	                   function displayData(array) {
	                      infowindow2.setContent(
	                   "<h4> " + array[0] + "<br /> (" + array[9] + ")</h4>" + "<b>Type:</b> " + array[1] + "<br />" + "<b>Height:</b> " + array[2] + "<br />" + 
	                   "<b>Year Built:</b> " + array[3] + "<br />" + "<b>Capacity:</b> " + array[4] +
	                   "<br />" + "<b>Property Coverage Limit:</b> " + array[5] + "<br />" + "<b>Loss Coverage Limit:</b> " + array[6] +
	                   "<br />" + "<b>Foundation Type:</b> " + array[7] + "<br />" + "<b>Remarks:</b> " + array[8]);
	       }
	  }
	  
	  var layer;
	  function displayHazard() {
		  if (!layer) {
			  sector = 'Flood';
			  document.getElementById("hazardSelect").style.display="block";
		         layer = new google.maps.FusionTablesLayer();
		         updateLayerQuery(layer, sector);
		         layer.setMap(map);
		         createLegend(map, sector);
		         styleLayerBySector(layer, sector);
		         styleMap(map);
		         
		         google.maps.event.addListener(layer, 'click', function(e) {
		             var county = e.row['name'].value;
	
		             var risk = e.row['2013'].value;
		             if (risk > 66) {
		               e.infoWindowHtml = '<p class="high">High Risk!</p>';
		             } else if (risk > 33) {
		               e.infoWindowHtml = '<p class="medium">Medium Risk</p>';
		             } else {
		               e.infoWindowHtml = '<p class="low">Low Risk</p>';
		             }
		           });
	
		           google.maps.event.addDomListener(document.getElementById('sector'),
		               'change', function() {
		                 sector = this.value;
		                 updateLayerQuery(layer, sector);
		                 styleLayerBySector(layer, sector);
		                 updateLegend(sector);
		               });
	
		           google.maps.event.addDomListener(document.getElementById('county'),
		               'change', function() {
		                 var county = this.value;
		                 updateLayerQuery(layer, sector, county);
		               });
		  }
		  else {
			  layer.setMap(null);
			  layer = null;
			  document.getElementById("legend").remove();
			  document.getElementById("hazardSelect").style.display="none";
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

	      function styleLayerBySector(layer, sector) {
	        var layerStyle = LAYER_STYLES[sector];
	        var colors = layerStyle.colors;
	        var minNum = layerStyle.min;
	        var maxNum = layerStyle.max;
	        var step = (maxNum - minNum) / colors.length;

	        var styles = new Array();
	        for (var i = 0; i < colors.length; i++) {
	          var newMin = minNum + step * i;
	          styles.push({
	            where: generateWhere(newMin, sector),
	            polygonOptions: {
	              fillColor: colors[i],
	              fillOpacity: 1
	            }
	          });
	        }
	        layer.set('styles', styles);
	      }

	      function generateWhere(minNum, sector) {
	        var whereClause = new Array();
	        whereClause.push("'Risk Factor' = '");
	        whereClause.push(sector);
	        whereClause.push("' AND '2013' >= ");
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
	      
	      function displayMarkerInfo() {
	    	  
	      }
	      google.load('visualization', '1', {packages: ['motionchart']});
	      
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
	
	function displaySelectedRisk(selected) {
    	document.getElementById('selectedRisk').innerHTML = ('<h4>Selected point: <b><u>' + selected.name + '</b></u></h4>' + '<h4>Vulnerability Index: <b><u>' + selected.vIndex + '</b></u></h4>' );
	}
	
	function displaySelectedPOI(selected) {
	      document.getElementById('selectedPOI').innerHTML = ('<h5>Selected point: <b><u>' + selected.name + '</b></u></h5>');
	  }
</script>