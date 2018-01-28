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

<title>Win Radio Admin - Heart Stories</title>

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
				<h1 class="float-left text-center text-md-left">Heart Stories</h1>
			</div>

			<!-- include headerSection Start--> <%@include
				file="headerSection.jsp"%> <!-- include headerSection End -->
			<div class="clear"></div>
			</header>

			<div class="row">
				<div class="col-lg-12">
					<div class="alert bg-success" id="alertSuccess"
						style="display: none;" role="alert">
						<em class="fa fa-check-circle mr-2"></em>
						<%=CodeUtil.STATUS_MSG_ADDED%>
						<a href="#" class="float-right"><em class="fa fa-remove"
							onclick="closeAlert('alertSuccess')"></em> </a>
					</div>
					<div class="alert bg-danger" id="alertFail" style="display: none;"
						role="alert">
						<em class="fa fa-minus-circle mr-2"></em>
						<%=CodeUtil.STATUS_MSG_ERROR%>
						<a href="#" class="float-right"> <em class="fa fa-remove"
							onclick="closeAlert('alertFail')"></em>
						</a>
					</div>
				</div>
			</div>

			<%
				ResultSet rs = null;
				PreparedStatement pstmt = null;
				Connection conn = null;

				int idDramaModify = Integer.valueOf(request.getParameter("idDramaModify"));

				try {
					conn = ConnectionUtil.getConnection();
					pstmt = conn.prepareStatement(DramaCommands.GET_DRAMA_DETAILS);
					pstmt.setInt(1, idDramaModify);
					rs = pstmt.executeQuery();

					while (rs.next()) {

						String status;

						if (rs.getString("STATUS").equals("0")) {
							status = "Inactive";
						} else {
							status = "Active";
						}
			%> <!-- Row buttons start -->
			<div class="row">
				<div class="col-lg-6">
					<a href="adminDrama.jsp">
						<button type="button"
							class="btn btn-sm btn-primary float-left btn-options">
							<em class="fa fa-long-arrow-left"></em> Back
						</button>
					</a>
				</div>
				<div class="col-lg-6">
					<span id="currentRow" style="display: none;"></span>

					<%
						if (status == "Active") {
					%>

					<button type="button"
						class="btn btn-secondary btn-sm float-right btn-options"
						onclick="updateStatus('deactivate')">Deactivate</button>
					<button type="button"
						class="btn btn-primary btn-sm float-right btn-options"
						id="btnCancel">Cancel</button>
					<button type="button"
						class="btn btn-primary btn-sm float-right btn-options"
						onclick="updateEpisode()">Save</button>

					<%
						} else if (status == "Inactive") {
					%>

					<button type="button"
						class="btn btn-secondary btn-sm float-right btn-options"
						onclick="updateStatus('activate')">Activate</button>

					<%
						}
					%>

				</div>
			</div>
			<br />
			<!-- Row buttons end --> <!-- Row start: update question form -->
			<div class="row justify-content-md-center">
				<div class="col-lg-8">
					<div class="card">
						<div class="card-block">
							<h3 class="card-title">Modify episode</h3>

							<form id="formModifyEpisode" class="form">
								<div class="form-group row" style="display: none;">
									<label for="example-text-input" class="col-3 col-form-label">Episode
										ID</label>
									<div class="col-9">
										<input class="form-control" id="idEpisode" name="idEpisode"
											type="text" value="<%=rs.getString("ID_EPISODE")%>" readonly>
									</div>
								</div>
								<div class="form-group row">
									<label class="col-3 col-form label" for="title">Title</label>
									<div class="col-lg-9">
										<input class="form-control" id="title" name="title"
											type="text" placeholder="Episode Title" required="required"
											value="<%=rs.getString("TITLE")%>">
									</div>
								</div>
								<div class="form-group row">
									<label class="col-3 col-form label" for="description">Episode
										Description</label>

									<div class="col-lg-9">
										<textarea class="form-control" id="description"
											name="description" type="text"
											placeholder="Episode Description" required="required"
											rows="5"><%=rs.getString("DESCRIPTION")%></textarea>
									</div>
								</div>
								<div class="form-group row">
									<label class="col-3 col-form label" for="file">File</label>

									<div class="col-lg-9">
										<input class="form-control file" id="file" name="file"
											type="file" placeholder="File..." required="required"
											value="TESTESTESTSETSE">
									</div>
								</div>
								<div class="form-group row">
									<label class="col-3 col-form label" for="file">Thumbnail
										Image</label>

									<div class="col-lg-9">
										<input class="form-control file" id="thumbnail"
											name="thumbnail" type="file" placeholder="File..."
											required="required" value="<%=rs.getString("IMAGE")%>">
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
	<%@include file="admin-js-imports.jsp"%>

	<script type="text/javascript">
		function updateEpisode() {
			var idEpisode = $('#idEpisode').val();
			var title = $('#title').val();
			var description = $('#description').val();
			var filename = $('#file').val();
			var image = $('#thumbnail').val();

			$
					.ajax({
						url : '${pageContext.request.contextPath}/updateDramaController',
						data : {
							action : 'updateEpisodeDetails',
							idEpisode : idEpisode,
							title : title,
							description : description,
							filename : filename,
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
							} else {
								document.getElementById('alertFail').style.display = "block";
							}
						},
						error : function() {
							alert("error");
						}
					})
		}

		function updateStatus(strStatus) {
			var idEpisode = $('#idEpisode').val();
			var status = "";

			if (strStatus == 'activate') {
				status = '1';
			} else if (strStatus == 'deactivate') {
				status = '0';
			}

			$
					.ajax({
						url : '${pageContext.request.contextPath}/updateDramaController',
						data : {
							action : 'updateEpisodeStatus',
							idEpisode : idEpisode,
							status : status
						},
						type : 'post',
						cache : false,
						success : function(data) {
							if ($.trim(data) == 'success') {
								document.getElementById('alertSuccess').style.display = "block";
								setTimeout(function() {
									location.reload();
								}, 2000);
							} else {
								document.getElementById('alertFail').style.display = "block";
							}
						},
						error : function(data) {
							alert("error");
						}
					})
		}

		function closeAlert(idAlert) {
			document.getElementById(idAlert).style.display = "none";
		}

		$('#btnCancel').click(function() {
			window.location.href = 'adminQOTD.jsp';
		})
	</script>

</body>
</html>