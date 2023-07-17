<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
<head>
<%-- <title><tiles:getAsString name="title" /></title> --%>

<link rel="icon" href="images/chennai_logo2.png" type="image/png" sizes="16x16" >
<title>Port of Chennai</title>

	<!-- no-cache no-store meta tages to avoid cache -->
 <meta http-equiv="cache-control" content="no-cache">
 <meta http-equiv="cache-control" content="no-store">
 <meta http-equiv="cache-control" content="must-revalidate">
 <meta http-equiv="cache-control" content="max-age=0">
 <meta http-equiv="cache-control" content="pre-check=0,post-check=0">
 <meta http-equiv="expires" content="0">
 <meta http-equiv="pragma" content="no-cache">
 <!-- no-cache no-store meta tages to avoid cache -->
</head>
<body>

	<%-- 	<%@  include file="header.jsp"%>
	<tiles:insertAttribute name="body" />
	<%@ include file="footer.jsp"%> --%>

	 <table border="0" width="100%" >
            <tr>
                <td  colspan="2" >
                    <tiles:insertAttribute name="myHeader" />
                </td>
            </tr>
            <tr>                
              
                <td colspan="2"  >
                    <tiles:insertAttribute name="myBody" />
                </td>
            </tr>
            <tr>
                <td  colspan="2" >
                    <tiles:insertAttribute name="myFooter" />
                </td>
            </tr>
        </table>

<%-- 	<div>
		<div>
			<tiles:insertAttribute name="myHeader" />
		</div>

		<div>
			<tiles:insertAttribute name="myBody" />
		</div>
		<div class="navbar-fixed-bottom">
			<tiles:insertAttribute name="myFooter" />
		</div>

	</div> --%>


</body>
</html>