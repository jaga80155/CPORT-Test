<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<br />
<br />
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
<STYLE type="text/css">
.errorMessage {
	color: red;
}
</STYLE>
</head>
<body>

	<h2 style="text-align: center;" class="text-info">
		<s:text name="Authentication Failed" />
	</h2>

	<br />
	<br />
	<br />
	<div class="col-md-3 india-map" style="border: 0px">&nbsp;</div>
	<div class="col-md-6" style="text-align: center;" class="text-info">
		<h2 style="color: black; text-align: center" align="center">You
			are not authorized to access this page</h2>
		<b style="font-size: 20px; color: black">Please <a
			href="<s:url action="homePage"/>" style="color: red">Click Here</a>
			To Login with proper credentials
		</b>
	</div>
</body>
</html>