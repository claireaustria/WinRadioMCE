<!-- Prevent Access to the page without logging in -->
<%@page import="com.win.radio.manila.utilities.CodeUtil"%>
<%@page import="com.win.radio.manila.utilities.DJListCommands"%>
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

<%@page import="java.util.List"%>
<%@page import="com.win.radio.manila.models.AccountModel"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
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
	
    <!-- Bootstrap core CSS -->
    <link href="../core-css/bootstrap.min.css" rel="stylesheet">

    <!--Fonts-->
    <link href="../fonts/fonts.css" rel="stylesheet">
    
    <!-- Icons -->
    <link href="../core-css/font-awesome.css" rel="stylesheet">
    
    <!-- Plugin CSS -->
	<link href="../core-css/dataTables.bootstrap4.css" rel="stylesheet">
    
    <!-- Custom styles for this template -->
    <link href="custom-css/style.css" rel="stylesheet">
    <link href="custom-css/admin.css" rel="stylesheet">
    
    <style>
    #dataTable_wrapper {
		padding: 20px 15px 20px 15px;
		margin: 5px;
	}
	
	.highlight { 
		background: #F0F0F0; 
	}
	
	.clickableRow:hover {
		cursor: pointer;
	}
    </style>
</head>
<body>
	<div class="container-fluid" id="wrapper">
		<div class="row">
			
			<main class="col-xs-12 col-sm-8 offset-sm-4 col-lg-9 offset-lg-3 col-xl-10 offset-xl-2 pt-3 pl-4">
				<header class="page-header row justify-center">
					<div class="col-md-6 col-lg-8" >
						<h1 class="float-left text-center text-md-left">DJ Maintenance</h1>
					</div>
					
					<!-- include headerSection Start-->
					<%@include file="headerSection.jsp" %>
					<!-- include headerSection End -->	
					
					<div class="clear"></div>
				</header>
				
				<!-- Alert confirmation start -->			
				<div class="row">
					<div class="col-lg-12">
						<div class="alert bg-warning" id="alertNoAcctSelected" style="display:none;" role="alert">
							<em class="fa fa-minus-circle mr-2"></em> Please choose an account to modify
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertNoAcctSelected')"></em></a>
						</div>
					</div>
				</div>
				<!-- Alert confirmation end -->		
					
				
				<!-- Buttons -->
				<div class="row">
					<div class="col-lg-12">
						<span id="currentRow" style="display: none;"></span>
						<button type="submit" class="btn btn-primary btn-md float-right btn-options" id="btnNewUser">Create New User</button>
						<button type="submit" class="btn btn-primary btn-md float-right btn-options" id="btnModifyUser">Modify Details</button>
					</div>
				</div>
				
				<br />

				
				<!-- Users table start -->
				<div class="row justify-content-md-center">
					<div class="col-lg-10">
				        <div class="card mb-3">
				          <div class="card-body">
				            <div class="table-responsive">
				              <table class="table table-bordered" width="100%" id="dataTable" cellspacing="0">
				                <thead>
				                  <tr>
				                  	<th style="display:none;">ID DJ</th>
				                  	<th>DJ Name</th>
				                    <th>Description</th>
				                  </tr>
				                </thead>
				                <tbody>
				                 	<%ResultSet rs = null;
				               		PreparedStatement pstmt = null;
				               		Connection conn = null;
				    								            		
				               		try{	 
				                    conn = ConnectionUtil.getConnection();
				       				pstmt = conn.prepareStatement(DJListCommands.GET_ALL_DJ);
				                   	pstmt.setString(1, CodeUtil.COD_REGION_MNL);
				                   	rs = pstmt.executeQuery();
				       				
				       				while (rs.next()) {
									%>
									<tr class="clickableRow">								
										<td style="display:none;"><%=rs.getString("ID_DJ")%></td>
										<td><%=rs.getString("DJ_NAME")%></td>
										<td><%=rs.getString("DESCRIPTION")%></td>
									</tr>
									<%
									}
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
				          </div>  
				        </div>
					</div>
		        </div>
		        <!-- Users table end -->
			
			</main>
		</div>
	
	
	</div>

    <!-- Bootstrap core JavaScript -->
    <script src="../core-js/jquery-3.2.1.min.js"></script>
    <script src="../core-js/tether.min.js"></script>
    <script src="../core-js/bootstrap.min.js"></script>
    
    <script src="../core-js/jquery.dataTables.js"></script>
    <script src="../core-js/dataTables.bootstrap4.js"></script>
    <script src="custom-js/admin.js"></script>
    <script src="custom-js/sb-admin.min.js"></script>
   
    <script type="text/javascript">
    $(function() {
        
        //Get all data rows from the table 
        var rows = $('tr').not(':first');
        
        rows.on('click', function(e) {
            //Get current row
            var row = $(this);
            //Highlight row
            if ((e.ctrlKey || e.metaKey) || e.shiftKey) {
                row.addClass('highlight');
            } else {
                rows.removeClass('highlight');
                row.addClass('highlight');
                //Get the first column - hidden ID account
                var idAccount = row.find('td:eq(0)').text();
                var span = document.getElementById("currentRow");
                span.textContent = idAccount;
            }
	    });
	        
        //Prevents the table texts from being modified
        $(document).bind('selectstart dragstart', function(e) { 
            e.preventDefault(); return false; 
        });
	 });
    
    /*Page redirect*/
    $('#btnNewUser').click(function(){
       window.location.href='adminNewUser.jsp';
    })
    
    /*Page redirect*/
    $('#btnModifyUser').click(function(){
    	var span = document.getElementById("currentRow");
    	var spanText = span.textContent;
    	if ($.trim(spanText) != "") {
       		window.location.href='adminUpdateUser.jsp?idAccountToModify='+spanText;
    	} else {
    		document.getElementById('alertNoAcctSelected').style.display = "block";
    	}
    })
    
    function closeAlert(idAlert) {
		document.getElementById(idAlert).style.display = "none";
	}
    </script>
    
    
</body>
</html>
