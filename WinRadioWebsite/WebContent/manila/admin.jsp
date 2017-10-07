<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.win.radio.manila.utilities.TransactionLogOperations"%>
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
						<h1 class="float-left text-center text-md-left">Dashboard</h1>
					</div>
					
					<div class="dropdown user-dropdown col-md-6 col-lg-4 text-center text-md-right"><a class="btn btn-stripped dropdown-toggle" href="https://example.com" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<img src="img/profile-pic.jpg" alt="profile photo" class="circle float-left profile-photo" width="50" height="auto">
						
						<div class="username mt-1">
							<h4 class="mb-1">Username</h4>
							
							<h6 class="text-muted">Super Admin</h6>
						</div>
						</a>
						
						<div class="dropdown-menu dropdown-menu-right" style="margin-right: 1.5rem;" aria-labelledby="dropdownMenuLink"><a class="dropdown-item" href="#"><em class="fa fa-user-circle mr-1"></em> View Profile</a>
						     <a class="dropdown-item" href="#"><em class="fa fa-sliders mr-1"></em> Preferences</a>
						     <a class="dropdown-item" href="#"><em class="fa fa-power-off mr-1"></em> Logout</a></div>
					</div>
					
					<div class="clear"></div>
				</header>
				
				 
			     <!-- Modal start -->
				 <div id="modalChangePassword" class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
					 <div class="modal-dialog" role="document">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="exampleModalLabel">Change password:</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body">
					        <form>
					          <div class="form-group">
					            <label for="recipient-name" class="form-control-label">New password:</label>
					            <input type="text" class="form-control" id="newPassword1" name="newPassword1" required="required">
					          </div>
					          <div class="form-group">
					            <label for="message-text" class="form-control-label">Enter new password again:</label>
					            <input type="text" class="form-control" id="newPassword2" name="newPassword2" required="required">
					          </div>
					        </form>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-primary">Submit</button>
					      </div>
					    </div>
					 </div>
				</div>
				<!-- Modal end -->
		
				
				<!-- ROW START -->
				<div class="row">
					<div class="col-md-12 col-lg-8">
						<div class="row" id="iconStatsRow">
							<div class="col-lg-4 iconStats">asdsdf</div>
							<div class="col-lg-4 iconStats">asd</div>
							<div class="col-lg-4 iconStats">asd</div>
						</div>
					</div>
					 
					<div class="col-md-12 col-lg-4">
						<div class="card mb-4">
							<div class="card-block">
								<h3 class="card-title">Recent Activities</h3>
									<div class="list-group list-group-flush small">
					              	<%
									try{	
									ResultSet rs = new TransactionLogOperations().getTransactionLogs();
									while(rs.next()){
									
									%>
					                <a href="#" class="list-group-item list-group-item-action">
					                  <div class="media">
					                    <div class="col-sm-3 col-md-2" style="padding: 0;">
											<img src="img/profile-pic.jpg" alt="profile photo" class="circle profile-photo" style="width: 100%; max-width: 100px;">
										</div>
										<div class="col-sm-6 col-md-8">
					                    <div class="media-body">
					                      <%=rs.getString("EVENT") %>
					                      <div class="text-muted smaller"><%=rs.getString("CREATE_DATE") %></div>
					                    </div>
					                    </div>
					                  </div>
					                </a>
					                <%}
									rs.close();  
									} catch (Exception e) {
										System.out.print(e.getMessage());
									e.printStackTrace();
									}
									%>
					                <a href="#" class="list-group-item list-group-item-action">
					                  View all activity...
					                </a>
					              </div>
							</div>
						</div>
					</div>
				</div>
				<!-- ROW END -->
				
			</main>
			

		</div>
	
	
	</div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="../core-js/jquery-3.2.1.min.js"></script>
    <script src="../core-js/tether.min.js"></script>
    <script src="../core-js/bootstrap.min.js"></script>
    
    <script src="../core-js/chart.min.js"></script>
    <script src="../core-js/chart-data.js"></script>
    <script src="../core-js/easypiechart.js"></script>
    <script src="../core-js/easypiechart-data.js"></script>
    <script src="../core-js/bootstrap-datepicker.js"></script>
    <script src="custom-js/custom.js"></script>
    <script>
	window.onload = function () {

		$('#modalChangePassword').modal({backdrop: 'static', keyboard: false})  
		$('#modalChangePassword').modal('show');
	};
	</script>
    
	  </body>
</html>
