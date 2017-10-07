<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
  	<meta charset="UTF-8">
  	<title>Win Radio Admin Login</title>
  
  	<link rel="stylesheet" href="../core-css/font-awesome.min.css">
  	<link rel="stylesheet" href="../fonts/fonts.css">
  	<link rel="stylesheet" href="custom-css/login-style.css">
  	
</head>

<body>
  <div class="login-form">
     <h1>Win Radio</h1>
     <form id="formNewUser" class="form">
	     <div class="form-group log-status" id="logStatUname">
	       <input type="text" class="form-control" placeholder="Username" autocomplete="off" id="username" required="required">
	       <i class="fa fa-user"></i>
	     </div>
	     <div class="form-group log-status" id="logStatPwd">
	       <input type="password" class="form-control" placeholder="Password" id="password" required="required">
	       <i class="fa fa-lock"></i>
	     </div>
	     <span class="alert" id="alertBlankUsername">Please input username</span>
	     <span class="alert" id="alertBlankPassword">Please input password</span>
	     <span class="alert" id="alertUsername">Incorrect username</span>
	     <span class="alert" id="alertPassword">Incorrect password</span>
	     <a class="link" href="#">Forgot your password?</a>
	     <div class="form-group">
	     	<button type="button" class="log-btn" id="btnLogin" onclick="login()">Log in</button>
	     </div>
	    
     </form>
     
    
   </div>
  	<script src='../core-js/jquery.min.js'></script>

    <script  src="custom-js/login-script.js"></script>
    
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
    	              alert('Something went wrong.');
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

    </script>

</body>
</html>
