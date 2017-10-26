<%@page import="com.win.radio.manila.utilities.DJListCommands"%>
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
    <link href="custom-css/djblog-style.css" rel="stylesheet">
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
				
				<!-- Alert confirmation start -->
				<div class="row">
					<div class="col-lg-12">
						<div class="alert bg-success" id="alertPublishSuccess" style="display:none;" role="alert">
							<em class="fa fa-check-circle mr-2"></em> Blog post successfully published! 
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertPublishSuccess')"></em></a>
						</div>
						<div class="alert bg-success" id="alertDraftSuccess" style="display:none;" role="alert">
							<em class="fa fa-check-circle mr-2"></em> Draft saved successfully!
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertDraftSuccess')"></em></a>
						</div>
						<div class="alert bg-danger" id="alertMissingField" style="display:none;" role="alert">
							<em class="fa fa-minus-circle mr-2"></em> Please fill up all fields.
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertMissingField')"></em></a>
						</div>
						<div class="alert bg-danger" id="alertFail" style="display:none;" role="alert">
							<em class="fa fa-minus-circle mr-2"></em> Something went wrong. Please try again. 
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertFail')"></em></a>
						</div>
						<div class="alert bg-danger" id="alertJSFail" style="display:none;" role="alert">
							<em class="fa fa-minus-circle mr-2"></em> Something went wrong. Please contact your administrator. 
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertJSFail')"></em></a>
						</div>
					</div>
				</div>
				<!-- Alert confirmation end -->
				
				
				<br/>
				
				<!-- Blog content row start -->
				<div class="row justify-content-md-center">
					<div class="col-lg-8">
						<div class="card">
							<div class="card-block">
								<form class="form-horizontal">		
									<div class="form-group" id="editTitleSection">
								        <label for="message-text" class="form-control-label">Blog Title:</label>
								        <input type="text" class="form-control" id="title" required="required" value="">
								    </div>
								    <%if (!session.getAttribute("codType").equals(CodeUtil.COD_TYPE_DJ)) { %>
								    <div class="form-group">
								        <label for="message-text" class="form-control-label">Posted By:</label>
								        <select class="form-control" id="postOwner">
									    <%ResultSet rs = null;
					            		PreparedStatement pstmt = null;
					            		Connection conn = null;
					            		
					            		try{	 
					                 	conn = ConnectionUtil.getConnection();
					                 	pstmt = conn.prepareStatement(DJListCommands.GET_ALL_DJ);
					                 	pstmt.setString(1, CodeUtil.COD_REGION_MNL);
					                	rs = pstmt.executeQuery();
					        				while(rs.next()) {
										%>
										
										<option value="<%=rs.getString("ID_DJ") %>"><%=rs.getString("DJ_NAME") %></option>
									      	
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
										</select>
									</div>
									<%} %>
									<div class="form-group">
										<label class="col-12 control-label no-padding" for="message">Content</label>
										<div class="col-12 no-padding">
											<textarea class="form-control" id="content" name="blogContent" rows="5" ></textarea>
										</div>
									</div>
									<div class="form-group">
										<fieldset class="form-group">
									    	<label class="col-12 control-label no-padding" for="message">Save blog post as:</label>
									    	<div class="form-check">
									      		<label class="form-check-label">
									        	<input type="radio" class="form-check-input" name="status" id="optionsRadios1" value="<%=CodeUtil.COD_BLOG_STATUS_DRAFT%>">
									        	Draft
									      		</label>
									    	</div>
									    	<div class="form-check">
										    	<label class="form-check-label">
										        <input type="radio" class="form-check-input" name="status" id="optionsRadios2" value="<%=CodeUtil.COD_BLOG_STATUS_PUBLISHED%>">
										        Publish on website
										      	</label>
									    	</div>
									 	</fieldset>
								 	</div>
									<div class="form-group">
										<div class="col-12 widget-right no-padding">
											<button type="button" class="btn btn-primary btn-md float-right" onclick="createBlog()">Submit</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<!-- Blog content row end -->	
				<br/>			
				
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
    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip(); 
    });
    
    function cancel() {
    	window.location.href='adminDJBlog.jsp';
    }
    
    function createBlog() {

		document.getElementById('alertPublishSuccess').style.display = "none";
		document.getElementById('alertDraftSuccess').style.display = "none";
		document.getElementById('alertJSFail').style.display = "none";
		document.getElementById('alertMissingField').style.display = "none";
    	
    	var title=$("#title").val();
		var content=$("#content").val();
		var postOwner = $("#postOwner").val();
		var status = $("input[name='status']:checked").val();
		
		var blogContent = {title: title, content: content, postOwner: postOwner, status: status};
    	var blogContentJSON = JSON.stringify(blogContent);
		
		if ($.trim(title) != "" && $.trim(content) != "" && $.trim(postOwner) != "" && $.trim(status) != "") {
			$.ajax({
	            url:'${pageContext.request.contextPath}/createDJBlogController',
	            data:blogContentJSON,
	            type:'post',
	            cache:false,
	            success:function(data){
	            	if ($.trim(data) == 'success') {
	            		if (status == 'Draft') {
	            			document.getElementById('alertDraftSuccess').style.display = "block";
	            		} else if (status == 'Published') {
	            			document.getElementById('alertPublishSuccess').style.display = "block";
	            		}
	            	} else if ($.trim(data) == 'fail') {
	            		document.getElementById('alertFail').style.display = "block";
	            	}
	            },
	            error:function(){
            		document.getElementById('alertJSFail').style.display = "block";
	            }
			});
		} else {
			document.getElementById('alertMissingField').style.display = "block";
		}
		
    }
    
    function closeAlert(idAlert) {
		document.getElementById(idAlert).style.display = "none";
	}
    
    </script>
</body>
</html>
