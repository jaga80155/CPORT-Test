<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
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
   function getuserrole()
   {
   
    var roleid = document.getElementById("userroleid").value;
		console.log("logged in role id in menu: "+roleid);
		/* Disable User mgmt,Role management,data mgmt and add m=notifications features for roles other than Administrator and Port Officer */
		if ((roleid == 1) || (roleid == 2) ) {
			//All features should be enabled
			console.log("Admin or Port ooficer login, So all features enabled");
		}
		else
		{
			console.log("Not admin/port officer so disabled few features");
			document.getElementById('usermgmt').style.pointerEvents = 'none';
			document.getElementById('rolemgmt').style.pointerEvents = 'none';
			document.getElementById('datamgmt').style.pointerEvents = 'none';
			document.getElementById('addnotmgmt').style.pointerEvents = 'none';
		}
		
   
    }
   
  
    </script>
    
<style>
th {
	color: #f0ce8d;
	text-shadow: 2px 2px 2px #333;
}

td {
	color: #fff;
}
</style>

</head>
<body class="bgs_1" onload="getuserrole();">

	<div class="clearfix"></div>
	<!---container-start--->
	<div class="container">
		<div class="col-md-12 gaps">&nbsp;</div>
		<div class="row">
			<div class="col-lg-2 col-md-2 hidden-sm col-xs-12">&nbsp;</div>
			<div class="col-lg-8 col-md-8 col-sm-12 col-xs-12 tb">
				<div class="flex-container_1">
					<div class="user_brdr_1">
						<div id="usermgmt" class="flex-item_1" onclick="useManagementSection();">
						<ul class="dmenu">
							<li><a href="#s1"><img src="images/user_management_yellow_small.PNG"></a>
							<a href="#s1">User Management</a>
			                    <ul class="dsubmenu">
			                        <li><a href="#">Register User</a></li>
			                        <li><a href="displayUpdateUserPage">Update User</a></li>
			                        <li><a href="displayDeleteUserPage">Delete User</a></li>
			                    </ul>
                </li>
						</ul>	
						</div>
					</div>
					<div id="rolemgmt" class="user_brdr_1">
						<div class="flex-item_1" onclick="roleManagementSection();">
												<ul class="dmenu">
							<li><a href="#s1"><img src="images/role_management_small.PNG"></a>
							<a href="#s1">Role Management</a>
			                    <ul class="dsubmenu">
			                        <li><a href="displayAddRolePage">Add Role</a></li>
			                         <li><a href="displayUpdateRolePage">Update Role</a></li>
			                        <li><a href="displayDeleteRolePage">Delete Role</a></li>
			                    </ul>
                </li>
						</ul>	
						</div>
					</div>
					<div id="datamgmt" class="user_brdr_1">
						<div class="flex-item_1" onclick="dataManagementSection();">
						<ul class="dmenu">
							<li><a href="#s1"><img src="images/data_management_small.PNG"></a>
							<a href="#s1" >Data Management</a>
							</li></ul>
						</div>
					</div>
					<div id="mapmgmt" class="user_brdr_1">
						<div class="flex-item_1" onclick="loadMap();">
						<ul class="dmenu">
							<li><a href="#s1"><img src="images/map_small.PNG"></a>
							<a href="#s1">Map Screen</a>
							</li></ul>
						</div>
					</div>
					<div id="chgpwdmgmt" class="user_brdr_1">
						<div class="flex-item_1" onclick="loadChangePassword();">
						<ul class="dmenu">
							<li><a href="#s1">
							<img src="images/change_password_small.PNG"></a>
							<a href="#s1">Change Password</a>
							</li></ul>
						</div>
					</div>
					<div id="addnotmgmt" class="flex-item_1" onclick="loadNotification();">
					<ul class="dmenu">
							<li><a href="#s1">
						<img src="images/add_notification_small.PNG"></a>
						<a href="#s1">Add Notifications</a>
							</li></ul>
					</div>
				</div>
			</div>
			<div class="col-lg-2 col-md-2 hidden-sm hidden-xs">&nbsp;</div>
		</div>
		<div class="col-lg-2 col-md-1 hidden-sm hidden-xs">&nbsp;</div>




	</div>
	 <s:hidden id="userroleid" value='%{#session.roleId}' />
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
