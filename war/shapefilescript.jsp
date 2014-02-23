 <script type="text/javascript">
      google.load('visualization', '1', { packages: ['corechart'] });

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

      function initialize() {
        var sector = 'Flood';
        var map = new google.maps.Map(document.getElementById('map-canvas'), {
            center: new google.maps.LatLng(4.210484, 101.975766),
            zoom: 5,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            zoomControlOptions: {
              style: google.maps.ZoomControlStyle.SMALL
            },
          });
        var layer = new google.maps.FusionTablesLayer();
        updateLayerQuery(layer, sector);
        layer.setMap(map);
        createLegend(map, sector);
        styleLayerBySector(layer, sector);
        styleMap(map);
        drawVisualization('Johor');

        google.maps.event.addListener(layer, 'click', function(e) {
          var county = e.row['name'].value;
          drawVisualization(county);

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
              drawVisualization(county);
            });
      }
       
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
        var legendWrapper = document.createElement('div');
        legendWrapper.id = 'legendWrapper';
        legendWrapper.index = 1;
        map.controls[google.maps.ControlPosition.LEFT_BOTTOM].push(
            legendWrapper);
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
        map.mapTypes.set('map-style', styledMapType);
        map.setMapTypeId('map-style');
      }

      function drawVisualization(county) {
        google.visualization.drawChart({
          containerId: "visualization",
          dataSourceUrl: "http://www.google.com/fusiontables/gvizdata?tq=",
          query: "SELECT 'Risk Factor','2006','2007','2008','2009','2010','2011','2012','2013' " +
              "FROM 1n6YmqLeeb7eXX0TqV2riidchOQ7nV-S2WIB8xfg WHERE name = '" + county + "'",
          chartType: "ColumnChart",
          options: {
            title: county,
            height: 400,
            width: 400
          }
        });
      }

      google.maps.event.addDomListener(window, 'load', initialize);</script>