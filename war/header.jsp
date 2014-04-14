<title>GeoIntel</title>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<!-- for slide up menu -->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
<meta name="description" content="Blueprint: Slide and Push Menus" />
<meta name="keywords" content="sliding menu, pushing menu, navigation, responsive, menu, css, jquery" />
<meta name="author" content="Codrops" />

<!-- Initialize custom drag-able elements for widgets -->	

<script src="assets/js/jquery.nouislider.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="assets/bootstrap-file/bootstrap-filestyle.min.js"> </script>
<script src="assets/jquery-ui-1.10.4.custom/development-bundle/jquery-1.10.2.js"></script>
<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.core.js"></script>
<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.widget.js"></script>
<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.mouse.js"></script>
<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.draggable.js"></script>
<script src="assets/jquery-ui-1.10.4.custom/development-bundle/ui/jquery.ui.resizable.js"></script>
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
<!-- INITIALIZE GOOGLE MAPS -->
<script src="http://maps.gstatic.com/cat_js/intl/en_us/mapfiles/api-3/15/8/%7Bmain,places%7D.js" type="text/javascript"></script>
<script src="https://maps.googleapis.com/maps/api/js?sensor=false&libraries=visualization,geometry,places"></script>

<link rel="stylesheet" href="assets/morris/morris.css">
<script src="assets/morris/morris.min.js"></script>
<script src="assets/morris/raphael-min.js"></script>

<script src="assets/js/bootstrap-slider.js"></script>
<script src="assets/js/classie.js"></script>
<script type="text/javascript" src="http://www.google.com/jsapi"></script>

<link rel="stylesheet" href="assets/css/global.css">
<link rel="stylesheet" href="assets/jquery-ui-1.10.4.custom/development-bundle/demos/demos.css">
<link rel="stylesheet" href="assets/jquery-ui-1.10.4.custom/development-bundle/themes/base/jquery.ui.all.css">    
<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon" href="../favicon.ico">
<link rel="stylesheet" type="text/css" href="assets/css/slide-up/default.css" />
<link rel="stylesheet" type="text/css" href="assets/css/slide-up/component.css" />
<link rel="stylesheet" type="text/css" href="assets/css/slider.css" />


<style>
 #widget1 { min-width: 240px; min-height: 120px; max-height: 800px; padding: 1.2em; position: absolute; background-color: rgba(255,255,255,0.82)}
 #widget1 h3 { margin: 0; text-align: center; margin-bottom: 5px; }
 #widget2 { min-width: 350px; min-height: 140px; left:850px; padding: 1.2em; position: absolute; background-color: rgba(255,255,255,0.82)}
 #widget2 h3 { margin: 0; text-align: center; margin-bottom: 5px; }
 #widget4 { min-width: 300px; min-height: 140px; left:260px; padding: 1.2em; position: absolute; background-color: rgba(255,255,255,0.82)}
 #widget4 h3 { margin: 0; text-align: center; margin-bottom: 5px; }
 #widget5 { min-width: 400px; min-height: 140px; top: 300px; padding: 1.2em; position: absolute; background-color: rgba(255,255,255,0.82)}
 #widget5 h3 { margin: 0; text-align: center; margin-bottom: 5px; }
 #widget6 { min-width: 800px; min-height: 500px; padding: 1.2em; position: absolute; background-color: rgba(255,255,255,0.82)}
 #widget6 h3 { margin: 0; text-align: center; margin-bottom: 5px; }
 #widget8 { min-width: 300px; min-height: 200px; padding: 1.2em; position: absolute; background-color: rgba(255,255,255,0.82)}
 #widget8 h3 { margin: 0; text-align: center; margin-bottom: 5px; }
 
 html { height: 100% }
 body { height: 100%; margin: 0; padding: 0 }
$('input[type="checkbox"].style1').checkbox({
   	buttonStyleChecked: 'btn-success',
       checkedClass: 'icon-check',
       uncheckedClass: 'icon-check-empty'
 });
      #legend {
        background: #FFF;
        margin: 10px;
        padding: 5px;
        width: 150px;
      }

      #legend p {
        font-weight: bold;
        margin-top: 3px;
      }

      #legend div {
        clear: both;
      }

      .color {
        height: 12px;
        width: 12px;
        margin-right: 3px;
        float: left;
        display: block;
      }

      .high {
        color: #F00;
      }

      .medium {
        color: #0F0;
      }

      .low {
        color: #00F;
      }

      .high, .medium, .low {
        font-weight: bold;
      }
      
      .highestValue {
        background:#F0E890;
      }
</style>