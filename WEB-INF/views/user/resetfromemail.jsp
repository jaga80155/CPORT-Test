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
</style>

<script src="scripts/jquery-1.11.0.min.js"></script>
<script src="scripts/base64.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
		var uname = "<s:property value="fieldErrors.get('username').get(0)"/>";
		var password = "<s:property value="fieldErrors.get('password').get(0)"/>";
		var cpassword = "<s:property value="fieldErrors.get('confirmPassword').get(0)"/>";
		
		if (uname != "") {
			 document.getElementById("username").style.border="1px solid red";
				$('#usernamediv').addClass('tooltip2');
				document.getElementById('usernamespan').innerHTML = uname;
			} 
		else if (password != "") {
		 document.getElementById("password").style.border="1px solid red";
			$('#passworddiv').addClass('tooltip2');
			document.getElementById('passwordspan').innerHTML = password;
		} else if (cpassword != "") {
			 document.getElementById("confirmPassword").style.border="1px solid red";
				$('#confirmpassworddiv').addClass('tooltip2');
				document.getElementById('confirmpasswordspan').innerHTML = cpassword;
			} 
	});
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
						<s:form class="form-horizontal" action="resetPasswordFromEmail"
							method="post" >
							<div class="form-group">
								<label for="username" class="col-sm-4 control-label" >Enter Username
									:</label>
								<div class="col-sm-6" id="usernamediv" >
									<span class="tooltiptext2" id="usernamespan"></span>
									<s:textfield name="username" cssClass="form-control" id="username"></s:textfield>
								
								</div>
							</div> 
							
						 	<div class="form-group">
								<label for="password" class="col-sm-4 control-label">New Password
									:</label>
								<div class="col-sm-6" id="passworddiv" >
								<span class="tooltiptext2" id="passwordspan"></span>
									<s:password name="password" cssClass="form-control" id="password"></s:password>
								</div>
							</div>
							
							<div class="form-group" id="">
								<label for="confirmPassword" class="col-sm-4 control-label">Confirm Password
									:</label>
								<div class="col-sm-6" id="confirmpassworddiv">
								<span class="tooltiptext2" id="confirmpasswordspan"></span>
									<s:password name="confirmPassword" cssClass="form-control" id="confirmPassword"></s:password>
								</div>
							</div> 

							<div class="row">
								<div class="col-md-4 col-sm-4"></div>
								<div class="col-md-4 col-sm-5">
									<button type="submit"  class="btn buts">Submit</button>
									
								</div>
								<div class="col-md-3"></div>
							</div>
							
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