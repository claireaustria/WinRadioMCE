<!-- Prevent Access to the page without logging in -->
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
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.win.radio.manila.utilities.PSOperations"%>
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
						<h1 class="float-left text-center text-md-left">Program Schedule</h1>
					</div>
					
					<!-- include headerSection Start-->
					<%@include file="headerSection.jsp" %>
					<!-- include headerSection End -->	
					
					<div class="clear"></div>
				</header>
				
				<!-- Create Button -->
				<div class="row">
					<div class="col-lg-12">
						<button type="submit" class="btn btn-primary btn-md float-right btn-options">Create Program</button>
					</div>
				</div>
				
				<br />
				
				<!-- Program Name And Schedule-->		
				<form id="formProgramSchedule" class="form" method="post" action="">	
					<div class="row">
						<div class="col-lg-7">
							<div class="card">
								<div class="card-block">
									<h3 class="card-title">Program Information</h3>
									<h6 class="card-subtitle mb-2 text-muted">This will be displayed on 'Program Schedule' page</h6>								
									
										<div class="form-group">
											<label class="col-7 control-label no-padding" for="program name">Program Name</label>
											<div class="col-12 no-padding">
												<input class="form-control" name="programname" type="text" placeholder="" required="required">
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-lg-7 control-label no-padding" for="program schdedule">Program Schedule</label>
											<div class="col-12 no-padding">
												<textarea class="form-control" id="programschedule" name="programschdedule" placeholder="" required="required" rows="6"></textarea>
											</div>
										</div>
										
								</div>
							</div>
						</div>
						
						<div class="col-lg-5">
							<div class="card">
								<div class="card-block">
									<div class="card-body">
										<div class="table-responsive">
											<table class="table table-bordered" width="" id="dataTable" cellspacing="0">
											<thead>
												<tr>
													<th>DJ NAME</th>
													<th>INCLUDE DJ</th>
												</tr>
											</thead>
											<tbody>
												<%
												ResultSet rs = null;
												Statement select = null;
												Connection conn = null;
												
												try{
													conn =	 ConnectionUtil.getConnection();
													select = conn.createStatement();
													rs = select.executeQuery(PSOperations.GET_DJ_NAME);
													while(rs.next()){
												%>
												<tr class="clickableROw">
													<td><%=rs.getString("DJ_NAME")%></td>
													<td><input type="checkbox" name="djid" value="<%=rs.getInt("ID_ACCOUNT")%>"></input></td>
												</tr>	
												<%
													}
												}catch(Exception ex)
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
											</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
				<!--Program DJ-->
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