var selectSingleClick;
var selectedfeatureLayer;
var BselectedfeatureLayer;
var selectedFeatures = new Array();
var selectedFeatures2 = new Array();
var selectedFeatures3 = new Array();
var selectedPlotIds = new Array();
var alreadySelected = 0;
var WfsSource;
var BWfsSource;
var PGWfsSource;
var vector;
var Bvector;
var PGvector;
var unselectedstyle;
var AGvector;
var FBVector,IBvector;

/* Fill color style for feature*/
var customStyle = new ol.style.Style({
	fill : new ol.style.Fill({
		color : "transparent"
	})
});

/* Function for multiple feature selection */
function featureSelction(evt,startView){
		map.removeInteraction(selectSingleClick);
		selectSingleClick = new ol.interaction.Select();
		
		/* Selected feature style */
		var selectedstyle = new ol.style.Style({
			stroke : new ol.style.Stroke({
				color : "blue",
				width : 2
			}),
			fill : new ol.style.Fill({
				color : "transparent"
			})
		});
		
		/* Unselected feature style */
		unselectedstyle = new ol.style.Style({
			stroke : new ol.style.Stroke({
				color : "black",
				width : 1
			}),
			fill : new ol.style.Fill({
				color : "transparent"
			})
		});
				
		map.addInteraction(selectSingleClick); // add single click interaction		

		var feature = map.forEachFeatureAtPixel(evt.pixel, function(feature,layer) {
			return feature;
		});

		var fid;
			fid = feature.getId();   // get the feature id to set style

		if (selectedFeatures.length == 0) {
			selectedFeatures.push(fid);  // push the selected fid value in array
			feature.setStyle(selectedstyle);
		} else {
			for (var j = 0; j < selectedFeatures.length; j++) {
				if (selectedFeatures[j] == fid) {

					selectedFeatures.splice(j, 1);  // if already selected remove from array
					feature.setStyle(unselectedstyle);  // set unselected style to feature

					var alreadySelected = 1;
					break;
				}
			}
			if (alreadySelected == 1) {
				alreadySelected = 0;
			} else {
				selectedFeatures.push(fid);  // push fid value in selected array
				feature.setStyle(selectedstyle);  // set selected style
				alreadySelected = 0;
			}
		}		
}

/* Load plots WFS layer */ 
function loadWfsFeatureLayer(){

	 selectedfeatureLayer = workspace + ":" + wfsplotslayername;   
     WfsSource = new ol.source.Vector({
        format: new ol.format.GeoJSON(),
        url: function(extent, resolution, projection) {
            return webMapServiceUrl + '/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=' + selectedfeatureLayer + '&outputFormat=application/json&srsname=EPSG:3857&' +
                'bbox=' + extent.join(',') + ',EPSG:3857';
        },
        strategy: ol.loadingstrategy.tile(ol.tilegrid.createXYZ({
            maxZoom: 19
        }))
    });
    
    vector = new ol.layer.Vector({
        source: WfsSource,
        style: customStyle
    });

    map.addLayer(vector); // Add wfs layer to map  
    
    BselectedfeatureLayer = workspace + ":" + wfsbuildingslayername;
    BWfsSource = new ol.source.Vector({
        format: new ol.format.GeoJSON(),
        url: function(extent, resolution, projection) {
            return webMapServiceUrl + '/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=' + BselectedfeatureLayer + '&outputFormat=application/json&srsname=EPSG:3857&' +
                'bbox=' + extent.join(',') + ',EPSG:3857';
        },
        strategy: ol.loadingstrategy.tile(ol.tilegrid.createXYZ({
            maxZoom: 19
        }))
    });
    
    Bvector = new ol.layer.Vector({
        source: BWfsSource,
        style: customStyle
    });

    map.addLayer(Bvector); // Add wfs layer to map     
}

function selectPlots()
{
	alert("Select Intrested Plots / Buildings");
	document.getElementById("myModalPlotRegistration").style.display="none";
    fSelectStatus2 = "on";
    document.getElementById("fselect2").src = "images/map/yellow_select.png";
    if(PGvector && IBvector){
		
	}
	else{
	PGselectedfeatureLayer = workspace + ":" + wfsplotslayername;
    PGWfsSource = new ol.source.Vector({
        format: new ol.format.GeoJSON(),
        url: function(extent, resolution, projection) {
            return webMapServiceUrl + '/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=' + PGselectedfeatureLayer + '&outputFormat=application/json&srsname=EPSG:3857&' +
                'bbox=' + extent.join(',') + ',EPSG:3857';
        },
        strategy: ol.loadingstrategy.tile(ol.tilegrid.createXYZ({
            maxZoom: 19
        }))
    });
    
    PGvector = new ol.layer.Vector({
        source: PGWfsSource,
        style: customStyle
    });

    map.addLayer(PGvector); // Add wfs layer to map 
    
	BGselectedfeatureLayer = workspace + ":" + wfsbuildingslayername;
    BGWfsSource = new ol.source.Vector({
        format: new ol.format.GeoJSON(),
        url: function(extent, resolution, projection) {
            return webMapServiceUrl + '/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=' + BGselectedfeatureLayer + '&outputFormat=application/json&srsname=EPSG:3857&' +
                'bbox=' + extent.join(',') + ',EPSG:3857';
        },
        strategy: ol.loadingstrategy.tile(ol.tilegrid.createXYZ({
            maxZoom: 19
        }))
    });
    
    IBvector = new ol.layer.Vector({
        source: BGWfsSource,
        style: customStyle
    });

    map.addLayer(IBvector); // Add wfs layer to map    
	}
}
function selectPlotsInIndex(){
	alert("Select Intrested Plots / Buildings");
	document.getElementById("myModal").style.display="none";
	fSelectStatus = "on";
    document.getElementById("fselect").src = "images/map/yellow_select.png";	
	if(AGvector && FBVector){
		
	}
	else{
	
	PGselectedfeatureLayer = workspace + ":" + wfsplotslayername;
    PGWfsSource = new ol.source.Vector({
        format: new ol.format.GeoJSON(),
        url: function(extent, resolution, projection) {
            return webMapServiceUrl + '/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=' + PGselectedfeatureLayer + '&outputFormat=application/json&srsname=EPSG:3857&' +
                'bbox=' + extent.join(',') + ',EPSG:3857';
        },
        strategy: ol.loadingstrategy.tile(ol.tilegrid.createXYZ({
            maxZoom: 19
        }))
    });
    
    AGvector = new ol.layer.Vector({
        source: PGWfsSource,
        style: customStyle
    });

    frontmap.addLayer(AGvector); // Add wfs layer to map  
    
	PBselectedfeatureLayer = workspace + ":" + wfsbuildingslayername;
    BGWfsSource2 = new ol.source.Vector({
        format: new ol.format.GeoJSON(),
        url: function(extent, resolution, projection) {
            return webMapServiceUrl + '/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=' + PBselectedfeatureLayer + '&outputFormat=application/json&srsname=EPSG:3857&' +
                'bbox=' + extent.join(',') + ',EPSG:3857';
        },
        strategy: ol.loadingstrategy.tile(ol.tilegrid.createXYZ({
            maxZoom: 19
        }))
    });
    
    FBVector = new ol.layer.Vector({
        source: BGWfsSource2,
        style: customStyle
    });

    frontmap.addLayer(FBVector); // Add wfs layer to map 
	}
}

function featureSelction2(evt,startView){
	map.removeInteraction(selectSingleClick);
	selectSingleClick = new ol.interaction.Select();
	
	/* Selected feature style */
	var selectedstyle = new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : "blue",
			width : 4
		}),
		fill : new ol.style.Fill({
			color : "transparent"
		})
	});
	
	/* Unselected feature style */
	unselectedstyle = new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : "transparent",
			width : 0
		}),
		fill : new ol.style.Fill({
			color : "transparent"
		})
	});
		
	map.addInteraction(selectSingleClick); // add single click interaction		

	var feature = map.forEachFeatureAtPixel(evt.pixel, function(feature,layer) {
		return feature;
	});

	var fid = feature.getId();   // get the feature id to set style
	
	var layername = fid.split(".")[0];
	var fplotid;
	if(layername == wfsplotslayername)
	fplotid = feature.get("plot_id");
	else
	fplotid =  fid.split(".")[1];
		
		if (selectedFeatures2.length == 0) {
		if (apptypevalue == "existing") {
			if (feature.getProperties().userid == $("#currentUserNameId").val()) {
				selectedFeatures2.push(fid); // push the selected fid value in array
				selectedPlotIds.push(fplotid);
				feature.setStyle(selectedstyle);
			} else {
				feature.setStyle(unselectedstyle);
				alert("Sorry, Please Select Plots Which Are Owned By You");
			}
		} else {

			if (feature.getProperties().status != "Occupied") {
				selectedFeatures2.push(fid); // push the selected fid value in array
				selectedPlotIds.push(fplotid);
				feature.setStyle(selectedstyle);
			} else {
				feature.setStyle(unselectedstyle);
				alert("This Plot is Occupied");
			}
		}
	}
 	else {
		for (var j = 0; j < selectedFeatures2.length; j++) {
			if (selectedFeatures2[j] == fid) {

				selectedFeatures2.splice(j, 1); // if already selected remove from array
				selectedPlotIds.splice(j, 1);
				feature.setStyle(unselectedstyle); // set unselected style to feature
				alreadySelected = 1;
				break;
			}
		}
		if (alreadySelected == 1) {
			alreadySelected = 0;
		} else {
			if (feature.getProperties().status != "Occupied") {
				selectedFeatures2.push(fid); // push fid value in selected array
				selectedPlotIds.push(fplotid);
				feature.setStyle(selectedstyle); // set selected style
				alreadySelected = 0;
			} else {
				feature.setStyle(unselectedstyle);
				alert("This Plot is Occupied");
			}
		}
	}
}

function featureSelction3(evt,startView){
	
	frontmap.removeInteraction(selectSingleClick);
	selectSingleClick = new ol.interaction.Select();
	
	/* Selected feature style */
	var selectedstyle = new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : "blue",
			width : 4
		}),
		fill : new ol.style.Fill({
			color : "transparent"
		})
	});
	
	/* Unselected feature style */
	unselectedstyle = new ol.style.Style({
		stroke : new ol.style.Stroke({
			color : "transparent",
			width : 0
		}),
		fill : new ol.style.Fill({
			color : "transparent"
		})
	});
		
	frontmap.addInteraction(selectSingleClick); // add single click interaction		

	var feature = frontmap.forEachFeatureAtPixel(evt.pixel, function(feature,layer) {
		return feature;
	});
	
	var fid = feature.getId();   // get the feature id to set style
	
	var layername = fid.split(".")[0];
	var fplotid;
	if(layername == wfsplotslayername)
	fplotid = feature.get("plot_id");
	else
	fplotid =  fid.split(".")[1];
		
	if (selectedFeatures3.length == 0) {
		if (feature.getProperties().status != "Occupied") {
			selectedFeatures3.push(fid); // push the selected fid value in array
			selectedPlotIds.push(fplotid);
			feature.setStyle(selectedstyle);
		} else {
			feature.setStyle(unselectedstyle);
			alert("This Plot is Occupied");
		}
	} else {
		for (var j = 0; j < selectedFeatures3.length; j++) {
			if (selectedFeatures3[j] == fid) {

				selectedFeatures3.splice(j, 1);  // if already selected remove from array
				selectedPlotIds.splice(j, 1);				
				feature.setStyle(unselectedstyle);  // set unselected style to feature
				var alreadySelected = 1;
				break;
			}
		}
		if (alreadySelected == 1) {
			alreadySelected = 0;
		} else {
			if (feature.getProperties().status != "Occupied") {
				selectedFeatures3.push(fid); // push fid value in selected array
				selectedPlotIds.push(fplotid);
				feature.setStyle(selectedstyle); // set selected style
				alreadySelected = 0;
			} else {
				feature.setStyle(unselectedstyle);
				alert("This Plot is Occupied");
			}
		}
	}
}