var gpsStatus = "off";
var pointStatus = "off";
var fSelectStatus = "off";
var fInfoStatus = "off";
var lengthCalStatus = "off";
var areaCalStatus = "off";
var plotregstatus = "off";
var plotsummarystatus = "off";
var plotallocationstatus = "off";
var attributequerystatus = "off";
var spatialquerystatus = "off";
var measureStatus = "off";
var geotype = "LineString";
var legendstatus = "off";
var ownplotstablestatus = "off";
var fSelectStatus2 = "off";
function gpsFunction() {

	if (gpsStatus == "on") {
		gpsOFF();
	} else {
		startgpsWatch();
		document.getElementById("gpsstatus").src = "images/map/gps_on.png";
		gpsStatus = "on";
	}
}

function gpsOFF(){
	document.getElementById("gpsstatus").src = "images/map/gps_off.png";
	gpsStatus = "off";
	stopgpsWatch();
}

/*ON - OFF Functions  -  start*/

function removemapInteractions() {
	map.removeInteraction(selectSingleClick);
	map.removeInteraction(draw);
	measureInteractionCount = 0;
}

function LengthMeasureON() {
	if (spatialquerystatus == "on") {
		spatialpointOFF();
	}

	if (lengthCalStatus == "on") {
		LengthMeasureOFF();
	} else {
		/* ON if lengthCalStatus is OFF */
		AreaMeasureOFF();
		featureInfoOFF();
		featureSelectionOFF();
		AttributeQueryOFF();
		SpatialQueryOFF();
		legendOFF();
		ownplotstableOFF();
		closepopup();

		geotype = "LineString";
		lengthCalStatus = "on";
		document.getElementById("typelength").src = "images/map/yellow_length.png";
		document.getElementById("map").style.cursor = "crosshair";

		map.removeInteraction(selectSingleClick);
	}
}

function LengthMeasureOFF() {
	MeasureunitsOFF();
	closepopup();
	lengthCalStatus = "off";
	document.getElementById("typelength").src = "images/map/white_length.png";
	document.getElementById("map").style.cursor = "default";
	geotype = "Polygon";
	removemapInteractions();
}

function AreaMeasureON() {
	if (spatialquerystatus == "on") {
		spatialpointOFF();
	}

	if (areaCalStatus == "on") {
		AreaMeasureOFF();
	} else {
		LengthMeasureOFF();
		featureInfoOFF();
		featureSelectionOFF();
		AttributeQueryOFF();
		SpatialQueryOFF();
		legendOFF();
		ownplotstableOFF();
		closepopup();

		if (lengthCalStatus == "on") {
			map.removeInteraction(draw);
			measureInteractionCount = 0;
		}
		geotype = "Polygon";
		areaCalStatus = "on";
		document.getElementById("map").style.cursor = "crosshair";
		document.getElementById("typearea").src = "images/map/yellow_area.png";

	}
}

function AreaMeasureOFF() {
	closepopup();
	MeasureunitsOFF();
	areaCalStatus = "off";
	document.getElementById("map").style.cursor = "default";
	document.getElementById("typearea").src = "images/map/white_area.png";

	geotype = "LineString";
	removemapInteractions();
}

function featureInfoON() {
	if (spatialquerystatus == "on") {
		spatialpointOFF();
	}

	if (fInfoStatus == "on") {
		featureInfoOFF();
	} else {
		LengthMeasureOFF();
		AreaMeasureOFF();
		featureSelectionOFF();
		AttributeQueryOFF();
		SpatialQueryOFF();
		legendOFF();
		ownplotstableOFF();
		closepopup();

		fInfoStatus = "on";
		document.getElementById("featureinfos").src = "images/map/yellow_info.png";

	}
}

function MeasureunitsON(){
	if(measureStatus == "on"){
		MeasureunitsOFF();
	}else{
		measureStatus = "on";
		$("#unitsofmeasure").slideToggle("slow");
		document.getElementById("measureunits").src = "images/map/measure_on.png";
		
		featureInfoOFF();
		AttributeQueryOFF();
		SpatialQueryOFF();
		legendOFF();
		ownplotstableOFF();
		featureSelectionOFF();
	}
}

function MeasureunitsOFF(){

	$("#unitsofmeasure").slideUp("slow");
	measureStatus = "off";
	document.getElementById("measureunits").src = "images/map/measure_off.png";
}
function featureInfoOFF() {
	closepopup();
	map.removeInteraction(spatialselect);
	fInfoStatus = "off";
	document.getElementById("featureinfos").src = "images/map/white_info.png";
}

function featureSelectionON() {
	if (spatialquerystatus == "on") {
		spatialpointOFF();
	}

	if (fSelectStatus == "on") {
		featureSelectionOFF();
	} else {
		LengthMeasureOFF();
		AreaMeasureOFF();
		featureInfoOFF();
		AttributeQueryOFF();
		SpatialQueryOFF();
		legendOFF();
		ownplotstableOFF();
		closepopup();
		
		fSelectStatus = "on";
		document.getElementById("fselect").src = "images/map/yellow_select.png";
		/* Loading new wfs layer for feature selection  */
		loadWfsFeatureLayer();
	}
}

function featureSelectionOFF() {
	if (fSelectStatus == "on") {
		
		newbuildingSource.clear(); 		
		WfsSource.clear();
		BWfsSource.clear();
		selectedFeatures = [];		
		map.removeLayer(Bvector); 
		map.removeLayer(vector); 		
	}
	fSelectStatus = "off";
	document.getElementById("fselect").src = "images/map/white_select.png";
	map.removeInteraction(selectSingleClick);
}

function plotregON() {

	if (spatialquerystatus == "on") {
		spatialpointOFF();
	}

	if (plotregstatus == "on") {
		
		if(fSelectStatus2 == "on")
		{

			document.getElementById("myModalPlotRegistration").style.display="block";
			document.getElementById("plotId").value=selectedPlotIds.toString();
	 
		}
		else
		{
			plotregOFF();
		}
		
	} else {

		LengthMeasureOFF();
		AreaMeasureOFF();
		featureInfoOFF();
		featureSelectionOFF();
		AttributeQueryOFF();
		SpatialQueryOFF();
		legendOFF();
		ownplotstableOFF();
		closepopup();
		closebasemapgallery();

		plotregstatus = "on";
		document.getElementById("tplotreg").src = "images/map/yellow_plot_app.png";
		plotRegistration();
		document.getElementById("plotId").value="";
		
	}	
}

function plotregOFF() {
	selectedPlotIds = [];
	plotregstatus = "off";
	fSelectStatus2 = "off";
	map.removeInteraction(selectSingleClick);
	map.removeLayer(PGvector);
	PGvector = undefined;
	map.removeLayer(IBvector);
	IBvector = undefined;
	document.getElementById("tplotreg").src = "images/map/white_plot_app.png";
	document.getElementById("fselect2").src = "images/map/white_select.png";
}

function plotsummaryON() {
	if (spatialquerystatus == "on") {
		spatialpointOFF();
	}

	if (plotsummarystatus == "on") {
		plotsummaryOFF();
	} else {
		LengthMeasureOFF();
		AreaMeasureOFF();
		featureInfoOFF();
		featureSelectionOFF();
		AttributeQueryOFF();
		SpatialQueryOFF();
		legendOFF();
		ownplotstableOFF();
		closepopup();
		closebasemapgallery();
		
		plotsummarystatus = "on";
		document.getElementById("plotsummaryimg").src = "images/map/yellow_piechart.png";
		plotSummary();
	}
}

function plotsummaryOFF() {
	plotsummarystatus = "off";
	document.getElementById("plotsummaryimg").src = "images/map/white_piechart.png";
}

function plotallocationON() {
	if (spatialquerystatus == "on") {
		spatialpointOFF();
	}

	if (plotallocationstatus == "on") {
		plotallocationOFF();
	} else {
		LengthMeasureOFF();
		AreaMeasureOFF();
		featureInfoOFF();
		featureSelectionOFF();
		AttributeQueryOFF();
		SpatialQueryOFF();
		legendOFF();
		ownplotstableOFF();
		closepopup();
		closebasemapgallery();
		
		plotallocationstatus = "on";
		document.getElementById("tplotallocation").src = "images/map/yellow_plot_report.png";
		plotAllocation();
	}
}

function plotallocationOFF() {
	plotallocationstatus = "off";
	document.getElementById("tplotallocation").src = "images/map/white_plot_report.png";
}

function AttributeQueryON() {
	if (spatialquerystatus == "on") {
		spatialpointOFF();
	}

	if (attributequerystatus == "on") {
		AttributeQueryOFF();
	} else {
		
		loadLayers();
		LengthMeasureOFF();
		AreaMeasureOFF();
		featureInfoOFF();
		featureSelectionOFF();
		SpatialQueryOFF();
		legendOFF();
		ownplotstableOFF();
		closepopup();

		attributequerystatus = "on";
		document.getElementById("attributequery").src = "images/map/yellow_attribute.png";
		$("#panel1").slideToggle("slow");
		$("#attributequerydetails").slideToggle("slow");
		
	}
}

function AttributeQueryOFF() {
	if (selectioncounts == 1) {
		
		for (var int = 0; int < selectedfeature.length; int++) {
			selectedfeature[int].setStyle(customStyle2);
		}
		selectedfeature = [];
		selectioncounts = 0;
	}
	attributequerystatus = "off";
	document.getElementById("attributequery").src = "images/map/white_attribute.png";
	$("#panel1").slideUp("slow");
	$("#attributequerydetails").slideUp("slow");
}

function SpatialQueryON() {
	if (spatialquerystatus == "on") {
		SpatialQueryOFF();
	} else {
		LengthMeasureOFF();
		AreaMeasureOFF();
		featureInfoOFF();
		featureSelectionOFF();
		AttributeQueryOFF();
		legendOFF();
		ownplotstableOFF();
		closepopup();

		spatialquerystatus = "on";
		document.getElementById("spatialquery").src = "images/map/yellow_spatial.png";

		$("#panel2").slideToggle("slow");
		
		document.getElementById("wfslayername").value = "none";
		document.getElementById("layerrangevalue").value = "none";
	}
}

function SpatialQueryOFF() {
	spatialquerystatus = "off";
	document.getElementById("spatialquery").src = "images/map/white_spatial.png";
	selectedPoint = 0;
	$("#panel2").slideUp("slow");
	spatialpointOFF();
}

function spatialpointON() {
	if (pointStatus == "on") {
		spatialpointOFF();
	} else {
		pointStatus = "on";
		document.getElementById("pointmap").src = "images/map/yellow_point.png";
	}
}

function spatialpointOFF() {
	pointStatus = "off";
	document.getElementById("pointmap").src = "images/map/white_point.png";
	spatialMarker.setPosition(undefined);
	if (spatialCount == 1) {
		map.removeInteraction(spatialselect);
		cirVectorSource.clear();
		spatialCount = 0;
		vectorWfsSource.clear();
	}
	selectedPoint = 0;
}

function legendOFF()
{
	legendstatus = "off";
	document.getElementById("legend").src = "images/map/white_legend.png";
	$("#panel3").slideUp("slow");
}

function legendON()
{
	if(legendstatus == "on")
		{
			legendOFF();
		}
	else
		{
			LengthMeasureOFF();
			AreaMeasureOFF();
			featureInfoOFF();
			featureSelectionOFF();
			AttributeQueryOFF();
			SpatialQueryOFF();
			ownplotstableOFF();
			closepopup();
		
			legendstatus = "on";
			document.getElementById("legend").src = "images/map/yellow_legend.png";
			$("#panel3").slideToggle("slow");
		
		}	
}

function ownplotstableON()
{
	if(ownplotstablestatus == "on")
		{
			ownplotstableOFF();
		}
	else
		{
			LengthMeasureOFF();
			AreaMeasureOFF();
			featureInfoOFF();
			featureSelectionOFF();
			AttributeQueryOFF();
			SpatialQueryOFF();
			legendOFF();
			closepopup();
		
			ownplotstablestatus = "on";
			document.getElementById("plotstable").src = "images/map/yellow_plots.png";
			$("#bottomtable").slideToggle("slow");
		
		}	
}

function ownplotstableOFF()
{
	ownplotstablestatus = "off";
	document.getElementById("plotstable").src = "images/map/white_plots.png";
	$("#bottomtable").slideUp("slow");
}

/*ON - OFF Functions  -  end*/

function changeCoordinateFormat() {

	var Coordinateformat = document.getElementById('projection').value;
	if (Coordinateformat == 3857) {

		map.removeControl(mousePosition4326);
		map.addControl(mousePosition3857);
	} else if (Coordinateformat == 4326) {
		map.removeControl(mousePosition3857);
		map.addControl(mousePosition4326);
	}
}