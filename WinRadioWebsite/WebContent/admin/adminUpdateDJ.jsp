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
	
	<title>Win Radio Admin - DJ Maintenance</title>
	
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
						<h1 class="float-left text-center text-md-left">DJ Maintenance</h1>
					</div>
					
					<!-- include headerSection Start-->
					<%@include file="headerSection.jsp" %>
					<!-- include headerSection End -->	
					
					<div class="clear"></div>
				</header>
				
            	<%ResultSet rs = null;
          		PreparedStatement pstmt = null;
          		Connection conn = null;
          		
          		int idDJ = Integer.valueOf(request.getParameter("idDJ"));
           				            		
          		try{	 
               	conn = ConnectionUtil.getConnection();
  				pstmt = conn.prepareStatement(DJListCommands.GET_ALL_DJ);
              	pstmt.setInt(1, idDJ);
              	pstmt.setString(2, String.valueOf(session.getAttribute("codRegion")));
              	pstmt.setInt(3, idDJ);
              	pstmt.setString(4, String.valueOf(session.getAttribute("codRegion")));
              	rs = pstmt.executeQuery();
  				
  				while (rs.next()) {
				%>
				<!-- Alert confirmation start -->				
				<div class="row">
					<div class="col-lg-12">
						<div class="alert bg-success" id="alertSuccess" style="display:none;" role="alert">
							<em class="fa fa-check-circle mr-2"></em> <%=CodeUtil.STATUS_MSG_SAVED %>
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertAcctUpdateSuccess')"></em></a>
						</div>
						<div class="alert bg-danger" id="alertFail" style="display:none;" role="alert">
							<em class="fa fa-minus-circle mr-2"></em> <%=CodeUtil.STATUS_MSG_ERROR %>
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertAcctUpdateFail')"></em></a>
						</div>
						<div class="alert bg-danger" id="alertMissingField" style="display:none;" role="alert">
							<em class="fa fa-minus-circle mr-2"></em> Please fill up all fields.
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertMissingField')"></em></a>
						</div>
					</div>
				</div>
				<!-- Alert confirmation end -->
				
				<!-- Buttons start -->
				<div class="row">
					<div class="col-lg-6">
						<a href="adminDJMaintenance.jsp">
							<button type="button" class="btn btn-sm btn-primary float-left btn-options"><em class="fa fa-long-arrow-left"></em> Back</button>
						</a>
					</div>
					<div class="col-lg-6">
						<span id="currentRow" style="display: none;"></span>
						<button type="button" class="btn btn-secondary btn-md float-right btn-options" id="btnDeactivate"
						onclick="updateAccountStatus('deactivate')" data-toggle="tooltip" title="Deactivate account">
							Deactivate
						</button>
						<button type="button" class="btn btn-primary btn-md float-right btn-options" onclick="updateDJ()">Save</button>
					</div>
				</div>
				<!-- Buttons end -->
				
				<br />
				
				<!-- Row start: update DJ form -->
				<div class="row justify-content-md-center">
					<!-- Update DJ form start -->
					<div class="col-lg-8">
						<div class="card">
							<div class="card-block">
								<form class="form-horizontal">			
								  	<div class="form-group" style="display:none;">
								        <label for="message-text" class="form-control-label">ID Account:</label>
								        <input type="text" class="form-control" id="idAccount" required="required" value="<%=rs.getString("ID_ACCOUNT") %>">
								    </div>								
								    <div class="form-group" style="display:none;">
								        <label for="message-text" class="form-control-label">ID DJ:</label>
								        <input type="text" class="form-control" id="idDJ" required="required" value="<%=rs.getString("ID_DJ") %>">
								    </div>							
									<div class="form-group" id="editTitleSection">
								        <label for="message-text" class="form-control-label">DJ Name:</label>
								        <input type="text" class="form-control" id="djName" required="required" value="<%=rs.getString("DJ_NAME") %>">
								    </div>
									<div class="form-group">
										<label class="col-12 control-label no-padding" for="message">Description:</label>
										<div class="col-12 no-padding">
											<textarea class="form-control" id="description" placeholder="" required="required" rows="5" value=""><%=rs.getString("DESCRIPTION") %></textarea>
										</div>
									</div>
									
								</form>
							</div>
						</div>
					</div>
					<!-- Update DJ form end -->
					
				</div>
				<!-- Row end: update DJ form -->
				
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
									
				<br />
					
			</main>
			

		</div>
	
	
	</div>

    <!-- Import JavaScript
	================================================== -->
	<%@include file="admin-js-imports.jsp" %>
    
    <script type="text/javascript"> 
	    $(document).ready(function(){
	        $('[data-toggle="tooltip"]').tooltip(); 
	    });
		
		function updateDJ() {
			document.getElementById('alertSuccess').style.display = "none";
			document.getElementById('alertFail').style.display = "none";
			document.getElementById('alertMissingField').style.display = "none";
			
			var idDJ=$("#idDJ").val();
			var description=$("#description").val();
			
			if ($.trim(idDJ) != "" && $.trim(description) != "") {
				$.ajax({
		            url:'${pageContext.request.contextPath}/updateDJListController',
		            data:{idDJ: idDJ, description: description, action: 'updateDJ'},
		            type:'post',
		            cache:false,
		            success:function(data){
		            	if ($.trim(data) == 'success') {
		            		document.getElementById('alertSuccess').style.display = "block";
		            	} else {
		            		document.getElementById('alertFail').style.display = "block";
		            	}
		            },
		            error:function(){
		            	document.getElementById('alertFail').style.display = "block";
		            }
				});
			} else {
				document.getElementById('alertMissingField').style.display = "block";
			}
		}
		
		function closeAlert(idAlert) {
			document.getElementById(idAlert).style.display = "none";
		}
		
		$('#btnDeactivate').click(function(){
			var idAccount=$("#idAccount").val();
	       	window.location.href='adminUpdateUser.jsp?idAccountToModify='+idAccount;
		})
		
		    
	</script>
   
</body>
</html>
