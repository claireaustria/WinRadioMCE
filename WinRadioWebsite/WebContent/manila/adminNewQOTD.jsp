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
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.win.radio.manila.utilities.QOTDOperations"%>
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

			<main
				class="col-xs-12 col-sm-8 offset-sm-4 col-lg-9 offset-lg-3 
					col-xl-10 offset-xl-2 pt-3 pl-4">
			<header class="page-header row justify-center">
			<div class="col-md-6 col-lg-8">
				<h1 class="float-left text-center text-md-left">Post Question
					of the Day</h1>
			</div>

			<!-- include headerSection Start--> <%@include
				file="headerSection.jsp"%> <!-- include headerSection End -->

			<div class="clear"></div>
			</header>

			<div class="row">
				<div class="col-lg-12">
					<!-- Breadcrumbs -->
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a
							href="adminQOTD.jsp">DJ Question of the Day</a></li>
						<li class="breadcrumb-item active">New Post</li>
					</ol>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-12">
					<div class="alert bg-success" id="alertQuestionSuccess"
						style="display: none;" role="alert">
						<em class="fa fa-check-circle mr-2"></em> New question successful!
						<a href="#" class="float-right"><em class="fa fa-remove"
							onclick="closeAlert('alertQuestionSuccess')"></em></a>
					</div>
					<div class="alert bg-danger" id="alertQuestionFail"
						style="display: none;" role="alert">
						<em class="fa fa-minus-circle mr-2"></em> Something went wrong,
						please try again. <a href="#" class="float-right"><em
							class="fa fa-remove"
							onclick="closeAlert('alertQuestionFail')"></em></a>
					</div>
				</div>
			</div>

			<!-- Row start: table -->
			<div class="row justify-content-md-center">
				<div class="col-lg-8">
					<div class="card">
						<div class="card-block">
							<h3 class="card-title">Post new question</h3>

							<form id="formNewUser" class="form">

								<center>
									<div class="form-group row">
										<label id="lblMissingField" class="col-12 col-form-label"
											style="color: red; display: none;">Please fill out
											all fields.</label>
									</div>
								</center>

								<div class="form-group row">
									<label for="example-text-input" class="col-3 col-form-label">DJ
										Owner</label>
									<div class="col-9">
										<select class="form-control" id="dropdownDJ" name="djName">
											<%
												ResultSet rs = null;
												Statement select = null;
												Connection conn = null;

												try {
													conn = ConnectionUtil.getConnection();
													select = conn.createStatement();
													rs = select.executeQuery(QOTDOperations.GET_ALL_DJ);

													while (rs.next()) {
											%>
											<option value="<%=rs.getString("ID_DJ")%>"><%=rs.getString("DJ_NAME")%></option>
											<%
												}

												} catch (Exception ex) {
													ex.printStackTrace();
												} finally {
													if (rs != null) {
														try {
															rs.close();
														} catch (SQLException e) {
															e.printStackTrace();
														}
													}
													if (select != null) {
														try {
															select.close();
														} catch (SQLException e) {
															e.printStackTrace();
														}
													}
													if (conn != null) {
														try {
															conn.close();
														} catch (SQLException e) {
															e.printStackTrace();
														}
													}
												}
											%>
										</select>
									</div>
								</div>

								<div class="form-group row">
									<label class="col-3 col-form-label" for="question">Content</label>

									<div class="col-9">
										<textarea class="form-control" id="message" name="question"
											placeholder="" required="required" rows="5"></textarea>
									</div>
								</div>

								<!-- Form actions -->
								<div class="form-group">
									<div class="col-12 widget-right no-padding">
										<button type="submit"
											class="btn btn-primary btn-md float-right"
											onclick="addNewQOTD()">Submit</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- Row end: table --> <br />

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
		function addNewQOTD() {
			var djName = $("#dropdownDJ").val();
			var question = $("#message").val();

			$
					.ajax({
						url : '${pageContext.request.contextPath}/qotdController',
						data : {
							djName : djName,
							question : question
						},
						type : 'post',
						cache : false,
						success : function(data) {
							if ($.trim(data) == 'success') {
								document.getElementById('alertQuestionSuccess').style.display = "block";
							} else {
								document.getElementById('alertQuestionFail').style.display = "block";
							}
						},
						error : function() {
							alert('Tangina ano mali');
						}
					});
		}

		function closeAlert(idAlert) {
			document.getElementById(idAlert).style.display = "none";
		}
	</script>

</body>
</html>
