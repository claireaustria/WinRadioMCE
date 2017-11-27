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
    <%@include file="admin-css-imports.jsp" %>
</head>
<body>
	<div class="container-fluid" id="wrapper">
		<div class="row">
			
			<main class="col-xs-12 col-sm-8 offset-sm-4 col-lg-9 offset-lg-3 col-xl-10 offset-xl-2 pt-3 pl-4">
				<header class="page-header row justify-center">
					<div class="col-md-6 col-lg-8" >
						<h1 class="float-left text-center text-md-left">Create Program Schedule</h1>
					</div>
					
					<!-- include headerSection Start-->
					<%@include file="headerSection.jsp" %>
					<!-- include headerSection End -->	
					
					<div class="clear"></div>
				</header>
				
				
				
				<div class="row">
					<div class="col-lg-12">
						<div class="alert bg-success" id="alertPSCreationSuccess" style="display:none;" role="alert">
							<em class="fa fa-check-circle mr-2"></em> Program Schedule creation successful!
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertAcctCreationSuccess')"></em></a>
						</div>
						<div class="alert bg-danger" id="alertPSCreationFail" style="display:none;" role="alert">
							<em class="fa fa-minus-circle mr-2"></em> Something went wrong, please try again. 
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertAcctCreationFail')"></em></a>
						</div>
					</div>
				</div>
				
				
				
				<!-- Program Name And Schedule-->		
				<form id="formProgramSchedule" class="form">	
				
					<!-- Create Button -->
					<div class="row">
						<div class="col-lg-12">
							<button type="button" class="btn btn-primary btn-md float-right btn-options" onclick="addNewProgram()">Create Program</button>
						</div>
					</div>
				
					<br />
					
					<div class="row">
						<div class="col-lg-7">
							<div class="card">
								<div class="card-block">
									<h3 class="card-title">Program Information</h3>
									<h6 class="card-subtitle mb-2 text-muted">This will be displayed on 'Program Schedule' page</h6>								
									
										<center>
											<div class="form-group row">
											  <label id="lblMissingField" class="col-12 col-form-label" style="color:red; display:none;">Please fill out all fields.</label>
											  <label id="lblTakenProgramName" class="col-12 col-form-label" style="color:red; display:none;">Program Name is already taken.</label>
											</div>
										</center>
									
										<div class="form-group">
											<label class="col-7 control-label no-padding" for="program name">Program Name</label>
											<div class="col-12 no-padding">
												<input class="form-control" id="programname" name="programname" type="text" placeholder="" required="required">
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-lg-7 control-label no-padding" for="program schdedule">Program Schedule</label>
											<div class="col-12 no-padding">
												<textarea class="form-control" id="programschedule" name="programschdedule" placeholder="" required="required" rows="5"></textarea>
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-lg-7 control-label no-padding" for="program schdedule">Program Description</label>
											<div class="col-12 no-padding">
												<textarea class="form-control" id="programdescription" name="programdescription" placeholder="" required="required" rows="5"></textarea>
											</div>
										</div>
										
										<div class="form-group">
										  <label class="col-lg-7 control-label no-padding" for="program schdedule">Program Status</label>
											<div class="col-12 no-padding">
										  	 <select class="form-control" id="programstatus" name="programstatus" disabled>
									  			<option value="<%=CodeUtil.COD_PS_STATUS_PUBLISHED%>">Publish</option>
									  			<option value="<%=CodeUtil.COD_PS_STATUS_ARCHIVED%>">Archive</option>
									      	 </select>
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
													<td><input class="checkbox"type="checkbox" id="djid" name="djid" value="<%=rs.getInt("ID_ACCOUNT")%>"></input></td>
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
    <%@include file="admin-js-imports.jsp" %>
    
    <script type="text/javascript">
    	function checkIfProgramNameExist(){
    		var programname=$("programname").val();
    		$.ajax({
    			url:'${pageContext.request.contextPath}/PSValueCheckerControlller',
    			data:{programname: programname},
    			type: 'get',
    			cache: false,
    			success: function(data){
    				if($.trim(data)){
    					return 'error';
    				}else{
    					return 'true';
    				}
    			},
    			error:function(){
    				alert('error');
    			}
    		})
    	}
    	
    	function validateForm()
    	{
    		var programname=$("#programname").val();
    		var programschedule=$("#programschedule").val();
    		var programdescription=$("#programdescription").val();
    		var djid=$("#djid").val();
    		
    		if($.trim(programname) == '' || $.trim(programschedule) == '' || $.trim(programdescription) == '' || $.trim(djid) == null){
    			return false;
    		} else {
    			if($.trim(programname) == '' || $.trim(programschedule) == '' || $.trim(programdescription) == '' || $.trim(djid) == null){
        			return false;
    			}
    		}
    		
    		return true;
    	}
   		
    	function addNewProgram(){
    		document.getElementById('lblTakenProgramName').style.display = "none";
    		document.getElementById('lblMissingField').style.display = "none";
    		
    		if(!validateForm()){
    			document.getElementById('lblTakenProgramName').style.display = "none";
        		document.getElementById('lblMissingField').style.display = "block";
        		return false;
   			}
    		
    		var programname=$("#programname").val();
    		$.ajax({
    			url:'${pageContext.request.contextPath}/psValueChecker',
    			data:{programname: programname},
    			type:'get',
    			cache:false,
    			success:function(data){
    				if($.trim(data)){
    					document.getElementById('lblTakenProgramName').style.display = "block";
    					returnfalse();
    				}
    			},
    			error:function(){
    				alert('error');
    			}
    		});
    		
    		var programname=$("#programname").val();
    		var programschedule=$("#programschedule").val();
    		var programdescription=$("#programdescription").val();
    		var programstatus=$("#programstatus").val();
    		
   			var values = [];    
   			$( "input[name='djid']:checked" ).each(function(){
   			    values.push($(this).val());
   			});
   			var str = values.join(", ");
    		
    		$.ajax({
    			url:'${pageContext.request.contextPath}/psCreate',
    			data:{programname: programname, programschedule: programschedule, programdescription: programdescription, djid: str, programstatus: programstatus},
    			type:'post',
    			cache: false,
    			success:function(data){
    				if($.trim(data) == 'success'){
    					document.getElementById('alertPSCreationSuccess').style.display = "block";
    				}else{
    					document.getElementById('alertPSCreationFail').style.display = "block";
    				}
    			},
    			error:function(){
    				alert('error');
    			}
    		});
    	}
    	
    	function returnFalse() {
			return false;
		}
    	</script>
</body>
</html>