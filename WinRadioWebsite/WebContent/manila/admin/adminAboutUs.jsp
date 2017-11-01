<!-- Prevent Access to the page without logging in -->
<%@page import="com.win.radio.manila.utilities.SocialMediaCommands"%>
<%@page import="com.win.radio.manila.utilities.CodeUtil"%>
<%@page import="com.win.radio.manila.utilities.ConnectionUtil"%>
<%@page import="com.win.radio.manila.utilities.CompanyDescriptionCommands"%>
<%
	try{
		String userName = (String) session.getAttribute("userName");
		if (null == userName) {
		   request.setAttribute("Error", "Session has ended.  Please login.");
		   response.sendRedirect("adminLogin.jsp");
		}
	}catch(Exception e){
		System.out.print(e.getMessage());
		e.printStackTrace();
	}

	response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");//HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<!-- End of Access Restriction -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.win.radio.manila.utilities.CompanyDescriptionOperations"%>
<%@page import="com.win.radio.manila.utilities.ConnectionUtil"%>
<%@include file="nav.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8">
	
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="Win Radio website">
	<meta name="author" content="Win Radio 2017">
	
	<title>Win Radio Admin</title>
	
    <!-- Import CSS files   
	================================================== -->
	<%@include file="admin-css-imports.jsp" %>
	
</head>
<body>
	<div class="container-fluid" id="wrapper">
		<div class="row">
			
			<main class="col-xs-12 col-sm-8 offset-sm-4 col-lg-9 offset-lg-3 col-xl-10 offset-xl-2 pt-3 pl-4">
				<header class="page-header row justify-center">
					<div class="col-md-6 col-lg-8" >
						<h1 class="float-left text-center text-md-left">About Us</h1>
					</div>
					
					<!-- include headerSection Start-->
					<%@include file="headerSection.jsp" %>
					<!-- include headerSection End -->	
					
					<div class="clear"></div>
				</header>
				
				<!-- Alert confirmation start -->
				<div class="row">
					<div class="col-lg-12">
						<div class="alert bg-success" id="alertUpdateSuccess" style="display:none;" role="alert">
							<em class="fa fa-check-circle mr-2"></em> Company details updated successfully!
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertUpdateSuccess')"></em></a>
						</div>
						<div class="alert bg-danger" id="alertUpdateFail" style="display:none;" role="alert">
							<em class="fa fa-minus-circle mr-2"></em> Something went wrong. Please try again. 
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertUpdateFail')"></em></a>
						</div>
						<div class="alert bg-danger" id="alertJSFail" style="display:none;" role="alert">
							<em class="fa fa-minus-circle mr-2"></em> Something went wrong. Please contact your administrator. 
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertJSFail')"></em></a>
						</div>
						
						<div class="alert bg-success" id="alertUpdateSocialSuccess" style="display:none;" role="alert">
							<em class="fa fa-check-circle mr-2"></em> Social media links updated successfully!
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertUpdateSocialSuccess')"></em></a>
						</div>
					</div>
				</div>
				<!-- Alert confirmation end -->
				
				
				<div class="row">
					<!-- About the company form start -->
					<div class="col-lg-6">
						<div class="card mb-4">
							<div class="card-block">
								<h3 class="card-title">About the company</h3>
								<h6 class="card-subtitle mb-2 text-muted">This will be displayed in the 'About Us' page</h6>
								
								<form class="form-horizontal" action="" method="post">
									<%ResultSet rs = null;
				            		PreparedStatement pstmt = null;
				            		Connection conn = null;
													            		
				            		try{	 
				                 	conn = ConnectionUtil.getConnection();
				    				pstmt = conn.prepareStatement(CompanyDescriptionCommands.GET_DESCRIPTION);
				                 	pstmt.setString(1, CodeUtil.COD_REGION_MNL);
				                 	rs = pstmt.executeQuery();
				    				
				    				while (rs.next()) {
									%>
									<center>
										<div class="form-group row">
										  	<label id="lblInvalidMobileNo" class="col-12 col-form-label" style="color:red;display:none;">Please enter an 11-digit mobile no.</label>
										  	<label id="lblInvalidPhoneNo" class="col-12 col-form-label" style="color:red;display:none;">Please enter a 7-digit phone no.</label>
										  	<label id="lblInvalidEmail" class="col-12 col-form-label" style="color:red;display:none;">Please enter a valid email address.</label>
										</div>
									</center>
									<fieldset>
										<div class="form-group" style="display:none;">
									    	<label for="recipient-name" class="form-control-label">ID Description</label>
									        <input type="text" class="form-control" id="idDescription" name="idDescription" required="required" value="<%=rs.getString("ID_DESCRIPTION") %>">
									    </div>
										<div class="form-group">
									    	<label for="recipient-name" class="form-control-label">Contact phone:</label>
									        <input type="text" class="form-control" id="contactPhone" name="contactPhone" required="required" value="<%=rs.getString("CONTACT_PHONE") %>">
									    </div>
								    	<div class="form-group">
								            <label for="message-text" class="form-control-label">Contact mobile:</label>
								            <input type="text" class="form-control" id="contactMobile" name="contactMobile" required="required" value="<%=rs.getString("CONTACT_MOBILE") %>">
								        </div>
								    	<div class="form-group">
								            <label for="message-text" class="form-control-label">Email:</label>
								            <input type="email" class="form-control" id="contactEmail" name=""contactEmail"" required="required" value="<%=rs.getString("CONTACT_EMAIL") %>">
								        </div>
										<!-- Message body -->
										<div class="form-group">
											<label class="col-12 control-label no-padding" for="message">Content</label>
											<div class="col-12 no-padding">
												<textarea class="form-control" id="description" name="description" placeholder="" required="required" rows="5" value=""><%=rs.getString("DESCRIPTION") %></textarea>
											</div>
										</div>
										
										<!-- Form actions -->
										<div class="form-group">
											<div class="col-12 widget-right no-padding">
												<button type="button" class="btn btn-primary btn-md float-right" id="btnSaveCompanyDetails" onclick="saveCompanyDetails()">Save</button>
											</div>
										</div>
									</fieldset>
									<%	}
				            		} catch(Exception ex)
				            		{
				            			ex.printStackTrace();
				            		} finally {
				            			try {
			            					if (rs != null) {
			            						rs.close();
			            					}
			            					if (pstmt != null) {
			            						pstmt.close();
			            					}
			            					if (conn != null) {
			            						conn.close();
			            					}
			            				} catch (SQLException e) {
			            					e.printStackTrace();
			            				}
				            		}
									%>
								</form>
							</div>
						</div>
					</div>
					<!-- About the company form end -->
					
					<!-- Social media form start -->
					<div class="col-lg-6">
						<div class="card">
							<div class="card-block">
								<h3 class="card-title">Social Media Links</h3>
							
								<form>
									<%ResultSet rsSocial = null;
				            		PreparedStatement pstmtSocial = null;
				            		Connection connSocial = null;
													            		
				            		try{	 
				            		connSocial = ConnectionUtil.getConnection();
				            		pstmtSocial = connSocial.prepareStatement(SocialMediaCommands.GET_SOCIAL_MEDIA_ACCTS);
				            		pstmtSocial.setString(1, CodeUtil.COD_REGION_MNL);
				            		pstmtSocial.setString(2, CodeUtil.COD_REGION_MNL);
				            		pstmtSocial.setString(3, CodeUtil.COD_REGION_MNL);
				            		rsSocial = pstmtSocial.executeQuery();
				    				
				    				while (rsSocial.next()) {
									%>
				      				<div class="form-group row">
									  	<label for="example-text-input" class="col-4 col-form-label">Facebook:</label>
									  	<div style="display:none;">
									    	<input class="form-control" id="facebookId" type="text" value="<%=rsSocial.getString("FACEBOOK_ID") %>" required="required">
									  	</div>
									  	<div class="col-8">
									    	<input class="form-control" id="facebookUrl" type="text" value="<%=rsSocial.getString("FACEBOOK_URL") %>" required="required">
									  	</div>
									</div>
									<div class="form-group row">
									  	<label for="example-text-input" class="col-4 col-form-label">Video Streaming:</label>
										<div style="display:none;">
									    	<input class="form-control" id="videoStreamId" type="text" value="<%=rsSocial.getString("VIDEO_STREAM_ID") %>" required="required">
									  	</div>
									  	<div class="col-8 align-middle">
									    	<input class="form-control align-middle" id="videoStreamUrl" type="text" value="<%=rsSocial.getString("VIDEO_STREAM_URL") %>" required="required">
									  	</div>
									</div>
									<div class="form-group row">
									  	<label for="example-text-input" class="col-4 col-form-label">Audio Streaming:</label>
									  	<div style="display:none;">
									    	<input class="form-control" id="audioStreamId" type="text" value="<%=rsSocial.getString("AUDIO_STREAM_ID") %>" required="required">
									  	</div>
									  	<div class="col-8">
									    	<input class="form-control" id="audioStreamUrl" type="text" value="<%=rsSocial.getString("AUDIO_STREAM_URL") %>" required="required">
									  	</div>
									</div>
									<!-- Form actions -->
									<div class="form-group">
										<div class="col-12 widget-right no-padding">
											<button type="button" class="btn btn-primary btn-md float-right" onclick="saveSocialLinks()">Submit</button>
										</div>
									</div>
									<%	}
				            		} catch(Exception ex)
				            		{
				            			ex.printStackTrace();
				            		} finally {
				            			try {
			            					if (rsSocial != null) {
			            						rsSocial.close();
			            					}
			            					if (pstmtSocial != null) {
			            						pstmtSocial.close();
			            					}
			            					if (connSocial != null) {
			            						connSocial.close();
			            					}
			            				} catch (SQLException e) {
			            					e.printStackTrace();
			            				}
				            		}
									%>
								</form>
							
							</div>
						</div>
					</div>
					<!-- Social media form end -->
				</div>
			</main>
			

		</div>
	</div>

    <!-- Import JavaScript
	================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<%@include file="admin-js-imports.jsp" %>
    
    <script type="text/javascript">
    	function saveCompanyDetails() {
    		document.getElementById('lblInvalidPhoneNo').style.display = "none";
    		document.getElementById('lblInvalidMobileNo').style.display = "none";
    		document.getElementById('lblInvalidEmail').style.display = "none";
    		
			var contactPhone=$("#contactPhone").val();
			var contactMobile=$("#contactMobile").val();
			var contactEmail=$("#contactEmail").val();
			var description=$("#description").val();
			var idDescription=$("#idDescription").val();
			
			if(checkIfValidPhoneNo(contactPhone) == 'error') {
        		document.getElementById('lblInvalidPhoneNo').style.display = "block";
        		return;
			}
			
			if(checkIfValidMobileNo(contactMobile) == 'error') {
        		document.getElementById('lblInvalidMobileNo').style.display = "block";
        		return;
			}
			
			if(!validateEmail(contactEmail)) {
        		document.getElementById('lblInvalidEmail').style.display = "block";
        		return;
			}
			
			$.ajax({
	            url:'${pageContext.request.contextPath}/updateCompanyDetails',
	            data:{action: 'updateCompanyDetails', idDescription:idDescription, contactPhone: contactPhone, contactMobile: contactMobile, contactEmail: contactEmail, description: description},
	            type:'post',
	            cache:false,
	            success:function(data){
	            	if ($.trim(data) == 'success') {
	            		document.getElementById('alertUpdateSuccess').style.display = "block";
	            	} else {
	            		document.getElementById('alertUpdateFail').style.display = "block";
	            	}
	            },
	            error:function(){
	            	document.getElementById('alertJSFail').style.display = "block";
	            }
			});
    	}
    	
    	function checkIfValidMobileNo(contactMobile) {
			if (contactMobile.length != 11) {
				   return 'error';
			}
		}
    	
    	function checkIfValidPhoneNo(contactPhone) {
			if (contactPhone.length != 7) {
				   return 'error';
			}
		}
    	
    	function validateEmail(email) {
    	    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    	    return re.test(email);
    	}
    	
    	function saveSocialLinks() {

    		var facebookId=$("#facebookId").val();
			var audioStreamId=$("#audioStreamId").val();
			var videoStreamId=$("#videoStreamId").val();
    		var facebookUrl=$("#facebookUrl").val();
			var audioStreamUrl=$("#audioStreamUrl").val();
			var videoStreamUrl=$("#videoStreamUrl").val();
			
    		$.ajax({
	            url:'${pageContext.request.contextPath}/updateCompanyDetails',
	            data:{action: 'updateSocialLinks', facebookId:facebookId, facebookUrl:facebookUrl, audioStreamId:audioStreamId, audioStreamUrl:audioStreamUrl, videoStreamId:videoStreamId, videoStreamUrl:videoStreamUrl},
	            type:'post',
	            cache:false,
	            success:function(data){
	            	if ($.trim(data) == 'success') {
	            		document.getElementById('alertUpdateSocialSuccess').style.display = "block";
	            	} else {
	            		document.getElementById('alertUpdateFail').style.display = "block";
	            	}
	            },
	            error:function(){
	            	document.getElementById('alertJSFail').style.display = "block";
	            }
			});
    	}
		
    	function closeAlert(idAlert) {
			document.getElementById(idAlert).style.display = "none";
		}
	
	</script>
		
</body>
</html>
