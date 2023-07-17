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

	function loaddocument() {
		window.open("helpdocument/Document.html");
	}
</script>
</head>
<body class="bgs_1" onload="noback();">
 <%-- <%	session.invalidate();%> --%>
	<!-- Header Section -->
	<div class="fluid-container" style="background: #e0c29c;">
		<div class="container">
			<div style="display: block; float: right;">
				<a href="" title="Help">
					<div
						style="display: block; float: left; font-family: Verdana; font-size: 14px; font-weight: bold; color: #000; padding-left: 5px; margin-right: 5px;"
						onclick="loaddocument();">
						<img alt="cannot load image" src="images/help.png">
					</div>
				</a> <a href="homeMap" title="Home">
					<div
						style="display: block; float: left; font-family: Verdana; font-size: 14px; font-weight: bold; color: #000; margin-right: 5px;">
						<img src="images/home.png">
					</div>
				</a>
			</div>
		</div>
	</div>
	<div class="fluid-container topbg">
		<div class="container">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 txt heads">
				<img src="images/chennai_logo.png" class="img-responsive"
					style="display: block; margin: 0px auto; padding: 25px; 0px;">
			</div>
		</div>
	</div>

	<!-- Body Section -->
	<!-- <img alt="" src="images/404.gif"
		style="display: block; margin: 0px auto;">
		<div class="clickhere">Please <button>Click Here</button> Login again</div> -->
		
		
		<div class="container">
<img src="images/404.gif" alt="404" class="img-responsive" style="margin:0px auto; display:block;">
<div style="text-align:center; color:#FFFFFF;  font-family: 'primeregular'; font-size: 20px;">Please <a href="homePage"><button style="font-family: 'primeregular';">Click Here</button></a> to Login again</div> 
</div>

	<!-- Footer Section -->
	<div class="navbar navbar-default navbar-fixed-bottom">
		<div class="fluid-container footer"
			style="border-top: 1px solid black;">
			<div><p>
				<marquee>
					
					Executed by RAILTEL Enterprises Limited (Powered by <a target="_blank" style="text-decoration: none; color: black;"
						href="http://iictechnologies.com/">IIC Technologies Limited, Hyderabad</a>) Copyright &copy; <script type="text/javascript"> document.write(new Date().getFullYear()); </script> Chennai Port  
				</marquee></p>
			</div>
		</div>
	</div>
</body>
</html>