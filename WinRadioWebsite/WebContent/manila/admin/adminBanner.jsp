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

<%@page import="com.win.radio.manila.utilities.DramaCommands"%>
<%@page import="com.win.radio.manila.utilities.DramaOperations"%>

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

<title>Win Radio Admin - DJ QOTD</title>

	<!-- Import CSS files   
	================================================== -->
	<%@include file="admin-css-imports.jsp" %>

</head>
<body>
	<div class="container-fluid" id="wrapper">
		<div class="row">

			<main
				class="col-xs-12 col-sm-8 offset-sm-4 col-lg-9 offset-lg-3 
					col-xl-10 offset-xl-2 pt-3 pl-4">
			<header class="page-header row justify-center">
			<div class="col-md-6 col-lg-8">
				<h1 class="float-left text-center text-md-left">Advertisement Banner Maintenance</h1>
			</div>

			<!-- include headerSection Start--> <%@include
				file="headerSection.jsp"%> <!-- include headerSection End -->

			<div class="clear"></div>
			</header>

			<div class="row">
				<div class="col-lg-12">
					<!-- Breadcrumbs -->
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="#">Advertisement Banner</a></li>
						<li class="breadcrumb-item active">Maintenance</li>
					</ol>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-12">
					<div class="alert bg-success" id="alertSuccess"
						style="display: none;" role="alert">
						<em class="fa fa-check-circle mr-2"></em> Update question
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
				<div class="col-lg-10">
					<div class="card">
						<div class="card-block">
							<h3 class="card-title">Advertisement Banner Maintenance</h3>
							<br>
							<form id="formModifyBanner" class="form">
								<center></center>
								<div class="form-group row">
									<div class="col-lg-2">
										<label class="col-form label" for="brand1">Brand 1</label>
									</div>									
									<div class="col-lg-5">
										<input class="form-control" id="brand1Title" name="brand1Title"
											type="text" placeholder="Brand 1" required="required">
									</div>
									<div class="col-lg-5">
										<input class="form-control file" id="file1" name="file1"
											type="file" placeholder="File..." required="required">
									</div>
								</div>
								<div class="form-group row">
									<div class="col-lg-2">
										<label class="col-form label" for="brand2">Brand 2</label>
									</div>
									<div class="col-lg-5">
										<input class="form-control" id="brand2Title" name="brand2Title"
											type="text" placeholder="Brand 2" required="required">
									</div>
									<div class="col-lg-5">
										<input class="form-control file" id="file2" name="file2"
											type="file" placeholder="File..." required="required">
									</div>
								</div>
								<div class="form-group row">
									<div class="col-lg-2">
										<label class="col-form label" for="brand3">Brand 3</label>
									</div>
									<div class="col-lg-5">
										<input class="form-control" id="brand3Title" name="brand3Title"
											type="text" placeholder="Brand 3" required="required">
									</div>
									<div class="col-lg-5">
										<input class="form-control file" id="file3" name="file3"
											type="file" placeholder="File..." required="required">
									</div>
								</div>
								<div class="form-group row">
									<div class="col-lg-2">
										<label class="col-form label" for="brand4">Brand 4</label>
									</div>
									<div class="col-lg-5">
										<input class="form-control" id="brand4Title" name="brand4Title"
											type="text" placeholder="Brand 4" required="required">
									</div>
									<div class="col-lg-5">
										<input class="form-control file" id="file4" name="file4"
											type="file" placeholder="File..." required="required">
									</div>
								</div>
								<div class="form-group row">
									<div class="col-lg-2">
										<label class="col-form label" for="brand5">Brand 5</label>
									</div>
									<div class="col-lg-5">
										<input class="form-control" id="brand5Title" name="brand5Title"
											type="text" placeholder="Brand 5" required="required">
									</div>
									<div class="col-lg-5">
										<input class="form-control file" id="file5" name="file5"
											type="file" placeholder="File..." required="required">
									</div>
								</div>
								<div class="form-group row">
									<div class="col-lg-2">
										<label class="col-form label" for="brand6">Brand 6</label>
									</div>
									<div class="col-lg-5">
										<input class="form-control" id="brand6Title" name="brand6Title"
											type="text" placeholder="Brand 6" required="required">
									</div>
									<div class="col-lg-5">
										<input class="form-control file" id="file6" name="file6"
											type="file" placeholder="File..." required="required">
									</div>
								</div>
								<div class="form-group row">
									<div class="col-lg-2">
										<label class="col-form label" for="brand7">Brand 7</label>
									</div>
									<div class="col-lg-5">
										<input class="form-control" id="brand7Title" name="brand7Title"
											type="text" placeholder="Brand 7" required="required">
									</div>
									<div class="col-lg-5">
										<input class="form-control file" id="file7" name="file7"
											type="file" placeholder="File..." required="required">
									</div>
								</div>
								<div class="form-group row">
									<div class="col-lg-2">
										<label class="col-form label" for="brand8">Brand 8</label>
									</div>
									<div class="col-lg-5">
										<input class="form-control" id="brand8Title" name="brand8Title"
											type="text" placeholder="Brand 8" required="required">
									</div>
									<div class="col-lg-5">
										<input class="form-control file" id="file8" name="file8"
											type="file" placeholder="File..." required="required">
									</div>
								</div>
								<div class="form-group row">
									<div class="col-lg-2">
										<label class="col-form label" for="brand9">Brand 9</label>
									</div>
									<div class="col-lg-5">
										<input class="form-control" id="brand9Title" name="brand9Title"
											type="text" placeholder="Brand 9" required="required">
									</div>
									<div class="col-lg-5">
										<input class="form-control file" id="file9" name="file9"
											type="file" placeholder="File..." required="required">
									</div>
								</div>
								<div class="form-group row">
									<div class="col-lg-2">
										<label class="col-form label" for="brand10">Brand 10</label>
									</div>
									<div class="col-lg-5">
										<input class="form-control" id="brand10Title" name="brand10Title"
											type="text" placeholder="Brand 10" required="required">
									</div>
									<div class="col-lg-5">
										<input class="form-control file" id="file10" name="file10"
											type="file" placeholder="File..." required="required">
									</div>
								</div>
								
								<div class="form-group">
									<div class="col-12 widget-right no-padding">
										<button type="button"
											class="btn btn-primary btn-sm float-right"
											onclick="modifyBanner()">Submit Changes</button>
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
	<%@include file="admin-js-imports.jsp" %>

	<script type="text/javascript">
		function modifyBanner() {
			var brand1 = $('#brand1').val();
			var brand2 = $('#brand2').val();
			var brand3 = $('#brand3').val();
			var brand4 = $('#brand4').val();
			var brand5 = $('#brand5').val();
			var brand6 = $('#brand6').val();
			var brand7 = $('#brand7').val();
			var brand8 = $('#brand8').val();
			var brand9 = $('#brand9').val();
			var brand10 = $('#brand10').val();
			
		}
	</script>

</body>
</html>
