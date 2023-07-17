var gpsWatch;
var zoomres;
var maxZoomlevel;
var gpsMarker;
var gpscoord;

function addGpsMarker(){
		
	$('#setGpspoint').hide();
	$('#gpsmessage').hide();
	map.getView().setRotation(getRadians(0));
	
	/* GPS position marker */
	gpsMarker = new ol.Overlay({
	   map: map,
	   element: ($('<i/>').addClass('gpspoint').get(0)) // Marker image from map.css
	});
	
	map.addOverlay(gpsMarker);   //Adding GPS marker to the map  
}

/* Zoom to point and change view with animation */
function zoomPoint(point,zoomres){ 
	
  var duration = 1000;
  var start = +new Date();
  var pan = ol.animation.pan({
    duration: duration,
    source: map.getView().getCenter(),
    start: start
  });
  
  var bounce = ol.animation.bounce({
    duration: duration,
    resolution: 4 * map.getView().getResolution(),
    start: start
  });
  
  if(map.getView().getResolution() < zoomres){
	  zoomres = map.getView().getResolution();
  }
  map.getView().setResolution(zoomres);
  map.getView().setCenter(point);  
}

 /* Calculate Radians */
function getRadians(d){
	var radians = d * (Math.PI / 180);
	return radians;
}

 /* Calculate projection point of GPS location */
function getTranspoint(x,y,i,o){	
	var mypoint = ol.proj.transform([x, y], i, o);
	return mypoint;
}

 /* Create new view */
function setnewView(x,y,z){
	var myview = new ol.View2D({
      center: [x, y],
      zoom: z,
	  maxZoom: maxZoomlevel
    })
	return myview;
}

 /* GPS start watch function */
var startgpsWatch = function(){
	
	xmlDoc = readXMLContent();  // Reading zoom values from map.xml 
	maxZoomlevel = xmlDoc.getElementsByTagName('map')[0].getElementsByTagName("maxzoomlevel")[0].childNodes[0].nodeValue; // Max zoom level of GPS point
	zoomres = xmlDoc.getElementsByTagName('map')[0].getElementsByTagName("zoomresolution")[0].childNodes[0].nodeValue; // Zoom resolution of GPS point 
	
	if(navigator.geolocation){
		$('#gpsmessage').show();
		$('#gpsmessage').html('<div id="gpsmessagebox">start watching...</div>');
		gpsWatch = navigator.geolocation.watchPosition(gpsokCallback, gpsfailCallback, gpsOptions);
	}
}

 /* GPS stop watch  function */
var stopgpsWatch = function(){
	navigator.geolocation.clearWatch(gpsWatch);
	$('.gpspoint').hide();  // Hide GPS marker
	$('#setGpspoint').hide();
	$('#gpsmessage').html("");
	$('#gpsmessage').hide();
}

 /* GPS success callback */
var gpsokCallback = function(position){
	
	var x = position.coords.longitude;
	var y = position.coords.latitude;
	 x = x.toFixed(2);
	 y = y.toFixed(2);
	
	var msg = '<div id="gpsmessagebox"><img src="images/map/marker.png" height="20px" width="20px"/>' +
	'X: ' + x + "&nbsp;&nbsp;" +
	'Y: ' + y +
	'</div>';
	$('#gpsmessage').html(msg);
	
	 gpscoord = getTranspoint(position.coords.longitude,position.coords.latitude,'EPSG:4326','EPSG:900913');

	gpsMarker.setPosition(gpscoord);  // Set position of GPS marker
	$('.gpspoint').show();  // Show GPS marker
//	$('#setGpspoint').show();
//	$("#gpsmessage").bind( "click", function(event, ui) {
		zoomPoint(gpscoord,zoomres);  // Zoom to GPS coordinates
//	});
//	$("#setGpspoint").button();
};

function goToLocation(){
	
	zoomPoint(gpscoord,zoomres);
}
 /* GPS fail callback */
	var gpsfailCallback = function(e){
	var msg = 'Fail ' + e.code + ': ' + e.message;	
};

 /* GPS options */
	var gpsOptions = {
			enableHighAccuracy: true,
			timeout: 5000,
			maximumAge: 0
	};