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
<style type="text/css">
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

</style>
<style type="text/css">
.errorMessage
{
 display:none;
} 
</style>
<script src="scripts/jquery-1.11.0.min.js"></script>
<script src="scripts/user/loginPage.js" type="text/javascript"></script>
<script src="scripts/base64.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function() {

  			  var chgPassword = "<s:property value="fieldErrors.get('chgPassword').get(0)"/>";
              var chgCPassword = "<s:property value="fieldErrors.get('chgCPassword').get(0)"/>";
              
              
               if(chgPassword != "")
	                 {
	                    document.getElementById("chgPassword").style.border="1px solid red";
	                    $('#chgPassworddiv').addClass('tooltip2');
	                    document.getElementById('chgPasswordspan').innerHTML = chgPassword;
	                    
	                 }
 		       else if(chgCPassword != "")
	 		       {
	 		           document.getElementById("chgCPassword").style.border="1px solid red";
	 		           $('#chgCPassworddiv').addClass('tooltip2');
	                    document.getElementById('chgCPasswordspan').innerHTML = chgCPassword;
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
							Change Password <img src="images/small_arrow.png">
						</h1>
						<s:form class="form-horizontal" action="changePassword"
							method="post" name="changepwdfrm">
							<div class="form-group">
								<label for="username" class="col-sm-6 control-label">Username
									:</label>
								<div class="col-sm-6">
									<s:textfield name="chgUsername" cssClass="form-control"
										value="%{#session.loginname}" readonly="true"
										cssStyle="color:black;"></s:textfield>
								</div>
							</div>
							<div class="form-group">
								<label for="username" class="col-sm-6 control-label">New
									Password :</label>
								<div class="col-sm-6" id="chgPassworddiv">
								   <span class="tooltiptext2" id="chgPasswordspan"></span>	
									<s:password name="chgPassword" showPassword="true"
										cssClass="form-control" id="chgPassword"></s:password>
								</div>
							</div>
							<div class="form-group">
								<label for="username" class="col-sm-6 control-label">Confirm
									New Password :</label>
								<div class="col-sm-6" id="chgCPassworddiv">
								   <span class="tooltiptext2" id="chgCPasswordspan"></span>	
									<s:password name="chgCPassword" showPassword="true"
										cssClass="form-control" id="chgCPassword"></s:password>
								</div>
							</div>

							<s:set var="status" value="status" />

							<s:if test="%{#status=='failure'}">
								<div style="text-align: center; color: red; font-size: 14px;">
									<img src="images/error.jpg" width="20px" /> &nbsp;
									<s:text name="Failed to Change Password." />
								</div>
								<br />
							</s:if>
							<s:if test="%{#status=='success'}">
								<div style="text-align: center; color: green; font-size: 14px;">
									<img src="images/Successicon.gif" width="20px" /> &nbsp;
									<s:text name="Successfully Changed Password." />
								</div>
								<br />
							</s:if>

							<div class="row">
								<div class="col-md-6 col-sm-6"></div>
								<div class="col-md-4 col-sm-5">
									<button type="button" onclick="changePwd();" class="btn buts">Change</button>
									<button type="button" class="btn buts"
										onclick="resetChangePassword()">Reset</button>
								</div>
								<div class="col-md-3"></div>
							</div>
							<s:token />
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