var plotregstatus = "off";
var fSelectStatus = "off";
var filename;
function submitform() {
	$("#freshPlotForm .txt")
			.each(function(index, data) {
						var attrName = $(this).attr('name');
						
						if (attrName == 'name') {
							var getname = $(this).val();
							if ($(this).val() == "") {								
								alert("Please Enter Full Name.");
								return false;
							}					
						}
						else if (attrName == 'address') {
							if ($(this).val() == '') {						
								alert("Please Enter Address.");
								return false;
							} else {
								var attValue = $(this).val();
								var regex = /^[ A-Za-z0-9.,:;&#()-_\n]*$/;
								var status = regex.test(attValue);
								if (status == false) {
									alert("Please Enter valid Address.");
									return false;
								}
							}
						}
						else if (attrName == 'gstin') {
							var attValue = $(this).val();
							if ($(this).val() == '') {
								alert("Please Enter GST Identification Number.");
								return false;
							} else {
								var regex = /^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$/;
								var status = regex.test(attValue);
								if (status == false) {
									alert("Please Enter valid GST Identification Number");
									return false;
								}
							}
						}
						else if (attrName == 'phoneNumber') {
							var attValue = $(this).val();
							if ($(this).val() == '') {
								alert("Please Enter Landline Number.");
								return false;
							} else if (!$.isNumeric(attValue)) {
								alert("Please Enter valid Landline Number.");
								return false;
							} else {
								var regex = /^[0-9]*$/;
								var status = regex.test(attValue);
								if (status == false) {
									alert("Please Enter valid Landline Number");
									return false;
								}
							}
						}
						else if (attrName == 'mobileNumber') {
							var attValue = $(this).val();
							if ($(this).val() == '') {
								alert("Please Enter Mobile Number.");
								return false;
							} else if (!$.isNumeric(attValue)) {
								alert("Please Enter valid Mobile Number.");
								return false;
							} else {
								var regex = /^[0-9]*$/;
								var status = regex.test(attValue);
								if (status == false) {
									alert("Please Enter valid Mobile Number.");
									return false;
								}
							}
						}
						else if (attrName == 'emailId') {
							var attValue = $(this).val();

							if ($(this).val() != '') {
								var regex =	/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
								var status = regex.test(attValue);
								if (status == false) {
									alert("Please Enter valid Email Id.");
								   return false;
								}
							} else {
								alert("Please Enter Email Id.");
								return false;
							}
						}
						else if (attrName == 'plotId') {
							var attValue = $(this).val();
							if ($(this).val() == '') {
								alert("Please Enter Interested Plot Id.");
								return false;
							} else {
								var regex = /^[A-Za-z0-9,_-]*$/;
								var status = regex.test(attValue);
								if (status == false) {
									alert("Please Enter valid Interested Plot Id.");
									return false;
								}
							}
						}
						else if (attrName == 'area') {
							var attValue = $(this).val();
							if ($(this).val() == '') {
								alert("Please Enter Area.");
								return false;
							} else {
								var regex = /^[0-9.]*$/;
								var status = regex.test(attValue);
								if (status == false) {
									alert("Area should be Numeric.");
									return false;
								}
							}
						}
						else if (attrName == 'purpose') {
							if ($(this).val() == '') {
								alert("Please Enter Purpose Of Requirement.");
								return false;
							} else {
								var attValue = $(this).val();
								var regex = /^[ A-Za-z0-9.,:;&#()-_\n]*$/;
								var status = regex.test(attValue);
								if (status == false) {
									alert("Please Enter Valid Purpose Of Requirement.");
									return false;
								}
							}
						} else if (attrName == 'period') {
							var attValue = $(this).val();
							if ($(this).val() == '') {
								alert("Please Enter Period Of Allotment In Months.");
								return false;
							} else {
								var regex = /^[0-9]*$/; // to allow only numbers
								var status = regex.test(attValue);
								if (status == false) {
									alert("Please Enter Valid Period Of Allotment In Months.");
									return false;
								}
							}
						}
						else if (attrName == 'file') {
							var attValue = $(this).val();
							if ($(this).val() == '') {
								alert("Please select a file");
								return false;
							} else {
								var regex = /([a-zA-Z0-9\s_\\.\-:])+(.txt|.xls|.pdf|.doc|.docx|.xlsx|.odt|.png|.jpg|.jpeg|.PNG|.JPG|.JPEG)$/; // to allow only numbers
								var status = regex.test(attValue);
								if (status == false) {
									alert("Please select a valid file.");
									return false;
								}
							}
						}
						else if (attrName == 'comments') {
							if ($(this).val() == '') {
								alert("Please Enter Comments.");
								return false;
							}
							else {
								if (apptypevalue == "existing") {
									document.getElementById("loadingimg").style.display = "";
									document.getElementById('faileddiv3').style.display = 'none';
									document.getElementById('duplicatediv3').style.display = 'none';
									document.getElementById('successdiv3').style.display = 'none';
									document.getElementById('mailfaileddiv3').style.display = 'none';
									document.getElementById('invalidappiddiv3').style.display = 'none';

									var fdata = new FormData();

									var filedata = $('#file')[0].files[0];
									
									fdata.append('name', $('#name').val());									 
									fdata.append('address', $('#address').val());									
									fdata.append('gstin', $('#gstin').val());									
									fdata.append('phoneNumber',$('#phoneNumber').val());									 
									fdata.append('mobileNumber', $('#mobileNumber').val());									
									fdata.append('emailId', $('#emailId').val());
									fdata.append('plotId', $('#plotId').val());									 
									fdata.append('area', $('#area').val());
									fdata.append('purpose', $('#purpose').val());
									fdata.append('period', $('#period').val());
									fdata.append('comments', $('#comments').val());
									fdata.append('file', filedata);                               
									
											$.ajax({
												url : "exisfrontmapplotregistrationfresh2",
												data : fdata,
												cache : false,
												contentType : false,
												processData : false,
												type : 'POST',
												success : function(data) {

													if (data.status == "invalidappid") {
														document.getElementById('faileddiv3').style.display = 'none';
														document.getElementById('duplicatediv3').style.display = 'none';
														document.getElementById('successdiv3').style.display = 'none';
														document.getElementById('mailfaileddiv3').style.display = 'none';
														document.getElementById('invalidappiddiv3').style.display = 'block';
														document.getElementById("loadingimg").style.display = "none";
													} else if (data.status == "failure") {
														document.getElementById('faileddiv3').style.display = 'block';
														document.getElementById('duplicatediv3').style.display = 'none';
														document.getElementById('successdiv3').style.display = 'none';
														document.getElementById('mailfaileddiv3').style.display = 'none';
														document.getElementById('invalidappiddiv3').style.display = 'none';
														document.getElementById("loadingimg").style.display = "none";
													} else if (data.status == "mailingerror") {
														document.getElementById('faileddiv3').style.display = 'none';
														document.getElementById('duplicatediv3').style.display = 'none';
														document.getElementById('successdiv3').style.display = 'none';
														document.getElementById('mailfaileddiv3').style.display = 'block';
														document.getElementById('invalidappiddiv3').style.display = 'none';
														document.getElementById("loadingimg").style.display = "none";
													} else if (data.status == "success") {
														document.getElementById('faileddiv3').style.display = 'none';
														document.getElementById('duplicatediv3').style.display = 'none';
														document.getElementById('successdiv3').style.display = 'block';
														document.getElementById('mailfaileddiv3').style.display = 'none';
														document.getElementById('invalidappiddiv3').style.display = 'none';
														document.getElementById("loadingimg").style.display = "none";
														var confi = confirm("APPLICATION SHALL BE PROCESSED BY CHENNAI PORT TRUST");
														if (confi) {
															document.tablesubmit.target = "_blank";
															var gst = document.getElementById("guestId").value;
															if (gst == 'loginuser'){
																document.tablesubmit.action = "frontmapplotregistrationfresh3";
																document.getElementById("myModalPlotRegistration").style.display = 'none';
															}
															document.tablesubmit.submit();															
														}
														else {
															document.getElementById('faileddiv3').style.display = 'block';
															document.getElementById('duplicatediv3').style.display = 'none';
															document.getElementById('successdiv3').style.display = 'none';
															document.getElementById('mailfaileddiv3').style.display = 'none';
															document.getElementById('invalidappiddiv3').style.display = 'none';
															document.getElementById("loadingimg").style.display = "none";
														}
													}
												},
												error : function(data) {
													alert("in error: " + data);
												}
											});
										}							
								else{
									document.getElementById("loadingimg").style.display = "";
									document.getElementById('faileddiv3').style.display = 'none';
									document.getElementById('duplicatediv3').style.display = 'none';
									document.getElementById('successdiv3').style.display = 'none';
									document.getElementById('mailfaileddiv3').style.display = 'none';
									document.getElementById('invalidappiddiv3').style.display = 'none';

									var fdata = new FormData();

									var filedata = $('#file')[0].files[0];
									
									fdata.append('name', $('#name').val());
									fdata.append('address', $('#address').val());
									fdata.append('gstin', $('#gstin').val());
									fdata.append('phoneNumber',$('#phoneNumber').val());
									fdata.append('mobileNumber', $('#mobileNumber').val());
									fdata.append('emailId', $('#emailId').val());
									fdata.append('plotId', $('#plotId').val());
									fdata.append('area', $('#area').val());
									fdata.append('purpose', $('#purpose').val());
									fdata.append('period', $('#period').val());
									fdata.append('comments', $('#comments').val());
									fdata.append('file', filedata);
									
									jQuery.ajax({
												url : "frontmapplotregistrationfresh2",
												data : fdata,
												cache : false,
												contentType : false,
												processData : false,
												type : 'POST',
												success : function(data) {													
													if(data.status == "duplicate")
														{
														document.getElementById('faileddiv3').style.display = 'none';
														document.getElementById('duplicatediv3').style.display = 'block';
														document.getElementById('successdiv3').style.display = 'none';
														document.getElementById('mailfaileddiv3').style.display = 'none';														
														document.getElementById("loadingimg").style.display = "none";
														}
													else if(data.status == "failure")
														{
														document.getElementById('faileddiv3').style.display = 'block';
														document.getElementById('duplicatediv3').style.display = 'none';
														document.getElementById('successdiv3').style.display = 'none';
														document.getElementById('mailfaileddiv3').style.display = 'none';														
														document.getElementById("loadingimg").style.display = "none";
														}
													else if(data.status == "mailingerror")
														{
														document.getElementById('faileddiv3').style.display = 'none';
														document.getElementById('duplicatediv3').style.display = 'none';
														document.getElementById('successdiv3').style.display = 'none';
														document.getElementById('mailfaileddiv3').style.display = 'block';														
														document.getElementById("loadingimg").style.display = "none";
														}
													else if(data.status == "success")
														{
														document.getElementById('faileddiv3').style.display = 'none';
														document.getElementById('duplicatediv3').style.display = 'none';
														document.getElementById('successdiv3').style.display = 'block';
														document.getElementById('mailfaileddiv3').style.display = 'none';														
														document.getElementById("loadingimg").style.display = "none";

														var confi = confirm("APPLICATION SHALL BE PROCESSED BY CHENNAI PORT TRUST");
														if (confi) {
															document.tablesubmit.target = "_blank";
															var gst = document.getElementById("guestId").value;
															if (gst == 'guest') {
																document.tablesubmit.action = "frontmapplotregistrationfresh3";
																document.getElementById("myModal").style.display = 'none';
															} else {
																document.tablesubmit.action = "frontmapplotregistrationfresh3";
																document.getElementById("myModalPlotRegistration").style.display = 'none';																
															}
															document.tablesubmit.submit();															
														}
													else
														{
														document.getElementById('faileddiv3').style.display = 'block';
														document.getElementById('duplicatediv3').style.display = 'none';
														document.getElementById('successdiv3').style.display = 'none';
														document.getElementById('mailfaileddiv3').style.display = 'none';														
														document.getElementById("loadingimg").style.display = "none";
														}													
												}},
												error : function(data) {
													alert("in error: "+data);
												}
											});
								}
							}
						}
					});
	plotregOFF();
}

function plotregON() {

	closebasemapgallery();
	document.getElementById("myModal").style.display = 'block';
	document.getElementById('faileddiv3').style.display = 'none';
	document.getElementById('duplicatediv3').style.display = 'none';
	document.getElementById('successdiv3').style.display = 'none';
	document.getElementById('mailfaileddiv3').style.display = 'none';
	document.getElementById('invalidappiddiv3').style.display = 'none';
	if (plotregstatus == "on") {
		if (fSelectStatus == "on") {
			document.getElementById("myModal").style.display = "block";
			document.getElementById("plotId").value = selectedPlotIds.toString();
		} else {
			plotregOFF();
		}
	} else {
		reset();
		closepopup();
		closebasemapgallery();
		plotregstatus = "on";
		plotRegistration();
		document.getElementById("plotId").value = "";
	}
}

function plotregOFF() {
	selectedPlotIds = [];
	plotregstatus = "off";
	fSelectStatus = "off";
	frontmap.removeInteraction(selectSingleClick);
	frontmap.removeLayer(AGvector);
	AGvector = undefined;
	frontmap.removeLayer(FBVector);
	FBVector = undefined;
	document.getElementById("fselect").src = "images/map/white_select.png";
}