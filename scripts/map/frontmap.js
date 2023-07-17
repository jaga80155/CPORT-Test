/* Global variables */
var frontmap;
var webMapServiceUrl;
var overlayGroup;
var frontpopup;
var workspace;
var wfsplotslayername,wfsbuildingslayername;
var basemapgroup;
var fSelectStatus = "off";
/* Initialization for Map */
function loadmap() {
	
	xmlDoc = readXMLContent();	 
	 /* Reading XML Contents */
	 var geoServer = xmlDoc.getElementsByTagName('geoserver'); //  Name of geoserver
	 var url = geoServer[0].getElementsByTagName("url")[0].childNodes[0].nodeValue; // URL of geoserver
	 	 workspace = geoServer[0].getElementsByTagName("workspace")[0].childNodes[0].nodeValue; // Name of workspace i.e., chennai_port
	     webMapServiceUrl = url + workspace + '/wms'; // Web map service URL
	 var basemapProjection = xmlDoc.getElementsByTagName('frontmap')[0].getElementsByTagName("basemapprojection")[0].childNodes[0].nodeValue; // Base map projection value in format of EPSG
	 var latitude = xmlDoc.getElementsByTagName('frontmap')[0].getElementsByTagName("lat")[0].childNodes[0].nodeValue; // Latitude of projection location
	 var longitude = xmlDoc.getElementsByTagName('frontmap')[0].getElementsByTagName("lon")[0].childNodes[0].nodeValue; // Longitude of projection location	 
		wfsplotslayername = geoServer[0].getElementsByTagName("wfsplotslayername")[0].childNodes[0].nodeValue;   //name of wfs plots layer  	
		wfsbuildingslayername = geoServer[0].getElementsByTagName("wfsbuildingslayername")[0].childNodes[0].nodeValue;   //name of wfs buildings layer  
	 /* Overlay layers group */
		overlayGroup = new ol.layer.Group({
			title : 'Layers'
		});
		
		basemapgroup = new ol.layer.Group({
			
		});
	 /* Float Conversion of Coordinates */
	 var lat = parseFloat(latitude);  
	 var lon = parseFloat(longitude);
	 
	/* Projection view specifications*/ 
	 var startView = new ol.View({
         center: ol.proj.transform([lat, lon], basemapProjection, 'EPSG:900913'),
         zoom: 18          
       });	 
	 
	 /* Remove map rotation feature */
	 var controls = ol.control.defaults({rotate: false}); 
	 var interactions = ol.interaction.defaults({altShiftDragRotate:false, pinchRotate:false});
	 
	 /* Creating map object */
	 frontmap = new ol.Map({
		 target: 'frontmap',
		// interactions: olgm.interaction.defaults(),
         view: startView,
		 controls: ol.control.defaults().extend([ new ol.control.ScaleLine({className: 'ol-scale-line', target: document.getElementById('scale-line')})]),
		 interactions: interactions
       }); 	
	 
	/*  layers according to the roleId */				
		var rolelayerList = $("#layerList").val();
		var rolelayerName = rolelayerList.split(",");
		for (var i = 0; i < rolelayerName.length; i++) {
			var lName = rolelayerName[i].replace("[", "");
			lName = lName.replace("]", "");
			
			var lName2 = lName.split("$")[0];
			var lnamevisibility = lName.split("$")[1];
			var visibilityval = (lnamevisibility === "true");  // visibility value conversion to boolean
			var displayName = lName2.toUpperCase();
			var layerNames = workspace + ":" + lName2.trim();
			addWMSLayer(webMapServiceUrl, layerNames.trim(), displayName,
					visibilityval, frontmap);  // Call function to add wms layer
		}		
		
	 /* Adding popup overlay to the map */
	 	 frontpopup = new ol.Overlay({
	 		element: document.getElementById('frontpopup')
	 	});	
	 	 
	 	frontmap.addLayer(basemapgroup);	 			
		//frontmap.addLayer(bingroad);  // Add default base map as a bing road
	 	newPlotsStatus();
	 	frontmap.addOverlay(frontpopup);  // Add feature info overlay to the map
	 	frontmap.addLayer(overlayGroup); // Add overlay group to map
	 	
		/* Adding control for layers switching */
		var layerSwitcher = new ol.control.LayerSwitcher({
			tipLabel : 'Layers'
		});
		
		frontmap.addControl(layerSwitcher); // Adding layers switcher to map object
		layerSwitcher.showPanel();   // Show layer panel in default
		 
		var layerss = overlayGroup.getLayers();
			
		/* clicked on map */	
		frontmap.on('singleclick', function(evt) {
			
		if(fSelectStatus == "on") {
			featureSelction3(evt,startView);
			}else{
				featureInfo2(evt, frontpopup, startView, layerss);  // feature info	
			}
					
		});	

		} 

/* Adding layers to map object */
function addWMSLayer(url, layerName, displayName, visiblevalue, map) {

	var wmsLayer = new ol.layer.Tile({
		title : displayName,
		visible : visiblevalue,
		source : new ol.source.TileWMS({
			url : url,
			params : {
				'LAYERS' : layerName
			},
			serverType : 'geoserver'
		})
	});

	overlayGroup.getLayers().push(wmsLayer);  // adding layers to overlay group
}

/* Function for closing a popup */
function closepopup() {
	$(frontpopup.getElement()).popover('destroy'); // remove popup window from map
}

function newPlotsStatus() {
	
	var getText = function(feature, resolution) {

		var maxResolution = "1.2";
		var text = feature.get('plot_id');

		if (resolution > maxResolution) {
			text = '';
		} else {
			text = text;
		}
		return text;
	};

	var createTextStyle = function(feature, resolution) {
		var align = "center";
		var baseline = "middle";
		var size = "8px";
		var offsetX = parseInt("0", 10);
		var offsetY = parseInt("0", 10);
		var weight = "bold";
		var rotation = "0"

		var fillColor = "#000";

		if (resolution < "1") {
			size = "10px";
		}
		if (resolution < "0.5") {
			size = "15px";
		}

		if (resolution < "0.25") {
			size = "25px";
		}
		if (resolution < "0.2") {
			size = "35px";
		}
		if (resolution < "0.15") {
			size = "45px";
		}
		var font = weight + ' ' + size + ' ' + "Verdana";

		return new ol.style.Text({
			textAlign : align,
			textBaseline : baseline,
			font : font,
			text : getText(feature, resolution),
			fill : new ol.style.Fill({
				color : fillColor
			}),
			offsetX : offsetX,
			offsetY : offsetY,
			rotation : rotation
		});
	};

	var strokecolor = "black";
	var strokewidth = 1;
	
	/*Custom style for plots based on status*/
	var customstyle = function(feature, resolution) {

		if (feature.get('allotment') == "Vacant") {
			fillcolor = "green";
		} else if(feature.get('allotment') == "Processing") {
			fillcolor = "orange";
		}else{
			fillcolor = "red";
		}

		return [ new ol.style.Style({
			stroke : new ol.style.Stroke({
				color : strokecolor,
				width : strokewidth
			}),
			fill : new ol.style.Fill({
				color : fillcolor
			}),
			text : createTextStyle(feature, resolution)
		}) ];

	};

	/* WFS Vector source of plotslayer */
	var newplotSource = new ol.source.Vector(
			{
				format : new ol.format.GeoJSON(),
				url : function(extent, resolution, projection) {
					return webMapServiceUrl + '/ows?service=WFS&version=1.0.0&request=GetFeature&typeName='+workspace+':'+wfsplotslayername+'&outputFormat=application/json&srsname=EPSG:3857&'
					+ 'bbox=' + extent.join(',') + ',EPSG:3857';
				},
				strategy : ol.loadingstrategy.tile(ol.tilegrid.createXYZ({
					maxZoom : 19
				}))
			});

	 plotwfsvector = new ol.layer.Vector({
		
		source : newplotSource//,
		//style : customstyle
	});

	//frontmap.addLayer(plotwfsvector);
}