/* Function to Read XML Content and Returns xmlDoc Object */
function readXMLContent() {
	
	if (window.XMLHttpRequest)
	{		
	     xmlhttp=new XMLHttpRequest(); // code for IE7+, Firefox, Chrome, Opera, Safari
	}
	else
	{	
	    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); // code for IE6, IE5
	}
	
	xmlhttp.open("GET","scripts/map/map.xml",false);

	xmlhttp.send();
	return xmlhttp.responseXML;
}