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
<%@page import="java.sql.PreparedStatement"%>
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
						<h1 class="float-left text-center text-md-left">Program Schedule</h1>
					</div>
					
					<!-- include headerSection Start-->
					<%@include file="headerSection.jsp" %>
					<!-- include headerSection End -->	
					
					<div class="clear"></div>
				</header>
				
				<!-- Alert confirmation start -->			
				<div class="row">
					<div class="col-lg-12">
						<div class="alert bg-warning" id="alertNoProgSelected" style="display:none;" role="alert">
							<em class="fa fa-minus-circle mr-2"></em> Please choose a program to modify
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertNoProgSelected')"></em></a>
						</div>
					</div>
				</div>
				<!-- Alert confirmation end -->	
				
				<!-- Buttons -->
				<div class="row">
					<div class="col-lg-12">
						<span id="currentRow" style="display: none;"></span>
						<button type="submit" class="btn btn-primary btn-md float-right btn-options" id="btnNewProgram">Create New Program Schedule</button>
						<button type="submit" class="btn btn-primary btn-md float-right btn-options" id="btnModifyProgram">Modify Details</button>
					</div>
				</div>
				
				<br/>
				
				<!--Program table -->
				<div class="row">
					<div class="col-lg-12">
				        <div class="card">
				          <div class="card-body">
				            <div class="table-responsive">
				              <table class="table table-bordered" width="100%" id="dataTable" cellspacing="0">
				                <thead>
				                  <tr>
				                  	<th style="display:none;">ID Program</th>
				                  	<th>Create Date</th>
				                    <th>Program Title</th>
				                    <th>Description</th>
				                    <th>Schedule</th>
				                    <th>Status</th>
				                    <th>DJ</th>
				                  </tr>
				                </thead>
				                <tbody>
				                 	<%
				                 	ResultSet rs = null;
				                 	ResultSet rs2 = null;
				                 	Statement select = null;
				            		PreparedStatement pstmt = null;
				            		Connection conn = null;
				            		
				            		try{	 
				                 	conn = ConnectionUtil.getConnection();
				        			select = conn.createStatement();
				        			rs = select.executeQuery(PSOperations.GET_ALL_PROGRAM);
				        			
				        			while(rs.next()) {
									%>
									<tr class="clickableRow">								
										<td style="display:none;"><%=rs.getInt("ID_PROGRAM")%></td>
										<td><%=rs.getString("CREATE_DATE")%></td>
										<td><%=rs.getString("PROG_NAME")%></td>
										<td><%=rs.getString("DESCRIPTION") %></td>
										<td><%=rs.getString("SCHEDULE") %></td>
										<% 
											String Stat = rs.getString("STATUS");
											if(Stat.equals(CodeUtil.COD_PS_STATUS_PUBLISHED)){
										%>
										<td style="color: #5cb85c;"><%=CodeUtil.COD_PS_STATUS_PUBLISHED%></td>
										<%
											}else if(Stat.equals(CodeUtil.COD_PS_STATUS_ARCHIVED)){
										%>
										<td style="color: #999999;"><%=CodeUtil.COD_PS_STATUS_ARCHIVED%></td>
										<%	
											}
										%>
										<td>
											<div class="dropdown">
											  <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">
											  <span class="caret"></span></button>
											  <ul class="dropdown-menu">
											  <%
											  		String Dj = rs.getString("PROG_DJ");
													String[] DjList = Dj.split(", ");
													for(int i = 0; i < DjList.length; i++)
													{
														pstmt = conn.prepareStatement(PSOperations.GET_PROGRAM_DJ_NAME);
														pstmt.setInt(1, Integer.parseInt(DjList[i]));
														rs2 = pstmt.executeQuery();
														
														while(rs2.next()){
												%>      
											    <li><a href="#"><%=rs2.getString("DJ_NAME")%></a></li>
											    <%
														}
													}
												%>
											  </ul>
											</div>
									 	</td>
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
				            			if (rs2 != null) {
				            				try {
				            					rs2.close();
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
				            			
				            		}
									%>
				                </tbody>
				              </table>
				            </div>
				          </div> 
			        	</div>
			    	</div>
		        </div>
					
			</main>
			

		</div>
	
	
	</div>

    <!-- Bootstrap core JavaScript -->
    <%@include file="admin-js-imports.jsp" %>
    <script src="custom-js/sb-admin.min.js"></script>
    
    <script type="text/javascript">
     $(function(){
    	 
    	 var rows = $('tr').not(':first');
    	 
    	 rows.on('click', function(e) {
    		
    		 var row = $(this);
    		 
    		 if((e.ctrlKey || e.metaKey) || e.shiftKey){
    			 row.addClass('highlight');
    		 } else {
    			rows.removeClass('highlight');
    			row.addClass('highlight');
    			
    			var idProgram = row.find('td:eq(0)').text();
    			var span = document.getElementById("currentRow");
    			span.textContent = idProgram;
    		 }
    	 });
    	 
    	 $(document).bind('selectstart dragstart', function(e){
    		e.preventDefault(); return false; 
    	 });
     });
     
     $('#btnModifyProgram').click(function(){
  		
    	 var span = document.getElementById("currentRow");
    	 var spanText = span.textContent;
    	 if($.trim(spanText) != ""){
    		window.location.href='adminUpdateProgramSchedule.jsp?idProgramToModify='+spanText;
    	 } else {
    		 document.getElementById('alertNoProgSelected').style.display = "block";
    	 }
     })	
    
     
     $('#btnNewProgram').click(function(){
    	window.location.href='adminNewProgramSchedule.jsp'; 
     })
     
     function closeAlert(idAlert){
    	 document.getElementById(idAlert).style.display = "none";
     }
    </script>
</body>
</html>
