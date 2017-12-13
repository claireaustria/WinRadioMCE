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
<%@page import="com.win.radio.manila.utilities.DramaOperations"%>
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

<title>Win Radio - Heart Stories</title>

	<!-- Import CSS files   
	================================================== -->
	<%@include file="admin-css-imports.jsp" %>

<style>
#dataTable_wrapper {
	padding: 20px 15px 20px 15px;
	margin: 5px;
}

.highlight {
	background: #F0F0F0;
}

.clickableRow:hover {
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="container-fluid" id="wrapper">
		<div class="row">

			<main
				class="col-xs-12 col-sm-8 offset-sm-4 col-lg-9 offset-lg-3 col-xl-10 offset-xl-2 pt-3 pl-4">
			<header class="page-header row justify-center">
			<div class="col-md-6 col-lg-8">
				<h1 class="float-left text-center text-md-left">Heart Stories
					Maintenance</h1>
			</div>

			<!-- include usernameSection Start--> <%@include
				file="headerSection.jsp"%> <!-- include sernameSection End -->

			<div class="clear"></div>
			</header> <!-- Alert confirmation start -->
			<div class="row">
				<div class="col-lg-12">
					<div class="alert bg-warning" id="alertNoSelected"
						style="display: none;" role="alert">
						<em class="fa fa-minus mr-2"></em> Please select an entry to
						modify. <a href="#" class="float-right"><em
							class="fa fa-remove" onclick="closeAlert('alertNoSelected')"></em></a>
					</div>
				</div>
			</div>
			<!-- Alert confirmation end --> <!-- Buttons -->

			<div class="row">
				<div class="col-lg-12">
					<button type="submit"
						class="btn btn-primary btn-sm float-right btn-options"
						id="btnNewDrama">Post New Episode</button>
					<button type="submit"
						class="btn btn-primary btn-sm float-right btn-options"
						id="btnModifyDrama">Modify Details</button>
				</div>
			</div>

			<br />

			<!-- Users table -->
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" width="100%" id="dataTable"
									cellspacing="0">
									<thead>
										<tr>
											<th style="display: none;">ID Account</th>
											<th>Date Created</th>
											<th>Posted By</th>
											<th>Title</th>
											<th>Status</th>
											<th>Date Modified</th>
										</tr>
									</thead>
									<tbody>
										<%
											ResultSet rs = null;
											Connection conn = null;
											PreparedStatement pstmt = null;
											
											String status;
											
											try {
												conn = ConnectionUtil.getConnection();
												pstmt = conn.prepareStatement(DramaOperations.GET_ALL_DRAMA);
												pstmt.setString(1, String.valueOf(session.getAttribute("codRegion")));
												rs = pstmt.executeQuery();
												
												while (rs.next()) {
													if (rs.getString("STATUS").equals("0")) {
														status = "Inactive";
													} else {
														status = "Active";
													}
												
										%>
										<tr class="clickableRow">
											<td style="display: none;"><%=rs.getString("ID_EPISODE")%></td>
											<td><%=rs.getString("DATE_POSTED")%></td>
											<td><%=rs.getString("USERNAME")%></td>
											<td><%=rs.getString("TITLE")%></td>
											<td><%=status%></td>
											<td><%=rs.getString("UPDATE_DATE")%></td>
										</tr>
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
										%>
									</tbody>
								</table>
								
								<!-- Hidden span to store ID  -->
								<span id="currentRow" style="display: none;"></span>
							</div>
						</div>
					</div>
				</div>
			</div>

			</main>
		</div>


	</div>

	<!-- Import JavaScript
	================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<%@include file="admin-js-imports.jsp" %>

	<script type="text/javascript">
	$(function() {

		var table = $('#dataTable').DataTable();
    	
    	$('#dataTable tbody').on( 'click', 'tr', function () {
            if ( $(this).hasClass('highlight') ) {
                $(this).removeClass('highlight');
                
                //Get the first column - hidden ID account
                var row = $(this);
                var idAccount = row.find('td:eq(0)').text();
                var span = document.getElementById("currentRow");
                span.textContent = "";
            }
            else {
                table.$('tr.highlight').removeClass('highlight');
                $(this).addClass('highlight'); var row = $(this);

                //Get the first column - hidden ID account
                var idAccount = row.find('td:eq(0)').text();
                var span = document.getElementById("currentRow");
                span.textContent = idAccount;
            }
        } );   

	});
	
	/*Page redirect*/
	$('#btnNewDrama').click(function() {
		window.location.href = 'adminNewDrama.jsp';
	})
	
	/*Page redirect*/
		$('#btnModifyDrama')
				.click(
						function() {
							var span = document.getElementById("currentRow");
							var spanText = span.textContent;
							if ($.trim(spanText) != "") {
								window.location.href = 'adminUpdateDrama.jsp?idDramaModify='
										+ spanText;
							} else {
								document.getElementById('alertNoSelected').style.display = "block";
							}
						})
	
	function closeAlert(idAlert) {
			document.getElementById(idAlert).style.display = "none";
		}
	
	function modifyDrama(idDramaModify) {
		
	}
	
	</script>


</body>
</html>
