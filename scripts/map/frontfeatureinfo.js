/* Function for Showing feature info popup on map */
function featureInfo2(evt, popup, startView, layerss) {
	
	var element = popup.getElement();
	var coordinate = evt.coordinate;
	
	$(element).popover('destroy'); // remove popup if already exist		
	
	var viewResolution = startView.getResolution();	 	// get current resolution of map
    var url = '';
    var infoData;
    
    /* Loop for getting feature info from all layers with event coordinate */
    layerss.forEach(function (layer, i, layerss) {
        if (layer.getVisible()) {
          var layernamee = layer.get('title').trim();
            url = layer.getSource().getGetFeatureInfoUrl(evt.coordinate, viewResolution, 'EPSG:3857', {
                'INFO_FORMAT': 'application/vnd.ogc.gml',
                    'FEATURE_COUNT': '300'
            });
            
            if (url) {
                
                /* Ajax request for a feature with url */
            	$.ajax({
            		type : "GET",
            		url : url,
            		dataType : "text",
            		success : function(response) {
            			infoData = response;
            			if(response.length>450)
            			func2(infoData,coordinate,element,popup,layernamee);
            		}
            		
            	});
            }
        }
    });
}

/* Function to align data in feature popup */
function func2(infoData, coordinate, element,popup,layernamee)
{
	
	var parsers = new DOMParser(); // Creating xml parser
	var xmlDoc = parsers.parseFromString(infoData, "text/xml"); // Reading xml data from ajax response 
	var tags = xmlDoc.getElementsByTagName('*'); // Reading all nodes in xml files
	var allData = "";
	
	if(layernamee == "PLOTS_LAYER"){
		
		allData += "<table border=\"0\">"; // Adding xml attribute value to display content
		
		for (var i = 3; i < tags.length; i++) {
			
			if(tags[i].firstChild != undefined || tags[i].firstChild != null)
				{
				 
				var namearray = new Array();
				var nodename = tags[i].nodeName;
				namearray = nodename.split(':');
				var fieldname = namearray[1].toUpperCase();
				if(tags[i].firstChild.nodeValue == null || tags[i].firstChild.nodeValue == "null" || fieldname == "COORDINATES" ){
						// Dont add values to display content
				}
				else
					{
					if(fieldname == "SHAPE_LENG"){
						var arearounded = (Math.round(tags[i].firstChild.nodeValue*100)/100);  // Decimal roundoff to two digits
						allData += "<tr style='font-family:verdana;'><td><b style=\"word-break: break-all; width:135px; margin:0; padding:0;\">" + fieldname + '</b></td><td>&nbsp;:&nbsp;&nbsp;</td><td> <p style=\"word-wrap: break-word; width:115px; margin:0; padding:0;\">'+ arearounded + ' Meters</p></td></tr>';  
					}
					if(fieldname == "SHAPE_AREA"){
						var arearounded = (Math.round(tags[i].firstChild.nodeValue*100)/100);  // Decimal roundoff to two digits
						allData += "<tr style='font-family:verdana;'><td><b style=\"word-break: break-all; width:135px; margin:0; padding:0;\">" + fieldname + '</b></td><td>&nbsp;:&nbsp;&nbsp;</td><td> <p style=\"word-wrap: break-word; width:115px; margin:0; padding:0;\">'+ arearounded + ' Square Meters</p></td></tr>';  
					}
					else if(fieldname == 'pointimage')
						{
						   allData += "<center><img alt=\"Image not available\" height=\"50px\" width=\"50px\" src=\"data:image/png;base64,"+tags[i].firstChild.nodeValue+" \"> </center> ";
						}
					else if(fieldname == "TYPE" || fieldname == "CUSTOM_BOUND_OR_NOT" || fieldname == "AREA" || fieldname == "LOCATION"|| fieldname == "MAP_ID" || fieldname == "STATUS" || fieldname == "SURVEY_NUMBER" || fieldname == "MUTATION"  || fieldname == "PERIOD_TO" || fieldname == "PLOT_ID")
						{
						
						allData += "<tr style='font-family:verdana;'><td valign=\"top\"><b style=\"word-break: break-all;width:135px; margin:0; padding:0;\">" + fieldname + '</b></td><td valign=\"top\">&nbsp;:&nbsp;&nbsp;</td><td valign=\"top\"><p style=\"word-wrap: break-word; width:115px; margin:0; padding:0;\"> '+ tags[i].firstChild.nodeValue + '</p></td></tr>'; 
						}
					else{
							
						}
					}
				}
	    }
		
	}
	else{
		
		allData += "<table border=\"0\"><tr style='font-family:verdana;'><td><b>FID</b></td><td>&nbsp;:&nbsp;&nbsp;</td>  <td>" + tags[4].getAttribute('fid') + '</td></tr>'; // Adding xml attribute value to display content	
		
		for (var i = 3; i < tags.length; i++) {
			
			if(tags[i].firstChild != undefined || tags[i].firstChild != null)
				{
				 
				var namearray = new Array();
				var nodename = tags[i].nodeName;
				namearray = nodename.split(':');
				var fieldname = namearray[1].toUpperCase();
				if(tags[i].firstChild.nodeValue == null || tags[i].firstChild.nodeValue == "null" || fieldname == "COORDINATES" ){
						// Dont add values to display content
				}
				else
					{
					if(fieldname == "SHAPE_LENG"){
						var arearounded = (Math.round(tags[i].firstChild.nodeValue*100)/100);  // Decimal roundoff to two digits
						allData += "<tr style='font-family:verdana;'><td><b style=\"word-break: break-all; width:135px; margin:0; padding:0;\">" + fieldname + '</b></td><td>&nbsp;:&nbsp;&nbsp;</td><td> <p style=\"word-wrap: break-word; width:115px; margin:0; padding:0;\">'+ arearounded + ' Meters</p></td></tr>';  
					}
					else if(fieldname == "SHAPE_AREA"){
						var arearounded = (Math.round(tags[i].firstChild.nodeValue*100)/100);  // Decimal roundoff to two digits
						allData += "<tr style='font-family:verdana;'><td><b style=\"word-break: break-all; width:135px; margin:0; padding:0;\">" + fieldname + '</b></td><td>&nbsp;:&nbsp;&nbsp;</td><td> <p style=\"word-wrap: break-word; width:115px; margin:0; padding:0;\">'+ arearounded + ' Square Meters</p></td></tr>';  
					}
					else if(fieldname == 'pointimage')
						{
						   allData += "<center><img alt=\"Image not available\" height=\"50px\" width=\"50px\" src=\"data:image/png;base64,"+tags[i].firstChild.nodeValue+" \"> </center> ";
						}
					else 
						{						
						allData += "<tr style='font-family:verdana;'><td valign=\"top\"><b style=\"word-break: break-all;width:135px; margin:0; padding:0;\">" + fieldname + '</b></td><td valign=\"top\">&nbsp;:&nbsp;&nbsp;</td><td valign=\"top\"><p style=\"word-wrap: break-word; width:115px; margin:0; padding:0;\"> '+ tags[i].firstChild.nodeValue + '</p></td></tr>'; 
						}
					}
				}
	    }
	}
	
	popup.setPosition(coordinate);  // Set popup position on map
	/* Configuration of popup window */
	$(element).popover({
		'placement' : 'top',
		'animation' : false,
		'html' : true,
		'title' : '<b style="color: #F0C92F;">Feature info</b><a href="#" onclick="closepopup()" style="float:right;padding-right:6px;font-weight:bolder; color:#F0C92F;">X</a>',
		'content' : allData
	});
	$(element).popover('show');   // Show popup on map	   
	}