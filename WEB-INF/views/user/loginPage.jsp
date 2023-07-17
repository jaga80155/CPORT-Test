<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
<link rel="icon" href="images/chennai_logo2.png" type="image/png"
	sizes="16x16">
<title>Port of Chennai</title>

<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/general.css" rel="stylesheet">
<link href="css/chennai_resonsive.css" rel="stylesheet">
<script src="scripts/jquery-1.11.1.min.js"></script>
<script src="scripts/user/loginPage.js" type="text/javascript"></script>
<script src="scripts/base64.js" type="text/javascript"></script>
<script type="text/javascript">
	function resetCaptcha() {

		document.getElementById('imgCaptcha').src = '<c:url value='simple-captcha.png' />';
	}

	function noback() {
		window.location.hash = "nbb";
		window.location.hash = "anbb";//again because google chrome don't insert first hash into history
		window.onhashchange = function() {
			window.location.hash = "nbb";
		}
		randomCaptchaString();

	}

	/*  this is to detech the browser and set it accordingly */
	function detectBrowser() {
		var N = navigator.appName;
		var UA = navigator.userAgent;
		var temp;
		var browserVersion = UA
				.match(/(opera|chrome|safari|firefox|msie)\/?\s*(\.?\d+(\.\d+)*)/i);
		if (browserVersion && (temp = UA.match(/version\/([\.\d]+)/i)) != null)
			browserVersion[2] = temp[1];
		browserVersion = browserVersion ? [ browserVersion[1],
				browserVersion[2] ] : [ N, navigator.appVersion, '-?' ];

		return browserVersion[0];
	};
</script>

<style>
.forums_1 {
	color: #000;
}

#wwerr_idpassword {
	color: red;
}

#wwerr_name {
	color: red;
}

#wwerr_MenuPage_pwd {
	color: red;
}

#wwerr_captchaAnswer {
	color: red;
}

.errorMessage
{
 display:none;
} 
</style>

<style>
.tooltip2 {
    position: relative;
  /*   display: inline-block; */
   
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
</style>

<script type="text/javascript">
	$(document).ready(function() {
		
		      var name = "<s:property value="fieldErrors.get('name').get(0)"/>";
              var pwd = "<s:property value="fieldErrors.get('pwd').get(0)"/>";
               var captchaAnswer = "<s:property value="fieldErrors.get('captchaAnswer').get(0)"/>";
               
               if(name != "")
	                 {
	                    document.getElementById("name").style.border="1px solid red";
	                    $('#namediv').addClass('tooltip2');
	                    document.getElementById('namespan').innerHTML = name;
	                    
	                 }
 		       else if(pwd != "")
	 		       {
	 		           document.getElementById("idpassword").style.border="1px solid red";
	 		           $('#pwddiv').addClass('tooltip2');
	                    document.getElementById('idpasswordspan').innerHTML = pwd;
	 		       } 
	 		       else if(captchaAnswer != ""){
	 		            document.getElementById("captchaAnswer").style.border="1px solid red";
	 		           $('#captchaAnswerdiv').addClass('tooltip2');
	                   document.getElementById('captchaAnswerspan').innerHTML = captchaAnswer;
	 		       
	 		       }
 		     
	});

</script>

</head>
<body class="bgs_1" onload="noback();">

	<div class="clearfix"></div>

	<div class="container">
		<div class="col-md-12 gap">&nbsp;</div>
		<!-- <div class="col-md-12 middle_head">
			<h1>Welcome to Chennai Port</h1>
		</div> -->
		<div class="col-lg-2 col-md-2 hidden-sm hidden-xs">&nbsp;</div>
		<div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
			<div class="brdr">


				<div class="loginbox">
					<h1>Log In</h1>
				<br/>
					<div class="form-group">

						<s:form action="MenuPage" method="post" autocomplete='off'
							name="loginfrm" id="loginfrm">
							<div id="namediv">
							 <span class="tooltiptext2" id="namespan"></span>	
							<s:textfield name="name" cssClass="form-control" id="name"
								placeholder="Username" /></div>
								<div id="pwddiv"> <span class="tooltiptext2" id="idpasswordspan"></span>	
							<s:password name="pwd" showPassword="true"
								cssClass="form-control" placeholder="Password" id="idpassword"></s:password></div>
							<div id="captchaAnswerdiv"> <span class="tooltiptext2" id="captchaAnswerspan"></span>	
							<s:textfield name="captchaAnswer" cssClass="form-control"
								id="captchaAnswer" placeholder="Enter Below Captcha" /></div>

							<div style="display: inline;" onmousedown="return false" >
								<input type="text" class="col_img" id="randomfield"
									name="captchaCode" value=""
									style="background-image: url(images/cap3.jpg); color: black; text-align: center; border: none; font-size: 14px; font-weight: bold; height: 34px; padding-top: 0px; width: 215px;"
									readonly tabindex="-1" /> <img src="images/Capture.png" border="0"
									class="capture_res" id="btnrefresh"
									onclick="randomCaptchaString();" style="cursor: pointer;"
									title="Refresh Capcha">

							</div>

							<s:set var="status" value="status" />

							<s:if test="%{#status=='problem'}">
								<div style="text-align: center; color: red; font-size: 14px;">
									<img src="images/cross.jpg" width="20px" /> &nbsp;
									<s:text name="Login Failed, Please try later." />
								</div>
								<br />
							</s:if>

							<s:if test="%{#status=='failure'}">
								<div style="text-align: center; color: red; font-size: 14px;">
									<img src="images/cross.jpg" width="20px" /> &nbsp;
									<s:text name="Login Failed, Please try later." />
								</div>
								<br />
							</s:if>

							<s:if test="%{#status=='inactive'}">
								<div style="text-align: center; color: red; font-size: 14px;">
									<img src="images/cross.jpg" width="20px" /> &nbsp;
									<s:text
										name="Current user is inactive, Please register as new User." />
								</div>
								<br />
							</s:if>

							<s:if test="%{#status=='locked'}">
								<div style="text-align: center; color: red; font-size: 14px;">
									<img src="images/cross.jpg" width="20px" /> &nbsp;
									<s:text
										name="Login Locked for present user, Please try after 30 minutes." />
								</div>
								<br />
							</s:if>

							<s:if test="%{#status=='invalid'}">
								<div style="text-align: center; color: red; font-size: 14px;">
									<img src="images/cross.jpg" width="20px" /> &nbsp;
									<s:text name="Invalid Username or Password." />
								</div>
								<br />
							</s:if>

							<button type="button" onclick="doLogin();" class="btn buts">LogIn</button> <a href="resetPasswordPage" class="resetAnchor">Reset Password</a>
							<s:token />
						</s:form>

					</div>
				</div>

				<div class="choose">&nbsp;</div>
			</div>

		</div>
		<div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 brdr_1 yellow_txt"
			style="height: 327px;">
			<h1>Notifications</h1>
			<marquee behavior="scroll" direction="up" scrollamount="1"
				onmouseover="this.stop();" onmouseout="this.start();"
				style="position: relative; left: 18px; height: 230px;">

				<s:iterator value="notificationsList">

					<p>
						<img src="images/small_arrow.png">
						<s:property />
					</p>

				</s:iterator>

			</marquee>

		</div>

		<div class="col-lg-2 col-md-2 hidden-sm hidden-xs">&nbsp;</div>

	</div>
</body>
</html>