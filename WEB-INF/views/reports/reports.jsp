<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
<title></title>
<meta name="robots" content="noindex">

<link href="css/bootstrap.css" rel="stylesheet" />
<link href="css/general.css" rel="stylesheet" />

<script type='text/javascript' src='scripts/reports/jquery-2.1.4.js'></script>
<script type="text/javascript" src="scripts/reports/report.js"></script>
<!-- <link rel="stylesheet" type="text/css" href="css/reports/jquery-ui.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="css/reports/result-light.css"> -->


<link rel="stylesheet" href="css/jquery.mobile-1.4.5.min.css">
<script src="scripts/map/jquery.mobile-1.4.5.min.js"></script>


</head>
<body>
	<input type="hidden" name="webserviceurl" id="webserviceurl"
		value="${webserviceurl}">
	<script src="scripts/reports/highcharts.js" type="text/javascript"></script>
	<script src="scripts/reports/highcharts-3d.js" type="text/javascript"></script>
	<script src="scripts/reports/exporting.js" type="text/javascript"></script>
	<script src="scripts/reports/grid-light.js"></script>
	<div id="widget-container" style="height: 100%; width: 100%;"></div>
</body>
</html>