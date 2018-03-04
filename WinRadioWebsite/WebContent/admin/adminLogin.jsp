<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
  	<meta charset="UTF-8">
  	<title>Win Radio Admin Login</title>

	<!--Fonts-->
	<link href="../../fonts/fonts.css" rel="stylesheet">
	  
	<!-- Icons -->
	<link href="../../core-css/font-awesome.css" rel="stylesheet">
	
	<link rel="stylesheet" href="custom-css/login-style.css?version=51">
  	
</head>

<body>
  <div class="login-form">
  	 <center>
	     <img src="img/logo-circle-gray-100px.jpg" id="logo" alt="Win Radio" />
	 </center>
     <form id="formNewUser" class="form">
	     <div class="form-group log-status" id="logStatUname">
	       <input type="text" class="form-control" placeholder="Username" autocomplete="off" id="username" required="required">
	       <i class="fa fa-user"></i>
	     </div>
	     <div class="form-group log-status" id="logStatPwd">
	       <input type="password" class="form-control" placeholder="Password" id="password" required="required">
	       <i class="fa fa-lock"></i>
	     </div>
	     <div class="form-group log-status" id="logStatPwd">
	     	<span class="alert" id="alertBlankUsername">Please input username</span>
		    <span class="alert" id="alertBlankPassword">Please input password</span>
		    <span class="alert" id="alertUsername">Incorrect username</span>
		    <span class="alert" id="alertPassword">Incorrect password</span>
		    <a class="link" href="#">Forgot your password?</a>
	     </div>
	     <div class="form-group">
	     	<button type="button" class="log-btn" id="btnLogin" onclick="login()">Log in</button>
	     </div>
	    
     </form>
     
    
   </div>
  	<!-- Import JavaScript
	================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<%@include file="admin-js-imports.jsp" %>
    
    <script type="text/javascript">
    function login(){
    		var user=$('#username').val();
            var pwd=$('#password').val();
            if (!$.trim(user)) {
            	$('.alert').fadeOut(10);  
            	$('.log-status').removeClass('wrong-entry');
       		 	$('#logStatUname').addClass('wrong-entry');
       		 	$('#alertBlankUsername').fadeIn(500);  
            	return false;
            } else if (!$.trim(pwd)) {
            	$('.alert').fadeOut(10);  
            	$('.log-status').removeClass('wrong-entry');
            	$('#logStatPwd').addClass('wrong-entry');
       		 	$('#alertBlankPassword').fadeIn(500);  
            	return false;
            }
            
            $.ajax({
                url:'${pageContext.request.contextPath}/loginController',  
                data:{"username":user,"password":pwd},
                type: 'get',
                success: function (data) {
                	var rspns = $.trim(data);
                	var username = "username";
                	var password = "password";
                	 if (rspns == "username") {
                		 incorrectUsername();
                	 } else if (rspns == password) {
                		incorrectPassword();
                	 } else if (!$.trim(data)) {
                		 window.location = "admin.jsp";
                	 }
                },
                error:function(){
    	              alert('Something went wrong. Please contact your systems administrator.');
                }
            });                 
    }
    
    function incorrectUsername() {
    	$('.alert').fadeOut(10);  
		$('.log-status').removeClass('wrong-entry');
		$('#logStatUname').addClass('wrong-entry');
	 	$('#alertUsername').fadeIn(500);  
    }

    function incorrectPassword() {
    	$('.alert').fadeOut(10);  
		$('.log-status').removeClass('wrong-entry');
		$('#logStatPwd').addClass('wrong-entry');
	 	$('#alertPassword').fadeIn(500);  
    }
    
    document.getElementById('password').onkeydown = function(event) {
        if (event.keyCode == 13) {
        	login();
        }
    }

    </script>
    
    <!-- Back Button browser will refresh the page -->
  	<script>
    
  		history.forward();
	
    </script>

</body>
</html>
