<%@page import="com.win.radio.manila.utilities.CodeUtil"%>
<%@page import="com.win.radio.manila.utilities.CompanyDescriptionCommands"%>
<%@page import="com.win.radio.manila.utilities.ConnectionUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
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
	<title>About Us | Win Radio Manila</title>

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

		<!-- Page Sub Menu
		============================================= -->
		<div id="page-menu">

			<div id="page-menu-wrap">

				<div class="container clearfix">

					<div class="menu-title"> </div>

					<nav>
						<ul>
							<li class="current"><a href="about-us.jsp"><div>About Us</div></a></li>
							<li><a href="contact-us.jsp"><div>Contact Us</div></a></li>
						</ul>
					</nav>

					<div id="page-submenu-trigger"><i class="icon-reorder"></i></div>

				</div>

			</div>

		</div><!-- #page-menu end -->
		
		<!-- Page Title
		============================================= -->
		<section id="page-title">

			<div class="container clearfix">
				<h1>About us</h1>
			</div>

		</section><!-- #page-title end -->
		
		<!-- Content
		============================================= -->
		<section id="content">

			<div class="content-wrap">

				<div class="container clearfix">
					<div class="row clearfix">

						<div class="col-lg-12">
							<%
							ResultSet rs = null;
		            		PreparedStatement pstmt = null;
		            		Connection conn = null;
		            		
							try{	 
			                 	conn = ConnectionUtil.getConnection();
			    				pstmt = conn.prepareStatement(CompanyDescriptionCommands.GET_DESCRIPTION);
			                 	pstmt.setString(1, CodeUtil.COD_REGION_MNL);
			                 	rs = pstmt.executeQuery();
			    				
			    				while (rs.next()) {
							%>
							
							<p class="lead" style="white-space: pre-wrap;"><%=rs.getString("DESCRIPTION") %></p>
						      	
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
						</div>

					</div>
				</div>

			</div>

		</section><!-- #content end -->

		<!-- Footer
		============================================= -->
		<footer id="footer" class="dark">

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

	<script type="text/javascript" src="https://maps.google.com/maps/api/js?key=AIzaSyDMxJ92oBkSnVNHFX3R8XhtYQPEgk1_IiI"></script>
	<script type="text/javascript" src="js/jquery.gmap.js"></script>

	<script type="text/javascript">

		jQuery('#google-map').gMap({
			address: 'Melbourne, Australia',
			maptype: 'ROADMAP',
			zoom: 14,
			markers: [
				{
					address: "Melbourne, Australia",
					html: '<div style="width: 300px;"><h4 style="margin-bottom: 8px;">Hi, we\'re <span>Envato</span></h4><p class="nobottommargin">Our mission is to help people to <strong>earn</strong> and to <strong>learn</strong> online. We operate <strong>marketplaces</strong> where hundreds of thousands of people buy and sell digital goods every day, and a network of educational blogs where millions learn <strong>creative skills</strong>.</p></div>',
					icon: {
						image: "images/icons/map-icon-red.png",
						iconsize: [32, 39],
						iconanchor: [32,39]
					}
				}
			],
			doubleclickzoom: false,
			controls: {
				panControl: true,
				zoomControl: true,
				mapTypeControl: true,
				scaleControl: false,
				streetViewControl: false,
				overviewMapControl: false
			}
		});

	</script>

</body>
</html>