/* Global variables */
var map;
var webMapServiceUrl;
var popup;
var overlayGroup;
var wfsgroup;
var centermap;
var buildingwfsvector;
var plotwfsvector;
var newbuildingSource;
var newplotSource;
var workspace;
var wfsplotslayername;
var wfsbuildingslayername;
var mousePosition4326;
var mousePosition3857;
var webserviceurls;
var cusername;
var roleId;
var fromdatevalue,todatevalue,columnname,columnvalue;
var ownPlotSource;
/* Initialization for Map */
function init() {
	
	/* Show plot summary report only for Admin User */
	roleId=document.getElementById("roleId").value;
	cusername = document.getElementById("currentUserNameId").value;
	
	if(roleId==1){
		document.getElementById("adminPlotSummary").style.display='inline-block';
		document.getElementById("legendforAdmin").style.display='inline-block';
		document.getElementById("legendfornormaluser").style.display='none';
		document.getElementById("allUserNames").onmousedown='return true';
		
	}else{
		document.getElementById("adminPlotSummary").style.display='none';
		document.getElementById("legendforAdmin").style.display='none';
		document.getElementById("legendfornormaluser").style.display='inline-block';
		document.getElementById("leaseename").value=document.getElementById("currentUserNameId").value;
	}
	
	/* Reading XML Contents */
	var xmlDoc = readXMLContent();
	var geoServer = xmlDoc.getElementsByTagName('geoserver'); //  Name of geoserver
	var url = geoServer[0].getElementsByTagName("url")[0].childNodes[0].nodeValue; // URL of geoserver
	workspace = geoServer[0].getElementsByTagName("workspace")[0].childNodes[0].nodeValue; // Name of workspace i.e., chennai_port2
	webMapServiceUrl = url + workspace + '/wms'; // Web map service URL
	var basemapProjection = xmlDoc.getElementsByTagName('map')[0].getElementsByTagName("basemapprojection")[0].childNodes[0].nodeValue; // Base map projection value in format of EPSG
	var latitude = xmlDoc.getElementsByTagName('map')[0].getElementsByTagName("lat")[0].childNodes[0].nodeValue; // Latitude of projection location
	var longitude = xmlDoc.getElementsByTagName('map')[0].getElementsByTagName("lon")[0].childNodes[0].nodeValue; // Longitude of projection location	 
	var zoomlevel = xmlDoc.getElementsByTagName('map')[0].getElementsByTagName("zoomto")[0].childNodes[0].nodeValue; // Map zoom level 	  

	wfsplotslayername = geoServer[0].getElementsByTagName("wfsplotslayername")[0].childNodes[0].nodeValue;   //name of wfs plots layer 
	wfsbuildingslayername = geoServer[0].getElementsByTagName("wfsbuildingslayername")[0].childNodes[0].nodeValue;   //name of wfs plots layer
	webserviceurls = geoServer[0].getElementsByTagName("webserviceurl")[0].childNodes[0].nodeValue;
	
	satellitebasemapgroup = new ol.layer.Tile({
	    name: 'satellite',
	    source : new ol.source.TileWMS({
			url : webMapServiceUrl,
			params : {
				'LAYERS' : workspace + ':Chennaiport_image'
			},
			serverType : 'geoserver'
		})
	});
	
	/* Overlay layers group */
	overlayGroup = new ol.layer.Group({
		title : 'Layers'
	});
	
	wfsgroup = new ol.layer.Group({
//		title : 'WFS Layers'
	});

	/* Float Conversion of Coordinates */
	var lat = parseFloat(latitude);
	var lon = parseFloat(longitude);

	centermap = ol.proj.transform([ lat, lon ], basemapProjection,
			'EPSG:900913');

	/* Projection view specifications*/
	var startView = new ol.View({
		center : centermap,
		zoom : zoomlevel
	});

	/* Remove map rotation feature */

	var interactions = ol.interaction.defaults({
		altShiftDragRotate : true,
		pinchRotate : false
	});	
	  
	/* Creating map object */
	map = new ol.Map({
		target : 'map',
		
		view : startView,
		controls : ol.control.defaults().extend([ new ol.control.ScaleLine({
			className : 'ol-scale-line',
			target : document.getElementById('scale-line')
		}) ]),
		interactions : interactions
	});

	addGpsMarker(); //Add gps marker to map	
	
	//Show mouse coordinates
	mousePosition4326 = new ol.control.MousePosition({
		coordinateFormat : myFormat(4),
		projection : 'EPSG:4326',
		target : document.getElementById('mousecoordinates'),
		undefinedHTML : 'Mouse is not hover on map'
	});
	
	mousePosition3857 = new ol.control.MousePosition({
		coordinateFormat : myFormat2(4),
		target : document.getElementById('mousecoordinates'),
		undefinedHTML : 'Mouse is not hover on map'
	});
	
	map.addControl(mousePosition4326);
	
	//  layers according to the roleId				
	var rolelayerList = $("#layerList").val();
	var rolelayerName = rolelayerList.split(",");
	for (var i = 0; i < rolelayerName.length; i++) {
		var lName = rolelayerName[i].replace("[", "");
		lName = lName.replace("]", "");
		
		var lName2 = lName.split("$")[0];
		var lnamevisibility = lName.split("$")[1];
		var visibilityval = (lnamevisibility === "true");
		var displayName = lName2.toUpperCase();
		var layerNames = workspace + ":" + lName2.trim();
		addWMSLayer(webMapServiceUrl, layerNames.trim(), displayName,
				visibilityval, map);
	}
	
	newPlotsStatus();
	buildingsStyle();
	map.addLayer(wfsgroup);
	map.addLayer(overlayGroup); // Add overlay group to map
	showOwnPlots();
	/* Adding control for layers switching */
	var layerSwitcher = new ol.control.LayerSwitcher({
		tipLabel : 'Layers'
	});

	map.addControl(layerSwitcher); // Adding layers switcher to map object

	layerSwitcher.showPanel();

	/* Adding popup overlay to the map */
	popup = new ol.Overlay({
		element : document.getElementById('popup')
	});
	
	map.addOverlay(popup);

	/* Load layers for spatial query */
	loadwfsLayers(rolelayerName.reverse());
	
	/* Loading new wfs layer for feature selection 
	loadWfsFeatureLayer(); */
	
	/* Load Mesure requirements*/
	loadMeasureRequirements();

	/* clicked on map */
	var layerss = overlayGroup.getLayers();

	map.on('singleclick', function(evt) {

		if (lengthCalStatus == "on") {
			addMeasureInteraction(); 
		}
		else if (areaCalStatus == "on") {
			addMeasureInteraction(); 
		} 
		else if (fInfoStatus == "on") {
			featureInfo2(evt, popup, startView, layerss);
		}
		else if (fSelectStatus == "on") {
			featureSelction(evt, startView); 
		}else if (fSelectStatus2 == "on") {
			featureSelction2(evt, startView); 
		}
		else if (pointStatus == "on") {
				if (document.getElementById('wfslayername').value == "none") {
					alert("Please select the layer ");
					 } 
				else {
					spatialQuery(evt); // Spatial query
					 }
		}
		else{
			spatialMarker.setPosition(undefined);
			map.removeInteraction(draw);
			map.removeInteraction(selectSingleClick);
			$(popup.getElement()).popover('destroy');
			if(source)
			source.clear();
			if(cirVectorSource)
			cirVectorSource.clear();
			map.removeInteraction(spatialselect); // Adding select interaction to the map
			if(vectorWfsSource)
			vectorWfsSource.clear();			
		}
	});

	$(map.getViewport()).on('click', measurevalues()); // measure geometry

	var exportPNGElement = document.getElementById('export-png');

	exportPNGElement.addEventListener('click', function(e) {
		map.once('postcompose', function(event) {
			var canvas = event.context.canvas;
			exportPNGElement.href = canvas.toDataURL('image/png');
		});
		map.renderSync();
	}, false);
	
	if(roleId == "1" || roleId =="2"){
		
	}else{
		$("#tabledatabutton").css("display","none");
		$("#reporttype").css("display","none");
		$("#datalist").css("display","none");
		$("#dateduration").css("display","none");
		
		loadplotdetails("get_totalplotdetails","Userid",document.getElementById("currentUserName").value,"Own Plots Details");
	}

	$('#tabledatabutton').on('click', function() {

		var datatypevalue = $("#reportfor").val();
		var statustypevalue = $("#reporttype").val();
		if(statustypevalue == "none"){
			alert("Select report type");
		}else{
			
		$("#bottomtabledata").html("<h4>Loading..</h4>");
	    if(datatypevalue == 'plots' && statustypevalue == 'all')
	    {	    	
	    	loadplotdetails("get_totalplotdetails","all","all","Total Plots Details");
	    }
	    else if(datatypevalue == 'plots' && statustypevalue == 'vacant')
	    {	   	
	    	loadplotdetails("get_totalplotdetails","Status","Available", "Vacant Plots Details");
	    }
	    else if(datatypevalue == 'plots' && statustypevalue == 'processing')
	    {
	    	loadplotdetails("get_totalplotdetails","Status","Processing","Processing Plots Details");
	    }
	    else if(datatypevalue == 'plots' && statustypevalue == 'allotted')
	    {
	    	loadplotdetails("get_totalplotdetails","Status","Occupied", "Allotted Plots Detials");
	    }
	    else if(datatypevalue == 'plots' && statustypevalue == 'cb')
    	{
	    	loadplotdetails("get_totalplotdetails", "Custom Bound Or Not","CB", "Custom Bound Plot Details");
    	}
	    else if(datatypevalue == 'plots' && statustypevalue == 'ncb')
    	{
	    	loadplotdetails("get_totalplotdetails","Custom Bound Or Not","NCB", "Non Custom Bound Plot Details");
    	}
	    else if(datatypevalue == 'plots' && statustypevalue == 'allotte')
	    {   		
    		var allottename = $("#datalist").val();
    		if(allottename == "none"){
    			alert("Select Value");
    			$("#bottomtabledata").html("");
    		}else{   			
    		var actualname = allottename;
    		if(actualname.includes("%26")){
    			var t = document.getElementById("datalist");
    			actualname = t.options[t.selectedIndex].text;
    		}
    		loadplotdetails("get_totalplotdetails","Allotte Name",allottename,actualname+" Plot Details");
    		}
	    }
	    else if(datatypevalue == 'plots' && statustypevalue == 'typewise')
	    {   		
    		var typewise = $("#datalist").val();
    		if(typewise == "OS"){
    			loadplotdetails("get_totalplotdetails","Type","OS","OpenSpace Plot Details");   
    		}else if(typewise == "OSD"){
    			loadplotdetails("get_totalplotdetails","Type","OSD","OpenSpace Developed Plot Details");   
    		}else{
    			alert("select value");
    			$("#bottomtabledata").html("");
    		}   		 		
    	}
	    else if(datatypevalue == 'plots' && statustypevalue == 'period')
	    {    		
    		var period = $("#datalist").val();
    		loadplotdetails("get_totalplotdetails","Period Of Allotments In Months",period,period+" Months Allotted Plot Details");
    		$("#bottomtabledata").html("");
    	}
	    else if(datatypevalue == 'plots' && statustypevalue == 'duration'){   		
    		var fromdate = $("#fromperioddate").val();
    		var todate = $("#toperioddate").val();
    		
    		$("#bottomtabledata").html("");
    		loadplotdetailsdatewise("get_totalplotdetails",btoa(fromdate), btoa(todate) , "Plot Alllocation Between "+fromdate+" and "+todate+ "Details");
    	}
	    
	    //for  buildings
	    else if(datatypevalue == 'buildings' && statustypevalue == 'all')
	    {
	    	loadplotdetails("get_totalbuildingsdetails","all","all","Total Buildings Details");	
	    }
	    else if(datatypevalue == 'buildings' && statustypevalue == 'vacant')
	    {    	
	    	loadplotdetails("get_totalbuildingsdetails","Status","Vacant"," Buildings Details");	
	   	}
	    else if(datatypevalue == 'buildings' && statustypevalue == 'portuse')
	    {    	
	    	loadplotdetails("get_totalbuildingsdetails","Status","Occupied","Port Use Buildings Details");		
	    }
	    else if(datatypevalue == 'buildings' && statustypevalue == 'allotted')
	    {	    	
	    	loadplotdetails("get_totalbuildingsdetails","Status","Allotted","Allotted Buildings Details");			
	    }  
	    else if(datatypevalue == 'buildings' && statustypevalue == 'cb')
    	{	    	
	    	loadplotdetails("get_totalbuildingsdetails","Custom Bound Or Not","CB","Custom Bound Buildings Details");			
    	}
	    else if(datatypevalue == 'buildings' && statustypevalue == 'ncb')
    	{	    	
	    	loadplotdetails("get_totalbuildingsdetails","Custom Bound Or Not","NCB","Non Custom Bound Buildings Details");	
    	}
	    else if(datatypevalue == 'buildings' && statustypevalue == 'allotte')
	    {    		
    		var allottename = $("#datalist").val();
    		var actualname = allottename;
    		if(actualname.includes("%26")){
    			var t = document.getElementById("datalist");
    			actualname = t.options[t.selectedIndex].text;
    		}
    		loadplotdetails("get_totalbuildingsdetails","Leasee Name",allottename,actualname+" Buildings Details");			
    	}
	    else if(datatypevalue == 'buildings' && statustypevalue == 'typewise')
	    {   		
    		var typewise = $("#datalist").val();
    		loadplotdetails("get_totalbuildingsdetails","Type" ,typewise, typewise+" Buildings Details");		
    	}	    
    	else if(datatypevalue == 'buildings' && statustypevalue == 'period')
    	{    		
    		var period = $("#datalist").val();
    		$("#bottomtabledata").html("");
    		loadplotdetails("get_totalbuildingsdetails","Preiod Of Allotment",period,"Preiod Of Allotment "+period+" Months Buildings Details");			
    	}
    	else if(datatypevalue == 'buildings' && statustypevalue == 'duration')
    	{   		
    		var fromdate = $("#fromperioddate").val();
    		var todate = $("#toperioddate").val();
    		
    		$("#bottomtabledata").html("");
    		loadplotdetailsdatewise("get_totalbuildingsdetails",btoa(fromdate), btoa(todate) , "Buiding Alllocation Between "+fromdate+" and "+todate+ "Details"); 	
    	}
	}
	});	
}

function exportasxls(){
	
	if(roleId == 1 || roleId == 2) {
		
	var datatypevalue = $("#reportfor").val();
	var statustypevalue = $("#reporttype").val();
	if(statustypevalue == "none"){
		alert("Select report type");
	}else{		
	var apiName = "";
	if(datatypevalue =="plots"){
		apiName = "get_totalplotdetails";
	}else{
		apiName = "get_totalbuildingsdetails";
	}
	var filepath = "PlotDetails.xls";
	if(datatypevalue == 'plots' && statustypevalue == 'all')
    {	
		columnname="all";
		columnvalue="all";
		filepath = "Total Plots Details.xls";
    	
    }
    else if(datatypevalue == 'plots' && statustypevalue == 'vacant')
    {	
    	columnname="Status";
		columnvalue="Available";
		filepath = "Vacant Plots Details.xls";
    	
    }
    else if(datatypevalue == 'plots' && statustypevalue == 'processing')
    {
    	columnname="Status";
		columnvalue="Processing";
		filepath = "Processing Plots Details.xls";
    }
    else if(datatypevalue == 'plots' && statustypevalue == 'allotted')
    {
    	columnname="Status";
		columnvalue="Occupied";
		filepath = "Allotted Plots Detials.xls";
    }
    else if(datatypevalue == 'plots' && statustypevalue == 'cb')
	{
    	columnname="Custom Bound Or Not";
		columnvalue="CB";
		filepath = "Custom Bound Plot Details.xls";
		
	}
    else if(datatypevalue == 'plots' && statustypevalue == 'ncb')
	{
    	columnname="Custom Bound Or Not";
		columnvalue="NCB";
		filepath = "Non Custom Bound Plot Details.xls";
		
	}
    else if(datatypevalue == 'plots' && statustypevalue == 'allotte')
    {   		
		var allottename = $("#datalist").val();
		if(allottename == "none"){
			alert("Select Value");
			$("#bottomtabledata").html("");
		}else{   			
		var actualname = allottename;
		if(actualname.includes("%26")){
			var t = document.getElementById("datalist");
			actualname = t.options[t.selectedIndex].text;
		}
		columnname="Allotte Name";
		columnvalue=allottename;
		filepath = ""+actualname+" Plot Details.xls";	
		}
    }
    else if(datatypevalue == 'plots' && statustypevalue == 'typewise')
    {   		
		var typewise = $("#datalist").val();
		if(typewise == "OS"){
			columnname="Type";
			columnvalue="OS";
			filepath = "OpenSpace Plot Details.xls";
			
		}else if(typewise == "OSD"){
			columnname="Type";
			columnvalue="OSD";
			filepath = "OpenSpace Developed Plot Details.xls";			
		}else{
			alert("select value");
			$("#bottomtabledata").html("");
		}   		 		
	}
    else if(datatypevalue == 'plots' && statustypevalue == 'period')
    {    		
			var period = $("#datalist").val();
			columnname="Period Of Allotments In Months";
			columnvalue = period; 
		    filepath = "Period of Allotments in "+ columnvalue +"months Plots.xls";
	}
    else if(datatypevalue == 'plots' && statustypevalue == 'duration'){   		
		var fromdate = $("#fromperioddate").val();
		var todate = $("#toperioddate").val();
		
		$("#bottomtabledata").html("");
		var fromdate = $("#fromperioddate").val();
		var todate = $("#toperioddate").val();
		
		fromdatevalue = btoa(fromdate);
		todatevalue = btoa(todate);
		filepath = "From "+ fromdate + " To "+ todate +" Plots.xls";
	}
    
    //for  buildings
    else if(datatypevalue == 'buildings' && statustypevalue == 'all')
    {
    	columnname="all";
		columnvalue="all";
		filepath = "Total Buildings Details.xls";					
    }
    else if(datatypevalue == 'buildings' && statustypevalue == 'vacant')
    {    
    	columnname="Status";
		columnvalue="Vacant";
		filepath = "Vacant Buildings Details.xls";		

   	}
    else if(datatypevalue == 'buildings' && statustypevalue == 'occupied')
    {    	
    	columnname="Status";
		columnvalue="Occupied";
		filepath = "Port Use Buildings Details.xls";		
    }
    else if(datatypevalue == 'buildings' && statustypevalue == 'allotted')
    {	    
    	columnname="Status";
		columnvalue="Allotted";
		filepath = "Allotted Buildings Details.xls";		
    }  
    else if(datatypevalue == 'buildings' && statustypevalue == 'cb')
	{
    	columnname="Custom Bound Or Not";
    	columnvalue="CB";
    	filepath = "Custom Bound Buildings Details.xls";
    	
	}
    else if(datatypevalue == 'buildings' && statustypevalue == 'ncb')
	{	 
    	columnname="Custom Bound Or Not";
    	columnvalue="NCB";
    	filepath = "Non Custom Bound Buildings Details.xls";
    	
	}
    else if(datatypevalue == 'buildings' && statustypevalue == 'allotte')
    {    		
		var allottename = $("#datalist").val();
		if(allottename == "none"){
			alert("Select Value");
			$("#bottomtabledata").html("");
		}else{  
		var actualname = allottename;
		if(actualname.includes("%26")){
			var t = document.getElementById("datalist");
			actualname = t.options[t.selectedIndex].text;
		}
		columnname="Leasee Name";
    	columnvalue=allottename;
    	filepath = ""+actualname+" Buildings Details.xls";
	}
		}
    else if(datatypevalue == 'buildings' && statustypevalue == 'typewise')
    {   
    	
		var typewise = $("#datalist").val();
		columnname="Type";
    	columnvalue=typewise;
    	filepath = ""+typewise+" Buildings Details.xls";
    	
	}	    
	else if(datatypevalue == 'buildings' && statustypevalue == 'period')
	{    		
		var period = $("#datalist").val();
		
		$("#bottomtabledata").html("");		
		columnname="Period Of Allotments In Months";
		columnvalue = period; 
	    filepath = "Period of Allotments "+ columnvalue +"months Buildings.xls";
					
	}
	else if(datatypevalue == 'buildings' && statustypevalue == 'duration')
	{   		
		var fromdate = $("#fromperioddate").val();
		var todate = $("#toperioddate").val();
		$("#bottomtabledata").html("");
		
		fromdatevalue = btoa(fromdate);
		todatevalue = btoa(todate);
		
	    filepath = "From "+ fromdate + " To "+ todate +" Buildings.xls";
	}
	
	var strURL;
	
	if(statustypevalue == "duration"){
		strURL = webserviceurls + "allplotdetailsdatewise?apiname=" + apiName + "&inputparams=&inputparamsdelimeter=@&fromvalue="+fromdatevalue+"&tovalue="+todatevalue+"&outputexcelname="+filepath+"&dateformat="+btoa("MM/dd/yyyy");			  

	}else{
		strURL = webserviceurls + "allplotdetails?apiname=" + apiName + "&inputparams=&inputparamsdelimeter=@&columnname="+columnname+"&columnvalue="+columnvalue+"&outputexcelname="+filepath;			   
	}
	    var a = document.createElement('a');    
	    console.log(strURL);
	    document.body.appendChild(a);
	    a.setAttribute("type", "hidden");	  
	    a.href = strURL;
	    a.download = filepath;
	    a.click();	
}
	} else {
		
		if($("#reportfor").val() == "plots") {
			
			var a = document.createElement('a');    
		    var strURL = webserviceurls + "allplotdetails?apiname=get_totalplotdetails&inputparams=&inputparamsdelimeter=@&columnname=Userid&columnvalue="+document.getElementById("currentUserName").value+"&outputexcelname=Ownplotsdetails.xls";	
		    console.log(strURL);
		    document.body.appendChild(a);
		    a.setAttribute("type", "hidden");	  
		    a.href = strURL;
		    a.download = 'Ownplotsdetails.xls';
		    a.click();	
		} else {
			
			var a = document.createElement('a');    
		    var strURL = webserviceurls + "allplotdetails?apiname=get_totalbuildingsdetails&inputparams=&inputparamsdelimeter=@&columnname=Userid&columnvalue="+document.getElementById("currentUserName").value+"&outputexcelname=OwnBuildingsdetails.xls";	
		    console.log(strURL);
		    document.body.appendChild(a);
		    a.setAttribute("type", "hidden");	  
		    a.href = strURL;
		    a.download = 'Ownplotsdetails.xls';
		    a.click();
		}		
	}
}
function exportaspdf()
{
  var mywindow = window.open('', 'PRINT', 'height=600,width=800');

    mywindow.document.write('<html><head><title>Plot Status Details</title><style>table, td, th{border: 1px solid black !important; border-collapse: collapse; padding: 2px 5px; color: black; background: white; }</style>');
    mywindow.document.write('</head><body style="text-align:center;">');
    mywindow.document.write("<div><img src='data:image/png;base64,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' height='100px' width='100%'></div>");
    if($("#reportfor").val() == "plots"){
    mywindow.document.write('<h1 style="text-align:center;">Plot Details</h1>');
    }
    else{
    mywindow.document.write('<h1 style="text-align:center;">Building Details</h1>');
    }
    mywindow.document.write(document.getElementById("plotdatatable").outerHTML); //table id
    mywindow.document.write('</body></html>');
    mywindow.document.close(); // necessary for IE >= 10
    mywindow.focus(); // necessary for IE >= 10*/
    mywindow.print();
    mywindow.close();
    return true;
}

/* Adding layers to map object */
function addWMSLayer(url, layerName, displayName, visiblevalue, map) {

	var wmsLayer = new ol.layer.Tile({
		title : displayName,
		visible : visiblevalue,
		source : new ol.source.TileWMS({
			url : url,
			crossOrigin: 'anonymous',
			params : {
				'LAYERS' : layerName
			},
			serverType : 'geoserver'
		})
	});

	overlayGroup.getLayers().push(wmsLayer);
}

function reports() {
	window.location.href = "getreports";
}

function closepopup() {
	$(popup.getElement()).popover('destroy'); // remove popup window from map
	source.clear();
	if(fullimgstatus == 1)
	   { closefullimage(); }
}

function CenterMap() {
	if(gpsStatus == "on"){
		gpsOFF();
	}
	map.getView().setCenter(centermap);
	map.getView().setZoom(18);
}

function rotatemap()
{
	map.getView().rotate(0);
	ro = 0;
	document.getElementById("compassimg").style.transform = "rotate("+ro+"deg)";
}

var ro = 0;

function anticrotate()
{
var currentRotation = map.getView().getRotation();
map.getView().rotate(currentRotation - Math.PI /18);
ro = ro - 10;
document.getElementById("compassimg").style.transform = "rotate("+ro+"deg)";
}

function crotate()
{
	var currentRotation = map.getView().getRotation();
	map.getView().rotate(currentRotation + Math.PI /18);
	ro = ro + 10;
	document.getElementById("compassimg").style.transform = "rotate("+ro+"deg)";
}

function plotRegistrationForm() {

	window.open("appDetails", "myWindow", "width=1500, height=1500");
}

function newPlotsStatus() {
		
	/* WFS Vector source of plotslayer */
	newplotSource = new ol.source.Vector(
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
		title:"PLOTS_WFS",
		source : newplotSource,
		style : new ol.style.Style({
			stroke : new ol.style.Stroke({
				color : "transparent",
				width : 0
			}),
			fill : new ol.style.Fill({
				color : "transparent"
			})
		})
	});

	wfsgroup.getLayers().push(plotwfsvector);
}

function buildingsStyle() {

	/* WFS Vector source of plotslayer */
	newbuildingSource = new ol.source.Vector(
			{
				format : new ol.format.GeoJSON(),
				url : function(extent, resolution, projection) {
					return webMapServiceUrl + '/ows?service=WFS&version=1.0.0&request=GetFeature&typeName='+workspace+':'+wfsbuildingslayername+'&outputFormat=application/json&srsname=EPSG:3857&'
					+ 'bbox=' + extent.join(',') + ',EPSG:3857';						
				},
				strategy : ol.loadingstrategy.tile(ol.tilegrid.createXYZ({
					maxZoom : 19
				}))
			});
	
	
	 buildingwfsvector = new ol.layer.Vector({
		title:"BUILDINGS_WFS",
		source : newbuildingSource,
		style : new ol.style.Style({
			stroke : new ol.style.Stroke({
				color : "transparent",
				width : 0
			}),
			fill : new ol.style.Fill({
				color : "transparent"
			})
		})
	});

	wfsgroup.getLayers().push(buildingwfsvector);
}

var myFormat = function(dgts)
{
  return (
    function(coord1) {
    	
    	    var lat = coord1[1];  //coord1[1].toFixed(4);
    	    var lon = coord1[0];   //coord1[0].toFixed(4);
    	    var ns =  deg_to_dms(lat) + " N"; 
    	    var ew = deg_to_dms(lon) + " E"; 
    	    
    	    return ' ' + 'Latitude:' + ' ' + ns + ' &nbsp;|&nbsp;'
    		+ ' ' + ' Longitude :'+ ' ' + ew;
  });  
};

var myFormat2 = function(dgts)
{
  return (
    function(coord1) {
    	var secondProjection = 'PROJCS["WGS 84 / UTM zone 44N",GEOGCS["WGS 84",DATUM["WGS_1984",SPHEROID["WGS 84",6378137,298.257223563,AUTHORITY["EPSG","7030"]],AUTHORITY["EPSG","6326"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],UNIT["degree",0.0174532925199433,AUTHORITY["EPSG","9122"]],AUTHORITY["EPSG","4326"]],PROJECTION["Transverse_Mercator"],PARAMETER["latitude_of_origin",0],PARAMETER["central_meridian",81],PARAMETER["scale_factor",0.9996],PARAMETER["false_easting",500000],PARAMETER["false_northing",0],UNIT["metre",1,AUTHORITY["EPSG","9001"]],AXIS["Easting",EAST],AXIS["Northing",NORTH],AUTHORITY["EPSG","32644"]]';
    	var firstProjection = 'PROJCS["WGS 84 / Pseudo-Mercator",GEOGCS["WGS 84",DATUM["WGS_1984",SPHEROID["WGS 84",6378137,298.257223563,AUTHORITY["EPSG","7030"]],AUTHORITY["EPSG","6326"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],UNIT["degree",0.0174532925199433,AUTHORITY["EPSG","9122"]],AUTHORITY["EPSG","4326"]],PROJECTION["Mercator_1SP"],PARAMETER["central_meridian",0],PARAMETER["scale_factor",1],PARAMETER["false_easting",0],PARAMETER["false_northing",0],UNIT["metre",1,AUTHORITY["EPSG","9001"]],AXIS["X",EAST],AXIS["Y",NORTH],EXTENSION["PROJ4","+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +wktext  +no_defs"],AUTHORITY["EPSG","3857"]]';
   		
    	    var lat = coord1[1]; 
    	    var lon = coord1[0]; 
    	    var coordinates = proj4(firstProjection,secondProjection,[lon,lat]);
    	    return ' X : '+' ' + coordinates[0].toFixed(4) + ' &nbsp;|&nbsp;' + ' Y : '+' ' + coordinates[1].toFixed(4);	    	
  });  	  
};

function deg_to_dms(deg){
	   var d = Math.floor (deg);
	   var minfloat = (deg-d)*60;
	   var m = Math.floor(minfloat);
	   var secfloat = (minfloat-m)*60;
	   var s = Math.round(secfloat);
	   // After rounding, the seconds might become 60. These two
	   // if-tests are not necessary if	 no rounding is done.
	   if (s==60) {
	     m++;
	     s=0;
	   }
	   if (m==60) {
	     d++;
	     m=0;
	   }
	   return ("" + d + "&#176; " + m + "' " + s + "''");
	}

function getplotdetails(apiname, inparams, delimeterr){
	
	var apiName = apiname;
		inputParams = inparams;
	var delimeter = delimeterr;

	// For Get User detail's based on username
	var strURL = webserviceurls + "jsontable?apiname=" + apiName
			+ "&inputparams=" + inputParams + "&inputparamsdelimeter="
			+ delimeter;
	console.log(strURL);
    var plotsresponse;
	$.ajax({
		type : "GET",
		url : strURL,
		dataType : 'json',
		async: false,
		success : function(response) {
			plotsresponse = response;
		},
		failure : function(response) {
			alert("fail");
		},
		error : function(response) {
			alert("error");
			alert(response.result);
		}

	});
	return plotsresponse;
}

var $ajaxrequest;
function getdataarray(apiname, inputParams,inparams, inparams2, delimeterr){
	
	// For Get User detail's based on username
	var strURL = webserviceurls + "allplotdetailsforreport?apiname=" + apiname + "&inputparams=" + inputParams + "&inputparamsdelimeter=" + delimeterr+"&columnname="+inparams+"&columnvalue="+inparams2;	

    $ajaxrequest = $.ajax({
		type : "GET",
		url : strURL,
		dataType : 'json',
	});
	return $ajaxrequest;
}

function getdataarraydatewise(apiname, inputParams,inparams, inparams2, delimeterr){
	
	// For Get User detail's based on username
	var strURL = webserviceurls + "allplotdetailsreportdatewise?apiname=" + apiname	+ "&inputparams=" + inputParams + "&inputparamsdelimeter=" + delimeterr+"&fromdate="+inparams+"&todate="+inparams2+"&dateformat="+btoa("MM/dd/yyyy");
	
    $ajaxrequest = $.ajax({
		type : "GET",
		url : strURL,
		dataType : 'json',
	});
	return $ajaxrequest;
}

var reportfor;
var reporttype;

function loadreporttype(){
	reportfor = $("#reportfor").val();
	if(roleId=="1" || roleId=="2"){
		
	}else{
		if(reportfor == "plots"){
			
			loadplotdetails("get_totalplotdetails","Userid",document.getElementById("currentUserName").value,"Own Plots Details");
		}else{
			loadplotdetails("get_totalbuildingsdetails","Userid",document.getElementById("currentUserName").value,"Own Buildings Details");

		}	
	}
	if(reportfor == "plots"){
		
		$("#reporttype").empty();
		$("#datalist").css("display","none");
		$("#dateduration").css("display","none");
		$("#reporttype").append("<option value='none' >Select report type</option>" +
				" <option value='all' >All</option>" +
				"<option value='vacant'>Vacant</option>" +
				"<option value='allotted' >Allotted</option>" +
				"<option value='processing'>Processing</option>" +
				"<option value='cb'>CB</option>" +
				"<option value='ncb'>NCB</option>" +
				"<option value='typewise'>Type of Plot</option>"+
				"<option value='allotte'>Party Wise</option>" +
				"<option value='period'>Period of Allotment</option>" +
				"<option value='duration'>From Date To Date</option>");
	}else{
		$("#reporttype").empty();
		$("#datalist").css("display","none");
		$("#dateduration").css("display","none");
		$("#reporttype").append("<option value='none' >Select report type</option>" +
				"<option value='all' >All</option>" +
				"<option value='vacant'>Vacant</option>" +
				"<option value='allotted' >Allotted</option>" +
				"<option value='portuse'>Port Use</option>" +
				"<option value='cb'>CB</option>" +
				"<option value='ncb'>NCB</option>" +
				"<option value='typewise'>Type of Building</option>" +
				"<option value='allotte'>Party Wise</option>" +
				"<option value='period'>Period of Allotment</option>" +
				"<option value='duration'>From Date To Date</option>");
	}
	$("#reporttitle").html("");
	$("#bottomtabledata").empty();
}

function loaddatalist() {
	
	reporttype = $("#reporttype").val();
	if(reporttype == "allotte"){	
		cleardatalist();
		$("#datalist").css("display","inline-block");
		$("#dateduration").css("display","none");
		loadallottelist();
	}else if(reporttype == "period"){
		cleardatalist();
		$("#datalist").css("display","inline-block");
		$("#dateduration").css("display","none");
		loadperiodallotments();
		
	}else if(reporttype == "duration"){
		cleardatalist();
		$("#datalist").css("display","none");
		$("#dateduration").css("display","inline-block");
	}else if(reporttype == "typewise"){	
		cleardatalist();
		$("#datalist").css("display","inline-block");
		$("#dateduration").css("display","none");
		loadtypewiselist();
	}else{
		cleardatalist();
		$("#datalist").css("display","none");
		$("#dateduration").css("display","none");
	}
}

function loadallottelist(){
	var allottelist;
	if($("#reportfor").val() == "plots"){
		allottelist = getplotdetails("get_distinctplotallottenames", "", "@");
	}else{
		allottelist = getplotdetails("get_distinctbuildingallottenames", "", "@");
	}
	var resultdata = allottelist.result.split("[[")[1];
	var dataarray = resultdata.split("], [");
	cleardatalist();
	for (var int = 0; int < dataarray.length; int++) {
		var tabledata = dataarray[int].split(", ");
		for (var int2 = 0; int2 < tabledata.length; int2++) {
			if(dataarray.length-1 == int){
				if(tabledata.length-1 == int2){
					if(tabledata[tabledata.length-1].split("]]")[0]!='null'){
						if(tabledata[tabledata.length-1].split("]]")[0].includes("&")){
							$("#datalist").append("<option value='"+tabledata[tabledata.length-1].split("]]")[0].replace("&","%26")+"'>"+tabledata[tabledata.length-1].split("]]")[0]+"</option>");
						}else{
							if(tabledata[tabledata.length-1].split("]]")[0].includes(","))
							$("#datalist").append("<option value='"+tabledata[tabledata.length-1].split("]]")[0].replace(",","")+"'>"+tabledata[tabledata.length-1].split("]]")[0]+"</option>");							
							else
							$("#datalist").append("<option value='"+tabledata[tabledata.length-1].split("]]")[0]+"'>"+tabledata[tabledata.length-1].split("]]")[0]+"</option>");
						     }						
					    }
					}else{
					if(tabledata[int2]!='null'){
						if(tabledata[int2].includes("&")){
							$("#datalist").append("<option value='"+tabledata[int2].replace("&","%26")+"'>"+tabledata[int2]+"</option>");
						}else{
							if(tabledata[int2].includes(","))
							$("#datalist").append("<option value='"+tabledata[int2].replace(",","")+"'>"+tabledata[int2]+"</option>");
							else
							$("#datalist").append("<option value='"+tabledata[int2]+"'>"+tabledata[int2]+"</option>");
						}
					}
				}
			}else{
				if(tabledata[int2]!='null'){
					if(tabledata[int2].includes("&")){
						$("#datalist").append("<option value='"+tabledata[int2].replace("&","%26")+"'>"+tabledata[int2]+"</option>");
					}else{
						if(tabledata[int2].includes(","))
						$("#datalist").append("<option value='"+tabledata[int2].replace(",","")+"'>"+tabledata[int2]+"</option>");
						else
						$("#datalist").append("<option value='"+tabledata[int2]+"'>"+tabledata[int2]+"</option>");
					}
					}
			     }			
			}		
		}
}

function loadperiodallotments(){
	
	var periodlist;
	if($("#reportfor").val() == "plots"){
		periodlist = getplotdetails("get_distinctplotperiodallotments", "", "@");
	}else{
		periodlist = getplotdetails("get_distinctbuildingperiodallotments", "", "@");
	}
	var resultdata = periodlist.result.split("[[")[1];
	var dataarray = resultdata.split("], [");
	cleardatalist();
	for (var int = 0; int < dataarray.length; int++) {
		var tabledata = dataarray[int].split(", ");
		for (var int2 = 0; int2 < tabledata.length; int2++) {
			if(dataarray.length-1 == int){
				if(tabledata.length-1 == int2){
					if(tabledata[tabledata.length-1].split("]]")[0]!='null'){
						if(tabledata[tabledata.length-1].split("]]")[0].includes("&")){
							$("#datalist").append("<option value='"+tabledata[tabledata.length-1].split("]]")[0].replace("&","%26")+"'>"+tabledata[tabledata.length-1].split("]]")[0]+"</option>");
						}else{
							if(tabledata[tabledata.length-1].split("]]")[0].includes(","))
							$("#datalist").append("<option value='"+tabledata[tabledata.length-1].split("]]")[0].replace(",","")+"'>"+tabledata[tabledata.length-1].split("]]")[0]+"</option>");							
							else
							$("#datalist").append("<option value='"+tabledata[tabledata.length-1].split("]]")[0]+"'>"+tabledata[tabledata.length-1].split("]]")[0]+"</option>");
						     }						
					    }
					}else{
					if(tabledata[int2]!='null'){
						if(tabledata[int2].includes("&")){
							$("#datalist").append("<option value='"+tabledata[int2].replace("&","%26")+"'>"+tabledata[int2]+"</option>");
						}else{
							if(tabledata[int2].includes(","))
							$("#datalist").append("<option value='"+tabledata[int2].replace(",","")+"'>"+tabledata[int2]+"</option>");
							else
							$("#datalist").append("<option value='"+tabledata[int2]+"'>"+tabledata[int2]+"</option>");
						}
					}
				}
			}else{
				if(tabledata[int2]!='null'){
					if(tabledata[int2].includes("&")){
						$("#datalist").append("<option value='"+tabledata[int2].replace("&","%26")+"'>"+tabledata[int2]+"</option>");
					}else{
						if(tabledata[int2].includes(","))
						$("#datalist").append("<option value='"+tabledata[int2].replace(",","")+"'>"+tabledata[int2]+"</option>");
						else
						$("#datalist").append("<option value='"+tabledata[int2]+"'>"+tabledata[int2]+"</option>");
					}
					}
			     }			
			}		
		}
}

function cleardatalist(){
	$("#datalist").empty();
	$("#datalist").append("<option value='none'>Select Value</option>");
	$("#reporttitle").html("");
	$("#bottomtabledata").empty();
}

function cleartable(){
	$("#reporttitle").html("");
	$("#bottomtabledata").empty();
}

function loadtypewiselist(){
	if($("#reportfor").val() == "plots"){
		$("#datalist").append("<option value='OS'>OS</option>");
		$("#datalist").append("<option value='OSD'>OSD</option>");
	}else{
		$("#datalist").append("<option value='OS'>OS</option>");
		$("#datalist").append("<option value='OSD'>OSD</option>");
		$("#datalist").append("<option value='BGR'>BGR</option>");
		$("#datalist").append("<option value='CS'>CS</option>");
		$("#datalist").append("<option value='BGA'>BGA</option>");
		$("#datalist").append("<option value='Building with AC sheet'>Building with AC sheet</option>");
		$("#datalist").append("<option value='Building'>Building</option>");
		$("#datalist").append("<option value='Open terrace'>Open Terrace</option>");
		$("#datalist").append("<option value='Terrace'>Terrace</option>");
	}
}
var totalplottable;
function loadplotdetails(apiname,inputparameter1,inpuparameter2,titlename){
	
	$("#reporttitle").html(titlename);
	var totalplotdetails1 = getdataarray(apiname,"", inputparameter1 , inpuparameter2,  "@");
	
	totalplotdetails1.success(function(response){
		
		var totalplotdetails=response;
		totalplottable = document.createElement('table');
		totalplottable.setAttribute('id', "plotdatatable");
		var plottableheader = document.createElement('tr');
		var plotheaderdata="";
		if($("#reportfor").val() == "plots"){
			plotheaderdata = "<th>S.no</th><th>Plot Id</th><th>Type</th><th>Status</th><th>Remarks</th><th>Allotte Name</th><th>Extent Area</th><th>Period of Allotment in Months</th>" +
			 "<th>Date of Allocation</th> <th>Period From</th> <th>Period To</th> <th>Is CustomsBound or Not</th><th>Licence Fee</th> <th>SoR Rate</th>"+
			 "<th>Last Date of Payment</th> <th>Rent Overdue</th> <th>Survey Number</th> <th>Mutation</th><th>Area</th> <th>Location</th> <th>Map ID</th><th>Shape Area</th>";
		}else{
			plotheaderdata = "<th>S.no</th><th>Building ID</th><th>Type</th><th>Status</th><th>Remarks</th><th>Allotments</th><th>Leasee Name</th>" 
			+ "<th>Period of Allotment</th> <th>Date of Allocation</th> <th>From Period of Allocation</th><th>To Period of Allocation</th> <th>Customs bound or not</th>"
			+ "<th>Lease Amount Monthly</th> <th>Lease Amount Annual</th> <th>Lease Amount Up Front</th><th>As per SoR Rate</th> <th>Concession in SoR</th>"
			+ "<th>More Than the SoR(Tender)</th> <th>Survey Number</th> <th>Mutation</th>";
		}
	plottableheader.setAttribute('style', "background-color: rgba(0,0,0,0.5); color: #F0C92F; font-weight: normal !important; font-size: 12px !important; border:1px solid white; padding:2px;");

			$(plottableheader).append(plotheaderdata);
			totalplottable.appendChild(plottableheader);
			
		for (var int = 1; int < totalplotdetails.length; int++) {
			var tabledata = totalplotdetails[int];
			var rowdata = document.createElement('tr');
			for (var int2 = 0; int2 < tabledata.length-1; int2++) {			
					$(rowdata).append("<td>"+tabledata[int2]+"</td>");			     		
				}
			totalplottable.appendChild(rowdata);
			}
		
		var plotdatadiv = document.createElement('div');
			plotdatadiv.setAttribute('style', "width:100%; height: 145px !important; overflow: auto;");
			$(plotdatadiv).append(totalplottable);	
			$("#bottomtabledata").empty();
			$("#bottomtabledata").append(plotdatadiv);
					
	});
}

function loadplotdetailsdatewise(apiname,inputparameter1,inpuparameter2,titlename){
	
	$("#reporttitle").html(titlename);
	var totalplotdetails1 = getdataarraydatewise(apiname,"", inputparameter1 , inpuparameter2,  "@");
	
	totalplotdetails1.success(function(response){
		
		var totalplotdetails=response;
		totalplottable = document.createElement('table');
		totalplottable.setAttribute('id', "plotdatatable");
		var plottableheader = document.createElement('tr');
		var plotheaderdata="";
		if($("#reportfor").val() == "plots"){
			plotheaderdata = "<th>S.no</th><th>Plot Id</th><th>Type</th><th>Status</th><th>Remarks</th><th>Allotte Name</th><th>Extent Area</th><th>Period of Allotment in Months</th>" +
			 "<th>Date of Allocation</th> <th>Period From</th> <th>Period To</th> <th>Is CustomsBound or Not</th><th>Licence Fee</th> <th>SoR Rate</th>"+
			 "<th>Last Date of Payment</th> <th>Rent Overdue</th> <th>Survey Number</th> <th>Mutation</th><th>Area</th> <th>Location</th> <th>Map ID</th><th>Shape Area</th>";
		}else{
			plotheaderdata = "<th>S.no</th><th>Building ID</th><th>Type</th><th>Status</th><th>Remarks</th><th>Allotments</th><th>Leasee Name</th>" 
			+ "<th>Period of Allotment</th> <th>Date of Allocation</th> <th>From Period of Allocation</th><th>To Period of Allocation</th> <th>Customs bound or not</th>"
			+ "<th>Lease Amount Monthly</th> <th>Lease Amount Annual</th> <th>Lease Amount Up Front</th><th>As per SoR Rate</th> <th>Concession in SoR</th>"
			+ "<th>More Than the SoR(Tender)</th> <th>Survey Number</th> <th>Mutation</th>";
		}
	plottableheader.setAttribute('style', "background-color: rgba(0,0,0,0.5); color: #F0C92F; font-weight: normal !important; font-size: 12px !important; border:1px solid white; padding:2px;");

			$(plottableheader).append(plotheaderdata);
			totalplottable.appendChild(plottableheader);
		
		for (var int = 1; int < totalplotdetails.length; int++) {
			var tabledata = totalplotdetails[int];
			var rowdata = document.createElement('tr');
			for (var int2 = 0; int2 < tabledata.length-1; int2++) {			
					$(rowdata).append("<td>"+tabledata[int2]+"</td>");			     		
				}
			totalplottable.appendChild(rowdata);
			}
		
		var plotdatadiv = document.createElement('div');
			plotdatadiv.setAttribute('style', "width:100%; height: 145px !important; overflow: auto;");
			$(plotdatadiv).append(totalplottable);	
			$("#bottomtabledata").empty();
			$("#bottomtabledata").append(plotdatadiv);
					
	});
}

function showOwnPlots() {
	
	var strokecolor = "black";
	var strokewidth = 0;
	
	/*Custom style for plots based on status*/
	var customstyle = function(feature, resolution) {

		if (feature.get('userid') == $("#currentUserNameId").val()) {
			strokecolor = "blue";
			strokewidth = 1.5;
		} else{
			strokecolor = "transparent";
			strokewidth = 0;
		}

		return [ new ol.style.Style({
			stroke : new ol.style.Stroke({
				color : strokecolor,
				width : strokewidth
			}),
			fill : new ol.style.Fill({
				color : "transparent"
			})
		}) ];

	};
	
	/* WFS Vector source of plotslayer */
	ownPlotSource = new ol.source.Vector(
			{
				format : new ol.format.GeoJSON(),
				url : function(extent, resolution, projection) {
					return webMapServiceUrl
							+ '/ows?service=WFS&version=1.0.0&request=GetFeature&typeName='+workspace+':'+wfsplotslayername+'&outputFormat=application/json&srsname=EPSG:3857&'
							+ 'bbox=' + extent.join(',') + ',EPSG:3857';
				},
				strategy : ol.loadingstrategy.tile(ol.tilegrid.createXYZ({
					maxZoom : 19
				}))
			});

	var ownplotsvector = new ol.layer.Vector({
		source : ownPlotSource,
		style : customstyle
		});

	map.addLayer(ownplotsvector);
}