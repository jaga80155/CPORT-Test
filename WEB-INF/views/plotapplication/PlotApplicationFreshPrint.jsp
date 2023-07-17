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

<title>:: ChennaiPort ::</title>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="css/general.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/responsive.css">
<link rel="stylesheet" type="text/css" href="css/main.css">

<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">

<script type="text/javascript" src="scripts/jquery-1.11.0.min.js"></script>
<script type="text/javascript"
	src="scripts/plots/plotapplicationfresh.js"></script>
	<script type="text/javascript"
	src="scripts/plots/freshplotapp.js"></script>

<style type="text/css">
.vcn {
	width: 115px;
}
TD{font-family: Arial; font-size: 15px;}
</style>
<script>
	function print1(e) {
	window.print();
	}
</script>
<script>
history.pushState(null, null, location.href);
window.onpopstate = function(event) {
    history.go(1);
};
</script>
</head>
<body>
	<br />
	<div class="container" id="plotregistrationprint">
		<center>
			<table cellspacing="5" cellpadding="5" class="widget">
				<tr>
					<th colspan="2"><center>
							<font size="5"><s:property  value="#session.plotRegistrationDeatiles"/></font>
						</center></th>
				</tr><tr>
				<td style="height: 20px" >   </td>
				<td>   </td>
				</tr>
				<tr>
					<td>Request Number : </td>
					<td><s:property value="#session.applicationId" /></td>
				</tr>
				<tr>
					<td>Company Full Name : </td>
					<td><s:property value="#session.name" /></td>
				</tr>
				<tr>
					<td>Address :</td>
					<td><s:property value="#session.address" /></td>
				</tr>
				<tr>
					<td>GSTIN No :</td>
					<td><s:property value="#session.gstin" /></td>
				</tr>
				<tr>
					<td>Landline Number :</td>
					<td><s:property value="#session.phoneNumber" /></td>
				</tr>
				<tr>
					<td>Mobile Number :</td>
					<td><s:property value="#session.mobileNumber" /></td>
				</tr>
				<tr>
					<td>Email Id :</td>
					<td><s:property value="#session.emailId" /></td>
				</tr>
				<tr>
					<td>Interested Plot Id / Building Id :</td>
					<td style="width:300px; text-align:justify; word-break:break-all;"><s:property value="#session.plotId" /></td>
				</tr>
				<tr>
					<td>Required Area (In Sq.meters) :</td>
					<td><s:property value="#session.area" /> </td>
				</tr>
				<tr>
					<td>Purpose Of Requirement :</td>
					<td><s:property value="#session.purpose" /> </td>
				</tr>
				<tr>
					<td>Period Of Allotment In Months :</td>
					<td><s:property value="#session.period" /> </td>
				</tr>
				<tr>
					<td>Uploaded File Name  :</td>
					<td><s:property  value="#session.filename" /> </td>
				</tr>
				<tr>
					<td>Comments :</td>
					<td><s:property value="#session.comments"/></td>
				</tr>				
			</table>
			<br/>
			<table>
				<td>
				<tr>
					<td><center>					
							<input type="button" id="printBut" class="btn btn-danger"
								align="middle" value="print" onclick="print1();"/>
					</center></td>
				</tr>
			</table>
		</center>
	</div>
</body>
</html>