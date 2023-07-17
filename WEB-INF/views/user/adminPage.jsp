<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
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

<script type="text/javascript" src="scripts/user/adminPage.js"></script>
<script type="text/javascript">
	function getuserrole() {

		var roleid = document.getElementById("userroleid").value;
		console.log("logged in role id in adminPage: "+roleid);
		
		/* Disable User mgmt,Role management,data mgmt and add m=notifications features for roles other than Administrator and Port Officer */
		if (roleid == 1) {
			//All features should be enabled
			console.log("Admin or Port officer login, So all features enabled");
		}else if(roleid == 2){
			document.getElementById('datamgmt').style.pointerEvents = 'none';
			document.getElementById('addnotmgmt').style.pointerEvents = 'none';
			document.getElementById('rolemgmt').style.pointerEvents = 'none';
		}
		else
		{
			console.log("Not admin/port officer so disabled few features");
			document.getElementById('usermgmt').style.pointerEvents = 'none';
			document.getElementById('usermgmt').style.display = 'none';
			document.getElementById('rolemgmt').style.pointerEvents = 'none';
			document.getElementById('rolemgmt').style.display = 'none';
			document.getElementById('datamgmt').style.pointerEvents = 'none';
			document.getElementById('datamgmt').style.display = 'none';
			document.getElementById('addnotmgmt').style.pointerEvents = 'none';
			document.getElementById('addnotmgmt').style.display = 'none';
			
		}

		window.location.hash = "no-back-button";
		window.location.hash = "Again-No-back-button";//again because google chrome don't insert first hash into history
		window.onhashchange = function() {
			window.location.hash = "no-back-button";
		}
		
	}
</script>
</head>
<body class="bgs_1" onload="getuserrole();">

	<div class="clearfix"></div>


	<div class="container">
		<div class="col-md-12 gap">&nbsp;</div>

		<div class="col-lg-2 col-md-2 hidden-sm hidden-xs">&nbsp;</div>
		<div class="col-lg-8 col-md-8 col-sm-12 col-xs-12 flexpads">

			<div class="row">
				<div class="flex-container">

					<div id="usermgmt" class="user_brdr"
						onclick="useManagementSection();">
						<div class="flex-item">
							<img src="images/user_management_icon.png">
							<h1>User Management</h1>
						</div>
					</div>
					<div id="rolemgmt" class="role_brdr"
						onclick="roleManagementSection();">
						<div class="flex-item">
							<img src="images/role_management_icon.png">
							<h1>Role Management</h1>
						</div>
					</div>
					<div id="datamgmt" class="data_brdr"
						onclick="dataManagementSection();">
						<div class="flex-item">
							<img src="images/data_management_icon.png">
							<h1>Data Management</h1>
						</div>
					</div>
				</div>
			</div>
			<div class="row"></div>
			<div class="row">
				<div class="flex-container">
					<div id="mapmgmt" class="map_brdr" onclick="loadMap();">
						<div class="flex-item">
							<img src="images/map_icon.png">
							<h1>Map Screen</h1>
						</div>
					</div>
					<div id="chgpwdmgmt" class="pass_brdr"
						onclick="loadChangePassword();">
						<div class="flex-item">
							<img src="images/change_password_icon.png">
							<h1>Change Password</h1>
						</div>
					</div>
					<div id="addnotmgmt" class="note_brdr"
						onclick="loadNotification();">
						<div class="flex-item">
							<img src="images/add_notification_icon.png">
							<h1>Add Notifications</h1>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-lg-2 col-md-2 hidden-sm hidden-xs">&nbsp;</div>

	</div>
	<s:hidden id="userroleid" value='%{#session.roleId}' />
	<div class="clearfix"></div>


	<!-- jQuery (necessary for Bootstrap's JavaScr4pt plugins) -->
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