<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="com.win.radio.manila.utilities.TransactionLogCommands"%>
<%@page import="com.win.radio.manila.utilities.CodeUtil"%>
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

<%@page import="com.win.radio.manila.utilities.TransactionLogOperations"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
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
	
    <!-- Import CSS files
    ================================================== -->
	<%@include file="admin-css-imports.jsp" %>
    
    <style type="text/css">
    	.card-body-icon {
			position: absolute;
			z-index: 0;
			top: -10px;
			right: -25px;
			font-size: 5rem;
			-webkit-transform: rotate(15deg);
			-ms-transform: rotate(15deg);
			transform: rotate(15deg);
		}
		
		.card-header {
			height: 12%;
		}
    </style>
</head>
<body>
	<div class="container-fluid" id="wrapper">
		<div class="row">
			
			<main class="col-xs-12 col-sm-8 offset-sm-4 col-lg-9 offset-lg-3 col-xl-10 offset-xl-2 pt-3 pl-4">
				<header class="page-header row justify-center">
					<div class="col-md-6 col-lg-8" >
						<h1 class="float-left text-center text-md-left">Dashboard</h1>
					</div>
					
					<!-- include headerSection Start-->
					<%@include file="headerSection.jsp" %>
					<!-- include headerSection End -->	
					
					<div class="clear"></div>
				</header>
				 
				<!-- Check of IndexChangePWD start-->
				<%
				try{
				 	if((Integer)session.getAttribute("indChangePwd") == 1){
				%>
				 
			    <!-- Modal start -->
				<div id="modalChangePassword" class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
					 <div class="modal-dialog" role="document">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="exampleModalLabel">Change password:</h5>
					        <button type="button" id="btnModalClose" class="close" style="display:none;" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body">
					        <form>
					          <div class="form-group">
					            <label for="recipient-name" class="form-control-label">New password:</label>
					            <input type="password" class="form-control" id="password1" name="password1" required="required">
					          </div>
					          <div class="form-group">
					            <label for="message-text" class="form-control-label">Enter new password again:</label>
					            <input type="password" class="form-control" id="password2" name="password2" required="required">
					          </div>
					          <div class="form-group">
					            <label for="message-text" id="diffPwdLabel" class="form-control-label" style="display: none; color:red;">Both passwords should be the same.</label>
					          </div>
					          <div class="form-group">
					            <label for="message-text" id="lblChangePwdSuccess" class="form-control-label" style="display: none; color:green;">Password changed successfully.</label>
					          </div>
					          <div class="form-group">
					            <label for="message-text" id="lblError" class="form-control-label" style="display: none; color:red;">Something went wrong, please try again.</label>
					          </div>
					        </form>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-primary" onclick="changePassword()">Submit</button>
					      </div>
					    </div>
					 </div>
				</div>
				<!-- Modal end -->
				
				<%	}
				}
				 catch(Exception e){
					 System.out.print(e.getMessage());
					 e.printStackTrace();
				}
				%>
				<!--Check of IndexChangePWD end-->
		
				
				<!-- ROW START -->
				<div class="row">
					
					
					<%if (strAcctType.equals(CodeUtil.COD_TYPE_ADMIN) || strAcctType.equals(CodeUtil.COD_TYPE_CONTENT_MANAGER)) { %>
					<div class="col-lg-8">
					<%} else { %>
					<div class="col-lg-12">
					<%} %>
						<section class="row">
							<div class="col-lg-12">
								<div class="jumbotron">
									<h1 class="mb-4">Hello, <%=session.getAttribute("firstName")%>!</h1>
									<p class="lead">Welcome to the admin page of Win Radio PH. 
										<%if (strAcctType.equals(CodeUtil.COD_TYPE_DJ)) { %>
										 What do you want to do today?
										<%} %>
									</p>		
								</div>
							</div>
						</section>
						
						<%if (strAcctType.equals(CodeUtil.COD_TYPE_ADMIN) || strAcctType.equals(CodeUtil.COD_TYPE_CONTENT_MANAGER)) { %>
						<!-- Card statistics start -->
						<section class="row">
							<div class="col-lg-4">
								<div class="card card-inverse card-info">
									<div class="card-header">
										<div class="card-body-icon">
						                  <i class="fa fa-fw fa-globe"></i>
						                </div>126 Site Views <br />Today
					                </div>
									
									<a href="#" class="card-footer text-white clearfix small z-1">
						                <span class="float-left">View Details</span>
						                <span class="float-right">
						                  <i class="fa fa-angle-right"></i>
						                </span>
					              	</a>
								</div>
							</div>
							
							<%ResultSet resultSet = null;
		            		PreparedStatement pstmt = null;
		            		Connection connection = null;
		            		
		            		try{	 
		            		connection = ConnectionUtil.getConnection();
		                 	pstmt = connection.prepareStatement(TransactionLogCommands.GET_DAILY_TRANSACTION_LOG_COUNT);
		                 	
		                 	String timeStamp = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
		                 	
		                 	pstmt.setString(1, timeStamp);
		                 	pstmt.setString(2, CodeUtil.COD_REGION_MNL);
		                 	resultSet = pstmt.executeQuery();
		        				while(resultSet.next()) {
							%>
							<div class="col-lg-4">
								<div class="card card-inverse card-warning">
									<div class="card-header">
										<div class="card-body-icon">
						                  <i class="fa fa-fw fa-tasks"></i>
						                </div><%=resultSet.getString("TRANSACTION_COUNT") %> User Activities<br /> Today
					                </div>
									
									<a href="#" class="card-footer text-white clearfix small z-1">
						                <span class="float-left">View Details</span>
						                <span class="float-right">
						                  <i class="fa fa-angle-right"></i>
						                </span>
					              	</a>
								</div>
							</div>
							<%	}
		            		} catch(Exception ex)
		            		{
		            			ex.printStackTrace();
		            		} finally {
		            			if (resultSet != null) {
		            				try {
		            					resultSet.close();
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
		            			if (connection != null) {
		            				try {
		            					connection.close();
		            				} catch (SQLException e) {
		            					e.printStackTrace();
		            				}
		            			}
		            		}
							%>
											
							<div class="col-lg-4">
								<div class="card card-inverse card-success">
									<div class="card-header">
										<div class="card-body-icon">
						                  <i class="fa fa-fw fa-globe"></i>
						                </div>126 Site Views <br />Today
					                </div>
									
									<a href="#" class="card-footer text-white clearfix small z-1">
						                <span class="float-left">View Details</span>
						                <span class="float-right">
						                  <i class="fa fa-angle-right"></i>
						                </span>
					              	</a>
								</div>
							</div>
						</section>
						<!-- Card statistics end -->
						<%} %>
					</div>
					
					<%if (strAcctType.equals(CodeUtil.COD_TYPE_ADMIN) || strAcctType.equals(CodeUtil.COD_TYPE_CONTENT_MANAGER)) { %>
					<!-- User activity start -->
					<div class="col-lg-4">
						<div class="card mb-4">
							<div class="card-block">
								<h3 class="card-title">Recent Activities</h3>
									<div class="list-group list-group-flush small">
					              	<%ResultSet rs = null;
				            		Statement select = null;
				            		Connection conn = null;
				            		
				            		try{	 
				                 	conn = ConnectionUtil.getConnection();
				        			select = conn.createStatement();
				        			rs = select.executeQuery(TransactionLogOperations.GET_TRANSACTION_LOGS);
				        			
				        				while(rs.next()) {
									%>
					                <a href="#" class="list-group-item list-group-item-action">
					                  <div class="media">
					                    <div class="col-sm-3 col-md-2" style="padding: 0;">
											<img src="img/profile-pic.jpg" alt="profile photo" class="circle profile-photo" style="width: 100%; max-width: 100px;">
										</div>
										<div class="col-sm-6 col-md-10">
					                    <div class="media-body">
					                      <%=rs.getString("EVENT") %>
					                      <div class="text-muted smaller"><%=rs.getString("CREATE_DATE") %></div>
					                    </div>
					                    </div>
					                  </div>
					                </a>
					                <%	}
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
					                <a href="#" class="list-group-item list-group-item-action">
					                  View all activity...
					                </a>
					              </div>
							</div>
						</div>
					</div>
					<!-- User activity end -->
					<%} %>
				</div>
				<!-- ROW END -->
				
			</main>
			

		</div>
	
	
	</div>

    <!-- Import JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<%@include file="admin-js-imports.jsp" %>
    
    
    <script>
	window.onload = function () {
		$('#modalChangePassword').modal({backdrop: 'static', keyboard: false});
		$('#modalChangePassword').modal('show');
	};
	
	function changePassword() {
		var password1=$("#password1").val();
		var password2=$("#password2").val();
		var diffPwdLabel = document.getElementById('diffPwdLabel');
		
		if (password1 != password2) {
			diffPwdLabel.style.display = "block";
		} else {
			diffPwdLabel.style.display = "none";
			
			$.ajax({
	            url:'${pageContext.request.contextPath}/changePasswordController',
	            data:{password1: password1, password2: password2},
	            type:'post',
	            cache:false,
	            success:function(data){
	            	if ($.trim(data) == 'success') {
	            		document.getElementById('lblChangePwdSuccess').style.display = "block";
	            		document.getElementById('btnModalClose').style.display = "block";
	            	} else if ($.trim(data) == 'fail') {
	            		var diffPwdLabel = document.getElementById('lblError');
	            		diffPwdLabel.style.display = "block";
	            	}
	            },
	            error:function(){
	              alert('error');
	            }
			});
		}
	}
	</script>
    
	  </body>
</html>
