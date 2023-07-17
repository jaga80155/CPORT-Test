<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<title>Publish Layer</title>
<!-- no-cache no-store meta tages to avoid cache -->
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="cache-control" content="no-store">
<meta http-equiv="cache-control" content="must-revalidate">
<meta http-equiv="cache-control" content="max-age=0">
<meta http-equiv="cache-control" content="pre-check=0,post-check=0">
<meta http-equiv="expires" content="0">
<meta http-equiv="pragma" content="no-cache">
<!-- no-cache no-store meta tages to avoid cache -->

<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/general.css" rel="stylesheet">

<link rel="stylesheet" href="css/map/ol.css">
<script type='text/javascript' src='scripts/reports/jquery-2.1.4.js'></script>
<script type="text/javascript" src="scripts/map/ol.js"></script>
<script>
	$(document).ready(
			function() {
				$('#selectworkspace').on(
						'change',
						function(event) {

							var selectedWS = $(this).val();
							if (selectedWS != "0") {
								$.getJSON('ajaxAction', {
									selectedWorkspaceName : selectedWS
								}, function(jsonResponse) {
									var select = $('#featureName');
									select.find('option').remove();
									$('<option>').val(-1).text('Select Layer')
											.appendTo(select);
									$.each(jsonResponse.stateMap, function(key,
											value) {
										$('<option>').val(key).text(value)
												.appendTo(select);
									});
								});
							} else {
								var select = $('#featureName');
								select.find('option').remove();
								$('<option>').val(0).text('Select Layer')
										.appendTo(select);
							}
						});

			});
</script>
<style type="text/css">
#frontmap {
	overflow: hidden;
}

canvas.ol-unselectable {
	height: 150px !important;
}

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
	margin: 18% auto; /* 15% from the top and centered */
	padding: 0px;
	/* 	border: 1px solid #888; */
	width: 30%; /* Could be more or less, depending on screen size */
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
	left: 2px;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.modal-header {
	min-height: 13.42857143px;
	padding: 15px !important;
}

.mbody {
	padding: 10px !important;
	position: relative;
	top: 4px;
}

.close1 {
	margin-top: -6px !important;
	opacity: 1 !important;
	color: red !important;
}
</style>
<script type="text/javascript">
	function publish(evt) {
		if (document.getElementById("createworkspace").value == ''
				&& document.getElementById("selectworkspace").value == "0") {
			alert("WorkSpace is Required");
			evt.preventDefault();
			return false;
		} else {
			document.getElementById("sformId").submit();
		}
	};

	function fillWorkspaceName() {

		document.getElementsByName("storeName")[0].value = "";
		document.getElementsByName("layerName")[0].value = "";
		document.getElementsByName("srs")[0].selectedIndex = 0;
		document.getElementsByName("defaultStyle")[0].selectedIndex = 0;
		document.getElementsByName("sfile")[0].value = "";
		

		if (document.getElementById("selectworkspace").value != "0") {
			document.getElementById("createworkspace").value = document
					.getElementById("selectworkspace").value;
		} else {
			document.getElementById("createworkspace").value = "";
			document.getElementById("featureName").value = "0";			
		}
		
		document.getElementById("llpreview").style.display = "none";
	};

	function preview() {
		// 		window.location.href = "getLayers";
		document.getElementById("lpreview").style.display = 'block';

	};
	var count = 0;
	var lcount = 0;
	var frontmap;
	var wmsLayer;
	function layerPreview() {

		  document.getElementById("selectworkspace").style.border="0px";
		  document.getElementById("featureName").style.border="0px";
		   $('#selectworkspacediv').removeClass('tooltip2');
		  $('#featureNamediv').removeClass('tooltip2');
		    document.getElementById('selectworkspacespan').innerHTML = "";
		  document.getElementById('featureNamespan').innerHTML = "";
		  
 
		var webMapServiceUrl;
		var showpreview = document.getElementById("selectworkspace").value;
		var layerSelect = document.getElementById("featureName").value;

		if (showpreview == "0") {
			//alert("Please Select WorkSpace.");
			
			 document.getElementById("selectworkspace").style.border="1px solid red";
             $('#selectworkspacediv').addClass('tooltip2');
             document.getElementById('selectworkspacespan').innerHTML = "Please Select WorkSpace.";
		}
		if (layerSelect == "-1") {
			//document.getElementById("myModalLayer").style.display = 'block';
			//alert("Please Select Layer.");
			 document.getElementById("featureName").style.border="1px solid red";
             $('#featureNamediv').addClass('tooltip2');
             document.getElementById('featureNamespan').innerHTML = "Please Select Layer.";
		}

		if (showpreview != "0" && layerSelect != "-1") {
			document.getElementById("llpreview").style.display = 'block';
			var url = document.getElementById("geoserverurl").value + '/';
			//alert(url);
			var workspace = document.getElementById("selectworkspace").value;

			var sel = document.getElementById("featureName");
			var ltext = sel.options[sel.selectedIndex].text;

			var workspacelayer = workspace + ":" + ltext;
			webMapServiceUrl = url + workspace + '/wms'; // Web map service URL
			var basemapProjection = 'EPSG:4326';
			var latitude = '80.292';
			var longitude = '13.081';
			if (lcount == 1) {
				wmsLayer.setVisible(false);
				lcount = 0;
			}
			wmsLayer = new ol.layer.Tile({
				title : ltext,
				visible : true,
				source : new ol.source.TileWMS({
					url : webMapServiceUrl,
					params : {
						'LAYERS' : workspacelayer
					},
					serverType : 'geoserver'
				})
			});

			/* Float Conversion of Coordinates */
			var lat = parseFloat(latitude);
			var lon = parseFloat(longitude);

			/* Projection view specifications*/
			var startView = new ol.View({
				center : ol.proj.transform([ lat, lon ], basemapProjection,
						'EPSG:900913'),
				zoom : 12
			});

			/* Creating map object */
			if (count == 0) {
				frontmap = new ol.Map({
					target : 'frontmap',
					layers : [ wmsLayer ], // Add base map first
					view : startView
				});
				lcount = 1;
			} else {
				frontmap.addLayer(wmsLayer);
				lcount = 1;
			}
			count++;
		}
	}

	function closeModal() {
		document.getElementById("myModal").style.display = 'none';
		document.getElementById("myModalLayer").style.display = 'none';
	}
	
	function clearPreview(){
		document.getElementById("llpreview").style.display = "none";
	}
</script>

<style>
.tooltip2 {
    position: relative;
    display: inline-block;
   
}

.tooltip2 .tooltiptext2 {
    visibility: hidden;
    width: 220px;
    background-color: #efaa58;
    color: red;
    text-align: center;
    border-radius: 6px;
    padding: 5px 0;
    position: absolute;
    z-index: 1;
   /*  bottom: 150%; */
    bottom: 130%;
    left: 50%;
     margin-left: -90px;
   /*  margin-left: -60px; */
}

.tooltip2 .tooltiptext2::after {
    content: "";
    position: absolute;
    top: 100%;
    left: 50%;
    margin-left: -5px;
    border-width: 5px;
    border-style: solid;
    border-color: #efaa58 transparent transparent transparent;
}

.tooltip2:hover .tooltiptext2 {
    visibility: visible;
}

.errorMessage
{
 display:none;
} 
</style>

<script type="text/javascript">
	$(document).ready(function() {
		
		      var workspaceName = "<s:property value="fieldErrors.get('workspaceName').get(0)"/>";
              var storeName = "<s:property value="fieldErrors.get('storeName').get(0)"/>";
               var layerName = "<s:property value="fieldErrors.get('layerName').get(0)"/>";
                var srs = "<s:property value="fieldErrors.get('srs').get(0)"/>";
              var defaultStyle = "<s:property value="fieldErrors.get('defaultStyle').get(0)"/>";
               var sfile = "<s:property value="fieldErrors.get('sfile').get(0)"/>";
               
               if(workspaceName != "")
	                 {
	                    document.getElementById('createworkspace').style.border = "1px solid red";
	                    $('#workspaceNamediv').addClass('tooltip2');
	                    document.getElementById('workspaceNamespan').innerHTML = workspaceName;
	                    
	                 }
 		       else if(storeName != "")
	 		       {
	 		       	    document.getElementById('idstoreName').style.border = "1px solid red";
	 		            $('#storeNamediv').addClass('tooltip2');
	                    document.getElementById('storeNamespan').innerHTML = storeName;
	 		       }
 		     
               else if(layerName != "")
	               {
	              	 document.getElementById("idlayerName").style.border="1px solid red";
	              	 $('#layerNamediv').addClass('tooltip2');
	                 document.getElementById('layerNamespan').innerHTML = layerName;
	               }
	                else if(srs != "")
	 		       {
	 		       	    document.getElementById('idsrs').style.border = "1px solid red";
	 		            $('#srsdiv').addClass('tooltip2');
	                    document.getElementById('srsspan').innerHTML = srs;
	 		       }
 		     
               else if(defaultStyle != "")
	               {
	              	 document.getElementById("iddefaultStyle").style.border="1px solid red";
	              	 $('#defaultStylediv').addClass('tooltip2');
	                 document.getElementById('defaultStylespan').innerHTML = defaultStyle;
	               }
	                else if(sfile != "")
	 		       {
	 		       	    document.getElementById('idsfile').style.border = "1px solid red";
	 		       	      document.getElementById('idsfile').style.width = "207px";
	 		            $('#sfilediv').addClass('tooltip2');
	                    document.getElementById('sfilespan').innerHTML = sfile;
	 		       }
 		     
	});

</script>

</head>
<body>

	<div class="clearfix"></div>
	<!---container-start--->
	<div class="container">


		<div class="col-lg-1 col-md-1 hidden-sm hidden-xs">&nbsp;</div>
		<div class="col-lg-10 col-md-10 col-sm-12 col-xs-12">

			<div class="row">

				<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
					<div class="forums runtxt">
						<h1>
							Publish Layer <img src="images/small_arrow.png">
						</h1>

						<s:form class="form-horizontal" method="post"
							action="publishLayer" enctype="multipart/form-data" id="sformId"
							cssStyle="border-right: 1px solid orange;">

							<div class="form-group">
								<label for="workspaceName" class="col-sm-5 control-label">
									Workspace Name :</label>
								<div class="col-sm-6" id="workspaceNamediv">
								 <span class="tooltiptext2" id="workspaceNamespan"></span>
									<s:textfield name="workspaceName" id="createworkspace"
										cssClass="form-control"></s:textfield>
								</div>
							</div>

							<div class="form-group">
								<label for="storeName" class="col-sm-5 control-label">Store
									Name :</label>
								<div class="col-sm-6" id="storeNamediv">
								 <span class="tooltiptext2" id="storeNamespan"></span>
									<s:textfield name="storeName" cssClass="form-control" id="idstoreName"></s:textfield>
								</div>
							</div>

							<div class="form-group">
								<label for="layerName" class="col-sm-5 control-label">Layer
									Name :</label>
								<div class="col-sm-6" id="layerNamediv">
								 <span class="tooltiptext2" id="layerNamespan"></span>
									<s:textfield name="layerName" cssClass="form-control" id="idlayerName"></s:textfield>
								</div>
							</div>

							<div class="form-group">
								<label for="srs" class="col-sm-5 control-label">Native
									SRS :</label>
								<div class="col-sm-6" id="srsdiv">
								 <span class="tooltiptext2" id="srsspan"></span>
									<s:select
										list="#{'0':'Select Native SRS','EPSG:32645':'EPSG:32645', 'EPSG:900913':'EPSG:900913'}"
										name="srs" cssClass="form-control sectionbg" id="idsrs"></s:select>
								</div>
							</div>

							<div class="form-group">
								<label for="defaultStyle" class="col-sm-5 control-label">
									 Style : </label>
								<div class="col-sm-6" id="defaultStylediv">
								 <span class="tooltiptext2" id="defaultStylespan"></span>
									<s:select
										list="#{'0':'Select Style','Polygon':'Polygon', 'point':'point', 'polyline':'polyline'}"
										name="defaultStyle" cssClass="form-control sectionbg" id="iddefaultStyle"></s:select>
								</div>
							</div>

							<div class="form-group">
								<label for="selectFile" class="col-sm-5 control-label">Upload
									File :</label>
								<div class="col-sm-6" id="sfilediv">
								 <span class="tooltiptext2" id="sfilespan"></span>
									<s:file name="sfile"  accept=".zip" id="idsfile" cssClass="form-control" cssStyle="padding-top: 3px; padding-left: 2px;" ></s:file>
								</div> 
							</div>  

							<s:set var="status" value="status" />

							<s:if test="%{#status=='failure'}">
								<div style="text-align: center; color: red; font-size: 14px;">
									<img src="images/error.jpg" width="20px" /> &nbsp;
									<s:text name="Failed to publish layer." />
								</div>
								<br />
							</s:if>
							<s:if test="%{#status=='success'}">
								<div style="text-align: center; color: green; font-size: 14px;">
									<img src="images/Successicon.gif" width="20px" /> &nbsp;
									<s:text name="Layer published Successfully." />
								</div>
								<br />
							</s:if>
							<s:if test="%{#status=='availableLayer'}">
								<div style="text-align: center; color: red; font-size: 14px;">
									<img src="images/error.jpg" width="20px" /> &nbsp;
									<s:text name="Layer already exists." />
								</div>
								<br />
							</s:if>

							<div class="row">
								<div class="col-md-5 col-sm-5"></div>
								<div class="col-md-4 col-sm-5">
									<button type="submit" class="btn buts">Publish</button>
								</div>
							</div>
							<s:token/>
						</s:form>

						<input type="hidden" name="geoserverurl" id="geoserverurl"
							value="${geoserverurl}">

					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
					<div style="height: 54px"></div>
					<div class="forums runtxt form-horizontal">
						<div class="form-group">
							<label for="storeName" class="col-sm-5 control-label">Existing
								Workspace:</label>
							<div class="col-sm-6" id="selectworkspacediv">
							 <span class="tooltiptext2" id="roleNamespan"></span>
							 <span class="tooltiptext2" id="selectworkspacespan" style="bottom:130%;"></span>
								<s:select list="workspaceList" headerKey="0"
									headerValue="Select Workspace"
									cssClass="form-control sectionbg" id="selectworkspace"
									onchange="fillWorkspaceName();"></s:select>
							</div>

						</div>
						<div class="form-group">
							<label for="storeName" class="col-sm-5 control-label">Layer:</label>
							<div class="col-sm-6" id="featureNamediv">
							 <span class="tooltiptext2" id="roleNamespan"></span>
							  <span class="tooltiptext2" id="featureNamespan" style="bottom:130%;"></span>
								<s:select id="featureName" name="featureName"
									list="{'Select Layer'}" cssClass="form-control sectionbg" onchange="clearPreview();"></s:select>
							</div>

						</div>
						<div class="form-group">
							<label for="storeName" class="col-sm-5 control-label">&nbsp;</label>
							<div class="col-sm-5">
								<button type="button" class="btn buts" onclick="layerPreview()"
									id="previewBtn">Preview</button>
							</div>

						</div>
					</div>
					<br />
					<div id="llpreview">
						<div id="frontmap" style="background: #fff;"></div>
					</div> 

				</div>

			</div>

		</div>
		<!-- 		<div style="height: 347px;"></div> -->
	</div>
	<div class="col-lg-1 col-md-1 hidden-sm hidden-xs">&nbsp;</div>


	<!--end-container-div--->

	<!---container-end--->

	<div class="clearfix"></div>

	<div id="myModal" class="modal" style="display: none;">

		<!-- Modal content -->
		<div class="modal-content" style="width: 300px;">
			<div class="modal-header">
				<span class="close close1" onclick="closeModal()">X</span>
			</div>
			<div class="modal-body mbody">
				<p style="color: red; font-size: 12px; text-align: center;">
					Please Select WorkSpace.</p>
			</div>

		</div>

	</div>

	<div id="myModalLayer" class="modal" style="display: none;">

		<!-- Modal content -->
		<div class="modal-content" style="width: 300px;">
			<div class="modal-header">
				<span class="close close1" onclick="closeModal()">X</span>
			</div>
			<div class="modal-body mbody">
				<p style="color: red; font-size: 12px; text-align: center;">
					Please Select Layer.</p>
			</div>

		</div>

	</div>

	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="scripts/bootstrap.min.js"></script>
	<script>
		$('.carousel').carousel({
			interval : 3000
		//changes the speed
		})
	</script>

</body>
</html>
