<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.win.radio.manila.utilities.SQLOperations"%>
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
				
				
				<div class="row">
					<!-- About the company form start -->
					<div class="col-lg-7">
						<div class="card mb-4">
							<div class="card-block">
								<h3 class="card-title">About the company</h3>
								<h6 class="card-subtitle mb-2 text-muted">This will be displayed in the 'About Us' page</h6>
								
								<form class="form-horizontal" action="" method="post">
									<fieldset>
										<!-- Message body -->
										<div class="form-group">
											<label class="col-12 control-label no-padding" for="message">Content</label>
											
											<div class="col-12 no-padding">
												<textarea class="form-control" id="message" name="message" placeholder="" required="required" rows="5"></textarea>
											</div>
										</div>
										
										<!-- Form actions -->
										<div class="form-group">
											<div class="col-12 widget-right no-padding">
												<button type="submit" class="btn btn-primary btn-md float-right">Submit</button>
											</div>
										</div>
									</fieldset>
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
											<button type="submit" class="btn btn-primary btn-md float-right">Submit</button>
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
</body>
</html>
