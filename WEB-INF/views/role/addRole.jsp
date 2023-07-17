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

<script type="text/javascript" src="scripts/role/addRole.js"></script>

<style>
th {
	color: #f0ce8d;
	background: #dbae8c;
	text-shadow: none;
}

td {
	color: #fff;
}

label.checkboxLabel {
	font-family: verdana;
	font-size: 12px;
	font-weight: normal;
}

div#wwctrl_layerslist {
	padding: 9px;
	margin: 1px;
}

input[type="checkbox"] {
	margin: 4px 0 0;
	margin-top: 1px \9;
	line-height: normal;
	position: relative;
	top: 3px;
}

#wwerr_layerslist {
	color: red;
}

.table-bordered {
	border: 1px solid red;
}

.errorMessage
{
 display:none;
} 
</style>

<style>
.tooltip2 {
    position: relative;
    display: inline-block;
   
}

.tooltip2 .tooltiptext2 {
    visibility: hidden;
    width: 220px;
    background-color: #efaa58;
    color: red;
    text-align: center;
    border-radius: 6px;
    padding: 5px 0;
    position: absolute;
    z-index: 1;
    bottom: 150%;
    left: 50%;
    margin-left: -60px;
}

.tooltip2 .tooltiptext2::after {
    content: "";
    position: absolute;
    top: 100%;
    left: 50%;
    margin-left: -5px;
    border-width: 5px;
    border-style: solid;
    border-color: #efaa58 transparent transparent transparent;
}

.tooltip2:hover .tooltiptext2 {
    visibility: visible;
}

.cssErrorStyl{
border: 1px solid red;
} 
</style>


<script type="text/javascript">
	$(document).ready(function() {
		$('#wwctrl_layerslist').children('label').each(function() {
			$(this).after("<br>");
		});
		
		      var roleName = "<s:property value="fieldErrors.get('roleName').get(0)"/>";
              var roledesc = "<s:property value="fieldErrors.get('roledesc').get(0)"/>";
               var layerslist = "<s:property value="fieldErrors.get('layerslist').get(0)"/>";
               
               if(roleName != "")
	                 {
	                    document.getElementById('roleName').style.border = "1px solid red";
	                    $('#roleNamediv').addClass('tooltip2');
	                    document.getElementById('roleNamespan').innerHTML = roleName;
	                    
	                 }
 		       else if(roledesc != "")
	 		       {
	 		       	    document.getElementById('roledesc').style.border = "1px solid red";
	 		            $('#roledescdiv').addClass('tooltip2');
	                    document.getElementById('roledescspan').innerHTML = roledesc;
	 		       }
 		     
               else if(layerslist != "")
	               {
	              	 document.getElementById("checklistdiv").style.border="1px solid red";
	              	 $('#checklistdiv2').addClass('tooltip2');
	                 document.getElementById('checklistspan').innerHTML = layerslist;
	               }
	               
	               
	});
	function checkAll() {
		$("input[type=checkbox]").each(function() { //loop through each checkbox
			this.checked = true; //select all checkboxes with class "checkbox1"               
		});
	}

	function UncheckAll() {

		$("input[type=checkbox]").each(function() { //loop through each checkbox
			this.checked = false; //select all checkboxes with class "checkbox1"               
		});

	}
	function resetAddRolePage(){
		window.location.href="resetAddRolePage";
	}
</script>

</head>
<body class="bgs_1">

	<div class="clearfix"></div>
	<!---container-start--->
	<div class="container">
 
		<div class="col-lg-2 col-md-1 hidden-sm hidden-xs">&nbsp;</div>
		<div class="col-lg-8 col-md-10 col-sm-12 col-xs-12">

			<div class="row">
				<div class="col-lg-1 col-md-1 col-sm-1 hidden-xs">&nbsp;</div>
				<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
					<div class="forums">
						<h1>
							Add Role<img src="images/small_arrow.png">
						</h1>
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">&nbsp;</div>
			</div>


			<s:form class="form-horizontal" action="addRole" method="post">
				<div class="row">
					<div class="col-lg-1 col-md-1 col-sm-hidden col-xs-hidden"></div>
					<div class="col-lg-7 col-md-7 col-sm-7 col-xs-12">
						<div class="gaps">&nbsp;</div>
						<div class="forums">

							<div class="form-group">
								<label for="inputEmail3" class="col-sm-5 control-label">Role
									Name: </label>
								<div class="col-sm-6" id="roleNamediv">
								   <span class="tooltiptext2" id="roleNamespan"></span>			
									<s:textfield id="roleName" name="roleName"
										cssClass="form-control">	
																
										</s:textfield> 
								</div>
							</div>
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-5 control-label">Role
									Description: </label>
								<div class="col-sm-6" id="roledescdiv">
								  <span class="tooltiptext2" id="roledescspan"></span>		
									<s:textfield id="roledesc" name="roledesc"
										cssClass="form-control" > </s:textfield>
								</div>
							</div>
							

							<s:set var="status" value="status" />
							<s:if test="%{#status=='exists'}">
								<div style="text-align: center; color: red; font-size: 14px;">
									<img src="images/error.jpg" width="20px" /> &nbsp;
									<s:text name="Rolename already Exists. " />
								</div>
								<br />
							</s:if>
							<s:if test="%{#status=='failure'}">
								<div style="text-align: center; color: red; font-size: 14px;">
									<img src="images/error.jpg" width="20px" /> &nbsp;
									<s:text name="Failed to add new role." />
								</div>
								<br />
							</s:if>
							<s:if test="%{#status=='success'}">
								<div style="text-align: center; color: green; font-size: 14px;">
									<img src="images/Successicon.gif" width="20px" /> &nbsp;
									<s:text name="Successfully added new role." />
								</div>
								<br />
							</s:if>

<div class="row">
<div class="col-md-5 col-sm-5"></div>
<div class="col-md-5 col-sm-5">
<button type="submit" class="btn buts">Add</button>
									<button type="button" class="btn buts" onclick="resetAddRolePage()">Reset</button>
		</div>
<div class="col-md-2 col-sm-3"></div>
</div>


							<!-- adding layers (assets)-->

							<div class="gaps">&nbsp;</div>

						</div>
						<div class="table-responsive">
							<table class="table table-bordered" id="myTable">
								<thead>
									<tr>
										<th
											style="font-family: 'primeregular'; border: 1px solid #c19878; letter-spacing: 1px; color: #000; background: #dbae8c;">Role
											Id</th>
										<th
											style="font-family: 'primeregular'; border: 1px solid #c19878; letter-spacing: 1px; color: #000; background: #dbae8c;">Role
											Name</th>
										<th
											style="font-family: 'primeregular'; border: 1px solid #c19878; letter-spacing: 1px; color: #000; background: #dbae8c;">Role
											Description</th>
									</tr>
								</thead>
								<tbody>
									<s:iterator value="roleList">
										<tr>
											<td style="border: 1px solid #c19878;font-family:'verdana';font-size:12px;"><s:property
													value="roleId" /></td>
											<td style="border: 1px solid #c19878;font-family:'verdana';font-size:12px;"><s:property
													value="roleName" /></td>
											<td style="border: 1px solid #c19878;font-family:'verdana';font-size:12px;"><s:property
													value="roleDescription" /></td>
										</tr>
									</s:iterator>
								</tbody>
							</table>
						</div>


					</div>
					<div class="col-lg-4 col-md-4 col-sm-4 col-xs-hidden" id="checklistdiv2">

						<h2
							style="text-align: left; font-family: 'primeregular'; letter-spacing: 1px; font-size: 15px; color: #dbae8c;">
							<s:text name="Layers" />  	
						</h2>


						<div class="checkbox_role" id="checklistdiv" style="overflow: auto; border: 1px solid #c19878; width: 300px; height: 272px; scrollbar-track-color: #c19878;">
							
							 
							<s:checkboxlist list="layerList" name="layerslist"
								cssClass="lbl_checkbox" id="layerslist" cssStyle="font-family:'verdana';font-size:12px;"/>
							<!-- list="layerList" -->
						</div>
						<br />
						<div align="center">
							<input type="button" name="Check_All" value="Check All"
								onclick="checkAll()" class="btn buts"> &nbsp;&nbsp; <input
								type="button" name="UnCheck_All" value="Uncheck All"
								onclick="UncheckAll()" class="btn buts">
<span class="tooltiptext2" id="checklistspan" style="bottom:93%; left:60%;"></span>	
						</div>
						<br/><br/>
					</div>
				</div>
				<s:token/>
			</s:form>
<!-- 			<div style="height: 116px;"></div> -->

		</div>
		<div class="col-lg-2 col-md-1 hidden-sm hidden-xs">&nbsp;</div>
	</div>
	<!--end-container-div--->

	<!---container-end--->

	<div class="clearfix"></div>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="scripts/jquery-1.11.0.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="scripts/bootstrap.min.js"></script>
	<script>
		$('.carousel').carousel({
			interval : 3000
		//changes the speed
		})
	</script>
</body>
</html>
