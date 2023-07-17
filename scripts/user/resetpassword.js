function userNameValidate(){
	var uname = document.getElementById("initialusername").value;
	if(uname == ""){
		alert("Please Enter User Name");
		return false;
	}else if(uname.length<5){
		alert("Please Enter Valid User name");
		return false;
	}else if(uname != ""){
		
	}
}

function emailMobileValidate(){
	var emialid = document.getElementById("emailId").value;
	var mobilenumber = document.getElementById("mobileNumber").value;
	
	if (mobilenumber == '') {
		alert( "Please Enter Mobile Number.");
		return false;
	} else if (!$.isNumeric(mobilenumber)) {
		alert("Please Enter valid Mobile Number.");
		return false;
	} else if (!(10 <= mobilenumber.length)) {
		alert("Mobile Number length should be minimum of 10.");
		return false;
	} else {
		var regex = /^[0-9]*$/;
		var status = regex.test(mobilenumber);
		if (status == false) {
			alert("Please Enter valid Mobile Number.");
			return false;
		}
	}
	
	if (emialid == '') {
		alert("Please Enter Email Id.");
		return false;
	} else {
		var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z-])+\.)+([a-zA-Z0-9.]{2,6})+$/;
		var status = regex.test(emialid);
		if (status == false) {
			alert("Please Enter valid Email Id.");
			return false;
		}
	}
	
	if((mobilenumber != '') && (emialid='')){
		
	}
}

function validateNamePassword(){
	var username = document.getElementById("finaluser").value;
	var password = document.getElementById("password").value;
	var confirmPassword = document.getElementById("confirmPassword").value;
	if(username == ""){
		alert("Please Enter User Name");
		return false;
	}else if(username.length<5){
		alert("Please Enter Valid User name");
		return false;
	}

	if(password == "" ){
		alert("please Enter Password");
		return false;
	}
	
	if(confirmPassword==""){
		alert("please Enter confirm Password");
		return false;
	}
	
	
	
}