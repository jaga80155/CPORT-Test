<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>


<title>:: Chennai Port ::</title>

<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/general.css" rel="stylesheet">
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
	bottom: 150%;
	left: 50%;
	margin-left: -60px;
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

.errorMessage {
	display: none;
}

.modal {
	display: inherit;
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4);
	position: fixed; /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
	background-color: #fefefe;
	margin: 0.1% auto; /* 15% from the top and centered */
	margin-top: 7%;
	padding: 0px;
	border: 1px solid #888;
	width: 30%; /* Could be more or less, depending on screen size */
	background: rgba(0, 0, 0, 0.7);
}

/* The Close Button */
.close {
	color: #aaa;
	float: right;
	font-size: 20px;
	font-weight: bold;
	color: black;
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
	color: black;
}

.mbody {
	padding: 25px !important;
	position: relative;
	top: 2px;
	color: white;
	font-family: verdana;
	font-size: 12px !important;
}

.lbutton {
	background-color: #e39231;
	cursor: pointer;
	border: none;
	padding: 5px 10px;
	border-radius: 5px;
	font-family: prime, san-serif;
	font-size: 20px;
	letter-spacing: 1px;
	text-decoration: none;
	cursor: pointer;
}

.lbutton:HOVER{
	text-decoration: none;
	cursor: pointer;
}

</style>

<script src="scripts/jquery-1.11.0.min.js"></script>
<script src="scripts/base64.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {

						var emailId = "<s:property value="
						fieldErrors.get('emailId').get(0)
						"/>";

						var phone = "<s:property value="
						fieldErrors.get('mobileNumber').get(0)
						"/>";

						if (phone != "") {
							document.getElementById("mobileNumber").style.border = "1px solid red";
							$('#mobilediv').addClass('tooltip2');
							document.getElementById('phonespan').innerHTML = phone;
						} else if (emailId != "") {
							document.getElementById("emailId").style.border = "1px solid red";
							$('#emailiddiv').addClass('tooltip2');
							document.getElementById('emailIdspan').innerHTML = emailId;
						}

					});

	function closeModal() {
		document.getElementById("myModalPlotSummary").style.display = 'none';
		window.location = "homePage";
	}
</script>
</head>
<body class="bgs_1">

	<div class="clearfix"></div>
	<!---container-start--->
	<div class="container">


		<div class="col-lg-2 col-md-1 hidden-sm hidden-xs">&nbsp;</div>
		<div class="col-lg-8 col-md-10 col-sm-12 col-xs-12">

			<div class="row">
				<div class="col-lg-2 col-md-2 col-sm-2 hidden-xs">&nbsp;</div>
				<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
					<div class="forums runtxt">
						<h1>
							Reset Password <img src="images/small_arrow.png">
						</h1>

						<s:form class="form-horizontal" action="verifyEmailId"
							method="post">

							<div class="form-group">
								<label for="mobile" class="col-sm-5 control-label">Enter
									Mobile Number :</label>
								<div class="col-sm-6" id="mobilediv">
									<span class="tooltiptext2" id="phonespan"></span>
									<s:textfield name="mobileNumber" cssClass="form-control"
										id="mobileNumber"></s:textfield>
								</div>
							</div>

							<div class="form-group" id="">
								<label for="emailId" class="col-sm-5 control-label">Enter
									EmailId :</label>
								<div class="col-sm-6" id="emailiddiv">
									<span class="tooltiptext2" id="emailIdspan"></span>
									<s:textfield name="emailId" cssClass="form-control"
										id="emailId"></s:textfield>
								</div>
							</div>

							<div class="row">
								<div class="col-md-5 col-sm-5"></div>
								<div class="col-md-4 col-sm-5">
									<button type="submit" class="btn buts">Submit</button>

								</div>
								<div class="col-md-3"></div>

							</div>

							<s:set var="status" value="status" />

							<s:if test="%{#status=='failure'}">
								<div style="text-align: center; color: red; font-size: 14px;">
									<img src="images/cross.jpg" width="20px" /> &nbsp;
									<s:text
										name="Entered details are not matching please contact Adminstrator" />
								</div>
								<br />
							</s:if>

							<s:if test="%{#status=='success'}">

								<div id="myModalPlotSummary" class="modal">

									<!-- Modal content -->
									<div class="modal-content plot_smy_mdl">
										<div class="modal-header">
											<h4 style="font-weight: bold;">
												Reset Password<span class="close close1"
													onclick="closeModal()">X</span>
											</h4>
										</div>
										<div class="modal-body mbody">
											<div
												style="text-align: center; color: green; font-size: 14px;">
												<img src="images/Successicon.gif" width="20px" /> &nbsp;
												<s:text name="Reset link is sent to your registered emailId" />
												<div
													style="text-align: center; color: #FFFFFF; font-family: 'primeregular'; font-size: 20px; top: 8px; position: relative;">
													Please <a onclick="closeModal()" class="lbutton">Click
														Here</a> to Login again
												</div>
											</div>

										</div>
									</div>
								</div>


								<br />
							</s:if>
							<s:token/>
							<s:hidden name="username" />
							
						</s:form>


					</div>
				</div>
				<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">&nbsp;</div>
			</div>
			<!-- <div style="height:347px;"></div> -->
		</div>
		<div class="col-lg-2 col-md-1 hidden-sm hidden-xs">&nbsp;</div>


	</div>
	<!--end-container-div--->

	<!---container-end--->

	<div class="clearfix"></div>


	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->

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