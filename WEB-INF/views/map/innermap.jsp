<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="images/chennai_logo2.png" type="image/png"
	sizes="16x16">
<title>Port of Chennai</title>

<!-- no-cache no-store meta tages to avoid cache -->
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="cache-control" content="no-store">
<meta http-equiv="cache-control" content="must-revalidate">
<meta http-equiv="cache-control" content="max-age=0">
<meta http-equiv="cache-control" content="pre-check=0,post-check=0">
<meta http-equiv="expires" content="0">
<meta http-equiv="pragma" content="no-cache">
<!-- no-cache no-store meta tages to avoid cache -->

<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="css/general.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="css/main.css" type="text/css" />

<link rel="stylesheet" href="css/jqx.base.css" type="text/css" />

<link rel="stylesheet" href="css/map/ol.css">
<link rel="stylesheet" href="css/map/map.css" type="text/css">
<link rel="stylesheet" href="css/map/ol3-layerswitcher.css">
<link rel="stylesheet" href="css/map/bootstrap.min.css" type="text/css">

<!-- JS Files -->
<script type="text/javascript" src="scripts/map/jqueryslidepanel.js"></script>
<script type="text/javascript" src="scripts/map/FileSaver.min.js"></script>
<script type="text/javascript" src="scripts/map/jquery.table2excel.js"></script>
<script type="text/javascript" src="scripts/map/map.js"></script>
<script type="text/javascript" src="scripts/map/ol.js"></script>
<script type="text/javascript" src="scripts/map/ol3-layerswitcher.js"></script>
<script type="text/javascript" src="scripts/map/bootstrap.min.js"></script>
<script type="text/javascript" src="scripts/map/attributequery.js"></script>
<script type="text/javascript" src="scripts/map/measure.js"></script>
<script type="text/javascript" src="scripts/map/gpspoint.js"></script>
<script type="text/javascript" src="scripts/map/featureinfo.js"></script>
<script type="text/javascript" src="scripts/map/spatialquery.js"></script>
<script type="text/javascript" src="scripts/map/xmlreader.js"></script>
<script type="text/javascript" src="scripts/map/featureselection.js"></script>
<script type="text/javascript" src="scripts/map/fixedmapscale.js"></script>
<script type="text/javascript" src="scripts/map/turf.min.js"></script>
<script type="text/javascript" src="scripts/map/proj4.js"></script>
<script type="text/javascript" src="scripts/plots/freshplotapp.js"></script>
<script type="text/javascript" src="scripts/map/basemapgallery.js"></script>
<script type="text/javascript" src="scripts/map/mapcustomcontrols.js"></script>

<!-- script and style for datepicker -->

<link rel="stylesheet" href="css/jquery-ui-calender.css">
<script type="text/javascript" src="scripts/jquery-ui-1.10.3.custom.js"></script>
<script src="scripts/tooltip.bootstrap.datepicker.min.js"></script>
<script src="scripts/jquery.datepicker.js"></script>
<script type="text/javascript" src="scripts/reports/report.js"></script>

<script type="text/javascript">
	var apptypevalue = "existing";
	$(document).ready(function() {

		//	$( "#allocateddate" ).datepicker();
		$("#fromallocateddate").datepicker();
		$("#toallocateddate").datepicker();
		$("#fromperioddate").datepicker();
		$("#toperioddate").datepicker();
		
		$("#datalist").css("display","none");
		$("#dateduration").css("display","none");
		
		var webserviceurl = document.getElementById("webserviceurl").value;

		$('#measureunits').tooltip({
			placement : "bottom"
		});
		$('#typelength').tooltip({
			placement : "bottom"
		});
		$('#typearea').tooltip({
			placement : "bottom"
		});
		$('#featureinfos').tooltip({
			placement : "bottom"
		});
		$('#fselect').tooltip({
			placement : "bottom"
		});
		$('#tplotreg').tooltip({
			placement : "bottom"
		});
		$('#printmap').tooltip({
			placement : "bottom"
		});
		$('#plotsummaryimg').tooltip({
			placement : "bottom"
		});
		$('#tplotallocation').tooltip({
			placement : "bottom"
		});
		$('#gpsdiv').tooltip({
			placement : "right"
		});
		$('#zoomtoport').tooltip({
			placement : "right"
		});
		$('#scale-line').tooltip({
			placement : "right"
		});
		$('#zoomin').tooltip({
			placement : "right"
		});
		$('#zoomout').tooltip({
			placement : "right"
		});
		$('#rotatemap').tooltip({
			placement : "top"
		});
		$('#anticrotate').tooltip({
			placement : "top"
		});
		$('#crotate').tooltip({
			placement : "top"
		});
		$('#attributequery').tooltip({
			placement : "bottom"
		});
		$('#spatialquery').tooltip({
			placement : "bottom"
		});
		$('#basemaps').tooltip({
			placement : "bottom"
		});
		$('#plotstable').tooltip({
			placement : "bottom"
		});
		$('#legend').tooltip({
			placement : "bottom"
		});

		$("#scale-line").click(function() {
			$("#fixedscale").slideToggle("slow");
		});

		/* $("#plotstable").click(function() {
			$("#bottomtable").slideToggle("slow");
		}); */

		var height = $(window).height();
		var mapheight = height - 180;
		$("#map").css("height", mapheight);

		$('[name="apptype"]').on('change', function(e) {
			var radios = document.getElementsByName("apptype");
			for (var i = 0; i < radios.length; i++) {
				if (radios[i].checked) {
					apptypevalue = radios[i].value;
					if (apptypevalue == "fresh") {
						$("#appiddiv").hide();
					} else if (apptypevalue == "existing") {
					//$("#appiddiv").show();
					}
				}
			}

		});
	});

	function getplotallocationreport() {

		var currentDate = new Date();

		var leaseename = document.getElementById("leaseename").value;

		var fromadate = document.getElementById("fromallocateddate").value;
		var toadate = document.getElementById("toallocateddate").value;

		var fDate = new Date(fromadate);
		var tDate = new Date(toadate);

		if ((leaseename == null || leaseename == "" || leaseename == '0')) {
			alert("Allotee Name required");
		} else if (fromadate == null || fromadate == "") {
			alert("From Date is required");
		} else if (toadate == null || toadate == "") {

			alert("To Date is required");
		} else if (fDate > tDate) {
			alert("From Date is invalid");
		} else if (fDate > currentDate) {
			alert("From Date is invalid");
		}
		/* else if(tDate > currentDate){
			alert("To Date is invalid");
		} */
		else {
			document.getElementById("myModalPlotAllocation").style.display = 'none';
			document.plotallocationform.submit();
			plotallocationOFF();
			if (document.getElementById("currentUserName").value == "AdminUser") {
				document.getElementById("leaseename").value = '0';
			}

			document.getElementById("fromallocateddate").value = '';
			document.getElementById("toallocateddate").value = '';
		}

	}

	$('#reports').click(function() {
		$("#query").dialog("open");
		return false;
	});

	function plotAllocation() {
		document.getElementById("myModalPlotAllocation").style.display = 'block';
	}
	function closeModal() {
		document.getElementById("myModalPlotAllocation").style.display = 'none';
		document.getElementById("myModalPlotSummary").style.display = 'none';
		document.getElementById("myModalPlotRegistration").style.display = 'none';
		document.getElementById("uploadimgdiv").style.display = 'none';
		document.getElementById("uploaddocdiv").style.display = 'none';
		reset();
		document.getElementById('faileddiv3').style.display = 'none';
		document.getElementById('duplicatediv3').style.display = 'none';
		document.getElementById('successdiv3').style.display = 'none';
		document.getElementById('mailfaileddiv3').style.display = 'none';
		document.getElementById('invalidappiddiv3').style.display = 'none';
		plotregOFF();
		plotsummaryOFF();
		plotallocationOFF();
	}

	function plotSummary() {
		document.getElementById("myModalPlotSummary").style.display = 'block';
	}
	function plotRegistration() {
		reset();
		document.getElementById("myModalPlotRegistration").style.display = 'block';
		document.getElementById('faileddiv3').style.display = 'none';
		document.getElementById('duplicatediv3').style.display = 'none';
		document.getElementById('successdiv3').style.display = 'none';
		document.getElementById('mailfaileddiv3').style.display = 'none';
		document.getElementById('invalidappiddiv3').style.display = 'none';

	}
	function closeModalForValidate() {
		document.getElementById("myModalValidator").style.display = 'none';
	}

	function reset() {
		document.getElementById("name").value = "";
		document.getElementById("address").value = "";
		document.getElementById("gstin").value = "";
		document.getElementById("phoneNumber").value = "";
		document.getElementById("mobileNumber").value = "";
		document.getElementById("emailId").value = "";
		document.getElementById("plotId").value = "";
		document.getElementById("area").value = "";
		document.getElementById("purpose").value = "";
		document.getElementById("period").value = "";
		document.getElementById("file").value = "";
		document.getElementById("comments").value = "";
		document.getElementById("appid").value = "";

	}
</script>

<script type="text/javascript">
	function logout() {

		window.location = "logout";
	}
	function homeLink() {
		window.location = "homePageLink";
	}
	function loaddocument() {
		/* window.open("helpdocument/Document.html"); */
		window.open("Data/HandOut.pdf");
	}
	
	
	var tableToExcel = (function() {
	      var uri = 'data:application/vnd.ms-excel;base64,'
	        , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
	        , base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) }
	        , format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; }) }
	      return function(table, name) {
	        if (!table.nodeType) table = document.getElementById(table)
	        var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML}
	        window.location.href = uri + base64(format(template, ctx))
	      }
	    })()
	    
	    
	    
</script>


<style>
html, body, .full_size {
	height: 100%;
	margin: 0px;
	padding: 0px;
}

div#highcharts-2 {
	width: 100% !important;
}

.fileUpload {
	position: relative;
	overflow: hidden;
	vertical-align: bottom;
	display: inline-block;
}

.fileUpload input.upload {
	position: absolute;
	top: 0;
	right: 0;
	margin: 0;
	padding: 0;
	font-size: 20px;
	cursor: pointer;
	opacity: 0;
	filter: alpha(opacity = 0);
}

input#uploadFile {
	vertical-align: top;
}
</style>

<style type="text/css">
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
	background-color: #fefefe;
	margin: 0.1% auto; /* 15% from the top and centered */
	margin-top: 7%;
	padding: 0px;
	/* 	border: 1px solid #888; */
	width: 30%; /* Could be more or less, depending on screen size */
	background: rgba(0, 0, 0, 0.7);
}

.pamodal-content {
	background-color: #fefefe;
	margin: 0.1% auto; /* 15% from the top and centered */
	background: rgba(0, 0, 0, 0.7);
	padding: 0px;
	/* 	border: 1px solid #888; */
	width: 40%; /* Could be more or less, depending on screen size */
	box-shadow: 0 5px 15px rgba(0, 0, 0, .5);
	border: 1px solid rgba(0, 0, 0, .2);
	border-radius: 6px;
	background-clip: padding-box;
}

/* The Close Button */
.close {
	color: #aaa;
	float: right;
	font-size: 20px;
	font-weight: bold;
}

.chfile {
	display: block;
	position: relative;
	top: 5px;
	left: 0px;
	outline: none;
	width: 185px;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.modal-header {
	min-height: 13.42857143px;
	padding: 5px !important;
	border-bottom: 0px !important;
	font-family: primeregular;
	font-size: 18px;
}

.mbody {
	padding: 10px !important;
	position: relative;
	top: 4px;
	color: white;
	font-family: verdana;
	font-size: 12px !important;
}

.close1 {
	margin-top: -1px !important;
	opacity: 1 !important;
	color: black !important;
	margin-right: 5px;
}

.reg_pop {
	color: #F0C92F;
	text-align: center;
	font-size: 20px;
}

.errorMessage {
	color: red;
	font-size: 14px;
}

#loading {
	width: 100%;
	height: 100%;
	top: 0px;
	left: 0px;
	position: fixed;
	display: block;
	opacity: 0.7;
	background-color: #fff;
	z-index: 99;
	text-align: center;
	vertical-align: middle;
}

#loading-image {
	position: relative;
	top: 330px;
	z-index: 100;
}

label {
	display: inline-block;
	max-width: 100%;
	margin-bottom: 6px;
	font-weight: normal !important;
	font-family: primeregular !important;
}
</style>

</head>
<body onload="init()">


<%-- <% 

response.setContentType("application/vnd.ms-excel"); 
response.setHeader("Content-Disposition", "inline; filename=" 
+ "excel.xls"); 

%> --%>



	<s:hidden name="currentUserName" id="currentUserName" />
	<div id="loading">
		<img id="loading-image" src="images/processing.gif" alt="Loading..."
			width="120px" height="120px" />
	</div>


	<div class="fluid-container" style="background: #e0c29c;" id="username">
		<div class="container">
			<div style="display: block; float: right;">
				<div
					style="display: block; float: left; font-family: Verdana; line-height: 28px; font-size: 14px; font-weight: normal; color: #000;">
					Welcome
					<s:property value="#session['loginname']" />
					&nbsp;&nbsp;
				</div>

				<a href="#" title="Home">
					<div
						style="display: block; float: left; font-family: Verdana; font-size: 14px; font-weight: bold; color: #000; padding-left: 5px; margin-right: 5px;"
						onclick="homeLink();">
						<img alt="cannot load image" src="images/home.png">
					</div>
				</a> <a href="Data/Chennai-Port.apk" target="_blank"
					title="Download Android Mobile Application"
					download="Chennai-Port.apk">
					<div
						style="display: block; float: left; font-family: Verdana; font-size: 14px; font-weight: bold; color: #000; padding-right: 5px;">
						<img alt="Download Android Mobile Application"
							src="images/android_icon.png">
					</div>
				</a> <a href="#" title="Logout">
					<div
						style="display: block; float: left; font-family: Verdana; font-size: 14px; font-weight: bold; color: #000; margin-right: 5px;"
						onclick="logout();">
						<img src="images/logout.png" />
					</div>
				</a>

				<div
					style="display: block; float: left; font-family: Verdana; font-size: 14px; font-weight: bold; color: #000; margin-right: 5px;">
					<a href="http://chennaiport.gov.in/ScaleOfRates.html"
						target="_blank"><img alt="cannot load image"
						src="images/sfrates.png" width="28px" height="28px"
						style="display: block; float: right;" title="Scale of Rates">
					</a>
				</div>

				<a href="#" title="Help">
					<div
						style="display: block; float: left; font-family: Verdana; font-size: 14px; font-weight: bold; color: #000;"
						onclick="loaddocument();">
						<img alt="cannot load image" src="images/help.png">
					</div>
				</a>


			</div>
		</div>

	</div>

	<div class="fluid-container topbg" id="logo">

		<div class="container">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 txt heads">

				<img src="images/chennai_logo.png" class="img-responsive"
					style="display: block; margin: 0px auto; padding: 16px; 0px;">

			</div>
		</div>
	</div>

	<div id="topheader"
		style="border: none !important; padding: 5px 5px 5px 10px !important; background-color: rgba(0, 0, 0, 0.7); width: 100%; top: 0px; position: relative; z-index: 1;">

		<fieldset style="display: inline-block; padding: 2px;">
			<a
				style="padding: 0px !important; background: none; cursor: pointer;"
				onclick="LengthMeasureON();"><img alt="length" id="typelength"
				src="images/map/white_length.png" title="Calculate Length"></a>
		</fieldset>

		<fieldset data-role="controlgroup" data-type="vertical"
			style="display: inline-block; padding: 2px;">
			<a
				style="padding: 0px !important; background: none; cursor: pointer;"
				onclick="AreaMeasureON();"><img alt="area" id="typearea"
				src="images/map/white_area.png" title="Calculate Area"></a>
		</fieldset>

		<fieldset style="display: inline-block; padding: 2px;">
			<a
				style="padding: 0px !important; background: none; cursor: pointer;"
				onclick="MeasureunitsON();"><img alt="units" id="measureunits"
				src="images/map/measure_off.png" title="Measure Units"></a>
		</fieldset>

		<fieldset data-role="controlgroup" data-type="vertical"
			style="display: inline-block; padding: 2px;">
			<a
				style="padding: 0px !important; background: none; cursor: pointer;"
				onclick="featureInfoON();"><img alt="feature info"
				id="featureinfos" src="images/map/white_info.png"
				title="Feature Info"></a>
		</fieldset>

		<fieldset data-role="controlgroup" data-type="vertical"
			style="display: inline-block; padding: 2px;">
			<a
				style="padding: 0px !important; background: none; cursor: pointer;"
				onclick="featureSelectionON();"><img alt="Feature Selection"
				id="fselect" src="images/map/white_select.png"
				title="Feature Selection"></a>
		</fieldset>

		<fieldset data-role="controlgroup" data-type="vertical"
			style="display: inline-block; padding: 2px;">
			<a href="#"
				style="padding: 0px !important; background: none; cursor: pointer; border: none;"
				data-toggle="modal" data-role="button" id="plotreg"
				onclick="plotregON();"><img alt="registration" id="tplotreg"
				src="images/map/white_plot_app.png"
				title="Application For Allotment"></a>
		</fieldset>
		<fieldset data-role="controlgroup" data-type="vertical"
			style="display: inline-block; padding: 2px;" id="adminPlotSummary">

			<a href="#"
				style="padding: 0px !important; background: none; cursor: pointer; border: none;"
				id="reports" data-toggle="modal" data-role="button"
				onclick="plotsummaryON();"><img alt="Reports"
				id="plotsummaryimg" src="images/map/white_piechart.png"
				title="Plots Summary"></a>
		</fieldset>
		<fieldset data-role="controlgroup" data-type="vertical"
			style="display: none; padding: 2px;">
			<a href="#"
				style="padding: 0px !important; background: none; cursor: pointer; border: none;"
				data-toggle="modal" data-role="button" id="plotallo"
				onclick="plotallocationON();"><img alt="allocation"
				id="tplotallocation" src="images/map/white_plot_report.png"
				title="Plot Allocation Report"></a>
		</fieldset>
		<fieldset data-role="controlgroup" data-type="vertical"
			style="position: relative; display: inline-block;">
			<a
				style="padding: 0px !important; background: none; cursor: pointer;"
				id="export-png" download="map.png" title="Print Map"><img
				alt="Print map" src="images/map/white_print_map.png" id="printmap"
				title="Print&nbsp;Map"></a>
		</fieldset>
		<fieldset data-role="controlgroup" data-type="vertical"
			style="display: inline-block; padding: 2px;">
			<a
				style="padding: 0px !important; background: none; cursor: pointer;"
				title="Attribute Query"><img alt="Attribute Query"
				id="attributequery" src="images/map/white_attribute.png"
				title="Attribute Query" onclick="AttributeQueryON();"></a>
		</fieldset>

		<fieldset data-role="controlgroup" data-type="vertical"
			style="display: inline-block; padding: 2px;">
			<a
				style="padding: 0px !important; background: none; cursor: pointer;"
				title="Spatial Query"><img alt="Spatial Query" id="spatialquery"
				src="images/map/white_spatial.png" title="Spatial Query"
				onclick="SpatialQueryON();"></a>
		</fieldset>

		<fieldset data-role="controlgroup" data-type="vertical"
			style="display: inline-block; padding: 2px;">
			<a
				style="padding: 0px !important; background: none; cursor: pointer;"
				title="Own Plots/Buildings Info"><img alt="Plots Info" id="plotstable"
				src="images/map/white_plots.png" title="Own Plots/Buildings Info"
				onclick="ownplotstableON();"></a>
		</fieldset>

		<fieldset data-role="controlgroup" data-type="vertical"
			style="display: inline-block; padding: 2px;">
			<a
				style="padding: 0px !important; background: none; cursor: pointer;"
				title="Legend"><img alt="Legend Info" id="legend"
				src="images/map/white_legend.png" title="Legend"
				onclick="legendON();"></a>
		</fieldset>

		<fieldset data-role="controlgroup" data-type="vertical"
			style="display: inline-block; padding: 2px; padding-right: 17px; float: right; padding-top: 6px;">
			<a
				style="padding: 0px !important; background: none; cursor: pointer;"
				title="Basemap Gallery"><img alt="Base Maps" height="26px"
				width="26px" id="basemaps" src="images/map/basemapgalleryicon.png"
				title="Basemap Gallery" onclick="showBaseMaps();"></a>
		</fieldset>

	</div>
	<input type="hidden" name="layerList" id="layerList"
		value="${layerList}">

	<input type="hidden" name="plotscountarray" id="plotscountarray"
		value="${plotscountarray}">

	<input type="hidden" name="webserviceurl" id="webserviceurl"
		value="${webserviceurl}">

	<input type="hidden" name="plotIds" id="plotIds" value="${plotIds}">

	<input type="hidden" name="plotDetails" id="plotDetails"
		value="${plotDetails}">

	<input type="hidden" name="roleId" id="roleId" value="${roleId}">

	<input type="hidden" name="uploadimgtype" id="uploadimgtype" value="">

	<input type="hidden" id="currentUserNameId" value="${currentUserName}">
	

	<!-- 								-panel-2 div start --- -->
	<div data-role="content">
		<div id="map" style="width: 100%"></div>
		<div id="popup"></div>
		<div class="panels">
			<div id="panel1">

				<div
					style="font-family: primeregular; font-size: 18px; background: #e39231; padding: 1px; margin-bottom: 5px;">
					<h4 style="font-weight: bold;">
						Attribute Query<span class="close close1"
							onclick="AttributeQueryOFF();">X</span>
					</h4>
				</div>
				<select class="backgrs opt1" name="Layer Name" id="layername"
					onchange="getFileds()">
					<option value="none">Select Layer</option>
				</select><br> <select class="backgrs opt1" id="fields"
					onchange="getValues()">
					<option value="none">Select Field</option>
				</select><br> <select class="backgrs opt1" name="day" id="idcount">
					<option value="none">Select Value</option>
				</select>
				<div style="margin-top: 5px;">
					<button id="submit" type="button" class="btn buts"
						style="width: 80px;" onclick="onSubmit();">Submit</button>
				</div>
			</div>
		</div>
		<div class="panels">
			<div id="panel2">
				<div
					style="font-family: primeregular; font-size: 18px; background: #e39231; padding: 1px;">
					<h4 style="font-weight: bold;">
						Spatial Query<span class="close close1"
							onclick="SpatialQueryOFF();">X</span>
					</h4>
				</div>
				<fieldset data-role="controlgroup" data-type="horizontal"
					style="border: none; padding-top: 5px;">
					<select name="Layer Name" id="wfslayername" class="backgrs opt1"
						style="width: 160px; float: left; border: 1px solid #ccc; height: 32px; padding: 1px; margin-left: 15px;"
						onchange="loadWfsLayer();">
						<option value="none">Select Layer</option>
					</select> <a
						style="background: none; float: left; margin: 5px 5px 5px 10px;"
						onclick="spatialpointON();"> <img alt="point on map"
						id="pointmap" src="images/map/white_point.png"></a>
				</fieldset>
				<fieldset data-role="controlgroup" data-type="horizontal"
					style="border: none;">
					<select id="layerrangevalue"
						style="width: 160px; float: left; height: 32px; padding: 1px; margin-left: 15px; border: 1px solid #ccc;"
						class="backgrs opt1">

						<option value="none">Select Range</option>
						<option>25</option>
						<option>50</option>
						<option>75</option>
						<option>100</option>
						<option>125</option>
						<option>150</option>
						<option>175</option>
						<option>200</option>
						<option>225</option>
						<option>250</option>
						<option>275</option>
						<option>300</option>
						<option>325</option>
						<option>350</option>
						<option>375</option>
						<option>400</option>
					</select>
				</fieldset>
				<div style="margin-top: 10px;">
					<button id="submit" type="button" class="btn buts"
						onclick="onSubmitSpatialQuery();">&nbsp;Submit&nbsp;</button>
				</div>

			</div>
		</div>

		<div class="unitsposition">
			<div id="unitsofmeasure">

				<h4
					style="font-family: primeregular; font-size: 18px; font-weight: bold; color: #fff;">
					Unit of Measurement<b
						style="float: right; margin-right: 10px; cursor: pointer; color: #fff !important; font-weight: bold; font-size: 16px"
						onclick="MeasureunitsOFF();">X</b>
				</h4>
				<select class="backgrs opt1" id="unittype"
					style="display: inline-block;">
					<option value="me" selected="selected">Meter</option>
					<option value="km">Kilo Meters</option>
					<option value="ft">Feet</option>
					<option value="mi">Mile</option>
					<option value="ya">Yard</option>
				</select>

			</div>
		</div>

		<div id="attributequerydetails"></div>

		<div id="projectionpos">
			<label style="font-family: verdana !important; padding-right: 2px;">Coordinate
				System</label><select id="projection" onchange="changeCoordinateFormat()"
				style="color: black">
				<option value="4326">GCS</option>
				<option value="3857">UTM</option>
			</select>
		</div>

		<div class="panels">
			<div id="panel3">

				<b
					style="float: right; margin-right: 8px; cursor: pointer; color: #fff !important; font-weight: bold; font-size: 16px; padding-top: 4px;"
					onclick="legendOFF();">X</b>
				<div class="lgnd">
					<h1 style="font-family: 'primeregular'; font-size: 18px;">Legend</h1>
					<h1 style="margin-left: -140px;">Buildings :</h1>
					<div>
						<span style="background: #B40404"></span>
						<p>BUILD-ACSHEET</p>
					</div>
					<div>
						<span style="background: #0B2161"></span>
						<p>BUILDING-G+9</p>
					</div>
					<div>
						<span style="background: #3B240B"></span>
						<p>BUILDING-SITE-OUTSIDE</p>
					</div>

					<div>
						<span style="background: #0A2A0A"></span>
						<p>BUILDING-UNDERCONSTRUCTION</p>
					</div>
					<div>
						<span style="background: #04B4AE"></span>
						<p>BUILDING G+4</p>
					</div>
					<div>
						<span style="background: #DF0174"></span>
						<p>BUILDING G+5</p>
					</div>

					<div>
						<span style="background: #F7819F"></span>
						<p>BUILDING G+1</p>
					</div>
					<div>
						<span style="background: #5858FA"></span>
						<p>BUILDING G+2</p>
					</div>
					<div>
						<span style="background: #FFFFFF"></span>
						<p>BUILDING G+3 &nbsp;&nbsp;&nbsp;</p>
					</div>

					<div>
						<span style="background: #5E610B"></span>
						<p>BUILD-RCC</p>
					</div>
					<div>
						<span style="background: #243B0B"></span>
						<p>BUILDING G+4 UG</p>
					</div>
					<div>
						<span style="background: #CECEF6"></span>
						<p>AC SHEED-ONLY-COVERED</p>
					</div>
				</div>

				<div class="lgnd" id="legendforAdmin">
					<h1 style="margin-left: -170px;">Plots :</h1>
					<div>
						<span style="background: #FF0000"></span>
						<p>OCCUPIED &amp; PAID</p>
					</div>
					<br>
					<div>
						<span style="background: #008000"></span>
						<p>AVAILABLE</p>
					</div>
					<br>
					<div>
						<span style="background: #FFA500"></span>
						<p>PROCESSING</p>
					</div>
					<br>
					<div>
						<span style="background: #EE82EE"></span>
						<p>PARTIALLY ALLOTED</p>
					</div>
					
				</div>

				<div class="lgnd" id="legendfornormaluser">
					<h1 style="margin-left: -170px;">Plots :</h1>
					<div>
						<span style="background: #FF0000"></span>
						<p>OCCUPIED</p>
					</div>
					<br>
					<div>
						<span style="background: #008000"></span>
						<p>AVAILABLE</p>
					</div>
					<br>
					
					<div>
						<span style="border: 1px solid blue;"></span>
						<p>OWN</p>
					</div>
					<br>
					<div>
						<span style="background: #FFA500"></span>
						<p>PROCESSING</p>
					</div>
					<br>
					<div>
						<span style="background: #EE82EE"></span>
						<p>PARTIALLY ALLOTED</p>
					</div>

				</div>

			</div>
		</div>


		<div class="centerzoom" onclick="CenterMap()" id="zoomtoport"
			title="Default Extent">
			<p>E</p>
		</div>

		<div class="rotationclass">

			<div class="anticrotate" onclick="anticrotate()" id="anticrotate"
				title="Anti Clockwise Rotation">
				<img alt="Anti Clockwise Rotation" src="images/map/Rleftarraw.png">
			</div>

			<div class="centerrotation" onclick="rotatemap()" id="rotatemap"
				title="Default Rotation">
				<img alt="Default Rotation" src="images/map/RcenterImg.png"
					class="RcenterImgclass" id="compassimg">
			</div>

			<div class="crotate" onclick="crotate()" id="crotate"
				title="Clockwise Rotation">
				<img alt="Clockwise Rotation" src="images/map/Rrightarraow.png">
			</div>

		</div>

		<div id="scale-line" class="scale-line" title="Click to Change Scale"
			style="cursor: pointer;"></div>

		<div id="mousecoordinates" class="coordinatesclass"></div>

		<div id="fixedscale">
			<ul>
				<li onclick="fixedMapScale(200,map);">200 M</li>
				<li onclick="fixedMapScale(500,map);">500 M</li>
				<li onclick="fixedMapScale(1000,map);">1000 M</li>
				<li onclick="fixedMapScale(2000,map);">2000 M</li>
				<li onclick="fixedMapScale(5000,map);">5000 M</li>
				<li onclick="fixedMapScale(10000,map);">10 KM</li>
				<li onclick="fixedMapScale(20000,map);">20 KM</li>
				<li onclick="fixedMapScale(50000,map);">50 KM</li>
				<li onclick="fixedMapScale(100000,map);"
					style="border: none !important; padding: 4px 4px 0px 4px !important;">100
					KM</li>
			</ul>
		</div>
		<div id="gpsdiv" class="gpsdivpos" title="Find My Location">

			<a style="padding: 0px !important; background: none;"
				onclick="gpsFunction();"><img alt="gps" id="gpsstatus"
				src="images/map/gps_off.png" width="21px" height="21px"></a>

		</div>
		<div class="fullsize">
			<div id="fullsizeimage" style="padding: 4px;">
				<p id="closeimage" onclick="closefullimage()">X</p>
				<img
					src="data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
					id="bigimage" width="280px" height="280px" border="0"
					style="background-color: transparent; border-style: none;">
			</div>
		</div>

		<div class="basemap" style="display: none;" id="basemapgallerydiv">
			<div id="basemapheader"
				style="background: rgba(0, 0, 0, 0.9); width: 100%; height: 24px; text-align: left; color: white; padding: 2px 5px; letter-spacing: 2px; font-family: primeregular; font-size: 14px;">
				Basemap Gallery
				<p id="closebasemap" onclick="closebasemapgallery()"
					style="float: right; font-weight: bolder; font-size: 15px; cursor: pointer;">X</p>
			</div>
			<div id="basemapgallery" style="padding: 4px;">

				<div id="osmbasemap"
					style="width: 120px; float: left; padding: 10px;">
					<a href="javascript:void(0);"> <img height="67px" width="84px"
						style="border: 1px solid black" src="images/map/temposm.jpg"
						title="OpenStreetMap" 
						onclick="changetoOSMbasemap(map);">
					</a>
					<div class="baseglycls">
						<span  title="OpenStreetMap">OpenStreetMap</span>
					</div>
				</div>

				<div id="bingbasemap"
					style="width: 120px; float: left; padding: 10px; padding-top: 5px;">
					<a href="javascript:void(0);"> <img height="67px" width="84px"
						style="border: 1px solid black" src="images/map/bingmap.jpg"
						title="Bing Map" 
						onclick="changetoBINGbasemap(map);">
					</a>
					<div class="baseglycls">
						<span  title="OpenStreetMap">BingMap</span>
					</div>
				</div>

				<div id="bingroadbasemap"
					style="width: 120px; float: left; padding: 10px;">
					<a href="javascript:void(0);"> <img height="67px" width="84px"
						style="border: 1px solid black" src="images/map/bingroads.JPG"
						title="Bing Map" 
						onclick="changetoBINGROADbasemap(map);">
					</a>
					<div class="baseglycls">
						<span  title="OpenStreetMap">BingRoadMap</span>
					</div>
				</div>

				<div id="bingAerialWithLabelsbasemap"
					style="width: 120px; float: left; padding: 10px;">
					<a href="javascript:void(0);"> <img height="67px" width="84px"
						style="border: 1px solid black"
						src="images/map/bingariallabel.JPG" title="Bing Map"
						 onclick="changetoBINGAerialWithLabels(map);">
					</a>
					<div class="baseglycls">
						<span  title="OpenStreetMap">BingLabelsMap</span>
					</div>
				</div>

				<div id="cartoDBbasemap"
					style="width: 120px; float: left; padding: 10px;">
					<a href="javascript:void(0);"> <img height="67px" width="84px"
						style="border: 1px solid black"
						src="images/map/cartoDBBasemap.jpg" title="CartoDB Map"
						alt="CartoDBMap" onclick="changetocartoDBbasemap(map);">
					</a>
					<div class="baseglycls">
						<span  title="StreetsMap">CartoDbMap</span>
					</div>
				</div>


			 	<div id="satellitebasemap"
					style="width: 120px; float: left; padding: 10px;">
					<a href="javascript:void(0);"> <img height="67px" width="84px"
						style="border: 1px solid black" src="images/map/satelliteimg.jpg"
						title="Satellite" 
						onclick="changetoSATELLITEbasemap(map);">
					</a>
					<div class="baseglycls">
						<span  title="OpenStreetMap">SatelliteMap</span>
					</div>
				</div> 
			</div>
		</div>
<input type="hidden" value="inner" id="frommap">
		<div style="height: 180px;" id="bottomtable">
		
		<div id='exporttable'>
		<h4 align='center' style=' float: left; margin-left: 50px;' id="reporttitle"></h4>
		<select id='reportfor' onchange="loadreporttype()">
		<option value="plots">Plots</option>
		<option value="buildings">Buildings</option></select>
		<select id='reporttype' onchange="loaddatalist()">
		<option value='none' >Select report type</option>
		<option value='all' >All</option>
		<option value='vacant'>Vacant</option>
		<option value='allotted' >Allotted</option>
		<option value='processing'>Processing</option>
		<option value='cb'>CB</option>
		<option value='ncb'>NCB</option>
		<option value='typewise'>Type of Plot</option>
		<option value='allotte'>Party Wise</option>
		<option value='period'>Period of Allotment</option>
		<option value='duration'>From Date To Date</option>		
		</select>
		<select id='datalist' style='max-width: 200px;' onchange="cleartable()">
		<option value="none">Select Value</option>
		</select>
		<span id="dateduration">
		<span>From Date: <input type="text" id="fromperioddate"></span>	
		<span>To Date: <input type="text" id="toperioddate"></span>		
		</span>
		<input id='tabledatabutton' type='button' value='Show'/>
				
		<img src='images/map/pdf-flat.png' title='Export PDF' onclick='exportaspdf();'>
		<img src='images/map/csv-flat.png' title='Export CSV' onclick='exportasxls();'>	
		<span id="loadingtext"></span>	
		</div>
		<div id="bottomtabledata">
		</div>
		
		</div>
		<div id="footer">
			<div class="navbar navbar-default navbar-fixed-bottom">
				<div class="fluid-container footer"
					style="border-top: 1px solid black;">
					<div>
						<p>
							<marquee>
								Disclaimer: The data here in this application is for information purposes only || Executed by RAILTEL Enterprises Limited (powered by <a
									target="_blank" style="text-decoration: none; color: black;"
									href="http://iictechnologies.com/">IIC Technologies
									Limited, Hyderabad</a>) Copyright &copy;
								<script type="text/javascript">
									document.write(new Date().getFullYear());
								</script>
								Chennai Port
							</marquee>
						</p>
					</div>
				</div>
			</div>
		</div>

		<!-- 		Plot Regitration popup start -->

		<div id="myModalPlotRegistration" class="modal" style="display: none;">

			<!-- Modal content -->
			<div class="modal-content plot_modal_reg">
				<div class="modal-header">
					<h4 style="font-weight: bold;">
						Application for Allotment<span class="close close1"
							onclick="closeModal()">X</span>
					</h4>
				</div>
				<div class="modal-body mbody">

					<div class="row">

						<s:form class="form-horizontal" name="tablesubmit"
							id="freshPlotForm">

							<s:hidden name="guest" value="loginuser" id="guestId" />

							<div class="form-group frm">
								<label class="col-sm-5 control-label plotfont">&nbsp;</label>
								<div class="col-sm-5">
									<input type="radio" name="apptype" class="txt" value="fresh"
										> <label>Fresh</label>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" name="apptype" class="txt" value="existing"
										checked> <label>Renewal</label>
								</div>
							</div>

							<div class="form-group frm" id="appiddiv" style="display: none;">
								<label class="col-sm-5 control-label plotfont">User ID :</label>
								<div class="col-sm-5">
									<s:textfield id="appid" name="appid"
										cssClass="form-control txt " placeholder="Enter Your User Id"></s:textfield>
								</div>
							</div>

							<div class="form-group frm">
								<label for="Application Date"
									class="col-sm-5 control-label plotfont">Company Full Name : </label>
									
								<div class="col-sm-5" >
									<s:textfield id="name" name="name" cssClass="form-control txt " placeholder="Enter Full Name"></s:textfield>
								</div>
							</div>
							<div class="form-group frm">
								<label class="col-sm-5 control-label plotfont">Address :
									<font color="red"></font>
								</label>
								<div class="col-sm-5">
									<s:textarea id="address" name="address"
										cssClass="form-control txt " rows="2" cssStyle="resize:none;" placeholder="Enter Address"></s:textarea>
								</div>
							</div>
							<div class="form-group frm">
								<label class="col-sm-5 control-label plotfont">GSTIN No : <font color="red"></font>
								</label>
								<div class="col-sm-5">
									<s:textfield id="gstin" name="gstin"
										cssClass="form-control txt txtNumeric " maxlength="15" placeholder="Enter GST Identification Number"></s:textfield>
								</div>
							</div>
							<div class="form-group frm">
								<label class="col-sm-5 control-label plotfont">Landline
									Number : <font color="red"></font>
								</label>
								<div class="col-sm-5">
									<s:textfield id="phoneNumber" name="phoneNumber"
										cssClass="form-control txt txtNumeric " maxlength="15" placeholder="Enter Landline Number"></s:textfield>
								</div>
							</div>
							<div class="form-group frm">
								<label class="col-sm-5 control-label plotfont">Mobile
									Number : <font color="red"></font>
								</label>
								<div class="col-sm-5">
									<s:textfield id="mobileNumber" name="mobileNumber"
										cssClass="form-control txt txtNumeric" maxlength="10" placeholder="Enter Mobile Number"></s:textfield>
								</div>
							</div>
							<div class="form-group frm">
								<label class="col-sm-5 control-label plotfont">Email Id
									: <font color="red"></font>
								</label>
								<div class="col-sm-5">
									<s:textfield id="emailId" name="emailId"
										cssClass="form-control txt " placeholder="Enter Email-id"></s:textfield>
								</div>
							</div>
							<div class="form-group frm">
								<label class="col-sm-5 control-label plotfont">Interested
									Plot / Building Id :<font color="red"></font>
								</label>
								<div class="col-sm-5">
									<s:textfield id="plotId" name="plotId"
										cssClass="form-control txt " placeholder="Select The Required Plots/Buildings"></s:textfield>
								</div>
								<a href="#" title="Select Intrested Plots"
									onclick="selectPlots();"><img
									id="fselect2"
									src="images/map/white_select.png" 
									style="top: 2px; height: 32px; width: 32px; position: relative;"></a>
							</div>
							<div class="form-group frm">
								<label class="col-sm-5 control-label plotfont">Required Area (In Sq.meters) :<font
									color="red"></font>
								</label>
								<div class="col-sm-5">
									<s:textfield id="area" name="area"
										cssClass="form-control txt txtNumeric" maxlength="12" placeholder="Enter Required Area In Sq.Meters"></s:textfield>
								</div>

							</div>
							<div class="form-group frm">
								<label class="col-sm-5 control-label plotfont">Purpose Of Requirement :<font
									color="red"></font>
								</label>
								<div class="col-sm-5">
									<s:textfield id="purpose" name="purpose"
										cssClass="form-control txt txtNumeric" maxlength="50" placeholder="Purpose Of Requirement"></s:textfield>
								</div>

							</div>
							<div class="form-group frm">
								<label class="col-sm-5 control-label plotfont">Period Of Allotment In Months :<font
									color="red"></font>
								</label>
								<div class="col-sm-5">
									<s:textfield id="period" name="period"
										cssClass="form-control txt txtNumeric" maxlength="12" placeholder="Period Of Allotment In Months"></s:textfield>
								</div>

							</div>
							<div class="form-group frm">
								<label class="col-sm-5 control-label plotfont">Upload
									File : <font color="red"></font>
								</label>
								<div class="col-sm-5">
									<s:file id="file" name="file" cssClass="chfile txt"></s:file>
								</div>
							</div>
							<div class="form-group frm">
								<label class="col-sm-5 control-label plotfont">Comments
									: <font color="red"></font>
								</label>

								<div class="col-sm-5">
									<s:textarea id="comments" name="comments"
										cssClass="form-control txt " cssStyle="resize:none;" placeholder='Enter Plot / Building details and comments'></s:textarea>
								</div>
							</div>

							<%-- <s:hidden name="UniqueId" value="" id="UniqueId" /> --%>
							<s:hidden name="apptypename" value="" id="apptypename"
								key="apptypename" />
  <div align="right" style="margin-right: 20px; color: red"> * All fields are mandatory </div>
							<div class="form-group frm">
								<label class="col-sm-5 control-label"></label>
								<div class="col-sm-4">
									<button id="subBut" type="button" class="btn buts"
										style="width: 80px;" onclick="submitform();">Submit</button>
								</div>

							</div>
							<div id="loadingimg" style="display: none;" align="center">
								<img src="images/formloading.gif" width="30px" /> <br /> <br />
							</div>

							<div
								style="text-align: center; color: red; font-size: 14px; display: none;"
								id="faileddiv3">
								<img src="images/error.jpg" width="20px" /> &nbsp;
								<s:text
									name="Failed to Submit the Application. Please Try Again." />
							</div>
							<div
								style="text-align: center; color: red; font-size: 14px; display: none;"
								id="mailfaileddiv3">
								<img src="images/error.jpg" width="20px" /> &nbsp;
								<s:text
									name="Successfully submitted Application but failed to send mail.." />
							</div>

							<div
								style="text-align: center; color: red; font-size: 14px; display: none;"
								id="duplicatediv3">
								<img src="images/error.jpg" width="20px" /> &nbsp;
								<s:text
									name="Email and Phone Number already exist, Please Apply with existing, Application ID" />
							</div>

							<div
								style="text-align: center; color: red; font-size: 14px; display: none;"
								id="invalidappiddiv3">
								<img src="images/error.jpg" width="20px" /> &nbsp;
								<s:text
									name="Invalid Application ID or not matched with Email and Phone Number" />
							</div>

							<div
								style="text-align: center; color: green; font-size: 14px; display: none;"
								id="successdiv3">
								<img src="images/Successicon.gif" width="20px" /> &nbsp;
								<s:text name="Successfully submitted form." />
							</div>
							<s:token />
						</s:form>
					</div>
				</div>
			</div>
		</div>
		<!-- 		Plot Regitration popup end-->

		<!-- Plot Allocation Report popup start -->
		<div id="myModalPlotAllocation" class="modal" style="display: none;">
			<!-- Modal content -->
			<div class="pamodal-content">
				<div class="modal-header">
					<h4 style="font-weight: bold;">
						Plot Allocation Report<span class="close close1"
							onclick="closeModal()">X</span>
					</h4>
				</div>
				<div class="modal-body mbody">
					<div class="row">
						<s:form name="plotallocationform" id="plotallocationform"
							method="post" action="plotallocationjasperreport" target="_blank">
							<div class="widget-container fluid-height clearfix">
								<div class="col-md-12">
									<div class="form-horizontal">
										<div class="form-group">
											<label for="file"
												class="col-lg-4 col-md-4 col-sm-4 control-label lbls size_map">
												Allotee Name: </label>
											<div class="col-lg-7 col-md-7 col-sm-7" id="allUserNames"
												onmousedown="return false">
												<s:select id="leaseename" name="leaseename" list="userList"
													listKey="userName" listValue="userName" headerKey="0"
													headerValue="Select Username"
													cssClass="form-control sectionbg" />
											</div>

										</div>
										<div class="form-group">
											<label for="file"
												class="col-lg-4 col-md-4 col-sm-4 control-label lbls size_map">
												From Date: </label>
											<div class="col-lg-7 col-md-7 col-sm-7">
												<s:textfield name="fromdate" id="fromallocateddate"
													data-role="date" placeholder="MM-DD-YYYY" readonly="false"
													cssClass="form-control txt inpts"></s:textfield>
												<!-- class="datepicker"  -->
											</div>
										</div>
										<div class="form-group">
											<label for="file"
												class="col-lg-4 col-md-4 col-sm-4 control-label lbls size_map">
												To Date: </label>
											<div class="col-lg-7 col-md-7 col-sm-7">
												<s:textfield name="todate" id="toallocateddate"
													data-role="date" placeholder="MM-DD-YYYY" readonly="false"
													cssClass="form-control txt inpts"></s:textfield>
												<!-- class="datepicker"  -->
											</div>
										</div>

										<div class="form-group">
											<label class="col-sm-4 control-label"></label>
											<div class="col-sm-4">
												<button id="subBut" type="button" class="btn buts"
													style="width: 80px;" onclick="getplotallocationreport();">Submit</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</s:form>
					</div>
				</div>
			</div>
		</div>

		<!-- Plot Allocation Report popup end -->

		<!-- 		Plot Summary Popup  start-->

		<div id="myModalPlotSummary" class="modal" style="display: none;">

			<!-- Modal content -->
			<div class="modal-content plot_smy_mdl">
				<div class="modal-header">
					<h4 style="font-weight: bold;">
						Plots Summary<span class="close close1" onclick="closeModal()">X</span>
					</h4>
				</div>
				<div class="modal-body mbody">

					<script src="scripts/reports/highcharts.js" type="text/javascript"></script>
					<script src="scripts/reports/highcharts-3d.js"
						type="text/javascript"></script>
					<script src="scripts/reports/exporting.js" type="text/javascript"></script>
					<script src="scripts/reports/grid-light.js"></script>
					<div id="widget-container"></div>

				</div>
			</div>
		</div>
		<!-- 		Plot Summary Popup  end -->

		<!-- 			popo up for upload image start-->

		<div id="uploadimgdiv" class="modal" style="display: none;">


			<div class="modal-content upload_mdl">
				<div class="modal-header">

					<h4 style="font-weight: bold !important;">
						Upload Image<span class="close close1" onclick="closeModal()">X</span>
					</h4>

				</div>
				<div class="modal-body mbody">


					<s:form action="" method="post"
						enctype="multipart/form-data" name="fform" id="fform">

						<s:actionmessage />
						<div class="form-group">
							<label for="file" class="control-label">Browse Image: </label>

							<div>
								<s:file name="userImage" id="userImage2" class="upload"></s:file>
							</div>
						</div>
						<s:hidden name="fid" id="fidd" key="fid" value="">
						</s:hidden>
						

						<div class="form-group"
							style="margin-top: 10px; margin-right: 62px;">
							<label for="file" class="col-sm-4 control-label"> </label>
							<button type="button" id="uploadimgbutton" class="btn buts"
								style="width: 80px;">Upload</button>
							<button type="button" id="uploadimgbuttonclose"
								onclick="closeModal();" class="btn buts" style="width: 80px;">Close</button>

							<div id="loadingimg2" style="float: right; display: none;">
								<img src="images/processing.gif" width="30px" /> <br /> <br />
							</div>

						</div>


						<div
							style="text-align: center; color: red; font-size: 14px; display: none;"
							id="faileddiv">
							<img src="images/error.jpg" width="20px" /> &nbsp;
							<s:text name="Failed to Upload Image.Please Try Again." />
						</div>

						<div
							style="text-align: center; color: green; font-size: 14px; display: none;"
							id="successdiv">
							<img src="images/Successicon.gif" width="20px" /> &nbsp;
							<s:text name="Successfully Uploaded the Image." />

						</div>


					</s:form>
				</div>
			</div>
		</div>

		<!-- 			popup for upload image end -->

		<!-- popup for upload document div  - start-->

		<div id="uploaddocdiv" class="modal" style="display: none;">

			<!-- Modal content -->
			<div class="modal-content upload_mdl">
				<div class="modal-header">

					<h4 style="font-weight: bold !important;">
						Upload Document<span class="close close1" onclick="closeModal()">X</span>
					</h4>

				</div>
				<div class="modal-body mbody">

					<div>
						<s:form action="uploadplotdoc" method="post"
							enctype="multipart/form-data" name="fform" id="fform">

							<s:actionmessage />
							<div class="form-group">
								<label for="file" class="control-label">Browse Document:
								</label>

								<div>
									<s:file name="userImage" id="userImage3"
										class="upload input_upl"></s:file>
								</div>
							</div>

							<!-- <input type="hidden" name="fid" id="fid" /> -->
							<s:hidden name="fid" id="fid2" key="fid" value="">
							</s:hidden>

							<div class="form-group file_32"
								style="margin-top: 10px; margin-right: 60px;">
								<label for="file" class="col-sm-4 control-label"> </label>
								<button type="button" id="uploaddocbutton" class="btn buts"
									style="width: 80px;">Upload</button>
								<button type="button" id="uploaddocbuttonclose"
									onclick="closeModal();" class="btn buts" style="width: 80px;">Close</button>

								<div id="loadingimg" style="float: right; display: none;">
									<img src="images/processing.gif" width="30px" /> <br /> <br />
								</div>

							</div>

							<div
								style="text-align: center; color: red; font-size: 14px; display: none;"
								id="faileddiv2">
								<img src="images/error.jpg" width="20px" /> &nbsp;
								<s:text name="Failed to Upload Document.Please Try Again." />
							</div>

							<div
								style="text-align: center; color: green; font-size: 14px; display: none;"
								id="successdiv2">
								<img src="images/Successicon.gif" width="20px" /> &nbsp;
								<s:text name="Successfully Uploaded the Document." />

							</div>
						</s:form>
					</div>


				</div>
			</div>
		</div>
	</div>
	<script>
		$("#uploadimgbutton")
				.click(
						function() {

							document.getElementById("loadingimg2").style.display = "";
							document.getElementById("uploadimgbutton").disabled = true;
							document.getElementById("uploadimgbuttonclose").disabled = true;

							var filepath = document
									.getElementById("userImage2").value;
							var filename;
							var fileextension;

							if (jQuery('#userImage2')[0].files[0] == undefined
									|| jQuery('#userImage2')[0].files[0] == null) {
								// alert("File is required");
								/* document.getElementById("myModalValidator").style.display='block';
								document.getElementById("validateMessageId").innerHTML="Select file to upload"; */
								alert("Select image to upload");
								document.getElementById("loadingimg2").style.display = "none";
								document.getElementById("uploadimgbutton").disabled = false;
								document.getElementById("uploadimgbuttonclose").disabled = false;
							}

							else {
								filename = filepath.split('\\').pop();
								fileextension = filename.split('.').pop();
								if (fileextension == "png"
										|| fileextension == "jpg") {
									var urll;
									
									if (document
											.getElementById("uploadimgtype").value == 'plots') {
										urll = 'uploadplotimg';
										
									} else {
										urll = 'uploadbuildingimg';
										
									}

									var data = new FormData();
									var filedata = jQuery('#userImage2')[0].files[0];
									data.append('userImage', filedata);
									data.append('fid', $('#fidd').val()) ;
									
									jQuery
											.ajax({
												url : urll,
												data : data,
												cache : false,
												contentType : false,
												processData : false,
												type : 'POST',
												success : function(data) {
													//alert("in success");
													document
															.getElementById('faileddiv').style.display = 'none';
													document
															.getElementById('successdiv').style.display = 'block';

													document
															.getElementById("loadingimg2").style.display = "none";
													document
															.getElementById("uploadimgbutton").disabled = false;
													document
															.getElementById("uploadimgbuttonclose").disabled = false;
												},
												error : function(data) {
													//alert("in error");
													document
															.getElementById('successdiv').style.display = 'none';
													document
															.getElementById('faileddiv').style.display = 'block';

													document
															.getElementById("loadingimg2").style.display = "none";
													document
															.getElementById("uploadimgbutton").disabled = false;
													document
															.getElementById("uploadimgbuttonclose").disabled = false;
												}
											});
								} else {
									/*  document.getElementById("myModalValidator").style.display='block';
									  document.getElementById("validateMessageId").innerHTML="Select .jpg or .png images"; */
									alert("Select .jpg or .png images");
									document.getElementById("loadingimg2").style.display = "none";
									document.getElementById("uploadimgbutton").disabled = false;
									document
											.getElementById("uploadimgbuttonclose").disabled = false;
								}

							}
						});

		$("#uploaddocbutton")
				.click(
						function() {

							document.getElementById("loadingimg").style.display = "";
							document.getElementById("uploaddocbutton").disabled = true;
							document.getElementById("uploaddocbuttonclose").disabled = true;

							var filepath = document
									.getElementById("userImage3").value;
							var filename;
							var fileextension;

							if (jQuery('#userImage3')[0].files[0] == undefined
									|| jQuery('#userImage3')[0].files[0] == null) {
								//alert("File is required");
								/*  document.getElementById("myModalValidator").style.display='block';
								 document.getElementById("validateMessageId").innerHTML="Select file to upload"; */
								alert("Select file to upload");
								document.getElementById("uploaddocbutton").disabled = false;
								document.getElementById("uploaddocbuttonclose").disabled = false;
								document.getElementById("loadingimg").style.display = "none";
							} else {
								filename = filepath.split('\\').pop();
								fileextension = filename.split('.').pop();
								if (fileextension == "pdf"
										|| fileextension == "doc"
										|| fileextension == "txt"
										|| fileextension == "xls") {
									var urll;
									if (document
											.getElementById("uploadimgtype").value == 'plots') {
										urll = 'uploadplotdoc';
									} else {
										urll = 'uploadbuildingdoc';
									}

									var data = new FormData();
									var filedata = jQuery('#userImage3')[0].files[0];
									data.append('userImage', filedata);
									data.append('fid', $('#fid2').val());

									jQuery
											.ajax({
												url : urll,
												data : data,
												cache : false,
												contentType : false,
												processData : false,
												type : 'POST',
												success : function(data) {
													document
															.getElementById('faileddiv2').style.display = 'none';
													document
															.getElementById('successdiv2').style.display = 'block';

													document
															.getElementById("uploaddocbutton").disabled = false;
													document
															.getElementById("uploaddocbuttonclose").disabled = false;
													document
															.getElementById("loadingimg").style.display = "none";
												},
												error : function(data) {
													document
															.getElementById('successdiv2').style.display = 'none';
													document
															.getElementById('faileddiv2').style.display = 'block';

													document
															.getElementById("uploaddocbutton").disabled = false;
													document
															.getElementById("uploaddocbuttonclose").disabled = false;
													document
															.getElementById("loadingimg").style.display = "none";
												}
											});
								} else {
									/* document.getElementById("myModalValidator").style.display='block';
									document.getElementById("validateMessageId").innerHTML="Select .doc or .pdf or .txt or .xls documents"; */
									alert("Select .doc or .pdf or .txt or .xls documents");
									document.getElementById("uploaddocbutton").disabled = false;
									document
											.getElementById("uploaddocbuttonclose").disabled = false;
									document.getElementById("loadingimg").style.display = "none";
								}
							}
						});
	</script>

	<script language="javascript" type="text/javascript">
		$(window).load(function() {
			$('#loading').hide();
		});
	</script>

</body>
</html>