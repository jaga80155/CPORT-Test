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

<!-- Bootstrap -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/general.css" rel="stylesheet">

<script type="text/javascript" src="scripts/user/adminPage.js"></script>
<script type="text/javascript" src="scripts/user/updateUser.js"></script>
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

.errorMessage
{
 display:none;
} 
</style>

<script type="text/javascript">

$(document).ready(function() {
		
		      var userId = "<s:property value="fieldErrors.get('userId').get(0)"/>";
		      var firstName = "<s:property value="fieldErrors.get('firstName').get(0)"/>";
		      var lastName = "<s:property value="fieldErrors.get('lastName').get(0)"/>";
		      var emailId = "<s:property value="fieldErrors.get('emailId').get(0)"/>";
		      var phone = "<s:property value="fieldErrors.get('phone').get(0)"/>";
		      var roleId = "<s:property value="fieldErrors.get('roleId').get(0)"/>";
		      
               if(userId != "")
	                 {
	                    document.getElementById('userId').style.border = "1px solid red";
	                    $('#userIddiv').addClass('tooltip2');
	                    document.getElementById('userIdspan').innerHTML = userId;
	                 }
	                 else if(firstName != ""){
	                  document.getElementById('firstName').style.border = "1px solid red";
	                    $('#firstNamediv').addClass('tooltip2');
	                    document.getElementById('firstNamespan').innerHTML = firstName;
	                 }
	                  else if(lastName != ""){
	                  document.getElementById('lastName').style.border = "1px solid red";
	                    $('#lastNamediv').addClass('tooltip2');
	                    document.getElementById('lastNamespan').innerHTML = lastName;
	                 }
	                  else if(emailId != ""){
	                  document.getElementById('emailId').style.border = "1px solid red";
	                    $('#emailIddiv').addClass('tooltip2');
	                    document.getElementById('emailIdspan').innerHTML = emailId;
	                 }
	                  else if(phone != ""){
	                  document.getElementById('phone').style.border = "1px solid red";
	                    $('#phonediv').addClass('tooltip2');
	                    document.getElementById('phonespan').innerHTML = phone;
	                 }
	                  else if(roleId != ""){
	                  document.getElementById('roleId').style.border = "1px solid red";
	                    $('#roleIddiv').addClass('tooltip2');
	                    document.getElementById('roleIdspan').innerHTML = roleId;
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
					<div class="forums">
						<h1>
							Update User <img src="images/small_arrow.png">
						</h1>
						<s:form action="updateUser" class="form-horizontal" method="post">
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-4 control-label">User
									Name : </label>
								<div class="col-sm-6" id="userIddiv">
								 <span class="tooltiptext2" id="userIdspan"></span>
									<s:select id="userId" name="userId" list="userList"
										listKey="userId" listValue="userName" headerKey="0"
										headerValue="Select Username"
										cssClass="form-control sectionbg" />
								</div>
							</div>
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-4 control-label">First
									Name :</label>
								<div class="col-sm-6" id="firstNamediv">
								 <span class="tooltiptext2" id="firstNamespan"></span>
									<s:textfield id="firstName" name="firstName"
										cssClass="form-control"></s:textfield>
								</div>
							</div>
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-4 control-label">Last
									Name: </label>
								<div class="col-sm-6" id="lastNamediv">
								 <span class="tooltiptext2" id="lastNamespan"></span>
									<s:textfield id="lastName" name="lastName"
										cssClass="form-control"></s:textfield>
								</div>
							</div>
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-4 control-label">Email
									Id: </label>
								<div class="col-sm-6" id="emailIddiv">
								 <span class="tooltiptext2" id="emailIdspan"></span>
									<s:textfield id="emailId" name="emailId"
										cssClass="form-control"></s:textfield>
								</div>
							</div>
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-4 control-label">Mobile
									Number: </label>
								<div class="col-sm-6" id="phonediv">
								 <span class="tooltiptext2" id="phonespan"></span>
									<s:textfield id="phone" name="phone" cssClass="form-control"></s:textfield>
								</div>
							</div>
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-4 control-label">Role:
								</label>
								<div class="col-sm-6" id="roleIddiv">
								 <span class="tooltiptext2" id="roleIdspan"></span>
									<s:select id="roleId" name="roleId" list="roleList"
										listKey="roleId" listValue="roleName" headerKey="0"
										headerValue="Select Role" cssClass="form-control sectionbg" />
								</div>
							</div>

							<s:set var="status" value="status" />

							<s:if test="%{#status=='failure'}">
								<div style="text-align: center; color: red; font-size: 14px;">
									<img src="images/error.jpg" width="20px" /> &nbsp;
									<s:text name="Failed to update user details." />
								</div>
								<br />
							</s:if>
							<s:if test="%{#status=='success'}">
								<div style="text-align: center; color: green; font-size: 14px;">
									<img src="images/Successicon.gif" width="20px" /> &nbsp;
									<s:text name="Successfully Updated User Details." />
								</div>
								<br />
							</s:if>
							<div class="row">
								<div class="col-md-4 col-sm-4"></div>
								<div class="col-md-5 col-sm-5">
									<button type="submit" class="btn buts">Update</button>
									<button type="reset" class="btn buts">Reset</button>
									<br />
									<br />
									<br />
								</div>
								<div class="col-md-3 col-sm-3"></div>
							</div>
							<!-- <div class="row">
								<div class="text-center">
									<button type="submit" class="btn buts">Update</button>
									<button type="reset" class="btn buts">Reset</button>
								</div>
							</div>-->
							<s:token/>
						</s:form>
					</div>
				</div>
				<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">&nbsp;</div>

			</div>
			<!-- <div style="height:174px;"></div> -->
		</div>
		<div class="col-lg-2 col-md-1 hidden-sm hidden-xs">&nbsp;</div>

	</div>
	<!--end-container-div--->

	<!---container-end--->

	<div class="clearfix"></div>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="scripts/jquery-1.11.0.min.js"></script>
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