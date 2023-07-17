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
<script type="text/javascript">
	function noback() {
		window.location.hash = "nbb";
		window.location.hash = "anbb";//again because google chrome don't insert first hash into history
		window.onhashchange = function() {
			window.location.hash = "nbb";
		}
	}
</script>
</head>
<body class="bgs_1" onload="noback();">

	<div style="height: 120px;"></div>

	<div>
		<h2 style="color: white; text-align: center" align="center">Your
			Session has been Expired</h2>
		<h3 style="color: white; text-align: center" align="center">
			<b style="font-size: 20px; color: white;">Please <a
				href="<s:url action="homePage"/>" style="color: red">Click Here</a>
				To Login Again
			</b>
		</h3>
	</div>
</body>
</html>