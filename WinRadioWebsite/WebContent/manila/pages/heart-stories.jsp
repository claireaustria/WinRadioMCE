<%@page import="com.win.radio.manila.utilities.DramaCommands"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.win.radio.manila.utilities.DramaOperations"%>
<%@page import="com.win.radio.manila.utilities.ConnectionUtil"%>
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
	<title>Heart Stories | Win Radio Manila</title>

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
				<h1>Heart Stories</h1>
				<span>Tagline should be here</span>
			</div>

		</section><!-- #page-title end -->

		<!-- Content
		============================================= -->
		<section id="content">

			<div class="content-wrap">

				<div class="container clearfix">


					<div class="clear"></div>

					<!-- Portfolio Items
					============================================= -->
					<div id="portfolio" class="portfolio grid-container portfolio-1 clearfix">

						<%ResultSet rs = null;
	            		PreparedStatement pstmt = null;
	            		Connection conn = null;
	            		
	            		try{	 
	                 	conn = ConnectionUtil.getConnection();
	                 	pstmt = conn.prepareStatement(DramaCommands.GET_ALL_EPISODES);
	                 	pstmt.setString(1, "MNL");
	                 	pstmt.setString(2, "1");
	                	rs = pstmt.executeQuery();
	        				while(rs.next()) {
						%>
						
						<article class="portfolio-item pf-media pf-icons clearfix">
							<div class="portfolio-image">
								<a href="portfolio-single.html">
									<img src="img/heart.png" alt="Heart Stories">
								</a>
								<div class="portfolio-overlay">
									<a href="http://vimeo.com/89396394" class="left-icon" data-lightbox="iframe"><i class="icon-line-play"></i></a>
								</div>
							</div>
							<div class="portfolio-desc">
								<h3><a href="portfolio-single.html"><%=rs.getString("TITLE")%></a></h3>
								<span><%=rs.getString("DATE_POSTED")%></span>
								<p><%=rs.getString("DESCRIPTION")%></p>
								<br />
								<a href="#" class="social-icon si-colored si-facebook">
									<i class="icon-facebook"></i>
									<i class="icon-facebook"></i>
								</a>
								<a href="#" class="social-icon si-colored si-twitter">
									<i class="icon-twitter"></i>
									<i class="icon-twitter"></i>
								</a>
							</div>
						</article>
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

					</div><!-- #portfolio end -->

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