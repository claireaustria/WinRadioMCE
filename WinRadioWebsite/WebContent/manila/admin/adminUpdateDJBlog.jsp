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
						<div class="alert bg-success" id="alertArchiveSuccess" style="display:none;" role="alert">
							<em class="fa fa-check-circle mr-2"></em> Blog post successfully archived!
							<a href="#" class="float-right"><em class="fa fa-remove" onclick="closeAlert('alertArchiveSuccess')"></em></a>
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
   					String strStatus = rs.getString("STATUS");
				%>	
				<!-- Buttons start -->
				<div class="row">
					<div class="col-lg-6">
						<a href="adminDJBlog.jsp">
							<button type="button" class="btn btn-sm btn-primary float-left btn-options"><em class="fa fa-long-arrow-left"></em> Back</button>
						</a>
					</div>
					<div class="col-lg-6">
						<%if (!strStatus.equals(CodeUtil.COD_BLOG_STATUS_ARCHIVED)) {%>
						<button type="button" class="btn btn-sm btn-secondary float-right btn-options" onclick="updateBlog('Archived')">Archive</button>
						<%} %>
						<button type="button" class="btn btn-sm btn-primary float-right btn-options" onclick="updateBlog('Published')">Publish to website</button>
						<button type="button" class="btn btn-sm btn-primary float-right btn-options" onclick="updateBlog('Draft')">Save As Draft</button>
						</div>
				</div>
				
				<br/>
				
				<!-- Blog content row start -->
				<div class="row">
					<div class="col-lg-8">
						<div class="card">
							<div class="card-block">
								<form class="form-horizontal">
									<div class="form-group" id="titleSection">
										<div class="row">
											<div class="col-lg-11">
												<h3><%=rs.getString("TITLE") %></h3>
											</div>
											<div class="col-lg-1">
												<h4><em class="fa fa-pencil pull-right" data-toggle="tooltip" title="Edit title" onclick="editTitle()"></em></h4>
											</div>	
										</div>							
										<div class="divider" style="margin-top: 1rem;"></div>
									</div>
									
								    <div class="form-group" style="display:none;">
								        <label for="message-text" class="form-control-label">ID Blog:</label>
								        <input type="text" class="form-control" id="idBlog" required="required" value="<%=rs.getString("ID_BLOG") %>">
								    </div>							
									<div class="form-group" id="editTitleSection" style="display:none;">
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
									
								</form>
							</div>
						</div>
					</div>
					
					<div class="col-lg-4">
						<div class="card">
							<div class="card-block">
								<center>
									<h4>Blog Status:</h4>
									<%
									if (strStatus.equals(CodeUtil.COD_BLOG_STATUS_DRAFT)) {%>
										<h5 style="color: #f0ad4e;"><%=strStatus %></h5>
									<%} else if (strStatus.equals(CodeUtil.COD_BLOG_STATUS_PUBLISHED)) { %>
										<h5 style="color: #5cb85c;"><%=strStatus %></h5>
									<%} else if (strStatus.equals(CodeUtil.COD_BLOG_STATUS_ARCHIVED)) { %>
										<h5 style="color: #999999;"><%=strStatus %></h5>
									<%} %>
								</center>
							</div>
						</div>
					</div>
					
				</div>
				<!-- Blog content row end -->	
				
				
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
			</main>
			

		</div>
	
	
	</div>

    <!-- Import JavaScript
	================================================== -->
	<%@include file="admin-js-imports.jsp" %>
    
    <script>
    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip(); 
    });
    
    function cancel() {
    	window.location.href='adminDJBlog.jsp';
    }
    
    function updateBlog(status) {
		var idBlog=$("#idBlog").val();
    	var title=$("#title").val();
		var content=$("#content").val();
		var postOwner = $("#postOwner").val();
		
		var blogContent = {idBlog: idBlog, title: title, content: content, postOwner: postOwner, status: status};
    	var blogContentJSON = JSON.stringify(blogContent);
		
		if ($.trim(title) != "" && $.trim(content) != "" && $.trim(postOwner) != "") {
			$.ajax({
	            url:'${pageContext.request.contextPath}/updateDJBlogController',
	            data:blogContentJSON,
	            type:'post',
	            cache:false,
	            success:function(data){
	            	if ($.trim(data) == 'success') {
	            		if (status == 'Draft') {
	            			document.getElementById('alertDraftSuccess').style.display = "block";
	            		} else if (status == 'Published') {
	            			document.getElementById('alertPublishSuccess').style.display = "block";
	            		} else if (status == 'Archived') {
	            			document.getElementById('alertArchiveSuccess').style.display = "block";
	            		}
	            	} else {
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
    
    function editTitle() {
    	document.getElementById('titleSection').style.display = "none";
    	document.getElementById('editTitleSection').style.display = "block";
    }
    </script>
</body>
</html>
