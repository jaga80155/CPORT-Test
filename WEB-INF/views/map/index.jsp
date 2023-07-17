<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
<head>

<link rel="icon" href="images/chennai_logo2.png" type="image/png"
	sizes="16x16">
<title>Port of Chennai</title>

<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/general.css" rel="stylesheet">


<link rel="stylesheet" href="css/map/jquery.mobile-1.4.5.css">
<link rel="stylesheet" href="css/map/ol.css">
<link rel="stylesheet" href="css/map/frontmap.css" type="text/css">
<link rel="stylesheet" href="css/map/ol3-layerswitcher.css">
<link rel="stylesheet" href="css/map/bootstrap.min.css" type="text/css">
<script type="text/javascript" src="scripts/map/jquery.mobile-1.4.5.js"></script>
<script type="text/javascript" src="scripts/map/jqueryslidepanel.js"></script>
<script type="text/javascript" src="scripts/map/frontmap.js"></script>
<script type="text/javascript" src="scripts/map/ol.js"></script>
<script type="text/javascript" src="scripts/map/bootstrap.min.js"></script>
<script type="text/javascript" src="scripts/map/xmlreader.js"></script>
<script type="text/javascript" src="scripts/map/fixedmapscale.js"></script>
<script type="text/javascript" src="scripts/map/ol3-layerswitcher.js"></script>
<script type="text/javascript" src="scripts/map/frontfeatureinfo.js"></script>
<script type="text/javascript" src="scripts/plots/freshplotapp.js"></script>
<script type="text/javascript" src="scripts/map/basemapgallery.js"></script>
<script type="text/javascript" src="scripts/map/featureselection.js"></script>

<script type="text/javascript">
var apptypevalue;
var plotregstatus = "off";
var fSelectStatus2 = "off";
	$(document).ready(function() {
		var height = $(window).height();
		var mapheight = height - 140;
		
		$("#frontmap").css("height", mapheight);

		$('[name="apptype"]').on('change', function(e) {
			var radios = document.getElementsByName("apptype");
			for (var i = 0; i < radios.length; i++) {
				if (radios[i].checked) {
					apptypevalue = radios[i].value;
					if (apptypevalue == "fresh") {
						
					} else if (apptypevalue == "existing") {
						
					}
				}
			}
		});
	});

	function homeLink() {
		window.location = "homePageLink";
	}

	function signin() {
		window.location = "homePage";
	}

	function loaddocument() {
		window.open("Data/HandOut.pdf");
	}
	
	function plotRegistration() {
		reset();
		closebasemapgallery();
		document.getElementById("myModal").style.display = 'block';
		document.getElementById('faileddiv3').style.display = 'none';
		document.getElementById('duplicatediv3').style.display = 'none';
		document.getElementById('successdiv3').style.display = 'none';
		document.getElementById('mailfaileddiv3').style.display = 'none';
		document.getElementById('invalidappiddiv3').style.display = 'none';
		
	}
	
	function closeModal() {
		document.getElementById("myModal").style.display = 'none';
		reset();
		document.getElementById('faileddiv3').style.display = 'none';
		document.getElementById('duplicatediv3').style.display = 'none';
		document.getElementById('successdiv3').style.display = 'none';
		document.getElementById('mailfaileddiv3').style.display = 'none';
		document.getElementById('invalidappiddiv3').style.display = 'none';
		document.getElementById("fselect").src = "images/map/white_select.png";
		
		if(fSelectStatus == "on")
		{
			plotregOFF();
		}

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
	function intialize() {
		window.location.hash = "no-back-button";
		window.location.hash = "Again-No-back-button";//again because google chrome don't insert first hash into history
		window.onhashchange = function() {
			window.location.hash = "no-back-button";
		}
		loadmap();
	}
</script>

<style>
html, body, .full_size {
	height: 100%;
	margin: 0px;
	padding: 0px;
}
</style>
<style>
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
	margin-top: 7%; /* 15% from the top and centered */
	padding: 0px;
	/* 	border: 1px solid #888; */
	width: 24%; /* Could be more or less, depending on screen size */
	background: rgba(0, 0, 0, 0.7);
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

.gm-style {
	font-size: inherit;
	font-family: inherit;
}

.gm-style .ol-attribution {
	bottom: 1em;
}

.gm-style .ol-attribution.ol-logo-only {
	bottom: 1em;
}
</style>

</head>
<body onload="intialize()">
	<div id="loading">
		<img id="loading-image" src="images/processing.gif" alt="Loading..."
			width="120px" height="120px" />
	</div>

	<div class="full_size">
		<div id="header">
			<div class="fluid-container" style="background: #e0c29c;">
				<div class="container">
					<div style="display: block; float: right;">
						<a href="homePage">
								<img src="images/login_front.png" title="Log In" alt="Log In" style="float: left; padding-right: 5px;" />
						</a> <a href="#">
								<img alt="Application for allotment" src="images/plot_register.PNG"	title="Application For Allotment"
								style="float: left; padding-right: 5px;" onclick="plotregON();" />
						</a>
						<a href="Data/Chennai-Port.apk" target="_blank" download="Chennai-Port.apk">			
								<img alt="Download Android Mobile Application" src="images/android_icon.png"
									title="Download Android Mobile Application" style="float: left; padding-right: 5px;">
						</a>						
						<a href="http://chennaiport.gov.in/ScaleOfRates.html" target="_blank" style="float: left; padding-right: 5px;">
								<img alt="Scale of Rates" src="images/sfrates.png" width="28px" height="28px" title="Scale of Rates">
						</a>
						<a href="">
								<img alt="Help" src="images/help.png" title="Help" style="float: left; padding-right: 5px;"	onclick="loaddocument();">
						</a>
					</div>
				</div>
			</div>

			<div class="fluid-container topbg">

				<div class="container">
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 txt heads">
						<img src="images/chennai_logo.png" class="img-responsive" style="display: block; margin: 0px auto; padding: 16px 0px;">
					</div>
				</div>
			</div>
		</div>
		<input type="hidden" name="layerList" id="layerList"
			value="${layerList}"> <input type="hidden"
			name="webserviceurl" id="webserviceurl" value="${webserviceurl}">
		<div data-role="content">

			<div id="frontmap" style="width: 100%"></div>

			<div class="basemap-switcher">

				<a
					style="padding: 0px !important; background: none; cursor: pointer;"
					title="Basemap Gallery"><img alt="Base Maps" height="26px"
					width="26px" id="basemaps" src="images/map/basemapgalleryicon.png"
					title="Basemap Gallery" onclick="showBaseMaps();"></a>
			</div>

			<div id="frontpopup"></div>
			<div id="scale-line" class="scale-line"></div>

		</div>
		<div id="legend-info" class="legend-type">
			<div
				style="background-color: red; width: 15px; height: 15px; display: inline-block;"></div>
			<p style="display: inline-block; vertical-align: middle;">&nbsp;
				Occupied &nbsp;</p>
			<div
				style="background-color: green; width: 15px; height: 15px; display: inline-block;"></div>
			<p style="display: inline-block; vertical-align: middle;">&nbsp;
				Available&nbsp;</p>
			<div
				style="background-color: orange; width: 15px; height: 15px; display: inline-block;"></div>
			<p style="display: inline-block; vertical-align: middle;">&nbsp;
				Processing &nbsp;</p>
			<div
				style="background-color:#EE82EE ; width: 15px; height: 15px; display: inline-block;"></div>
			<p style="display: inline-block; vertical-align: middle;">&nbsp;
				Partial alloted &nbsp;</p>
		</div>

		<div id="myModal" class="modal" style="display: none;">

			<!-- Modal content -->
			<div class="modal-content plot_modal_reg">
				<div class="modal-header">
					<h4 style="font-weight: bold;">
						Application for Allotment<span class="close close1"
							onclick="closeModal()">X</span>
					</h4>
				</div>
				<input type="hidden" value="front" id="frommap">
				<div class="modal-body mbody">
					<div class="row">

						<s:form class="form-horizontal" name="tablesubmit"
							id="freshPlotForm">
							<s:hidden name="guest" value="guest" id="guestId" />

							<div class="form-group frm">
								<label class="col-sm-5 control-label plotfont">&nbsp;</label>
								<div class="col-sm-5">
									<input type="radio" name="apptype" class="txt" value="fresh" checked> <label>Fresh</label>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" name="apptype" class="txt" value="existing" style="display: none;" > <label style="display: none;" >Existing</label>
								</div>
							</div>

							<div class="form-group frm" id="appiddiv" style="display: none;">
								<label class="col-sm-5 control-label plotfont">User ID :</label>
								<div class="col-sm-5">
									<s:textfield id="appid" name="appid"
										cssClass="form-control txt "  placeholder="Enter Your User Id"></s:textfield>
								</div>
							</div>

							<div class="form-group frm">
								<label for="Application Date"
									class="col-sm-5 control-label plotfont"  >Company Full Name :  </label>
								<div class="col-sm-5">
									<s:textfield id="name" name="name" cssClass="form-control txt " placeholder="Enter Full Name" ></s:textfield>
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
								<label class="col-sm-5 control-label plotfont">GSTIN No :<font color="red"></font>
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
										cssClass="form-control txt txtNumeric" maxlength="10" placeholder="Enter Mobile Number" ></s:textfield>
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
									onclick="selectPlotsInIndex();"><img
									src="images/map/white_select.png" id="fselect"
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
										cssClass="form-control txt txtNumeric" maxlength="4" placeholder="Period Of Allotment In Months"></s:textfield>
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
										cssClass="form-control txt" cssStyle="resize:none;" placeholder='Enter Plot / Building details and comments'></s:textarea>
								</div>
							</div>
							
							<s:hidden name="apptypename" value="" id="apptypename" key="apptypename"/>
							<div align="right" style="margin-right: 20px; color: red"> * All fields are mandatory </div>
							
							
							<div class="form-group frm">
								<label class="col-sm-5 control-label"></label>
								<div class="col-sm-4">
									<button id="subBut" type="button" class="btn buts"
										style="width: 80px;" onclick="submitform();" >Submit</button> 
								</div>
							</div>
							
							<div id="loadingimg" style="display:none;" align="center">
										<img src="images/formloading.gif" width="30px" /> <br />
										<br />
									</div>						
							    <div
									style="text-align: center; color: red; font-size: 14px; display: none;"
									id="faileddiv3">
									<img src="images/error.jpg" width="20px" /> &nbsp;
									<s:text name="Failed to Submit the Application. Please Try Again." />
								</div>
								<div
									style="text-align: center; color: red; font-size: 14px; display: none;"
									id="mailfaileddiv3">
									<img src="images/error.jpg" width="20px" /> &nbsp;
									<s:text name="Successfully submitted Application but failed to send mail.." />
								</div>
								
								<div
									style="text-align: center; color: red; font-size: 14px; display: none;"
									id="duplicatediv3">
									<img src="images/error.jpg" width="20px" /> &nbsp;
									<s:text name="Email and Phone Number already exist, Please Apply with existing, User ID" />
								</div>
								
								<div
									style="text-align: center; color: red; font-size: 14px; display: none;"
									id="invalidappiddiv3">
									<img src="images/error.jpg" width="20px" /> &nbsp;
									<s:text name="Invalid Application ID or not matched with Email and Phone Number" />
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
						title="OpenStreetMap" alt="OpenStreetMap"
						onclick="changetoOSMbasemap(frontmap);">
					</a>
					<div class="baseglycls">
						<span alt="OpenStreetMap" title="OpenStreetMap">OpenStreetMap</span>
					</div>
				</div>

				<div id="bingbasemap"
					style="width: 120px; float: left; padding: 10px;">
					<a href="javascript:void(0);"> <img height="67px" width="84px"
						style="border: 1px solid black" src="images/map/bingmap.jpg"
						title="Bing Map" alt="OpenStreetMap"
						onclick="changetoBINGbasemap(frontmap);">
					</a>
					<div class="baseglycls">
						<span alt="OpenStreetMap" title="OpenStreetMap">BingMap</span>
					</div>
				</div>

				<div id="bingroadbasemap"
					style="width: 120px; float: left; padding: 10px;">
					<a href="javascript:void(0);"> <img height="67px" width="84px"
						style="border: 1px solid black" src="images/map/bingroads.JPG"
						title="Bing Map" alt="OpenStreetMap"
						onclick="changetoBINGROADbasemap(frontmap);">
					</a>
					<div class="baseglycls">
						<span alt="OpenStreetMap" title="OpenStreetMap">BingRoadMap</span>
					</div>
				</div>
				
				<div id="satellitebasemap"
					style="width: 120px; float: left; padding: 10px;">
					<a href="javascript:void(0);"> <img height="67px" width="84px"
						style="border: 1px solid black" src="images/map/satelliteimg.jpg"
						title="Satellite" alt="OpenStreetMap"
						onclick="changetoSATELLITEbasemap(frontmap);">
					</a>
					<div class="baseglycls">
						<span alt="OpenStreetMap" title="OpenStreetMap">SatelliteMap</span>
					</div>
				</div>
				
				<div id="bingAerialWithLabelsbasemap"
					style="width: 120px; float: left; padding: 10px;">
					<a href="javascript:void(0);"> <img height="67px" width="84px"
						style="border: 1px solid black"
						src="images/map/bingariallabel.JPG" title="Bing Map"
						alt="OpenStreetMap"
						onclick="changetoBINGAerialWithLabels(frontmap);">
					</a>
					<div class="baseglycls">
						<span alt="OpenStreetMap" title="OpenStreetMap">BingLabelsMap</span>
					</div>
				</div>

				<div id="cartoDBbasemap"
					style="width: 120px; float: left; padding: 10px;">
					<a href="javascript:void(0);"> <img height="67px" width="84px"
						style="border: 1px solid black"
						src="images/map/cartoDBBasemap.jpg" title="CartoDB Map"
						alt="CartoDBMap" onclick="changetocartoDBbasemap(frontmap);">
					</a>
					<div class="baseglycls">
						<span alt="OpenStreetMap" title="StreetsMap">CartoDbMap</span>
					</div>
				</div>
				
			</div>
		</div>

		<div class="navbar navbar-default navbar-fixed-bottom">
			<div class="fluid-container footer"
				style="border-top: 1px solid black;">
				<div>
					<p>
						<marquee>
							Disclaimer: The data here in this application is for information purposes only || Executed by RAILTEL Enterprises Limited (Powered by <a
								style="text-decoration: none; color: black;" target="_blank"
								href="http://iictechnologies.com/">IIC Technologies Limited,
								Hyderabad</a>) Copyright &copy;
							<script type="text/javascript">
								document.write(new Date().getFullYear());
							</script>
							&nbsp;Chennai Port
						</marquee>
					</p>
				</div>
			</div>
		</div>

	</div>
	<script type="text/javascript">
		$(window).load(function() {
			$('#loading').hide();
		});	
	</script>
</body>
</html>