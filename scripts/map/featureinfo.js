var imgsrc;
var imgfid;
var fullimgstatus = 0;

/* Function for Showing feature info popup on map */
function featureInfo2(evt, popup, startView, layerss) {
	if(fullimgstatus == 1)
	   { 
		closefullimage();
		}
	
	var element = popup.getElement();
	var coordinate = evt.coordinate;
	
	$(element).popover('destroy'); // remove popup if already exist
		
	var viewResolution = startView.getResolution();	
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
            			if(response.length > 450)
            			func2(infoData,coordinate,element,popup,layernamee);
            		}          		
            	});
            }
        }
    });
}

/* Function for Showing full image on map */
function showimage(imgpath)
{
	if(fullimgstatus == 1)
		{
			$("#fullsizeimage").slideToggle("slow");
			fullimgstatus = 0;
		}
	else
		{
			$("#fullsizeimage").slideToggle("slow");
			document.getElementById("bigimage").src = imgpath;
			fullimgstatus = 1;
		}
}

/* function for close full image */
function closefullimage()
{
	$("#fullsizeimage").slideToggle("slow"); // Close full image
	fullimgstatus = 0;
}

/* check for .png image file with fid name */
function checkforpngformat(imgfid,foldername)
{
	var imgsource;
	
	$.ajax({
	    url:'Data/uploadedimages/'+foldername+'/'+imgfid+'.png',
	    type:'HEAD',
	    async:false,
	    error: function()
	    {
	    	imgsource = "Data/uploadedimages/"+foldername+"/default.jpg";
	    },
	    success: function()
	    {
	    	imgsource = "Data/uploadedimages/"+foldername+"/"+imgfid+".png";
	    }
	});	
	return imgsource;
}

/* check for jpg image file with fid name */
function checkforjpgformat(imgfid,foldername){
	
	var imgsource;	
	$.ajax({
	    url:'Data/uploadedimages/'+foldername+'/'+imgfid+'.jpg',
	    type:'HEAD',
	    async:false,
	    error: function()
	    {
	    	imgsource = checkforpngformat(imgfid,foldername);
	    },
	    success: function()
	    {
	    	imgsource = "Data/uploadedimages/"+foldername+"/"+imgfid+".jpg";
	    }
	});
	return imgsource;
}

/* Check for document with format */
function checkfordocument(imgfid,foldername, fileformat){
	
	var filesource;
	
	$.ajax({
	    url:'Data/uploadeddocs/'+foldername+'/'+imgfid+'.'+fileformat,
	    type:'HEAD',
	    async:false,
	    error: function()
	    {
	    	filesource = "false";
	    },
	    success: function()
	    {
	    	filesource = "true";
	    }
	});
	
	return filesource;
}

/* Function to align data in feature popup */
function func2(infoData, coordinate, element, popup, layernamee)
{
	
	var parsers = new DOMParser(); // Creating xml parser
	var xmlDoc = parsers.parseFromString(infoData, "text/xml"); // Reading xml data from ajax response 
	var tags = xmlDoc.getElementsByTagName('*'); // Reading all nodes in xml files
	var allData = "";
	
	if(layernamee == wfsplotslayername.toUpperCase())
	    allData += "<table border=\"0\">"; // Adding xml attribute value to display content
	else
		allData += "<table border=\"0\"><tr style='font-family:verdana;'><td><b>FID</b></td><td>&nbsp;:&nbsp;&nbsp;</td>  <td>" + tags[4].getAttribute('fid') + '</td></tr>'; // Adding xml attribute value to display content	

	if(roleId == "1"){
		
		/* Loop for adding all xml node values */

		for (var i = 1; i < tags.length; i++) { 
		
		if(tags[i].firstChild != undefined || tags[i].firstChild != null)
			{
			 
			var namearray = new Array();
			var nodename = tags[i].nodeName;
			namearray = nodename.split(':');
			var fieldname = namearray[1].toUpperCase();
			if(tags[i].firstChild.nodeValue == null || tags[i].firstChild.nodeValue == "null" || fieldname == "COORDINATES" || fieldname=='NULL' || tags[i].firstChild.nodeValue == "unknown"){    //
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
				
				else
					{
					allData += "<tr style='font-family:verdana;'><td valign=\"top\"><b style=\"word-break: break-all;width:135px; margin:0; padding:0;\">" + fieldname + '</b></td><td valign=\"top\">&nbsp;:&nbsp;&nbsp;</td><td valign=\"top\"><p style=\"word-wrap: break-word; width:115px; margin:0; padding:0;\"> '+ tags[i].firstChild.nodeValue + '</p></td></tr>';
					    if(fieldname == "ID" && layernamee == wfsplotslayername.toUpperCase())
						{
						    imgfid = tags[i].firstChild.nodeValue;
						}					
					}				    
				}
			}
    }	
		
	if(layernamee == wfsplotslayername.toUpperCase())
	   {		
		imgsrc = checkforjpgformat(imgfid,"plotslayer");
		
		/* Check document wrt feature id for download */
		var downloadlink;
		if(checkfordocument(imgfid,'plotslayer', 'pdf') == "true") // Check for .pdf format
			{
			   downloadlink = "<a href=\"Data/uploadeddocs/plotslayer/"+imgfid+".pdf\" download=\""+imgfid+".pdf\" target=\"_blank\" title=\"File Download\" id=\"filedownload\"><img src=\"images/map/filedownloadimg.png\" height=\"20px\" width=\"20px\"/></a>";
			}
		else if(checkfordocument(imgfid,'plotslayer', 'doc') == "true") //Check for .doc format
			{
			   downloadlink = "<a href=\"Data/uploadeddocs/plotslayer/"+imgfid+".doc\" download=\""+imgfid+".doc\" target=\"_blank\" title=\"File Download\" id=\"filedownload\"><img src=\"images/map/filedownloadimg.png\" height=\"20px\" width=\"20px\"/></a>";
			}
		else if(checkfordocument(imgfid,'plotslayer', 'txt') == "true")	// Check for .txt format 
			{
			   downloadlink = "<a href=\"Data/uploadeddocs/plotslayer/"+imgfid+".txt\" download=\""+imgfid+".txt\" target=\"_blank\" title=\"File Download\" id=\"filedownload\"><img src=\"images/map/filedownloadimg.png\" height=\"20px\" width=\"20px\"/></a>";
			}
		else if(checkfordocument(imgfid,'plotslayer', 'xls') == "true") // Check for .xls format
			{
			   downloadlink = "<a href=\"Data/uploadeddocs/plotslayer/"+imgfid+".xls\" download=\""+imgfid+".xls\" target=\"_blank\" title=\"File Download\" id=\"filedownload\"><img src=\"images/map/filedownloadimg.png\" height=\"20px\" width=\"20px\"/></a>";
			}
		else
			{
			downloadlink = "";  // if no document available hide download document icon
			}
		
		allData += "</table><table width=\"100%\"><tr><td>"+downloadlink+"&nbsp;&nbsp;&nbsp;&nbsp;</td>"+
		"<td><a href='#' data-toggle='modal' data-role='button' onclick=\"uploadDoc(imgfid,'plots');\" title=\"Upload Document\" id=\"docupload2\"> <img src=\"images/map/uploadimg3.png\" height=\"20px\" width=\"20px\"/></a>&nbsp;&nbsp;&nbsp;&nbsp;	</td>"+
           "<td><a href='#' data-toggle='modal' data-role='button' onclick=\"uploadImage(imgfid,'plots');\" title=\"Upload Image\" id=\"imgupload2\"> <img src=\"images/map/uploadimg.png\" height=\"20px\" width=\"20px\"/></a>&nbsp;&nbsp;&nbsp;&nbsp;	</td>"+
           "<td><center><div><img src="+imgsrc+" height=\"50px\" width=\"80px\" onclick=\"showimage(imgsrc);\" style=\"cursor: pointer;\"></div></center> </td></tr></table>";		
	   }
    if(layernamee == wfsbuildingslayername)
	   {
    	
    	imgfid = tags[4].getAttribute('fid').split(".")[1];  //Get Image wrt feature id  
		imgsrc = checkforjpgformat(imgfid,"buildingslayer");
		
			/* Check document wrt feature id for download */
		var downloadlink;
		if(checkfordocument(imgfid,'buildingslayer', 'pdf') == "true")   // Check for .pdf format
			{
			   downloadlink = "<a href=\"Data/uploadeddocs/buildingslayer/"+imgfid+".pdf\" download=\""+imgfid+".pdf\" target=\"_blank\" title=\"File Download\" id=\"filedownload\"><img src=\"images/map/filedownloadimg.png\" height=\"20px\" width=\"20px\"/></a>";
			}
		else if(checkfordocument(imgfid,'buildingslayer', 'doc') == "true")    // Check for .doc format
			{
			   downloadlink = "<a href=\"Data/uploadeddocs/buildingslayer/"+imgfid+".doc\" download=\""+imgfid+".doc\" target=\"_blank\" title=\"File Download\" id=\"filedownload\"><img src=\"images/map/filedownloadimg.png\" height=\"20px\" width=\"20px\"/></a>";
			}
		else if(checkfordocument(imgfid,'buildingslayer', 'txt') == "true")   // Check for .txt format	
			{
			   downloadlink = "<a href=\"Data/uploadeddocs/buildingslayer/"+imgfid+".txt\" download=\""+imgfid+".txt\" target=\"_blank\" title=\"File Download\" id=\"filedownload\"><img src=\"images/map/filedownloadimg.png\" height=\"20px\" width=\"20px\"/></a>";
			}
		else if(checkfordocument(imgfid,'buildingslayer', 'xls') == "true")   // Check for .xls format
			{
			   downloadlink = "<a href=\"Data/uploadeddocs/buildingslayer/"+imgfid+".xls\" download=\""+imgfid+".xls\" target=\"_blank\" title=\"File Download\" id=\"filedownload\"><img src=\"images/map/filedownloadimg.png\" height=\"20px\" width=\"20px\"/></a>";
			}
		else
			{ 
			  downloadlink = "";  // if no document available hide download document icons
			}
		
		allData += "</table><table width=\"100%\"><tr><td>"+downloadlink+"&nbsp;&nbsp;&nbsp;&nbsp;</td>"+
	            	"<td><a href='#' data-toggle='modal' data-role='button' onclick=\"uploadDoc(imgfid,'buildings');\" title=\"Upload Document\" id=\"docupload2\"> <img src=\"images/map/uploadimg3.png\" height=\"20px\" width=\"20px\"/></a>&nbsp;&nbsp;&nbsp;&nbsp;	</td>"+
		           "<td><a href='#' data-toggle='modal' data-role='button' onclick=\"uploadImage(imgfid,'buildings');\" title=\"Upload Image\" id=\"imgupload2\"> <img src=\"images/map/uploadimg.png\" height=\"20px\" width=\"20px\"/></a>&nbsp;&nbsp;&nbsp;&nbsp;	</td>"+
		           "<td><center><div><img src="+imgsrc+" height=\"50px\" width=\"80px\" onclick=\"showimage(imgsrc);\" style=\"cursor: pointer;\"></div></center> </td></tr></table>";
	   }
		
	}else if(roleId == "2"){
		/* Loop for adding all xml node values */

		for (var i = 1; i < tags.length; i++) { //11
		
		if(tags[i].firstChild != undefined || tags[i].firstChild != null)
			{
			 
			var namearray = new Array();
			var nodename = tags[i].nodeName;
			namearray = nodename.split(':');
			var fieldname = namearray[1].toUpperCase();
			if(tags[i].firstChild.nodeValue == null || tags[i].firstChild.nodeValue == "null" || fieldname == "COORDINATES" || fieldname=='NULL' || tags[i].firstChild.nodeValue == "unknown"){    //
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
				else
					{
					allData += "<tr style='font-family:verdana;'><td valign=\"top\"><b style=\"word-break: break-all;width:135px; margin:0; padding:0;\">" + fieldname + '</b></td><td valign=\"top\">&nbsp;:&nbsp;&nbsp;</td><td valign=\"top\"><p style=\"word-wrap: break-word; width:115px; margin:0; padding:0;\"> '+ tags[i].firstChild.nodeValue + '</p></td></tr>';
					    if(fieldname == "ID" && layernamee == wfsplotslayername.toUpperCase())
						{
						    imgfid = tags[i].firstChild.nodeValue;
						}					
					}
				    
				}
			}
    }
		
	if(layernamee == wfsplotslayername.toUpperCase())
	   {
		
		imgsrc = checkforjpgformat(imgfid,"plotslayer");
		
		/* Check document wrt feature id for download */
		var downloadlink;
		if(checkfordocument(imgfid,'plotslayer', 'pdf') == "true") // Check for .pdf format
			{
			   downloadlink = "<a href=\"Data/uploadeddocs/plotslayer/"+imgfid+".pdf\" download=\""+imgfid+".pdf\" target=\"_blank\" title=\"File Download\" id=\"filedownload\"><img src=\"images/map/filedownloadimg.png\" height=\"20px\" width=\"20px\"/></a>";
			}
		else if(checkfordocument(imgfid,'plotslayer', 'doc') == "true") //Check for .doc format
			{
			   downloadlink = "<a href=\"Data/uploadeddocs/plotslayer/"+imgfid+".doc\" download=\""+imgfid+".doc\" target=\"_blank\" title=\"File Download\" id=\"filedownload\"><img src=\"images/map/filedownloadimg.png\" height=\"20px\" width=\"20px\"/></a>";
			}
		else if(checkfordocument(imgfid,'plotslayer', 'txt') == "true")	// Check for .txt format 
			{
			   downloadlink = "<a href=\"Data/uploadeddocs/plotslayer/"+imgfid+".txt\" download=\""+imgfid+".txt\" target=\"_blank\" title=\"File Download\" id=\"filedownload\"><img src=\"images/map/filedownloadimg.png\" height=\"20px\" width=\"20px\"/></a>";
			}
		else if(checkfordocument(imgfid,'plotslayer', 'xls') == "true") // Check for .xls format
			{
			   downloadlink = "<a href=\"Data/uploadeddocs/plotslayer/"+imgfid+".xls\" download=\""+imgfid+".xls\" target=\"_blank\" title=\"File Download\" id=\"filedownload\"><img src=\"images/map/filedownloadimg.png\" height=\"20px\" width=\"20px\"/></a>";
			}
		else
			{
			downloadlink = "";  // if no document available hide download document icon
			}
		
		allData += "</table><table width=\"100%\"><tr><td>"+downloadlink+"&nbsp;&nbsp;&nbsp;&nbsp;</td>"+
		"<td><a href='#' data-toggle='modal' data-role='button' onclick=\"uploadDoc(imgfid,'plots');\" title=\"Upload Document\" id=\"docupload2\"> <img src=\"images/map/uploadimg3.png\" height=\"20px\" width=\"20px\"/></a>&nbsp;&nbsp;&nbsp;&nbsp;	</td>"+
           "<td><a href='#' data-toggle='modal' data-role='button' onclick=\"uploadImage(imgfid,'plots');\" title=\"Upload Image\" id=\"imgupload2\"> <img src=\"images/map/uploadimg.png\" height=\"20px\" width=\"20px\"/></a>&nbsp;&nbsp;&nbsp;&nbsp;	</td>"+
           "<td><center><div><img src="+imgsrc+" height=\"50px\" width=\"80px\" onclick=\"showimage(imgsrc);\" style=\"cursor: pointer;\"></div></center> </td></tr></table>";		
		
	   }
    if(layernamee == wfsbuildingslayername)
	   {
    	
    	imgfid = tags[4].getAttribute('fid').split(".")[1];  //Get Image wrt feature id  
		imgsrc = checkforjpgformat(imgfid,"buildingslayer");
		
			/* Check document wrt feature id for download */
		var downloadlink;
		if(checkfordocument(imgfid,'buildingslayer', 'pdf') == "true")   // Check for .pdf format
			{
			   downloadlink = "<a href=\"Data/uploadeddocs/buildingslayer/"+imgfid+".pdf\" download=\""+imgfid+".pdf\" target=\"_blank\" title=\"File Download\" id=\"filedownload\"><img src=\"images/map/filedownloadimg.png\" height=\"20px\" width=\"20px\"/></a>";
			}
		else if(checkfordocument(imgfid,'buildingslayer', 'doc') == "true")    // Check for .doc format
			{
			   downloadlink = "<a href=\"Data/uploadeddocs/buildingslayer/"+imgfid+".doc\" download=\""+imgfid+".doc\" target=\"_blank\" title=\"File Download\" id=\"filedownload\"><img src=\"images/map/filedownloadimg.png\" height=\"20px\" width=\"20px\"/></a>";
			}
		else if(checkfordocument(imgfid,'buildingslayer', 'txt') == "true")   // Check for .txt format	
			{
			   downloadlink = "<a href=\"Data/uploadeddocs/buildingslayer/"+imgfid+".txt\" download=\""+imgfid+".txt\" target=\"_blank\" title=\"File Download\" id=\"filedownload\"><img src=\"images/map/filedownloadimg.png\" height=\"20px\" width=\"20px\"/></a>";
			}
		else if(checkfordocument(imgfid,'buildingslayer', 'xls') == "true")   // Check for .xls format
			{
			   downloadlink = "<a href=\"Data/uploadeddocs/buildingslayer/"+imgfid+".xls\" download=\""+imgfid+".xls\" target=\"_blank\" title=\"File Download\" id=\"filedownload\"><img src=\"images/map/filedownloadimg.png\" height=\"20px\" width=\"20px\"/></a>";
			}
		else
			{ 
			  downloadlink = "";  // if no document available hide download document icons
			}
		
		allData += "</table><table width=\"100%\"><tr><td>"+downloadlink+"&nbsp;&nbsp;&nbsp;&nbsp;</td>"+
	            	"<td><a href='#' data-toggle='modal' data-role='button' onclick=\"uploadDoc(imgfid,'buildings');\" title=\"Upload Document\" id=\"docupload2\"> <img src=\"images/map/uploadimg3.png\" height=\"20px\" width=\"20px\"/></a>&nbsp;&nbsp;&nbsp;&nbsp;	</td>"+
		           "<td><a href='#' data-toggle='modal' data-role='button' onclick=\"uploadImage(imgfid,'buildings');\" title=\"Upload Image\" id=\"imgupload2\"> <img src=\"images/map/uploadimg.png\" height=\"20px\" width=\"20px\"/></a>&nbsp;&nbsp;&nbsp;&nbsp;	</td>"+
		           "<td><center><div><img src="+imgsrc+" height=\"50px\" width=\"80px\" onclick=\"showimage(imgsrc);\" style=\"cursor: pointer;\"></div></center> </td></tr></table>";
	   }
		
	}else if(roleId == "3"){
		var currentuserinfo = false;
		/* Loop for adding all xml node values */
		if(layernamee == wfsplotslayername.toUpperCase()){
			
			for (var i = 1; i < tags.length; i++) {
				
				if(tags[i].firstChild != undefined || tags[i].firstChild != null)
					{
					 
					var namearray = new Array();
					var nodename = tags[i].nodeName;
					namearray = nodename.split(':');
					var fieldname = namearray[1].toUpperCase();
					if(tags[i].firstChild.nodeValue == null || tags[i].firstChild.nodeValue == "null" || fieldname == "COORDINATES" || fieldname=='NULL' || tags[i].firstChild.nodeValue == "unknown"){    //
						// Dont add values to display content
					}
					else
						{
						if(fieldname == "USERID"){
							if(tags[i].firstChild.nodeValue.toUpperCase() == document.getElementById("currentUserName").value.toUpperCase()){
								currentuserinfo = true;
							}
						  }						    
						}
					}
				}
		}
		if(currentuserinfo && layernamee == wfsplotslayername.toUpperCase()){
			
			for (var i = 1; i < tags.length; i++) {
				
				if(tags[i].firstChild != undefined || tags[i].firstChild != null)
					{
					 
					var namearray = new Array();
					var nodename = tags[i].nodeName;
					namearray = nodename.split(':');
					var fieldname = namearray[1].toUpperCase();
					if(tags[i].firstChild.nodeValue == null || tags[i].firstChild.nodeValue == "null" || fieldname == "COORDINATES" || fieldname=='NULL' || tags[i].firstChild.nodeValue == "unknown"){    //
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
						
						else
							{
						allData += "<tr style='font-family:verdana;'><td valign=\"top\"><b style=\"word-break: break-all;width:135px; margin:0; padding:0;\">" + fieldname + '</b></td><td valign=\"top\">&nbsp;:&nbsp;&nbsp;</td><td valign=\"top\"><p style=\"word-wrap: break-word; width:115px; margin:0; padding:0;\"> '+ tags[i].firstChild.nodeValue + '</p></td></tr>';						  
							}
						}
					}
				  }
		}else{
			
		for (var i = 1; i < tags.length; i++) {
		
		if(tags[i].firstChild != undefined || tags[i].firstChild != null)
			{
			 
			var namearray = new Array();
			var nodename = tags[i].nodeName;
			namearray = nodename.split(':');
			var fieldname = namearray[1].toUpperCase();
			if(tags[i].firstChild.nodeValue == null || tags[i].firstChild.nodeValue == "null" || fieldname == "COORDINATES" || fieldname=='NULL' || tags[i].firstChild.nodeValue == "unknown"){    //
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
				
				else
					{
					if(layernamee == wfsplotslayername.toUpperCase()){
						
						if(fieldname == "TYPE" || fieldname == "CUSTOM_BOUND_OR_NOT" || fieldname == "AREA" || fieldname == "LOCATION"|| fieldname == "MAP_ID" || fieldname == "STATUS" || fieldname == "SURVEY_NUMBER" || fieldname == "MUTATION"  || fieldname == "PERIOD_TO" || fieldname == "PLOT_ID")
						{
						
						allData += "<tr style='font-family:verdana;'><td valign=\"top\"><b style=\"word-break: break-all;width:135px; margin:0; padding:0;\">" + fieldname + '</b></td><td valign=\"top\">&nbsp;:&nbsp;&nbsp;</td><td valign=\"top\"><p style=\"word-wrap: break-word; width:115px; margin:0; padding:0;\"> '+ tags[i].firstChild.nodeValue + '</p></td></tr>'; 
						}
						
					}else{
						
					allData += "<tr style='font-family:verdana;'><td valign=\"top\"><b style=\"word-break: break-all;width:135px; margin:0; padding:0;\">" + fieldname + '</b></td><td valign=\"top\">&nbsp;:&nbsp;&nbsp;</td><td valign=\"top\"><p style=\"word-wrap: break-word; width:115px; margin:0; padding:0;\"> '+ tags[i].firstChild.nodeValue + '</p></td></tr>';
					
					  }
					}
				    
				}
			}
		  }
		}
	}
	allData += "</table>";	
			popup.setPosition(coordinate);  // Set popup position on map
                	/* Configuration of popup window */
			$(element).popover({
				'placement' : 'top',
				'animation' : false,
				'html' : true,
				'title' : '<b style="color: #F0C92F;">Feature info</b><a href="#" onclick="closepopup()" style="float:right;padding-right:6px;font-weight:bolder; color:#F0C92F;">X</a>',
				'content' : allData
			});
			$(element).popover('show');  // Show popup on map
	
}

function uploadImage(imgfid,type) {
	
	 document.getElementById("fidd").value = imgfid;	  
	 document.getElementById("uploadimgtype").value = type;
	 
	 /* Reset popup window*/
	 document.getElementById('userImage2').value = "";
	 document.getElementById('faileddiv').style.display = 'none';
	 document.getElementById('successdiv').style.display = 'none';
	 
	 /* show model window */
	 document.getElementById("uploadimgdiv").style.display = 'block';
	 closepopup();
}

function uploadDoc(imgfid,type) {
	 document.getElementById("fid2").value = imgfid;
	 document.getElementById("uploadimgtype").value = type;
	 
	 /* Reset popup window*/
	 document.getElementById('userImage3').value = "";
	 document.getElementById('faileddiv2').style.display = 'none';
	 document.getElementById('successdiv2').style.display = 'none';
	 
	 /* show model window */
	 document.getElementById("uploaddocdiv").style.display = 'block';
	 closepopup();
}
