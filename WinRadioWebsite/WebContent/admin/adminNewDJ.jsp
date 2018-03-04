<!-- Prevent Access to the page without logging in -->
<%@page import="com.win.radio.manila.utilities.DJListCommands"%>
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

<title>Win Radio Admin - DJ Maintenance</title>

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
				<h1 class="float-left text-center text-md-left">DJ Maintenance</h1>
			</div>

			<!-- include headerSection Start--> <%@include
				file="headerSection.jsp"%> <!-- include headerSection End -->

			<div class="clear"></div>
			</header>

			<div class="row">
				<div class="col-lg-12">
					<div class="alert bg-success" id="alertUpdateSuccess" style="display:none;" role="alert">
						<em class="fa fa-check-circle mr-2"></em> <%=CodeUtil.STATUS_MSG_SAVED %>
						<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertUpdateSuccess')"></em></a>
					</div>
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

					<div class="alert bg-danger" id="alertMissingField"
						style="display: none;" role="alert">
						<em class="fa fa-minus-circle mr-2"></em> Please fill up all
						fields. <a href="#" class="float-right"><em
							class="fa fa-remove" onclick="closeAlert('alertMissingField')"></em></a>
					</div>
				</div>
			</div>
			
			<%ResultSet rs = null;
        	PreparedStatement pstmt = null;
        	Connection conn = null;
        		
        	int idDJ = Integer.valueOf(request.getParameter("idDJ"));
        	String userAction = String.valueOf(request.getParameter("userAction"));
        	String strDJName = "";
        	String strDescription = "";
        	
        	try{	 
              	conn = ConnectionUtil.getConnection();
 				pstmt = conn.prepareStatement(DJListCommands.GET_ALL_DJ);
             	pstmt.setInt(1, idDJ);
             	pstmt.setString(2, String.valueOf(session.getAttribute("codRegion")));
             	pstmt.setInt(3, idDJ);
             	pstmt.setString(4, String.valueOf(session.getAttribute("codRegion")));
             	rs = pstmt.executeQuery();
 				
 				while (rs.next()) {
 					strDJName = rs.getString("DJ_NAME");
 					strDescription = rs.getString("DESCRIPTION");
 				}
			%>

			<div class="row justify-content-md-center">
				<div class="col-lg-8">
					<div class="card">
						<div class="card-block">
							<%if (idDJ == 0) {%>
								<h3 class="card-title">Add New DJ</h3>
							<%} else { %>
								<h3 class="card-title">Update DJ Profile</h3>
							<%} %>
							<br>
							<form action="${pageContext.request.contextPath}/fileUpload"
								method="post">
								<center></center>
								<div class="form-group" style="display:none;">
								        <label for="message-text" class="form-control-label">ID DJ:</label>
								        <input type="text" class="form-control" id="idDJ" required="required" value="<%=idDJ%>">
								</div>	
								<div class="form-group" style="display:none;">
								        <label for="message-text" class="form-control-label">User Action:</label>
								        <input type="text" class="form-control" id="userAction" required="required" value="<%=userAction%>">
								</div>	
								<div class="form-group row">
									  <label class="col-3 col-form-label">Jock Name</label>
									  <div class="col-9">
									    <input class="form-control" id="djName" name="djName" type="text" placeholder="" 
									    required="required" value="<%=strDJName%>">
									  </div>
								</div>
								<div class="form-group row">
									  <label for="example-text-input" class="col-3 col-form-label">Jock Description</label>
									  <div class="col-9">
											<textarea class="form-control" id="description" name="description" rows="3" ><%=strDescription%></textarea>
										</div>
								</div>
								<div class="form-group row">
									<label class="col-3 col-form label" for="file">Image</label>
									<div class="col-lg-9">
										<input class="form-control file" id="image" name="image"
											type="file" placeholder="File...">
									</div>
								</div>
								<div class="form-group row">
									<div class="col-lg-12">
										<%if (idDJ == 0) {%>
										<button type="button"
											class="btn btn-primary btn-sm float-right"
											onclick="addDJ()">Submit</button>
										<%} else { %>
										<button type="button"
											class="btn btn-primary btn-sm float-right"
											onclick="updateDJ()">Save</button>
										<%} %>
										<a href="adminDJMaintenance.jsp">
											<button type="button"
												class="btn btn-sm btn-primary float-right btn-options">
												Cancel
											</button>
										</a>
									</div>
								</div>
							</form>

						</div>
					</div>
				</div>
			</div>
			
			<%	
           		} catch(Exception ex)
           		{
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

			</main>

		</div>

	</div>

	<!-- Import JavaScript
	================================================== -->
	<%@include file="admin-js-imports.jsp"%>

	<script type="text/javascript">
		function addDJ() {

			document.getElementById('alertSuccess').style.display = "none";
			document.getElementById('alertFail').style.display = "none";
			document.getElementById('alertMissingField').style.display = "none";
			
			var djName = $('#djName').val();
			var description = $('#description').val();
			var idDJ=$("#idDJ").val();
			var userAction=$("#userAction").val();

			if ($.trim(djName) != "" && $.trim(description) != "") {
				$.ajax({
					url : '${pageContext.request.contextPath}/updateDJListController',
					data : {
						djName : djName,
						description : description,
						action: 'createDJ'
					},
					type : 'post',
					cache : false,
					success : function(data) {
						if ($.trim(data) == 'success') {
							document.getElementById('alertSuccess').style.display = "block";
							if (userAction == 'createAccount') {
								setTimeout(function() {
									window.location.href='adminNewUser.jsp';
								}, 2000);
							}
						} else if ($.trim(data) == 'fail') {
							document.getElementById('alertFail').style.display = "block";
						}
					},
					error : function() {
						document.getElementById('alertFail').style.display = "block";
					}
				});
			} else {
				document.getElementById('alertMissingField').style.display = "block";
			}

		}
		
		function updateDJ() {
			document.getElementById('alertSuccess').style.display = "none";
			document.getElementById('alertFail').style.display = "none";
			document.getElementById('alertMissingField').style.display = "none";
			
			var idDJ=$("#idDJ").val();
			var djName = $('#djName').val();
			var description=$("#description").val();
			
			if ($.trim(idDJ) != "" && $.trim(description) != "") {
				$.ajax({
		            url:'${pageContext.request.contextPath}/updateDJListController',
		            data:{idDJ: idDJ, description: description, djName: djName, action: 'updateDJ'},
		            type:'post',
		            cache:false,
		            success:function(data){
		            	if ($.trim(data) == 'success') {
		            		document.getElementById('alertUpdateSuccess').style.display = "block";
		            	} else {
		            		document.getElementById('alertFail').style.display = "block";
		            	}
		            },
		            error:function(){
		            	document.getElementById('alertFail').style.display = "block";
		            }
				});
			} else {
				document.getElementById('alertMissingField').style.display = "block";
			}
		}

		function closeAlert(idAlert) {
			document.getElementById(idAlert).style.display = "none";
		}
	</script>

</body>
</html>
