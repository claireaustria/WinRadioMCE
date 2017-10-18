<!-- Prevent Access to the page without logging in -->
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
	
    <!-- Bootstrap core CSS -->
    <link href="../core-css/bootstrap.min.css" rel="stylesheet">

    <!--Fonts-->
    <link href="../fonts/fonts.css" rel="stylesheet">
      
    <!-- Icons -->
    <link href="../core-css/font-awesome.css" rel="stylesheet">
    
    <!-- Custom styles for this template -->
    <link href="custom-css/style.css" rel="stylesheet">
    <link href="custom-css/admin.css" rel="stylesheet">
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
					</div>
				</div>
				<!-- Alert confirmation end -->
				
				
				<div class="row">
					<!-- About the company form start -->
					<div class="col-lg-7">
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
					<div class="col-lg-5">
						<div class="card">
							<div class="card-block">
								<h3 class="card-title">Social Media Links</h3>
							
								<form id="formSocialMedia" class="form" method="post" action="${pageContext.request.contextPath}/createUserController">
				      				<div class="form-group row">
									  	<label for="example-text-input" class="col-4 col-form-label">Facebook:</label>
									  	<div class="col-8">
									    	<input class="form-control" name="facebook" type="text" placeholder="" required="required">
									  	</div>
									</div>
									<div class="form-group row">
									  	<label for="example-text-input" class="col-4 col-form-label">Video Streaming:</label>
									  	<div class="col-8 align-middle">
									    	<input class="form-control align-middle" name="videoStream" type="text" placeholder="" required="required">
									  	</div>
									</div>
									<div class="form-group row">
									  	<label for="example-text-input" class="col-4 col-form-label">Audio Streaming:</label>
									  	<div class="col-8">
									    	<input class="form-control" name="audioStream" type="text" placeholder="" required="required">
									  	</div>
									</div>
									<!-- Form actions -->
									<div class="form-group">
										<div class="col-12 widget-right no-padding">
											<button type="button" class="btn btn-primary btn-md float-right">Submit</button>
										</div>
									</div>
								</form>
							
							</div>
						</div>
					</div>
					<!-- Social media form end -->
				</div>
			</main>
			

		</div>
	</div>

    <!-- Bootstrap core JavaScript -->
    <script src="../core-js/jquery-3.2.1.min.js"></script>
    <script src="../core-js/jquery.min.js"></script>
    <script src="../core-js/tether.min.js"></script>
    <script src="../core-js/bootstrap.min.js"></script>
    
    <script src="custom-js/admin.js"></script>
    
    <script type="text/javascript">
    	function saveCompanyDetails() {
			var contactPhone=$("#contactPhone").val();
			var contactMobile=$("#contactMobile").val();
			var contactEmail=$("#contactEmail").val();
			var description=$("#description").val();
			var idDescription=$("#idDescription").val();
			
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
		
    	function closeAlert(idAlert) {
			document.getElementById(idAlert).style.display = "none";
		}
	
	</script>
		
</body>
</html>
