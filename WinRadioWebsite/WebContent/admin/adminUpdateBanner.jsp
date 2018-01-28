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
				<h1 class="float-left text-center text-md-left">Sponsor Banner</h1>
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
						<%=CodeUtil.STATUS_MSG_SAVED%>
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

				int idSponsorModify = Integer.valueOf(request.getParameter("idSponsorModify"));

				try {
					conn = ConnectionUtil.getConnection();
					pstmt = conn.prepareStatement(BannerOperations.GET_SPONSOR_DETAILS);
					pstmt.setInt(1, idSponsorModify);
					rs = pstmt.executeQuery();

					while (rs.next()) {

						String status;

						if (rs.getString("STATUS").equals("ACTIVE")) {
							status = "Active";
						} else {
							status = "Inactive";
						}
			%> <!-- Row buttons start -->
			<div class="row">
				<div class="col-lg-6">
					<a href="adminBanner.jsp">
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
						onclick="updateSponsor()">Save</button>

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
							<h3 class="card-title">Modify sponsor</h3>

							<form id="formModifySponsor" class="form">
								<div class="form-group row" style="display: none;">
									<label for="example-text-input" class="col-3 col-form-label">Banner
										ID</label>
									<div class="col-9">
										<input class="form-control" id="idBanner" name="idBanner"
											type="text" value="<%=rs.getString("ID_AD")%>" readonly>
									</div>
								</div>
								<div class="form-group row">
									<label class="col-3 col-form label" for="brand">Brand</label>
									<div class="col-lg-9">
										<input class="form-control" id="brand" name="brand"
											type="text" placeholder="Sponsor Name" required="required"
											value="<%=rs.getString("BRAND")%>">
									</div>
								</div>
								<div class="form-group row">
									<label class="col-3 col-form label" for="thumbnailURL">Thumbnail
										Image URL</label>
									<div class="col-lg-9">
										<input class="form-control" id="thumbnailURL"
											name="thumbnailURL" type="text" required="required"
											value="<%=rs.getString("IMAGE")%>" disabled>
									</div>
								</div>
								<div class="form-group row">
									<label class="col-3 col-form label" for="file">Thumbnail
										Image</label>
									<div class="col-lg-9">
										<input class="form-control file" id="thumbnail"
											name="thumbnail" type="file" placeholder="File..."
											required="required">
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
		function updateSponsor() {
			var idSponsor = $('#idBanner').val();
			var brand = $('#brand').val();
			var image = $('#thumbnail').val();

			$
					.ajax({
						url : '${pageContext.request.contextPath}/updateSponsorController',
						data : {
							action : 'updateSponsorDetails',
							idSponsor : idSponsor,
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
							} else {
								document.getElementById('alertFail').style.display = "block";
							}
						},
						error : function() {
							document.getElementById('alertFail').style.display = "block";
						}
					})
		}

		function updateStatus(strStatus) {
			var idSponsor = $('#idBanner').val();
			var status = "";

			if (strStatus == 'activate') {
				status = 'ACTIVE';
			} else if (strStatus == 'deactivate') {
				status = 'INACTIVE';
			}

			$
					.ajax({
						url : '${pageContext.request.contextPath}/updateSponsorController',
						data : {
							action : 'updateBannerStatus',
							idSponsor : idSponsor,
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
							document.getElementById('alertFail').style.display = "block";
						}
					})
		}

		function closeAlert(idAlert) {
			document.getElementById(idAlert).style.display = "none";
		}

		$('#btnCancel').click(function() {
			window.location.href = 'adminBanner.jsp';
		})
	</script>

</body>
</html>