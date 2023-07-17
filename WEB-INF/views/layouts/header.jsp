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
		window.location.hash = "nb";
		window.location.hash = "Again-No-back-button";//again because google chrome don't insert first hash into history
		window.onhashchange = function() {
			window.location.hash = "nb";
		}
		window.location = "logout";
	}
	function homeLink() {
		window.location = "homePageLink";
	}
	function loaddocument() {
		/* window.open("helpdocument/Document.html"); */
		window.open("Chennai_Port_User_Manual.htm");
	}
</script>
</head>
<body>
	<div class="fluid-container" style="background: #e0c29c;">
		<div class="container">
			<div style="display: block; float: right;">
				<div
					style="display: block; float: left; font-family: Verdana; line-height: 28px; font-size: 12px; font-weight: normal; color: #000;">
					Welcome
					<s:property value="#session['loginname']" />
					&nbsp;&nbsp;
				</div>
				
				<a href="#" >
					<div style="display: block; float: left; font-family: Verdana; font-size: 14px; font-weight: bold; color: #000; padding-left: 5px; margin-right: 5px;"
						onclick="homeLink();">
						<img alt="cannot load image" src="images/home.png" title="Home">
					</div>
				</a> 
				
				<a href="Data/Chennai-Port.apk" target="_blank"
							download="Chennai-Port.apk">
							<div style="display: block; float: left; font-family: Verdana; font-size: 14px; font-weight: bold; color: #000; padding-right: 5px;">
								<img alt="Download Android Mobile Application"
									src="images/android_icon.png" title="Download Android Mobile Application">
							</div>
				</a>
				
				<a href="#" >
					<div style="display: block; float: left; font-family: Verdana; font-size: 14px; font-weight: bold; color: #000; margin-right: 5px;"
						onclick="logout();">
						<img src="images/logout.png" title="Logout"/>
					</div>
				</a>
						<div style="display: block; float: left; font-family: Verdana; font-size: 14px; font-weight: bold; color: #000;margin-right:5px;" >
					<a href="http://chennaiport.gov.in/ScaleOfRates.html" target="_blank"><img alt="cannot load image" src="images/sfrates.png" width="28px" height="28px" style="display:block; float:right;" title="Scale of Rates">
			</a>	</div>
				<a href="#" >
					<div style="display: block; float: left; font-family: Verdana; font-size: 14px; font-weight: bold; color: #000;"
						onclick="loaddocument();">
						<img alt="cannot load image" src="images/help.png" title="Help">
					</div>
				</a> 

			</div>
		</div>
		
	</div>

	<div class="fluid-container topbg">

		<div class="container">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 txt heads">

				<img src="images/chennai_logo.png" class="img-responsive"
					style="display: block; margin: 0px auto; padding: 16px; 0px;">

			</div>

		</div>

	</div>

	</div>
	<div class="clearfix"></div>
</body>
</html>