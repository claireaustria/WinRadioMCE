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
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.win.radio.manila.utilities.AccountOperations"%>
<%@page import="com.win.radio.manila.utilities.ConnectionUtil"%>
<%@include file="nav.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8">
	
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="Win Radio website">
	<meta name="author" content="Win Radio 2017">
	
	<title>Win Radio Admin - User Maintenance</title>
	
	<!-- Import CSS files   
	================================================== -->
	<%@include file="admin-css-imports.jsp" %>

</head>
<body>
	<div class="container-fluid" id="wrapper">
		<div class="row">
			
			<main class="col-xs-12 col-sm-8 offset-sm-4 col-lg-9 offset-lg-3 col-xl-10 offset-xl-2 pt-3 pl-4">
				<header class="page-header row justify-center">
					<div class="col-md-6 col-lg-8" >
						<h1 class="float-left text-center text-md-left">User Maintenance</h1>
					</div>
					
					<!-- include headerSection Start-->
					<%@include file="headerSection.jsp" %>
					<!-- include headerSection End -->	
					
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
				
				<div class="row">
					<div class="col-lg-12">
						<div class="alert bg-success" id="alertAcctCreationSuccess" style="display:none;" role="alert">
							<em class="fa fa-check-circle mr-2"></em> Account creation successful!
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertAcctCreationSuccess')"></em></a>
						</div>
						<div class="alert bg-danger" id="alertAcctCreationFail" style="display:none;" role="alert">
							<em class="fa fa-minus-circle mr-2"></em> Something went wrong, please try again. 
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertAcctCreationFail')"></em></a>
						</div>
					</div>
				</div>
				
				
				<!-- Row start: create new user form -->
				<div class="row justify-content-md-center">
					<div class="col-lg-8">
						<div class="card">
							<div class="card-block">
								<h3 class="card-title">Create a new user</h3>
								
								<form id="formNewUser" class="form">
				      				<center><div class="form-group row">
									  <label id="lblMissingField" class="col-12 col-form-label" style="color:red; display:none;">Please fill out all fields.</label>
									  <label id="lblTakenEmail" class="col-12 col-form-label" style="color:red; display:none;">Email is already taken.</label>
									  <label id="lblTakenUsername" class="col-12 col-form-label" style="color:red; display:none;">Username is already taken.</label>
									  <label id="lblInvalidMobileNo" class="col-12 col-form-label" style="color:red;display:none;">Please enter an 11-digit mobile no.</label>
									</div>
									</center>
				      				<div class="form-group row">
									  <label for="example-text-input" class="col-3 col-form-label">First Name</label>
									  <div class="col-9">
									    <input class="form-control" id="firstName" name="firstName" type="text" placeholder="Jane" required="required">
									  </div>
									</div>
									<div class="form-group row">
									  <label for="example-text-input" class="col-3 col-form-label">Last Name</label>
									  <div class="col-9">
									    <input class="form-control" id="lastName" name="lastName" type="text" placeholder="Doe" required="required">
									  </div>
									</div>
									<div class="form-group row">
									  <label for="example-text-input" class="col-3 col-form-label">Gender</label>
									  <div class="col-9">
									  	<select class="form-control" id="gender" name="gender">
									  		<option value="Female">Female</option>
									  		<option value="Male">Male</option>
									    </select>
									  </div>
									</div>
		    						<div class="form-group row">
									  <label for="example-text-input" class="col-3 col-form-label">Account Type</label>
									  <div class="col-9">
									  	<select class="form-control" id="dropdownUserProfiles" name="codType" onblur="toggleScreenNameDiv()">
									  		<%ResultSet rs = null;
						            		Statement select = null;
						            		Connection conn = null;
						            		
						            		try{	 
						                 	conn = ConnectionUtil.getConnection();
						        			select = conn.createStatement();
						        			rs = select.executeQuery(AccountOperations.GET_ACCOUNT_TYPES);
						        				while(rs.next()) {
											%>
									      	<option value="<%=rs.getString("COD_TYPE") %>"><%=rs.getString("NAME") %></option>
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
									    </select>
									  </div>
									</div>
									<div class="form-group row" style="display:none;" id="divScreenName">
									  <label for="example-text-input" class="col-3 col-form-label">Screen Name</label>
									  <div class="col-9">
									    <input class="form-control" id="screenName" name="screenName" type="text" placeholder="DJ Name">
									  </div>
									</div>
									<div class="form-group row">
									  <label for="example-email-input" class="col-3 col-form-label">Email</label>
									  <div class="col-9">
									    <input class="form-control" id="email" name="email" type="email" required="required" placeholder="winradio@example.com" id="email">
									  </div>
									</div>
									<div class="form-group row">
									  <label for="example-text-input" class="col-3 col-form-label">Username</label>
									  <div class="col-9">
									    <input class="form-control" id="username" name="username" type="text" placeholder="janedoe" required="required">
									  </div>
									</div>
									<div class="form-group row">
									  <label for="example-tel-input" class="col-3 col-form-label">Mobile No.</label>
									  <div class="col-9">
									    <input class="form-control" id="mobileNo" name="mobileNo" type="number" required="required" placeholder="(09xx)xxxxxx">
									  </div>
									</div>
									
									<!-- Form actions -->
									<div class="form-group">
										<div class="col-12 widget-right no-padding">
											<button type="button" class="btn btn-primary btn-md float-right" onclick="addNewAccount()">Submit</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<!-- Row end: create new user form -->
				
				<br />
					
			</main>
			

		</div>
	
	
	</div>

	<!-- Import JavaScript
	================================================== -->
	<%@include file="admin-js-imports.jsp" %>
	
    <script type="text/javascript">
		
		function checkIfValidMobileNo() {
			var mobileNo=$("#mobileNo").val();
			if (mobileNo.length != 11) {
				   return 'error';
			}
		}
		
	    function validateForm()
	    {
	    	var firstName=$("#firstName").val();
	    	var lastName=$("#lastName").val();
	    	var screenName=$("#screenName").val();
	    	var email=$("#email").val();
	    	var username=$("#username").val();
	    	var mobileNo=$("#mobileNo").val();
	    	var acctType=$("#dropdownUserProfiles").val();
	    	
	    	if (acctType == 'PROFILE003') {
	    		if ($.trim(firstName) == '' || $.trim(lastName) == '' || $.trim(screenName) == '' || $.trim(email) == '' || $.trim(username) == '' || $.trim(mobileNo) == '') {
	    			return false;
	    		}
	    	} else {
	    		if ($.trim(firstName) == '' || $.trim(lastName) == '' || $.trim(email) == '' || $.trim(username) == '' || $.trim(mobileNo) == '') {
	    			return false;
	    		}
	    	}
	    	
	    	return true;
	    }
		
		function addNewAccount() {
			document.getElementById('lblTakenEmail').style.display = "none";
			document.getElementById('lblTakenUsername').style.display = "none";
			document.getElementById('lblInvalidMobileNo').style.display = "none";
			document.getElementById('lblMissingField').style.display = "none";
			
			if (!validateForm()) {
				document.getElementById('lblTakenEmail').style.display = "none";
				document.getElementById('lblTakenUsername').style.display = "none";
				document.getElementById('lblInvalidMobileNo').style.display = "none";
				document.getElementById('lblMissingField').style.display = "block";
				return false;
			}
			
			var email=$("#email").val();// value in field email
			$.ajax({
	            url:'${pageContext.request.contextPath}/checkIfValueExists',
	            data:{username: '0', email: email, idAccount: '0'},
	            type:'get',
	            cache:false,
	            success:function(data){
	            	if ($.trim(data)) {
	            		document.getElementById('lblTakenEmail').style.display = "block";
	            		returnFalse();
	            	} 
	            },
	            error:function(){
	              alert('error');
	            }
			});
			
			var username=$("#username").val();// value in field username
			$.ajax({
	            url:'${pageContext.request.contextPath}/checkIfValueExists',
	            data:{username: username, email: '0', idAccount: '0'},
	            type:'get',
	            cache:false,
	            success:function(data){
	            	if ($.trim(data)) {
	            		document.getElementById('lblTakenUsername').style.display = "block";
	            		returnFalse();
	            	}
	            },
	            error:function(){
	              alert('error');
	            }
			});
			
			if(checkIfValidMobileNo() == 'error') {
				document.getElementById('lblMissingField').style.display = "none";
				document.getElementById('lblTakenEmail').style.display = "none";
				document.getElementById('lblTakenUsername').style.display = "none";
				document.getElementById('lblInvalidMobileNo').style.display = "block";
				return false;
			}
			
			var firstName=$("#firstName").val();
	    	var lastName=$("#lastName").val();
	    	var gender=$("#gender").val();
	    	var acctType=$("#dropdownUserProfiles").val();
	    	var screenName=$("#screenName").val();
	    	var email=$("#email").val();
	    	var username=$("#username").val();
	    	var mobileNo=$("#mobileNo").val();
			
			$.ajax({
	            url:'${pageContext.request.contextPath}/createUserController',
	            data:{firstName: firstName, lastName: lastName, gender: gender, codType: acctType, screenName: screenName, email: email, username: username, mobileNo: mobileNo},
	            type:'post',
	            cache:false,
	            success:function(data){
	            	if ($.trim(data) == 'success') {
	            		document.getElementById('alertAcctCreationSuccess').style.display = "block";
	            	} else {
	            		document.getElementById('alertAcctCreationFail').style.display = "block";
	            	}
	            },
	            error:function(){
	              alert('error');
	            }
			});
		}
		
		$('#dropdownUserProfiles').on('change',function(){
			   var selection = $(this).val();
			   if (selection == 'PROFILE003') {
			       $('#divScreenName').show();
			   } else {
				   $('#divScreenName').hide();
			   }
		});
		
		function returnFalse() {
			return false;
		}
		
		
		function closeAlert(idAlert) {
			document.getElementById(idAlert).style.display = "none";
		}
	</script>
   
</body>
</html>
