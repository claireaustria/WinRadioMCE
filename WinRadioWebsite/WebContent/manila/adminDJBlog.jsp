<%@page import="com.win.radio.manila.utilities.BlogContentCommands"%>
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
    <link href="custom-css/djblog-style.css" rel="stylesheet">
</head>
<body>
	<div class="container-fluid" id="wrapper">
		<div class="row">
			
			<main class="col-xs-12 col-sm-8 offset-sm-4 col-lg-9 offset-lg-3 col-xl-10 offset-xl-2 pt-3 pl-4">
				<header class="page-header row justify-center">
					<div class="col-md-6 col-lg-8" >
						<h1 class="float-left text-center text-md-left">DJ Blogs Maintenance</h1>
					</div>
					
					<!-- include headerSection Start-->
					<%@include file="headerSection.jsp" %>
					<!-- include headerSection End -->	
					
					<div class="clear"></div>
				</header>
				
				<!-- Alert confirmation start -->			
				<div class="row">
					<div class="col-lg-12">
						<div class="alert bg-warning" id="alertNoRowSelected" style="display:none;" role="alert">
							<em class="fa fa-minus-circle mr-2"></em> Please choose a post to modify
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertNoAcctSelected')"></em></a>
						</div>
					</div>
				</div>
				<!-- Alert confirmation end -->	
				
				<!-- Row buttons start -->
				<div class="row">
					<div class="col-lg-6">
						<div class="pull-left">
							<div class="btn-group">
								<button type="button" class="btn btn-sm btn-default btn-filter" data-target="Published">Published</button>
								<button type="button" class="btn btn-sm btn-default btn-filter" data-target="Draft">Draft</button>
								<button type="button" class="btn btn-sm btn-default btn-filter" data-target="Archived">Archived</button>
								<button type="button" class="btn btn-sm btn-default btn-filter" data-target="all">All</button>
							</div>
						</div>
					</div>
					<div class="col-lg-6">
						<div class="pull-right">
							<button type="button" class="btn btn-sm btn-primary" onclick="modifyPost()">Modify</button>
							<button type="button" class="btn btn-sm btn-primary" onclick="createPost()">Create New Post</button>
						</div>
					</div>
				</div>
				<!-- Row buttons end -->
				
				<br/>

				<!-- Table row start -->
				<div class="row">
					<div class="col-lg-12">
			        	<div class="card mb-3">
								<div class="table-container">
									<table class="table table-filter" id="dataTable">
										<tbody>
										
											<%ResultSet rs = null;
						            		PreparedStatement pstmt = null;
						            		Connection conn = null;
						            		
						            		try{	 
						                 	conn = ConnectionUtil.getConnection();
						                 	pstmt = conn.prepareStatement(BlogContentCommands.GET_BLOG_POSTS);
						                 	pstmt.setString(1, "%");
						                 	pstmt.setString(2, CodeUtil.COD_REGION_MNL);
						                	rs = pstmt.executeQuery();
						        				while(rs.next()) {
											%>
											
											<tr data-status="<%=rs.getString("STATUS")%>">
												<td style="display:none;">
													<%=rs.getString("ID_BLOG")%>
												</td>
												<td>
													<div class="row">
														<div class="col-lg-1 justify-center">
															<a href="#" class="pull-left">
																<img src="https://s3.amazonaws.com/uifaces/faces/twitter/fffabs/128.jpg" class="media-photo">
															</a>
														</div>
														<div class ="col-lg-11">
															<div class="media">
																
																<div class="media-body">
																	<span class="media-meta pull-right"><%=rs.getString("CREATE_DATE")%></span>
																	<h4 class="title">
																		<%=rs.getString("TITLE")%>
																		<span class="pull-right <%=rs.getString("STATUS")%>">(<%=rs.getString("STATUS")%>)</span>
																	</h4>
																	<p class="summary"><%=rs.getString("FORMATTED_CONTENT")%></p>
																</div>
															</div>
														</div>
													</div>
												</td>
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
							</div>
						</div>
					</div>
				</div>
				<!-- Table row end -->
				
				<!-- Hidden text to store ID of current row -->
				<span id="currentRow" style="display: none;"></span>
				
			</main>
			

		</div>
	
	
	</div>

    <!-- Bootstrap core JavaScript -->
    <script src="../core-js/jquery-3.2.1.min.js"></script>
    <script src="../core-js/jquery.min.js"></script>
    <script src="../core-js/tether.min.js"></script>
    <script src="../core-js/bootstrap.min.js"></script>
    
    <script src="custom-js/admin.js"></script>
    
    <script>
    $(document).ready(function () {

        $('tr').on('click', function () {
        	$(this).closest('table').find('tr').not(this).removeClass('selected');  
            $(this).toggleClass('selected');
            var idBlog = $(this).find('td:eq(0)').text();
            var span = document.getElementById("currentRow");
            span.textContent = idBlog;
        });
        
        $('.btn-filter').on('click', function () {
          var $target = $(this).data('target');
          if ($target != 'all') {
            $('.table tr').css('display', 'none');
            $('.table tr[data-status="' + $target + '"]').fadeIn('slow');
          } else {
            $('.table tr').css('display', 'none').fadeIn('slow');
          }
        });

     });
    
    function modifyPost() {
    	var currentRow = document.getElementById("currentRow");
    	var rowContent = currentRow.textContent;
    	if ($.trim(rowContent) != "") {
       		window.location.href='adminUpdateDJBlog.jsp?idBlog='+rowContent;
    	} else {
    		document.getElementById('alertNoRowSelected').style.display = "block";
    	}
    }
    
    function closeAlert(idAlert) {
		document.getElementById(idAlert).style.display = "none";
	}
    
    function createPost() {
    	window.location.href='adminNewDJBlog.jsp?';
    }
    </script>
    
   
</body>
</html>
