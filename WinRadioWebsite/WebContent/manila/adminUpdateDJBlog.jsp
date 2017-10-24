<%@page import="com.win.radio.manila.utilities.BlogContentCommands"%>
<%@page import="com.win.radio.manila.utilities.CompanyDescriptionCommands"%>
<%@page import="com.win.radio.manila.utilities.ConnectionUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.win.radio.manila.utilities.CodeUtil"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.win.radio.manila.utilities.SQLOperations"%>
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
						<h1 class="float-left text-center text-md-left">Update Blog Post</h1>
					</div>
					
					<!-- include headerSection Start-->
					<%@include file="headerSection.jsp" %>
					<!-- include headerSection End -->	
					
					<div class="clear"></div>
				</header>
				
				<!-- Buttons start -->
				<div class="row">
					<div class="col-lg-12">
						<button type="button" class="btn btn-sm btn-secondary float-right btn-options" onclick="cancel()">Cancel</button>
						<button type="button" class="btn btn-sm btn-primary float-right btn-options" onclick="publish()">Publish</button>
						<button type="button" class="btn btn-sm btn-primary float-right btn-options" onclick="saveDraft()">Save As Draft</button>
					</div>
				</div>
				
				<br/>
				
				<!-- Blog content row start -->
				<div class="row">
					<div class="col-lg-8">
						<div class="card">
							<div class="card-block">
								<form class="form-horizontal">
									<%ResultSet rs = null;
				            		PreparedStatement pstmt = null;
				            		Connection conn = null;
													            		
				            		try{	 
				                 	conn = ConnectionUtil.getConnection();
				    				pstmt = conn.prepareStatement(BlogContentCommands.GET_BLOG_POSTS);
				                 	pstmt.setString(1, request.getParameter("idBlog"));
				                 	pstmt.setString(2, CodeUtil.COD_REGION_MNL);
				                 	rs = pstmt.executeQuery();
				    				
				    				while (rs.next()) {
									%>	
								    <div class="form-group" style="display:none;">
								        <label for="message-text" class="form-control-label">ID Blog:</label>
								        <input type="text" class="form-control" id="idBlog" required="required" value="<%=rs.getString("ID_BLOG") %>">
								    </div>							
									<div class="form-group">
								        <label for="message-text" class="form-control-label">Blog Title:</label>
								        <input type="text" class="form-control" id="title" required="required" value="<%=rs.getString("TITLE") %>">
								    </div>
								    <div class="form-group" style="display:none;">
								        <label for="message-text" class="form-control-label">Post Owner ID:</label>
								        <input type="text" class="form-control" id="postOwner" required="required" value="<%=rs.getString("POST_OWNER") %>">
								    </div>
									<div class="form-group">
								        <label for="message-text" class="form-control-label">Posted By:</label>
								        <input type="text" class="form-control" required="required" value="<%=rs.getString("DJ_NAME") %>">
								    </div>
									<div class="form-group">
										<label class="col-12 control-label no-padding" for="message">Content</label>
										<div class="col-12 no-padding">
											<textarea class="form-control" id="content" name="blogContent" placeholder="" required="required" rows="5" value=""><%=rs.getString("CONTENT") %></textarea>
										</div>
									</div>
									<%	}
				            		} catch(Exception ex)
				            		{
				            			ex.printStackTrace();
				            		} finally {
				            			try {
			            					if (rs != null) {
			            						rs.close();
			            					}
			            					if (pstmt != null) {
			            						pstmt.close();
			            					}
			            					if (conn != null) {
			            						conn.close();
			            					}
			            				} catch (SQLException e) {
			            					e.printStackTrace();
			            				}
				            		}
									%>
								</form>
							</div>
						</div>
					</div>
				</div>
					
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
    function cancel() {
    	window.location.href='adminDJBlog.jsp';
    }
    
    function saveDraft() {
    	var title=$("#title").val();
		var content=$("#content").val();
		var postOwner = $("#postOwner").val();
		
		if ($.trim(title) != "" && $.trim(content) != "" && $.trim(postOwner) != "") {
			$.ajax({
	            url:'${pageContext.request.contextPath}/updateDJBlogController',
	            data:{action: 'saveDraft', idBlog: idBlog, title: title, content: content, postOwner: postOwner},
	            type:'post',
	            cache:false,
	            success:function(data){
	            	if ($.trim(data) == 'success') {
	            		document.getElementById('alertSaveDraftSuccess').style.display = "block";
	            	} else if ($.trim(data) == 'fail') {
	            		document.getElementById('alertUpdateFail').style.display = "block";
	            	}
	            },
	            error:function(){
	              alert('error');
	            }
			});
		} else if ($.trim(title) == "") {
			
		} else if ($.trim(content) == "") {
			
		} else if ($.trim(postOwner) == "") {
			
		}
		
    }
    </script>
</body>
</html>
