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

</head>
<body class="bgs_1" style="color: white !important; text-align: center;">

	<h1 style="color: white;">Plot Registration unsuccessful...</h1>
	<h2>Please try again.</h2>
	<h3>Due To:</h3>
	<s:set var="status" value="status" />
	<s:if test="%{#status=='failure'}">
		<div style="text-align: center; color: red; font-size: 14px;">
			<img src="images/error.jpg" width="20px" /> &nbsp;
			<s:text name="Failed to save the data.Please Try Again." />
		</div>
		<br />

	</s:if>

	<s:if test="%{#status=='duplicate'}">
		<div style="text-align: center; color: red; font-size: 14px;">
			<img src="images/error.jpg" width="20px" /> &nbsp;
			<s:text name="Duplicate Email and Mobile Number. Apply with Existing Application Type." />
		</div>
		<br />
	</s:if>
	
	<s:if test="%{#status=='mailingerror'}">
		<div style="text-align: center; color: green; font-size: 14px;">
			<img src="images/Successicon.gif" width="20px" /> &nbsp;
			<s:text
				name="Successfully Saved the Data and Generated Application Id: " />
			<b style="color: purple; font-style: italic; font-size: medium;"><s:property
					value="generatedAppId" /></b>
			<s:text name=".But Falied to sent Mail. Please try again." />
		</div>
		<br />
	</s:if>

</body>
</html>