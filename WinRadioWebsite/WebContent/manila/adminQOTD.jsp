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
			
			<main class="col-xs-12 col-sm-8 offset-sm-4 col-lg-9 offset-lg-3 col-xl-10 offset-xl-2 pt-3 pl-4">
				<header class="page-header row justify-center">
					<div class="col-md-6 col-lg-8" >
						<h1 class="float-left text-center text-md-left">Post Question of the Day</h1>
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
				            <a href="adminUserMaintenance.jsp">DJ Question of the Day</a>
				          </li>
				          <li class="breadcrumb-item active">New Post</li>
				        </ol>
					</div>
				</div>
				
				
				<!-- Row start: table -->
				<div class="row justify-content-md-center">
					<div class="col-lg-8">
						<div class="card">
							<div class="card-block">
								<h3 class="card-title">Post new question</h3>
								
								<form id="formNewUser" class="form" method="post" 
										action="${pageContext.request.contextPath}/postDJQOTD">
										
									<div class="form-group row">
									  <label for="example-text-input" class="col-3 col-form-label">DJ Owner</label>
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
			var username=$("#username").val();// value in field email
			$.ajax({
	            url:'${pageContext.request.contextPath}/checkIfUsernameExists',
	            data:{username: username},
	            type:'get',
	            cache:false,
	            success:function(data){
	            	if ($.trim(data)) {
	            		var usernameField =  $('#username').get(0);    
	            		usernameField.setCustomValidity(data);
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
