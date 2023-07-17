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

<style>
th {
	color: #f0ce8d;
	text-shadow: 2px 2px 2px #333;
}

td {
	color: #fff;
}

.red1 {
	background: #708380 !important;
}

#wwerr_deleteRole_roleId {
	color: red;
}
</style>
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
		
		      var roleId = "<s:property value="fieldErrors.get('roleId').get(0)"/>";
               
               if(roleId != "")
	                 {
	                    document.getElementById('idroleId').style.border = "1px solid red";
	                    $('#roleIddiv').addClass('tooltip2');
	                    document.getElementById('roleIdspan').innerHTML = roleId;
	                    
	                 }
	               
	});

	function loaddocument() {
		window.open("helpdocument/deleterole.html");
	}
</script>

</head>
<body class="bgs_1">


	<div class="clearfix"></div>
	<!---container-start--->
	<div class="container">
		<!-- <a href="#" title="Help document">
				<div
					style="display: block; float: left; font-family: Verdana; font-size: 14px; font-weight: bold; color: #000; padding-left: 5px; margin-right:5px;"
					onclick="loaddocument();">
					<img alt="cannot load image" src="images/help.png">
				</div>
			</a> -->


		<div class="col-lg-2 col-md-1 hidden-sm hidden-xs">&nbsp;</div>
		<div class="col-lg-8 col-md-10 col-sm-12 col-xs-12">

			<div class="row">
				<div class="col-lg-1 col-md-1 col-sm-1 hidden-xs">&nbsp;</div>
				<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
					<div class="forums">
						<h1>
							Delete Role<img src="images/small_arrow.png">
						</h1>
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">&nbsp;</div>
			</div>

			<div class="gaps hidden-xs">&nbsp;</div>
			<div class="row">
				<div class="col-lg-2 col-md-2 col-sm-2 hidden-xs">&nbsp;</div>
				<div class="col-lg-6 col-md-6 col-sm-8 col-xs-12">

					<s:form class="form-horizontal" action="deleteRole" method="post">
						<div class="form-group forums">
							<label for="inputEmail3" class="col-sm-5 control-label">Role
								Name: </label> </label>
							<div class="col-sm-7"  id="roleIddiv">
							 <span class="tooltiptext2" id="roleIdspan"></span>
								<s:select name="roleId" list="roleList" listKey="roleId"
									listValue="roleName" headerKey="0" headerValue="Select Role"
									cssClass="form-control  sectionbg" id="idroleId"/>
							</div>
						</div>

						<s:set var="status" value="status" />

						<s:if test="%{#status=='failure'}">
							<div style="text-align: center; color: red; font-size: 14px;">
								<img src="images/error.jpg" width="20px" /> &nbsp;
								<s:text name="Failed to Inactivate the Role." />
							</div>
							<br />
						</s:if>
						<s:if test="%{#status=='validrole'}">
							<div style="text-align: center; color: red; font-size: 14px;">
								<img src="images/error.jpg" width="20px" /> &nbsp;
								<s:text name="Role is assigned to a user, Cannot inactivate the role." />
							</div>
							<br />
						</s:if>
						<s:if test="%{#status=='success'}">
							<div style="text-align: center; color: green; font-size: 14px;">
								<img src="images/Successicon.gif" width="20px" /> &nbsp;
								<s:text name="Successfully Inactivated Role." />
							</div>
							<br />
						</s:if>

						<div class="row">
							<div class="col-md-5 col-sm-5"></div>
							<div class="col-md-7 col-sm-5">
								<button type="submit" class="btn buts">Delete</button>
								<button type="reset" class="btn buts">Reset</button>
							</div>

						</div>

						<!--  <div class="col-md-5 col-sm-5">&nbsp;</div>
						<div class="col-md-7 col-sm-5">
							<button type="submit" class="btn buts">Delete</button>
							<button type="reset" class="btn buts">Reset</button>
						</div>
						<div class="col-md-1">&nbsp;</div>-->
						<s:token/>

					</s:form>
				</div>
				<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">&nbsp;</div>

			</div>



		</div>
		<div class="col-lg-2 col-md-1 hidden-sm hidden-xs">&nbsp;</div>


	</div>
	<!--end-container-div--->

	<!---container-end--->

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
