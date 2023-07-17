var plotswfssource;
var buildingswfssource;
var selectedfeature = [];
var selectioncounts = 0;
var customStyle2;
var attributetable = document.createElement('table');
var attributerowheader = document.createElement('tr');

/*
 * On load function for adding WFS layers to map and layer list to dropdown menu
 * in attribute query
 */
function loadLayers() {
	
	$('#layername').empty();
	$('#layername').html("<option value = 'none'> Select Layer </option>");
	$('#fields').empty();
	$('#fields').html("<option value = 'none'> Select Field </option>");
	$('#idcount').empty();
	$('#idcount').html("<option value = 'none'> Select Value </option>");
	
	if(plotswfssource && buildingswfssource){
		
	}else{
		/* Custom style with transparent */
		var customStyle = new ol.style.Style({
			stroke : new ol.style.Stroke({
				color : "transparent",
				width : 1
			}),
			fill : new ol.style.Fill({
				color : "transparent"
			})
		});
		
		/* Plots wfs layer for feature values */
		var plotswfssource2 = new ol.source.Vector();

		$.ajax({
			url : webMapServiceUrl + '/ows?service=WFS&version=1.0.0&request=GetFeature&typeName='+workspace+':'+wfsplotslayername+'&outputFormat=application/json&srsname=EPSG:3857',
			type: "GET",
			async: false				
		}).done(function(response){
			plotswfssource2.addFeatures(new ol.format.GeoJSON().readFeatures(response));
		});
		
		plotswfssource = new ol.layer.Vector({
			source : plotswfssource2,
			style : customStyle
		});
		
		/* Buildings wfs layer for feature values */
		var buildingswfssource2 = new ol.source.Vector();
		
		$.ajax({
			url : webMapServiceUrl + '/ows?service=WFS&version=1.0.0&request=GetFeature&typeName='+workspace+':'+wfsbuildingslayername+'&outputFormat=application/json&srsname=EPSG:3857',
			type: "GET",
			async: false				
		}).done(function(response){
			buildingswfssource2.addFeatures(new ol.format.GeoJSON().readFeatures(response));
		});

		buildingswfssource = new ol.layer.Vector({
			source : buildingswfssource2,
			style : customStyle
		});
		map.addLayer(plotswfssource);
		map.addLayer(buildingswfssource);
		
	}
	
	$('#layername').append("<option value=\"Plots\">Plots</option>");
	$('#layername').append("<option value=\"Buildings\">Buildings</option>");
	$(attributetable).empty();	
}

/* Onchange function for getting fileds for a selected layer */
function getFileds() {
	
	$('#fields').empty();
	$('#fields').html("<option value = 'none'> Select Field </option>");
	$('#idcount').empty();
	$('#idcount').html("<option value = 'none'> Select Value </option>");
	$(attributetable).empty();
	
	var selectedlayerName = document.getElementById('layername').value;
	var features;
	customStyle2 = new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : "transparent",
			width : 0
		}),
		fill : new ol.style.Fill({
			color : "transparent"
		})
	});
	if (selectioncounts == 1) {
		for (var int = 0; int < selectedfeature.length; int++) {
			selectedfeature[int].setStyle(customStyle2);
		}
		selectedfeature = [];
		selectioncounts = 0;
	}
	plotswfssource.setStyle(customStyle2);
	buildingswfssource.setStyle(customStyle2);

	if (selectedlayerName == "Plots") {
		
		features = plotswfssource.getSource().getFeatures();
		var buildProperties = features[0].getProperties();
		var appendData;
		appendData = "<option value = 'none'> Select Field </option>";
		
		$(attributerowheader).empty();
		$(attributerowheader).append("<th>S.No</th>");
		for (prop in buildProperties) {
			if (prop == "geometry") {
				// Don't add geometry to values
			} else {
				appendData += "<option value = '" + prop + "'>" + prop + " </option>";
				$(attributerowheader).append("<th>"+ prop +"</th>");	
				$('#fields').html(appendData);
			}
		}
	} else if (selectedlayerName == "Buildings") {
		features = buildingswfssource.getSource().getFeatures();
		var buildProperties = features[0].getProperties();
		var appendData;
		appendData = "<option value = 'none'> Select Field </option>";
		$(attributerowheader).empty();
		$(attributerowheader).append("<th>S.No</th>");
		for (prop in buildProperties) {
			if (prop == "geometry") {
			} else {
				appendData += "<option value = '" + prop + "'>" + prop	+ " </option>";
				$(attributerowheader).append("<th>"+ prop +"</th>");	
				$('#fields').html(appendData);
			}
		}
	}
	else {
		$('#fields').empty();
		$('#fields').html("<option value = 'none'> Select Field </option>");
		$('#idcount').empty();
		$('#idcount').html("<option value = 'none'> Select Value </option>");
	}
}

/* Onchange function to get values from each property */
function getValues() {
	$(attributetable).empty();
	if (selectioncounts == 1) {
		for (var int = 0; int < selectedfeature.length; int++) {
			selectedfeature[int].setStyle(customStyle2);
		}
		selectedfeature = [];
		selectioncounts = 0;
	}

	$('#idcount').empty();
	$('#idcount').html("<option value = 'none'> Select Value </option>");

	var selectedlayerName = document.getElementById('layername').value;
	var features;
	var valuesarray = [];

	if (selectedlayerName == "Plots") {
		features = plotswfssource.getSource().getFeatures();
		var selectedfieldName = document.getElementById('fields').value;
		if (selectedfieldName != "none") {
			for (var i = 0; i < features.length; i++) {
				var value = features[i].get(selectedfieldName);
				if (value == "" || value == null || value == undefined || value == '&nbsp;' || value == " " || value == "null") {

				} else {
					valuesarray.push(value);
				}
			}
			getuniquevalues(valuesarray); // Get unique values from array
		}
	}

	else if (selectedlayerName == "Buildings") {
		features = buildingswfssource.getSource().getFeatures();
		var selectedfieldName = document.getElementById('fields').value;
		if (selectedfieldName != "none") {
			for (var i = 0; i < features.length; i++) {
				var value = features[i].get(selectedfieldName);
				if (value == "" || value == null || value == undefined || value == '&nbsp;' || value == " " || value == "null") {

				} else {
					valuesarray.push(value);
				}
			}
			getuniquevalues(valuesarray);
		}
	}

	else {
		$('#fields').empty();
		$('#fields').html("<option value = 'none'> Select Field </option>");
		$('#idcount').empty();
		$('#idcount').html("<option value = 'none'> Select Value </option>");
		$(attributetable).empty();
	}
}

/* Function for getting unique values from array */
function getuniquevalues(arr) {
	var unique = arr.filter(function(item, i, ar) {
		return ar.indexOf(item) === i;
	});
	var appendData;
	appendData = "<option value = 'none'> Select Value </option>";
	for (var int = 0; int < unique.length; int++) {

		$('#idcount').empty();
		appendData += "<option value = '" + unique[int] + "'>" + unique[int]
				+ " </option>";
		$('#idcount').html(appendData);
	}
}

/* On submit of Attribute query */
function onSubmit() {
	
	var selectedlayerName = document.getElementById('layername').value;
	var selectedfieldName = document.getElementById('fields').value;
	var selectedvalue = document.getElementById('idcount').value;

	if (selectedlayerName == 'none') {
		alert("Please select the Layer");
	} else if (selectedfieldName == 'none') {
		alert("Please select the Field");
	} else if (selectedvalue == 'none') {
		alert("Please select the Value");
	} else {
		if (selectioncounts == 1) {
			for (var int = 0; int < selectedfeature.length; int++) {
				selectedfeature[int].setStyle(customStyle2);				
			}
			selectedfeature = [];
			selectioncounts = 0;
		}
		selectedfeature = [];
		var features;
		if (selectedlayerName == "Plots") {

			features = plotswfssource.getSource().getFeatures();
			for (var x = 0; x < features.length; x++) {

				var value = features[x].get(selectedfieldName);
				if (value == selectedvalue) {
					selectioncounts = 1;
					selectedfeature.push(features[x]);
					if (selectedfeature.length == 1) {
						var cnv = document.createElement('canvas');
						var ctx = cnv.getContext('2d');
						var img = new Image();
						img.src = './images/map/hat2.png';
											
						img.onload = function(){
						  var pattern = ctx.createPattern(img, 'repeat');
						  var pattstyle = new ol.style.Style({
							    fill: new ol.style.Fill({
								      color: pattern
								    }),
								stroke : new ol.style.Stroke({
										color : "#FFFF00",
										width : 4,
										lineDash : [ 10, 10 ],
										lineCap : "square"
									})
								  });
						  features[x].setStyle(pattstyle);
						};
						zoomtofeature(features[x]); 
					}
				}
				if (features.length == x + 1) {
					var cnv = document.createElement('canvas');
					var ctx = cnv.getContext('2d');
					var img = new Image();
					img.src = './images/map/hat2.png';
										
					img.onload = function(){
					  var pattern = ctx.createPattern(img, 'repeat');
					  var pattstyle = new ol.style.Style({
						    fill: new ol.style.Fill({
							      color: pattern
							    }),
							stroke : new ol.style.Stroke({
									color : "#FFFF00",
									width : 4,
									lineDash : [ 10, 10 ],
									lineCap : "square"
								})
							  });
					  for (var int2 = 0; int2 < selectedfeature.length; int2++) {
						  selectedfeature[int2].setStyle(pattstyle);
					  }					  
					};
					zoomtofeatures(features[x]); 
				}
			}
		} else if (selectedlayerName == "Buildings") {
			features = buildingswfssource.getSource().getFeatures();
			for (var x = 0; x < features.length; x++) {
				var value = features[x].get(selectedfieldName);
				if (value == selectedvalue) {			
					selectioncounts = 1;
					selectedfeature.push(features[x]);
				
					if (selectedfeature.length == 1) {
						var cnv = document.createElement('canvas');
						var ctx = cnv.getContext('2d');
						var img = new Image();
						img.src = './images/map/hat2.png';
											
						img.onload = function(){
						  var pattern = ctx.createPattern(img, 'repeat');
						  var pattstyle = new ol.style.Style({
							    fill: new ol.style.Fill({
								      color: pattern
								    }),
								stroke : new ol.style.Stroke({
										color : "#FFFF00",
										width : 4,
										lineDash : [ 10, 10 ],
										lineCap : "square"
									})
								  });
						  features[x].setStyle(pattstyle);
						};
						zoomtofeature(features[x]); 
					}
				}
				if (features.length == x + 1) {

					var cnv = document.createElement('canvas');
					var ctx = cnv.getContext('2d');
					var img = new Image();
					img.src = './images/map/hat2.png';										
					img.onload = function(){
					  var pattern = ctx.createPattern(img, 'repeat');
					  var pattstyle = new ol.style.Style({
						    fill: new ol.style.Fill({
							      color: pattern
							    }),
							stroke : new ol.style.Stroke({
									color : "#FFFF00",
									width : 4,
									lineDash : [ 10, 10 ],
									lineCap : "square"
								})
							  });
					  for (var int2 = 0; int2 < selectedfeature.length; int2++) {
						  selectedfeature[int2].setStyle(pattstyle);
					  	}					  
					};
					zoomtofeatures(features[x]); 
				}
			}
		} else {
			alert("Failed to load required parcel");
		}
	}
}

/* Zoom to feature */
function zoomtofeatures(feature) {

	if (selectedfeature.length > 1) {
		$(attributetable).empty();
		attributetable.appendChild(attributerowheader);
		var extent = ol.extent.createEmpty();
		for (var int = 0; int < selectedfeature.length; int++) {
			ol.extent.extend(extent, selectedfeature[int].getGeometry().getExtent());
			var attributerowm = document.createElement('tr');
			attributerowm.setAttribute('onclick', 'zoomtofeatureids('+int+')');
			attributerowm.setAttribute('id', "row"+int);
			var serno = int+1;
			$(attributerowm).append("<td>"+ serno +"</td>");
			var featureProperties = selectedfeature[int].getProperties();
			  for (var p in featureProperties) {
				  	if (featureProperties.hasOwnProperty(p)) {
			        	
			        	if(p=="geometry"){
			        		
			        	} else{
			        		$(attributerowm).append("<td>"+ featureProperties[p] +"</td>");        		
			        	}  
			        }
			    }
			  attributetable.appendChild(attributerowm); 		
		}
		map.getView().fit(extent, map.getSize(),20);
	}
	$('#attributequerydetails').html(attributetable);
}

function zoomtofeature(feature) {
	$(attributetable).empty();
	attributetable.appendChild(attributerowheader);
	var attributerowm = document.createElement('tr');
	attributerowm.setAttribute('onclick', 'zoomtofeatureid(0)');
	attributerowm.setAttribute('id', "row"+feature);
	var featureProperties = feature.getProperties();

	  for (var p in featureProperties) {
		  
		  	if (featureProperties.hasOwnProperty(p)) {
	        	
	        	if(p=="geometry"){
	        		
	        	} else{
	        		$(attributerowm).append("<td>"+ featureProperties[p] +"</td>");        		
	        	}  
	        }
	    }
	attributetable.appendChild(attributerowm); 
	var geom = feature.getGeometry(); // get extent values from feature
	map.getView().fit(geom, map.getSize(),20);
	$('#attributequerydetails').html(attributetable);
}

function zoomtofeatureid(feature){
	
	$("#row0").addClass("attributequeryselectedrow");
	var geom = selectedfeature[feature].getGeometry(); // get extent values from feature
	map.getView().fit(geom, map.getSize(),20);
}

function zoomtofeatureids(feature){
	
	for (var int = 0; int < selectedfeature.length; int++) {
		console.log(int);
		$("#row"+int+"").removeClass("attributequeryselectedrow");
		$("#row"+int+"").addClass("attributequeryunselectedrow");
	}
	
	$("#row"+feature+"").addClass("attributequeryselectedrow");
	var geom = selectedfeature[feature].getGeometry(); // get extent values from feature
	map.getView().fit(geom, map.getSize(),20);	
}