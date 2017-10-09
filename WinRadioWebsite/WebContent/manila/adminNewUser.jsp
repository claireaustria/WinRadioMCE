<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.win.radio.manila.utilities.AccountOperations"%>
<%@include file="nav.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8">
	
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="Win Radio website">
	<meta name="author" content="Win Radio 2017">
	
	<title>Win Radio Admin - User Maintenance</title>
	
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
						<h1 class="float-left text-center text-md-left">User Maintenance</h1>
					</div>
					
					<div class="dropdown user-dropdown col-md-6 col-lg-4 text-center text-md-right"><a class="btn btn-stripped dropdown-toggle" href="https://example.com" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<img src="img/profile-pic.jpg" alt="profile photo" class="circle float-left profile-photo" width="50" height="auto">
						
						<div class="username mt-1">
							<h4 class="mb-1">Username</h4>
							
							<h6 class="text-muted">Super Admin</h6>
						</div>
						</a>
						
						<div class="dropdown-menu dropdown-menu-right" style="margin-right: 1.5rem;" aria-labelledby="dropdownMenuLink"><a class="dropdown-item" href="#"><em class="fa fa-user-circle mr-1"></em> View Profile</a>
						    <a class="dropdown-item" href="#"><em class="fa fa-power-off mr-1"></em> Logout</a></div>
					</div>
					
					<div class="clear"></div>
				</header>
				
				<div class="row">
					<div class="col-lg-12">
						<!-- Breadcrumbs -->
				        <ol class="breadcrumb">
				          <li class="breadcrumb-item">
				            <a href="adminUserMaintenance.jsp">User List</a>
				          </li>
				          <li class="breadcrumb-item active">Create New User</li>
				        </ol>
					</div>
				</div>
				
				
				<!-- Row start: table -->
				<div class="row justify-content-md-center">
					<div class="col-lg-8">
						<div class="card">
							<div class="card-block">
								<h3 class="card-title">Create a new user</h3>
								
								<form id="formNewUser" class="form" method="post" action="${pageContext.request.contextPath}/createUserController">
				      				<div class="form-group row">
									  <label for="example-text-input" class="col-3 col-form-label">First Name</label>
									  <div class="col-9">
									    <input class="form-control" name="firstName" type="text" placeholder="Jane" required="required">
									  </div>
									</div>
									<div class="form-group row">
									  <label for="example-text-input" class="col-3 col-form-label">Last Name</label>
									  <div class="col-9">
									    <input class="form-control" name="lastName" type="text" placeholder="Doe" required="required">
									  </div>
									</div>
									<div class="form-group row">
									  <label for="example-text-input" class="col-3 col-form-label">Gender</label>
									  <div class="col-9">
									  	<select class="form-control" name="gender">
									  		<option value="Female">Female</option>
									  		<option value="Male">Male</option>
									    </select>
									  </div>
									</div>
		    						<div class="form-group row">
									  <label for="example-text-input" class="col-3 col-form-label">Account Type</label>
									  <div class="col-9">
									  	<select class="form-control" id="dropdownUserProfiles" name="codType">
									  		<%
											try{	
											ResultSet rs = new AccountOperations().getAccountTypes();
											while(rs.next()){
											%>
									      	<option value="<%=rs.getString("COD_TYPE") %>"><%=rs.getString("NAME") %></option>
									      	<%}
											rs.close();  
											} catch (Exception e) {
												System.out.print(e.getMessage());
											e.printStackTrace();
											}
											%>
									    </select>
									  </div>
									</div>
									<div class="form-group row" style="display:none;" id="divScreenName">
									  <label for="example-text-input" class="col-3 col-form-label">Screen Name</label>
									  <div class="col-9">
									    <input class="form-control" name="screenName" type="text" placeholder="DJ Name">
									  </div>
									</div>
									<div class="form-group row">
									  <label for="example-email-input" class="col-3 col-form-label">Email</label>
									  <div class="col-9">
									    <input class="form-control" name="email" type="email" required="required" placeholder="winradio@example.com" id="email" onchange="checkIfEmailExists()">
									  </div>
									</div>
									<div class="form-group row">
									  <label for="example-text-input" class="col-3 col-form-label">Username</label>
									  <div class="col-9">
									    <input class="form-control" id="username" name="username" type="text" placeholder="janedoe" required="required" onchange="checkIfUsernameExists()">
									  </div>
									</div>
									<div class="form-group row">
									  <label for="example-tel-input" class="col-3 col-form-label">Mobile No.</label>
									  <div class="col-9">
									    <input class="form-control" name="mobileNo" type="number" required="required" placeholder="(09xx)xxxxxx" pattern="[0-9]{}" title="11-digit mobile no" maxlength = "11"
									    oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);" id="example-tel-input">
									  </div>
									</div>
									
									<!-- Form actions -->
									<div class="form-group">
										<div class="col-12 widget-right no-padding">
											<button type="submit" class="btn btn-primary btn-md float-right">Submit</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<!-- Row end: table -->
				
				<br />
					
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
		function checkIfUsernameExists(){
			var username=$("#username").val();// value in field username
			$.ajax({
	            url:'${pageContext.request.contextPath}/checkIfValueExists',
	            data:{username: username, email: '0'},
	            type:'get',
	            cache:false,
	            success:function(data){
	            	if ($.trim(data)) {
	            		var usernameField =  $('#username').get(0);    
	            		usernameField.setCustomValidity(data);
	            	} else {
	            		var usernameField =  $('#username').get(0);   
	            		usernameField.setCustomValidity('');
	            	}
	            },
	            error:function(){
	              alert('error');
	            }
			});
		}
		
		function checkIfEmailExists(){
			var email=$("#email").val();// value in field email
			$.ajax({
	            url:'${pageContext.request.contextPath}/checkIfValueExists',
	            data:{username: '0', email: email},
	            type:'get',
	            cache:false,
	            success:function(data){
	            	if ($.trim(data)) {
	            		var emailField =  $('#email').get(0);    
	            		emailField.setCustomValidity(data);
	            	} else {
	            		var emailField =  $('#email').get(0);   
	            		emailField.setCustomValidity('');
	            	}
	            },
	            error:function(){
	              alert('error');
	            }
			});
		}
	</script>
   
</body>
</html>
