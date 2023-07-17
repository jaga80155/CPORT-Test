var selectedPoint = 0;
var vectorWfsSource;
var vector;
var spatialMarker;
var spatialselect;

/* Onload load layer list to dropdown menu in spatial query and add spatial marker */
function loadwfsLayers(wmsLayersList) {
	
	/* Adding layer list to layers dropdown menu */
	
	for (var i = 0; i < wmsLayersList.length; i++) {
		
		layerName = wmsLayersList[i];
		layerName = layerName.replace("[", "");
		layerName = layerName.replace("]", "");
		layerName = layerName.trim();
	
		$('#wfslayername').append("<option value="+workspace+":" + layerName.split("$")[0].trim() + ">" + layerName.split("$")[0].trim().toLowerCase().charAt(0).toUpperCase() + layerName.split("$")[0].trim().toLowerCase().slice(1) + "</option>");
		$('#wfsfeaturelayer').append("<option value="+workspace+":" + layerName.split("$")[0].trim() + " data-rel=\"close\">" + layerName.split("$")[0].trim().toLowerCase().charAt(0).toUpperCase() + layerName.split("$")[0].trim().toLowerCase().slice(1) + "</option>");

	}

        /* Spatial position marker */
	spatialMarker = new ol.Overlay({
		map : map,
		element : ($('<i/>').addClass('spatialpoint').get(0))  // Marker image from map.css
	});

	map.addOverlay(spatialMarker);   // Adding Spatial marker to the map
}

/* Load WFS layer */
function loadWfsLayer() {
	/* Style for loaded layer fill colors as transparent */
	var customStyle = new ol.style.Style({
		fill : new ol.style.Fill({
			color : "transparent"
		}),
		stroke : new ol.style.Stroke({
			color:"transparent",
			width:2
		})
	});
	if(spatialCount == 1){
		
		cirVectorSource.clear();  // Clear circle if already drawn on map
		map.removeInteraction(spatialselect); // remove select interaction to the map
		spatialCount = 0;
		spatialMarker.setPosition(undefined);  // remove spatial marker from the map
		vectorWfsSource.clear();
	}
	
	var selectedWfsLayer = document.getElementById('wfslayername').value; // Read layer name

	vectorWfsSource = new ol.source.Vector();
	
	$.ajax({
		url : webMapServiceUrl
		+ '/ows?service=WFS&version=1.0.0&request=GetFeature&typeName='
		+ selectedWfsLayer
		+ '&outputFormat=application/json&srsname=EPSG:3857',
		type: "GET",
		async: false				
	}).done(function(response){
		vectorWfsSource.addFeatures(new ol.format.GeoJSON()
        .readFeatures(response));
	});
	
	vector = new ol.layer.Vector({
		source : vectorWfsSource,
		style: customStyle
	});

	map.addLayer(vector); // Add selected wfs layer to map

}

/* Map click function when point on map enabled */
function spatialQuery(evt) {
	
if(spatialCount == 1){
		
		cirVectorSource.clear();  // Clear circle if already drawn on map
		map.removeInteraction(spatialselect); // remove select interaction to the map
		spatialCount = 0;
		spatialMarker.setPosition(undefined);  // remove spatial marker from the map
		//map.removeLayer(vector);
		vectorWfsSource.clear();
		
	}
	selectedPoint = ol.proj.transform(evt.coordinate, 'EPSG:3857','EPSG:900913');// Select middle point to draw a circle
	//alert(selectedPoint);
	spatialMarker.setPosition(evt.coordinate);
	document.getElementById("pointmap").src = "images/map/white_point.png";	
	pointStatus = "off";	
}

var cirVectorSource;
var spatialCount = 0;
/* function after submit click in spatial query */
function onSubmitSpatialQuery() {
	
	var layername = document.getElementById("wfslayername").value;
	var selectedrange = document.getElementById("layerrangevalue").value;
	
	if(layername == 'none')
	{
	   alert("Please select the Layer");
	}
	else if(selectedrange == 'none')
	{
	   alert("Please select the Range");
	}
	else if(selectedPoint == 0)
	{
	   alert("Please select a point on map");
	}
	
	else
	{
		/* Second time submission of spatial query */
		if(spatialCount == 1){
		
			cirVectorSource.clear();
			map.removeInteraction(spatialselect); // Adding select interaction to the map
			spatialCount = 0;
			//map.removeLayer(vector);
			vectorWfsSource.clear();
		}
			
		var radius = document.getElementById('layerrangevalue').value; // circle radius
	
		var circle = new ol.geom.Circle(selectedPoint, parseFloat(radius)); // Draw a circle through the point and radius
		
		cirVectorSource = new ol.source.Vector({
			projection : 'EPSG:900913'
		});
	    var polycircle = ol.geom.Polygon.fromCircle(circle, 64, 90);
	    var circleFeature = new ol.Feature(polycircle); // Creating a circle feature with circle object
		cirVectorSource.addFeature(circleFeature); // Adding circle to vector layer source with projection
	    		
		var circleLayer = new ol.layer.Vector({
			source : cirVectorSource
		});
		spatialCount = 1;
		map.addLayer(circleLayer); // Adding drawn circle to map
		selectedPoint = 0;
				
		/*get selected layer features and geometry*/

		var selectedlayerfeatures = vectorWfsSource.getFeatures();
		var layercoordinates;
		var circlefeatures = cirVectorSource.getFeatures();
		var circlefeaturescoordinates = circlefeatures[0].getGeometry().getCoordinates();
		
		var poly2 = turf.polygon(circlefeaturescoordinates);
		
		/* custom style for intersected features */
		var intersectedfetaturestyle = new ol.style.Style({
			fill : new ol.style.Fill({
				color : "transparent",
				
			}),
			stroke : new ol.style.Stroke({
				color : "blue",
				width : 2
			}),
			image : new ol.style.Circle({   // Circle radius and fill colors for point
				radius : 5,
				fill : new ol.style.Fill({
					color : 'transparent'
				}),
				stroke : new ol.style.Stroke({
					color : "blue",
					width : 2
				})
			})
		});
		
		for(var i=0; i<selectedlayerfeatures.length;i++)
		{
			var geotype;
			var isInside1;
			if(selectedlayerfeatures[i].getGeometry().getType() == "MultiPolygon")
			{
				layercoordinates = selectedlayerfeatures[i].getGeometry().getCoordinates()[0];
				for(var j = 0;j<layercoordinates[0].length;j++)
				{
					geotype = turf.point(layercoordinates[0][j]);
					isInside1 = turf.inside(geotype, poly2);
					if(isInside1 == true)
						break;
				}			
			}
			else if(selectedlayerfeatures[i].getGeometry().getType() == "Polygon" )
			{
				
				layercoordinates = selectedlayerfeatures[i].getGeometry().getCoordinates();
				for(var j = 0;j<layercoordinates[0].length;j++)
				{
					geotype = turf.point(layercoordinates[0][j]);
					isInside1 = turf.inside(geotype, poly2);
					if(isInside1 == true)
						break;
				}			
			}
			else if(selectedlayerfeatures[i].getGeometry().getType() == "MultiLineString" || selectedlayerfeatures[i].getGeometry().getType() == "LineString")
			{
				layercoordinates = selectedlayerfeatures[i].getGeometry().getCoordinates();
				for(var j = 0;j<layercoordinates[0].length;j++)
				{
					geotype = turf.point(layercoordinates[0][j]);
					isInside1 = turf.inside(geotype, poly2);
					if(isInside1 == true)
						break;
				}
			}
			else if(selectedlayerfeatures[i].getGeometry().getType() == "Point" || selectedlayerfeatures[i].getGeometry().getType() == "MultiPoint")
			{
				layercoordinates = selectedlayerfeatures[i].getGeometry().getCoordinates();
				geotype = turf.point(layercoordinates);
				isInside1 = turf.inside(geotype, poly2);
			}
			else
			{
				//alert("Invalid geometry");
			}
		
			if(isInside1 == true)
			{
				selectedlayerfeatures[i].setStyle(intersectedfetaturestyle);
			}				
		}	
	}
}