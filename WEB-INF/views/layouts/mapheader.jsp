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
<link rel="icon" href="images/chennai_logo2.png" type="image/png" sizes="16x16" >
<title>Port of Chennai</title>

<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/general.css" rel="stylesheet">

<script type="text/javascript">
	function logout() {
		window.location.hash = "no-back-button";
		window.location.hash = "Again-No-back-button";//again because google chrome don't insert first hash into history
		window.onhashchange = function() {
			window.location.hash = "no-back-button";
		}
		window.location = "logout";
	}
	
	function homeLink(){
		window.location = "mapAction";
	}
</script>
</head>
<body>
	<div class="fluid-container topbg">
		<div class="container">
			<div class="col-lg-2 col-md-2 col-sm-2 col-xs-6 leftside heads">
				<img src="images/logo.PNG" class="img-responsive">
			</div>
			<div class="col-lg-2 col-md-2 col-sm-2 col-xs-6 rightside heads">
				<img src="images/iiclogo.png" class="img-responsive">
			</div>
			<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12 txt heads">
				<h1>
					Port of Chennai <br> <span>ISO 9001:2008 & ISPS
						Compliant</span>
				</h1>
			</div>


			<div style="margin-bottom: 5px;">
				<!-- class="container"  -->
				<a href="#" title="Home">
					<div class="col-md-6 col-sm-6 col-xs-12" onclick="homeLink();"
						style="display: block; font-family: Verdana; font-size: 14px; font-weight: bold; color: #000;">
						<!-- <img src="images/home.png" style="margin-left: 185px;"> -->
						Home
					</div>
				</a>
				
				<div class="col-md-2 col-sm-2 col-xs-12"></div>

			</div>
			<a href="#" title="Logout">
				<div
					style="display: block; float: right; font-family: Verdana; font-size: 14px; font-weight: bold; color: #000;"
					onclick="logout();">
					Logout <img src="images/logout.png" />
				</div>
			</a>

			<div
				style="display: block; float: right; font-family: Verdana; line-height: 20px; padding-right: 10px; font-size: 12px; font-weight: normal; color: #000;">
				Welcome 
				<s:property value="#session['loginname']" />
				&nbsp;&nbsp;
			</div>



		</div>

	</div>
	<div class="clearfix"></div>
</body>
</html>