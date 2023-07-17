var encryptedData;

$(document).ready(function() {
/*	var browserName = detectBrowser();

	$("marquee").hover(function() {
		if (browserName == 'Firefox') {
			$(this).attr('scrollamount', 0);
		} else {
			this.stop();
		}

	}, function() {
		if (browserName == 'Firefox') {
			$(this).attr('scrollamount', 1);
		} else {
			this.start();
		}
	});*/
	
	enableEnterKey();
	
});


function doLogin(){
/*	if($('#name').val()==""){
		alert("Please Enter Username.");
		return false;
	}else if($('#idpassword').val()==""){
		alert("Please Enter Password.");
		return false;
	}else if($('#captchaAnswer').val()==""){
		alert("Please Enter Captcha.");
	}else{*/
		var data = $('#idpassword').val();
		encodedString = btoa(randomString(32,false) + data +randomString(32,false));
		$('#idpassword').val(encodedString);
		document.loginfrm.action = "MenuPage";
		document.loginfrm.submit();
	//}
}

var randomString = function(length, nonAlpha) {
	var text = "";
	var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

	if (nonAlpha) {
		possible += '_+-!@#$%^*()/*`~={}|\][;:,./?';
	}

	for (var i = 0; i < length; i++) {
		text += possible
				.charAt(Math.floor(Math.random() * possible.length));
	}
	return text;
}

function changePwd(){
/*	if($("#chgPassword").val()==""){
		alert("Please Enter Password.");
		return false;
	}else if($("#chgCPassword").val()==""){
		alert("Please Enter Confirm Password.");
		return false;
	} else{*/
		var data = $('#chgPassword').val();
		var data1 = $('#chgCPassword').val();
		encodedString = btoa(randomString(32,false) + data +randomString(32,false));
		$('#chgPassword').val(encodedString);
		encodedString = btoa(randomString(32,false) + data1 +randomString(32,false));
		$('#chgCPassword').val(encodedString);
		document.changepwdfrm.action = "changePassword";
		document.changepwdfrm.submit();
	//}
}

function RegisterUser(){
	
	/*if($("#repassword").val()==""){
		alert("Please Enter Password.");
		return false;
	}else if($("#crepassword").val()==""){
		alert("Please Enter Confirm Password.");
		return false;
	}else{*/
		var data = $('#repassword').val();
		var data1 = $('#crepassword').val();
		encodedString = btoa(randomString(32,false) + data +randomString(32,false));
		$('#repassword').val(encodedString);
		encodedString = btoa(randomString(32,false) + data1 +randomString(32,false));
		$('#crepassword').val(encodedString);
		document.registerfrm.action = "regsiterUser";
		document.registerfrm.submit();
	//}
	
}

/*Captcha Code*/ 
function randomCaptchaString() {
	var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
	var string_length = 6;
	var randomstring = '';
	for (var i=0; i<string_length; i++) {
		var rnum = Math.floor(Math.random() * chars.length);
		randomstring += chars.substring(rnum,rnum+1) + "  ";
		
	}
	document.getElementById("randomfield").value = randomstring;
}

/* Enter key validation */

function enableEnterKey()
{
	$('#loginfrm').keypress(function(event){
		 
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if(keycode == '13'){
			doLogin();
		}
	}); 
}

function resetRegisterPage(){
	window.location.href="resetRegisterPage";
}
function resetChangePassword(){
	window.location.href="resetChangePassword";
}