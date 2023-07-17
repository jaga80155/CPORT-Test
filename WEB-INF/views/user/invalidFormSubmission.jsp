<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
<link rel="icon" href="images/chennai_logo2.png" type="image/png" sizes="16x16" >
<title>Port of Chennai</title>

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

	 <%	session.invalidate(); %>

	<!-- Body Section -->
	
	<div class="container">
<img src="images/406.gif" alt="406" class="img-responsive" style="margin:0px auto; display:block;">
<div style="text-align:center; color:#FFFFFF;  font-family: 'primeregular'; font-size: 20px;">Please <a href="homePage"><button style="font-family: 'primeregular';">Click Here</button></a> to Login again</div> 
</div>
	<!-- <img alt="" src="images/Authentication Failed.jpg"
		style="display: block; margin: 0px auto;"> -->
 <div style="height:50px"></div>
	
</body>
</html>