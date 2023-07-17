$(document).ready(function() { //alert("hi.");
		$('#userId').change(function(event) { 
			var userId = $("#userId").val();
			
			$.getJSON('getJsonUpdateUser', {
				userId : userId
			}, function(jsonResponse) {
			     
				$('#firstName').val(jsonResponse.firstName);
				$('#lastName').val(jsonResponse.lastName);
				$('#emailId').val(jsonResponse.emailId);
				$('#phone').val(jsonResponse.phone);
				$('#roleId').val(jsonResponse.roleId);
			});
		});
	});