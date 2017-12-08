<%@page import="com.win.radio.manila.utilities.DJListCommands"%>
<%@page import="com.win.radio.manila.utilities.BlogContentCommands"%>
<%@page import="com.win.radio.manila.utilities.ConnectionUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html dir="ltr" lang="en-US">
<head>

	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta name="author" content="SemiColonWeb" />

	<!-- Stylesheet imports
	============================================= -->
	<%@include file="css-imports.jsp" %>

	<!-- Document Title
	============================================= -->
	<title>DJ Blogs | Win Radio Manila</title>

</head>

<body class="stretched">

	<!-- Document Wrapper
	============================================= -->
	<div id="wrapper" class="clearfix">

		<!-- Header
		============================================= -->
		<header id="header" class="full-header">

			<div id="header-wrap">

				<div class="container clearfix">

					<div id="primary-menu-trigger"><i class="icon-reorder"></i></div>

					<!-- Primary Navigation
					============================================= -->
					<%@include file="main-nav.jsp" %>

				</div>

			</div>

		</header><!-- #header end -->

		<!-- Page Title
		============================================= -->
		<section id="page-title">

			<div class="container clearfix">
				<h1>DJ Blogs</h1>
			</div>

		</section><!-- #page-title end -->

		<!-- Content
		============================================= -->
		<section id="content">

			<div class="content-wrap">

				<div class="container clearfix">
				
					
					<ul id="portfolio-filter" class="portfolio-filter clearfix" data-container="#portfolio">

						<li class="activeFilter"><a href="#" data-filter="*">Show All</a></li>
						
						<%ResultSet resultSet = null;
	            		PreparedStatement prepstmt = null;
	            		Connection connctn = null;
	            		
	            		try{	 
	            		connctn = ConnectionUtil.getConnection();
	            		prepstmt = connctn.prepareStatement(DJListCommands.GET_ALL_DJ);
	            		prepstmt.setString(1, "%");
	            		prepstmt.setString(2, "MNL");
	                 	resultSet = prepstmt.executeQuery();
	        				while(resultSet.next()) {
						%>
						<li><a href="#" data-filter=".<%=resultSet.getString("ID_DJ")%>"><%=resultSet.getString("DJ_NAME") %></a></li>
						<%	}
	            		} catch(Exception ex)
	            		{
	            			ex.printStackTrace();
	            		} finally {
	            			if (resultSet != null) {
	            				try {
	            					resultSet.close();
	            				} catch (SQLException e) {
	            					e.printStackTrace();
	            				}
	            			}
	            			if (prepstmt != null) {
	            				try {
	            					prepstmt.close();
	            				} catch (SQLException e) {
	            					e.printStackTrace();
	            				}
	            			}
	            			if (connctn != null) {
	            				try {
	            					connctn.close();
	            				} catch (SQLException e) {
	            					e.printStackTrace();
	            				}
	            			}
	            		}
						%>
					</ul><!-- #portfolio-filter end -->
					
					<div class="clear"></div>

										
					<!-- Post Content
					============================================= -->
					<div id="portfolio" class="portfolio portfolio-1 grid-container clearfix small-thumbs "> <!-- postcontent nobottommargin clearfix -->

						<%ResultSet rs = null;
	            		PreparedStatement pstmt = null;
	            		Connection conn = null;
	            		
	            		try{	 
	                 	conn = ConnectionUtil.getConnection();
	                 	pstmt = conn.prepareStatement(BlogContentCommands.GET_BLOG_POSTS);
	                 	pstmt.setString(1, "%");
	                 	pstmt.setString(2, "MNL");
	                	rs = pstmt.executeQuery();
	        				while(rs.next()) {
						%>
						
						<div class="entry clearfix <%=rs.getString("ID_DJ") %>">
							<div class="entry-image ">
								<a href="img/blog.jpg" data-lightbox="image"><img class="image_fade" src="img/blog.jpg" alt="Standard Post with Image"></a>
							</div>
							<div class="entry-c">
								<div class="entry-title">
									<h2><span class="id-blog" style="display:none;"><%=rs.getString("ID_BLOG") %></span> <a href="blog-single.html"><%=rs.getString("TITLE") %></a></h2>
								</div>
								<ul class="entry-meta clearfix">
									<li><%=rs.getString("DJ_NAME") %></li>
									<li><i class="icon-calendar3"></i> <%=rs.getString("DATE_POSTED") %></li>
									<li><a href="blog-single.html#comments"><i class="icon-comments"></i> 13</a></li>
								</ul>
								<div class="entry-content">
									<p><%=rs.getString("BLOG_PREVIEW") %></p>
									<a href="blog-single-small.jsp?idBlog=<%=rs.getString("ID_BLOG") %>" class="more-link">Read More</a>
								</div>
							</div>
						</div>
						
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
						
					</div><!-- .postcontent end -->
					
					<!-- Sidebar
					============================================= 
					<div class="sidebar nobottommargin col_last clearfix">
						<div class="sidebar-widgets-wrap">

							<div class="widget widget-twitter-feed clearfix">

								<h4>Shortcodes</h4>
								<ul>
									<li><a href="#" data-filter="*"><div>Show All</div></a></li>
									<li><a href="#" data-filter=".pf-icons"><div>Icons</div></a></li>
									<li><a href="#" data-filter=".pf-illustrations"><div>Illustrations</div></a></li>
									<li><a href="charts.html"><div>Charts</div></a></li>
								</ul>
							</div>
						</div>

					</div><!-- .sidebar end -->
				</div>

			</div>

		</section><!-- #content end -->
		
	
		<!-- Footer
		============================================= -->
		<%@include file="main-footer.jsp" %>

	</div><!-- #wrapper end -->

	<!-- Go To Top
	============================================= -->
	<div id="gotoTop" class="icon-angle-up"></div>

	<!-- External JavaScripts
	============================================= -->
	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/plugins.js"></script>

	<!-- Footer Scripts
	============================================= -->
	<script type="text/javascript" src="js/functions.js"></script>

</body>
</html>