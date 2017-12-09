<!-- Prevent Access to the page without logging in -->
<%
	try {
		String userName = (String) session.getAttribute("userName");
		if (null == userName) {
			request.setAttribute("Error", "Session has ended.  Please login.");
			response.sendRedirect("adminLogin.jsp");
		}
	} catch (Exception e) {
		System.out.print(e.getMessage());
		e.printStackTrace();
	}

	response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");//HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<!-- End of Access Restriction -->

<%@page import="com.win.radio.manila.utilities.ConnectionUtil"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="com.win.radio.manila.utilities.BannerCommands"%>
<%@page import="com.win.radio.manila.utilities.BannerOperations"%>

<%@page import="com.win.radio.manila.utilities.CodeUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.win.radio.manila.utilities.ConnectionUtil"%>
<%@include file="nav.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8">

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="Win Radio website">
<meta name="author" content="Win Radio 2017">

<title>Win Radio Admin - Sponsor Banner</title>

<!-- Import CSS files   
	================================================== -->
<%@include file="admin-css-imports.jsp"%>

</head>
<body>
	<div class="container-fluid" id="wrapper">
		<div class="row">

			<main
				class="col-xs-12 col-sm-8 offset-sm-4 col-lg-9 offset-lg-3 
					col-xl-10 offset-xl-2 pt-3 pl-4">
			<header class="page-header row justify-center">
			<div class="col-md-6 col-lg-8">
				<h1 class="float-left text-center text-md-left">Add New Sponsor</h1>
			</div>

			<!-- include headerSection Start--> <%@include
				file="headerSection.jsp"%> <!-- include headerSection End -->

			<div class="clear"></div>
			</header>

			<div class="row">
				<div class="col-lg-12">
					<div class="alert bg-success" id="alertSuccess"
						style="display: none;" role="alert">
						<em class="fa fa-check-circle mr-2"></em> Add new sponsor
						successful! <a href="#" class="float-right"><em
							class="fa fa-remove" onclick="closeAlert('alertSuccess')"></em> </a>
					</div>
					<div class="alert bg-danger" id="alertFail" style="display: none;"
						role="alert">
						<em class="fa fa-minus-circle mr-2"></em> Something went wrong,
						please try again. <a href="#" class="float-right"> <em
							class="fa fa-remove" onclick="closeAlert('alertFail')"></em>
						</a>
					</div>
				</div>
			</div>

			<div class="row justify-content-md-center">
				<div class="col-lg-8">
					<div class="card">
						<div class="card-block">
							<h3 class="card-title">Add New Sponsor in Banner</h3>
							<br>
							<form id="formNewSponsor" class="form">
								<center></center>
								<div class="form-group row">
									<label class="col-3 col-form label" for="title">Name of
										Sponsor</label>
									<div class="col-lg-9">
										<input class="form-control" id="sponsorName"
											name="sponsorName" type="text" placeholder="Name of Sponsor"
											required="required">
									</div>
								</div>
								<div class="form-group row">
									<label class="col-3 col-form label" for="file">File</label>

									<div class="col-lg-9">
										<input class="form-control file" id="file" name="file"
											type="file" placeholder="File..." required="required">
									</div>
								</div>
								<div class="form-group">
									<div class="col-12 widget-right no-padding">
										<button type="button"
											class="btn btn-primary btn-sm float-right"
											onclick="addNewSponsor()">Submit</button>
									</div>
								</div>
							</form>

						</div>
					</div>
				</div>
			</div>

			</main>

		</div>

	</div>

	<!-- Import JavaScript
	================================================== -->
	<%@include file="admin-js-imports.jsp"%>

	<script type="text/javascript">
		function addNewSponsor() {
			var brand = $('#sponsorName').val();
			var image = $('#file').val();
			
			$.ajax({
				url : '${pageContext.request.contextPath}/createBannerController',
				data : {
					brand : brand,
					image : image
				},
				type : 'post',
				cache : false,
				success : function(data) {
					if ($.trim(data) == 'success') {
						document.getElementById('alertSuccess').style.display = "block";
						setTimeout(function() {
							location.reload();
						}, 2000);
					} else if ($.trim(data) == 'fail') {
						document.getElementById('alertFail').style.display = "block";
					}
				},
				error : function() {
					document.getElementById('alertFail').style.display = "block";
				}
			});
		}
		
		function closeAlert(idAlert) {
			document.getElementById(idAlert).style.display = "none";
		}
		
		function validateImage(file) {
			
		}
	</script>

</body>
</html>
