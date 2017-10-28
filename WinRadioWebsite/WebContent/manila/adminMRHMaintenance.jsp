<%@page import="com.win.radio.manila.utilities.MRHCommands"%>
<%@page import="com.win.radio.manila.utilities.DJListCommands"%>
<%@page import="com.win.radio.manila.utilities.CodeUtil"%>
<%@page import="com.win.radio.manila.utilities.AccountCommands"%>
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
	
	<title>Win Radio Admin - Most Requested Hits</title>
	
    <!-- Bootstrap core CSS -->
    <link href="../core-css/bootstrap.min.css" rel="stylesheet">

    <!--Fonts-->
    <link href="../fonts/fonts.css" rel="stylesheet">
      
    <!-- Icons -->
    <link href="../core-css/font-awesome.css" rel="stylesheet">
    
    <!-- Custom styles for this template -->
    <link href="custom-css/style.css" rel="stylesheet">
    <link href="custom-css/admin.css" rel="stylesheet">    
    
    <style> 
		table {
    	counter-reset: rowNumber;
		}
		
		table tr:not(.rowHeader) {
		    counter-increment: rowNumber;
		}
		
		table tr td:first-child::before {
		    content: counter(rowNumber);
		    min-width: 1em;
		    margin-right: 0.5em;
		}
	</style>
	
</head>
<body>
	<div class="container-fluid" id="wrapper">
		<div class="row">
			
			<main class="col-xs-12 col-sm-8 offset-sm-4 col-lg-9 offset-lg-3 col-xl-10 offset-xl-2 pt-3 pl-4">
				<header class="page-header row justify-center">
					<div class="col-md-6 col-lg-8" >
						<h1 class="float-left text-center text-md-left">Most Requested Hits</h1>
					</div>
					
					<!-- include headerSection Start-->
					<%@include file="headerSection.jsp" %>
					<!-- include headerSection End -->	
					
					<div class="clear"></div>
				</header>
				
				<!-- Alert confirmation start -->
				<div class="row">
					<div class="col-lg-12">
						<div class="alert bg-success" id="alertSuccess" style="display:none;" role="alert">
							<em class="fa fa-check-circle mr-2"></em> Most requested hits list updated successfully! 
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertSuccess')"></em></a>
						</div>
						
						<div class="alert bg-warning" id="alertMissingField" style="display:none;" role="alert">
							<em class="fa fa-minus-circle mr-2"></em> Please fill up all fields.
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertMissingField')"></em></a>
						</div>
						<div class="alert bg-danger" id="alertFail" style="display:none;" role="alert">
							<em class="fa fa-minus-circle mr-2"></em> Something went wrong. Please contact your administrator. 
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertFail')"></em></a>
						</div>
					</div>
				</div>
				<!-- Alert confirmation end -->
				
				
				<!-- Buttons start -->
				<div class="row">
					<div class="col-lg-12">
						<button type="button" class="btn btn-primary btn-sm float-left btn-options" id="btnBack"
						onclick="updateAccountStatus('deactivate')" >
							<em class="fa fa-arrow-left"></em> Back
						</button>
						<button type="button" class="btn btn-primary btn-sm float-right btn-options" onclick="updateMRH()">Save list</button>
					</div>
				</div>
				<!-- Buttons end -->
				
				<br/>
				
				<section class="row justify-content-md-center">
					<div class="col-lg-3">
						<div class="card">
							<div class="card-block">
								Drag and drop the items in the table to re-arrange the list
							</div>
						</div>
					</div>
					
					<!-- Table MRH start -->
					<div class="col-lg-9">
						<div class="card">
							<table id="tblMRH" class="table">
								<thead>
							  		<tr class="rowHeader">
							  			<th>#</th>
							    		<th>Title</th>
							    		<th>Artist</th>
							  		</tr>
							  	</thead>
							  	<tbody>
							  		<%ResultSet rs = null;
				            		PreparedStatement pstmt = null;
				            		Connection conn = null;
				            		
				            		try{	 
				                 	conn = ConnectionUtil.getConnection();
				                 	pstmt = conn.prepareStatement(MRHCommands.GET_MRH_LIST);
				                 	pstmt.setString(1, CodeUtil.COD_REGION_MNL);
				                	rs = pstmt.executeQuery();
				        				while(rs.next()) {
									%>
							  		<tr>
							  			<td></td>
						    			<td width="50%"><input class="form-control" type="text" value="<%=rs.getString("TITLE")%>"/>
						    			</td><td width="50%"><input class="form-control" type="text" value="<%=rs.getString("ARTIST")%>"/></td>
							  		</tr>
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
							  	</tbody>
							</table>
						</div>
					</section>
					<!-- Table MRH end -->
					<br/>
					<br/>
				
				</div>
				
					
				
            	
					
			</main>
			

		</div>
	
	
	</div>

    <!-- Bootstrap core JavaScript -->
    <script src="../core-js/jquery-3.2.1.min.js"></script>
    <script src="../core-js/jquery.min.js"></script>
    <script src="../core-js/tether.min.js"></script>
    <script src="../core-js/bootstrap.min.js"></script>
    <script src="../core-js/table-dragger.min.js"></script>
    
    <script src="custom-js/admin.js"></script>
    
    <script type="text/javascript"> 
   	tableDragger(document.querySelector("#tblMRH"), { mode: "row", onlyBody: true });
   	
   	function updateMRH() {
		document.getElementById('alertMissingField').style.display = "none";
		document.getElementById('alertSuccess').style.display = "none";
		document.getElementById('alertFail').style.display = "none";
		var intError = 0;
   		
   		var arrMRH = [];
   		var headers = [];
   		
   	    $('#tblMRH th').not(":first").each(function(index, item) {
   	        headers[index] = $(item).html();
   	    });
      
   		$('#tblMRH tr').has('td').each(function() {
   			var arrayItem = {};
   		  	$('td', $(this)).not(":first").each(function(index, item) {
   		  		var inputValue = $(item).children('input').val();
   		  		if (($.trim(inputValue) != "")) {
   		     		arrayItem[headers[index]] = inputValue;
   		  		} else {
	   		  		document.getElementById('alertMissingField').style.display = "block";
	   		  		intError = 1;
   		  		}
   		  	});
   			arrMRH.push(arrayItem);
   		});
      
      	var jsonArrMRH = JSON.stringify(arrMRH);
      	
      	if (intError==0) {
	      	$.ajax({
	      	    url:"${pageContext.request.contextPath}/updateMRHController",
	      	    type:"POST",
	      	    data: {jsonArrMRH:jsonArrMRH},
	      	    success:function(data){
	      	    	if ($.trim(data) == 'success') {
	            		document.getElementById('alertSuccess').style.display = "block";
	            	} else if ($.trim(data) == 'fail') {
	            		document.getElementById('alertFail').style.display = "block";
	            	}
	      	    },
	      	 	error:function(){
	      	 		document.getElementById('alertFail').style.display = "block";
	            }
	      	});
      	}
   		
    }
   	
   	function closeAlert(idAlert) {
   		document.getElementById(idAlert).style.display = "none";
   	}
    </script>
    	
</body>
</html>
