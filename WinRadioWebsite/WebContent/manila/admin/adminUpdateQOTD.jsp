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

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="com.win.radio.manila.utilities.QOTDCommands"%>
<%@page import="com.win.radio.manila.utilities.QOTDOperations"%>

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
				<h1 class="float-left text-center text-md-left">Question of the
					Day</h1>
			</div>

			<!-- include headerSection Start--> <%@include
				file="headerSection.jsp"%> <!-- include headerSection End -->
			<div class="clear"></div>
			</header>

			<div class="row">
				<div class="col-lg-12">
					<!-- Breadcrumbs -->
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="adminQOTD.jsp">DJ
								Question of the Day</a></li>
						<li class="breadcrumb-item active">Update Question</li>
					</ol>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-12">
					<div class="alert bg-success" id="alertUpdateQuestionSuccess"
						style="display: none;" role="alert">
						<em class="fa fa-check-circle mr-2"></em> Update question
						successful! <a href="#" class="float-right"><em
							class="fa fa-remove"
							onclick="closeAlert('alertUpdateQuestionSuccess')"></em>
						</a>
					</div>
					<div class="alert bg-danger" id="alertUpdateQuestionFail"
						style="display: none;" role="alert">
						<em class="fa fa-minus-circle mr-2"></em> Something went wrong,
						please try again. <a href="#" class="float-right"> <em
							class="fa fa-remove"
							onclick="closeAlert('alertUpdateQuestionFail')"></em>
						</a>
					</div>
				</div>
			</div>

			<%
				ResultSet rs = null;
				PreparedStatement pstmt = null;
				Connection conn = null;

				int idQuestionToModify = Integer.valueOf(request.getParameter("idQuestionToModify"));

				try {
					conn = ConnectionUtil.getConnection();
					pstmt = conn.prepareStatement(QOTDCommands.GET_QUESTION_DETAILS);
					pstmt.setInt(1, idQuestionToModify);
					rs = pstmt.executeQuery();

					while (rs.next()) {

						String indicator;

						if (rs.getString("IND_POST").equals("0")) {
							indicator = "Archive";
						} else {
							indicator = "Current Post";
						}
			%> <!-- Active buttons start -->

			<div class="row">

				<div class="col-lg-12">

					<span id="currentRow" style="display: none;"></span>

					<%
						if (indicator == "Current Post") {
					%>

					<button type="button"
						class="btn btn-secondary btn-md float-right btn-options"
						onclick="updateQuestionStatus('deactivate')">Deactivate</button>
					<button type="button"
						class="btn btn-primary btn-md float-right btn-options"
						id="btnCancel">Cancel</button>
					<button type="button"
						class="btn btn-primary btn-md float-right btn-options"
						onclick="updateQuestion()">Save</button>

					<%
						} else if (indicator == "Archive") {
					%>

					<button type="button"
						class="btn btn-secondary btn-md float-right btn-options"
						onclick="updateQuestionStatus('activate')">Activate</button>

					<%
						}
					%>

				</div>

			</div>

			<br />

			<!-- Active buttons end --> <!-- Row start: update question form -->
			<div class="row justify-content-md-center">
				<div class="col-lg-8">
					<div class="card">
						<div class="card-block">
							<h3 class="card-title">Update question</h3>

							<form id="formUpdateQuestion" class="form">

								<div class="form-group row" style="display: none;">
									<label for="example-text-input" class="col-3 col-form-label">Question
										ID</label>
									<div class="col-9">
										<input class="form-control" id="idQuestion" name="idQuestion"
											type="text" value="<%=rs.getString("ID_QUESTION")%>" readonly>
									</div>
								</div>

								<div class="form-group row">

									<label class="col-3 col-form-label" for="question">DJ
										Owner</label>

									<div class="col-9">
										<div class="form-control" type="text" id="djName"
											name="djName" readonly><%=rs.getString("DJ_NAME")%></div>
									</div>

								</div>

								<div class="form-group row">

									<label class="col-3 col-form-label" for="postStatus">Status</label>

									<div class="col-9">
										<div class="form-control" type="text" id="postStatus"
											name="postStatus" readonly><%=indicator%></div>
									</div>

								</div>

								<div class="form-group row">

									<label class="col-3 col-form-label" for="question">Content</label>

									<div class="col-9">
										<textarea class="form-control" id="message" name="question"
											placeholder="" required="required" rows="5"><%=rs.getString("QUESTION")%>
											</textarea>
									</div>

								</div>

							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- Row end: table --> <br />

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
					if (pstmt != null) {
						try {
							pstmt.close();
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
			%> </main>

		</div>

	</div>

	<!-- Import JavaScript
	================================================== -->
	<%@include file="admin-js-imports.jsp" %>

	<script type="text/javascript">
		function updateQuestion() {
			var question = $("#message").val();
			var idQuestion = $("#idQuestion").val();

			alert(question);

			$
					.ajax({
						url : '${pageContext.request.contextPath}/updateQotdController',
						data : {
							question : question,
							idQuestion : idQuestion
						},
						type : 'post',
						cache : false,
						success : function(data) {
							if ($.trim(data) == 'success') {
								document
										.getElementById('alertUpdateQuestionSuccess').style.display = "block";
							} else {
								document
										.getElementById('alertUpdateQuestionFail').style.display = "block";
							}
						},
						error : function() {
							alert('error')
						}
					});
		}

		function closeAlert(idAlert) {
			document.getElementById(idAlert).style.display = "none";
		}

		$('#btnCancel').click(function() {
			window.location.href = 'adminQOTD.jsp';
		})

		function updateQuestionStatus(strStatus) {
			var idQuestion = $('#idQuestion').val();
			var questionStatus = "";
			if (strStatus == 'activate') {
				questionStatus = "1";
			} else if (strStatus == 'deactivate') {
				questionStatus = "0";
			}

			$
					.ajax({
						url : '${pageContext.request.contextPath}/updateQuestionStatus',
						data : {
							idQuestion : idQuestion,
							questionStatus : questionStatus
						},
						type : 'post',
						cache : false,
						success : function(data) {
							if ($.trim(data) == 'success') {
								document
										.getElementById('alertUpdateQuestionSuccess').style.display = "block";
								setTimeout(function() {
									location.reload();
								}, 2000);
							} else if ($.trim(data) == 'fail') {
								document
										.getElementById('alertUpdateQuestionFail').style.display = "block";
							}
						},
						error : function() {
							alert('error');
						}
					})
		}
	</script>

</body>
</html>