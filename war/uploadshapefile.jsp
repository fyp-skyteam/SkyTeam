<html>
<form action="http://ogre.adc4gis.com/convert" method="post" enctype="multipart/form-data" class="form-horizontal"><fieldset><legend>Convert to GeoJSON</legend><div class="control-group"><label for="upload" class="control-label">File*:</label><div class="controls"><input id="upload" type="file" name="upload"><p class="help-block">Must be a supported format</p></div></div><div class="control-group"><label for="callback" class="control-label">JSONP Callback: </label><div class="controls"><input id="callback" name="callback"></div></div><div class="control-group"><label class="control-label">Force Plain Text: </label><div class="controls"><input type="checkbox" name="forcePlainText" value="true"></div></div><div class="control-group"><div class="controls"><button name="convert" class="btn primary">Convert</button> <button name="view" class="btn success">View In Browser</button></div></div></fieldset></form></div><div class="span6"><form action="/convertJson" method="post" class="form-horizontal"><fieldset><legend>Convert from GeoJSON</legend><div class="control-group"><label for="json" class="control-label">GeoJSON:</label><div class="controls"><textarea id="json" name="json" rows="3" class="xlarge">{ "type": "FeatureCollection",
  "features": [
    { "type": "Feature",
      "geometry": {"type": "Point", "coordinates": [102.0, 0.5]},
      "properties": {"prop0": "value0"}
      },
    { "type": "Feature",
      "geometry": {
        "type": "LineString",
        "coordinates": [
          [102.0, 0.0], [103.0, 1.0], [104.0, 0.0], [105.0, 1.0]
          ]
        },
      "properties": {
        "prop0": "value0",
        "prop1": 0.0
        }
      },
    { "type": "Feature",
       "geometry": {
         "type": "Polygon",
         "coordinates": [
           [ [100.0, 0.0], [101.0, 0.0], [101.0, 1.0],
             [100.0, 1.0], [100.0, 0.0] ]
           ]
       },
       "properties": {
         "prop0": "value0",
         "prop1": {"this": "that"}
         }
       }
     ]
   }

</html>