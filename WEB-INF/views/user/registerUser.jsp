<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<!-- no-cache no-store meta tages to avoid cache -->
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="cache-control" content="no-store">
<meta http-equiv="cache-control" content="must-revalidate">
<meta http-equiv="cache-control" content="max-age=0">
<meta http-equiv="cache-control" content="pre-check=0,post-check=0">
<meta http-equiv="expires" content="0">
<meta http-equiv="pragma" content="no-cache">
<!-- no-cache no-store meta tages to avoid cache -->
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>:: Chennai Port ::</title>

<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/general.css" rel="stylesheet">
<script src="scripts/jquery-1.11.1.min.js"></script>
<script src="scripts/user/loginPage.js" type="text/javascript"></script>
<script src="scripts/base64.js" type="text/javascript"></script>
<script src="scripts/user/adminPage.js" type="text/javascript"></script>
<%-- <style>
.forums {
	
}

.forums label {
	font-weight: normal;
	font-family: verdana;
	color: #fff;
}

.forums input {
	font-weight: normal;
	font-family: verdana;
	color: #fff;
	font-size: 11px;
}
</style> --%>

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

<script type="text/javascript">
	$(document).ready(function() {

		var username = "<s:property value="fieldErrors.get('username').get(0)"/>";
		var password = "<s:property value="fieldErrors.get('password').get(0)"/>";
		var cpassword = "<s:property value="fieldErrors.get('cpassword').get(0)"/>";
		var firstName = "<s:property value="fieldErrors.get('firstName').get(0)"/>";
		var lastName = "<s:property value="fieldErrors.get('lastName').get(0)"/>";
		var emailId = "<s:property value="fieldErrors.get('emailId').get(0)"/>";

		var phone = "<s:property value="fieldErrors.get('phone').get(0)"/>";
		var roleId = "<s:property value="fieldErrors.get('roleId').get(0)"/>";

		if (username != "") {
		 document.getElementById("idusername").style.border="1px solid red";
			$('#usernamediv').addClass('tooltip2');
			document.getElementById('usernamespan').innerHTML = username;
		} else if (password != "") {
		 document.getElementById("repassword").style.border="1px solid red";
			$('#passworddiv').addClass('tooltip2');
			document.getElementById('passwordspan').innerHTML = password;
		} else if (cpassword != "") {
		 document.getElementById("crepassword").style.border="1px solid red";
			$('#cpassworddiv').addClass('tooltip2');
			document.getElementById('cpasswordspan').innerHTML = cpassword;
		} else if (firstName != "") {
		 document.getElementById("idfirstName").style.border="1px solid red";
			$('#firstNamediv').addClass('tooltip2');
			document.getElementById('firstNamespan').innerHTML = firstName;
		} else if (lastName != "") {
		 document.getElementById("idlastName").style.border="1px solid red";
			$('#lastNamediv').addClass('tooltip2');
			document.getElementById('lastNamespan').innerHTML = lastName;
		} else if (emailId != "") {
		 document.getElementById("idemailId").style.border="1px solid red";
			$('#emailIddiv').addClass('tooltip2');
			document.getElementById('emailIdspan').innerHTML = emailId;
		} else if (phone != "") {
		 document.getElementById("idphone").style.border="1px solid red";
			$('#phonediv').addClass('tooltip2');
			document.getElementById('phonespan').innerHTML = phone;
		} else if (roleId != "") {
		 document.getElementById("idroleId").style.border="1px solid red";
			$('#roleIddiv').addClass('tooltip2');
			document.getElementById('roleIdspan').innerHTML = roleId;
		}

	});
</script>

</head>
<body class="bgs_1">
	<div class="clearfix"></div>

	<div class="container">

		<div class="col-lg-2 col-md-1 hidden-sm hidden-xs">&nbsp;</div>
		<div class="col-lg-8 col-md-10 col-sm-12 col-xs-12">
			<div class="row">
				<div id="wwctrl_regsiterUser_roleId"></div>
			</div>
			<div class="row">
				<div class="col-lg-2 col-md-2 col-sm-1 hidden-xs">&nbsp;</div>
				<div class="col-lg-8 col-md-8 col-sm-10 col-xs-12">
					<div class="forums">
						<h1>
							Register User <img src="images/small_arrow.png">
						</h1>
						<s:form class="form-horizontal" action="regsiterUser"
							method="post" name="registerfrm">
							<div class="form-group">

								<%-- <div><s:fielderror fieldName="username"></s:fielderror></div> --%>
								<label for="inputEmail3" class="col-sm-4 control-label">User
									Name : </label>
								<div class="col-sm-6" id="usernamediv">
									<span class="tooltiptext2" id="usernamespan"></span>
									<s:textfield name="username" cssClass="form-control" id="idusername"></s:textfield>

								</div>
							</div>
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-4 control-label">Password
									: </label>
								<div class="col-sm-6" id="passworddiv">
									<span class="tooltiptext2" id="passwordspan"></span>
									<s:password name="password" showPassword="true"
										cssClass="form-control" id="repassword" ></s:password>
								</div>
							</div>

							<div class="form-group">
								<label for="inputEmail3" class="col-sm-4 control-label">Confirm
									Password : </label>
								<div class="col-sm-6" id="cpassworddiv">
									<span class="tooltiptext2" id="cpasswordspan"></span>
									<s:password name="cpassword" showPassword="true"
										cssClass="form-control" id="crepassword" ></s:password>
								</div>
							</div>

							<div class="form-group">
								<label for="inputEmail3" class="col-sm-4 control-label">First
									Name : </label>
								<div class="col-sm-6" id="firstNamediv">
									<span class="tooltiptext2" id="firstNamespan"></span>
									<s:textfield name="firstName" cssClass="form-control" id="idfirstName"></s:textfield>
								</div>
							</div>

							<div class="form-group">
								<label for="inputEmail3" class="col-sm-4 control-label">Last
									Name : </label>
								<div class="col-sm-6" id="lastNamediv">
									<span class="tooltiptext2" id="lastNamespan"></span>
									<s:textfield name="lastName" cssClass="form-control" id="idlastName"></s:textfield>
								</div>
							</div>

							<div class="form-group">
								<label for="inputEmail3" class="col-sm-4 control-label">Email
									Id : </label>
								<div class="col-sm-6" id="emailIddiv">
									<span class="tooltiptext2" id="emailIdspan"></span>
									<s:textfield name="emailId" cssClass="form-control" id="idemailId"></s:textfield>
								</div>
							</div>

							<div class="form-group">
								<label for="inputEmail3" class="col-sm-4 control-label">Mobile
									Number : </label>
								<div class="col-sm-6" id="phonediv">
									<span class="tooltiptext2" id="phonespan"></span>
									<s:textfield name="phone" cssClass="form-control" id="idphone"></s:textfield>
								</div>
							</div>
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-4 control-label">Role:
								</label>
								<div class="col-sm-6" id="roleIddiv">
									<span class="tooltiptext2" id="roleIdspan"></span>
									<s:select name="roleId" list="roleList" listKey="roleId"
										listValue="roleName" headerKey="0" headerValue="Select Role"
										cssClass="form-control sectionbg" id="idroleId"/>
								</div>
							</div>

							<s:set var="status" value="status" />
							<s:if test="%{#status=='exists'}">
								<div style="text-align: center; color: red; font-size: 14px;">
									<img src="images/error.jpg" width="20px" /> &nbsp;
									<s:text name="Username already Exists. " />
								</div>
								<br />
							</s:if>
							<s:if test="%{#status=='failure'}">
								<div style="text-align: center; color: red; font-size: 14px;">
									<img src="images/error.jpg" width="20px" /> &nbsp;
									<s:text name="Failed to Register the User." />
								</div>
								<br />
							</s:if>
							<s:if test="%{#status=='success'}">
								<div style="text-align: center; color: green; font-size: 14px;">
									<img src="images/Successicon.gif" width="20px" /> &nbsp;
									<s:text name="Successfully Registered the User" />
								</div>
								<br />
							</s:if>
							<div class="row">
								<div class="col-md-4 col-sm-4"></div>
								<div class="col-md-5 col-sm-5">
									<button type="button" onclick="RegisterUser();"
										class="btn buts">Register</button>
									<button type="button" class="btn buts"
										onclick="resetRegisterPage()">Reset</button>
								</div>
								<div class="col-md-3 col-sm-3"></div>
							</div>
							<!--  <div class="row">
								<div class="text-center">
									<button type="button" onclick="RegisterUser();" class="btn buts">Register</button>
									<button type="reset" class="btn buts">Reset</button>
								</div>
							</div>-->
							<s:token />
						</s:form>
					</div>
				</div>
				<div class="col-lg-2 col-md-2 col-sm-1 col-xs-12">&nbsp;</div>
			</div>
			<div style="height: 90px;"></div>

		</div>
		<div class="col-lg-2 col-md-1 hidden-sm hidden-xs">&nbsp;</div>

	</div>
	<div class="clearfix"></div>


	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
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