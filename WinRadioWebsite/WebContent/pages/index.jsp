<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.win.radio.manila.utilities.IndexOperations"%>
<%@page import="com.win.radio.manila.utilities.ConnectionUtil"%>

<!DOCTYPE html>
<html dir="ltr" lang="en-US">
<head>

<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="author" content="SemiColonWeb" />

<!-- Stylesheet imports
	============================================= -->
<%@include file="css-imports.jsp"%>

<!-- Document Title
	============================================= -->
<title>Win Radio PH</title>

</head>

<body class="stretched">

	<!-- Document Wrapper
	============================================= -->
	<div id="wrapper" class="clearfix">

		<!-- Header
		============================================= -->
		<header id="header" class="transparent-header full-header"
			data-sticky-class="not-dark">

			<div id="header-wrap">

				<div class="container clearfix">

					<div id="primary-menu-trigger">
						<i class="icon-reorder"></i>
					</div>

					<!-- Primary Navigation
					============================================= -->
					<%@include file="main-nav.jsp"%>

				</div>

			</div>

		</header>
		<!-- #header end -->

		<section id="slider"
			class="slider-parallax swiper_wrapper full-screen clearfix">
			<div class="slider-parallax-inner">

				<div class="swiper-container swiper-parent">
					<div class="swiper-wrapper">
						<!-- <div class="swiper-slide dark" style="background-image: url('images/slider/swiper/1.jpg');">
							<div class="container clearfix">
								<div class="slider-caption slider-caption-center">
									<h2 data-caption-animate="fadeInUp">Welcome to Win Radio PH</h2>
									<p data-caption-animate="fadeInUp" data-caption-delay="200">Create just what you need for your Perfect Website. Choose from a wide range of Elements &amp; simply put them on your own Canvas.</p>
								</div>
							</div>
						</div> -->
						<div class="swiper-slide dark">
							<div class="container clearfix">
								<div class="slider-caption slider-caption-center">
									<h2 data-caption-animate="fadeInUp">Welcome to Win Radio
										PH!</h2>
									<p data-caption-animate="fadeInUp" data-caption-delay="200">
										<a href="#"
											class="button button-border button-circle button-yellow button-light">Stream
											Now</a>
									</p>
								</div>
							</div>
							<div class="video-wrap">
								<video id="slide-video" poster="images/videos/explore.jpg"
									preload="auto" loop autoplay muted>
									<source src='images/videos/explore.webm' type='video/webm' />
									<source src='images/videos/explore.mp4' type='video/mp4' />
								</video>
								<div class="video-overlay"
									style="background-color: rgba(0, 0, 0, 0.55);"></div>
							</div>
						</div>
					</div>
					<!-- 
					<div id="slider-arrow-left"><i class="icon-angle-left"></i></div>
					<div id="slider-arrow-right"><i class="icon-angle-right"></i></div>
					 -->
				</div>

				<a href="#" data-scrollto="#content" data-offset="100"
					class="dark one-page-arrow"><i
					class="icon-angle-down infinite animated fadeInDown"></i></a>

			</div>
		</section>

		<!-- Content
		============================================= -->
		<section id="content">

			<div class="content-wrap">

				<!-- DIV: SPONSOR START -->
				<div class="container clearfix">
					<div class="heading-block center">
						<h2>Sponsors</h2>
					</div>

					<div id="banner-container">
						<div class="photobanner">
							<img class="first" src="images/blog/small/1.jpg" alt="" /> <img
								src="images/blog/small/2.jpg" alt="" /> <img
								src="images/blog/small/19.jpg" alt="" /> <img
								src="images/blog/small/3.jpg" alt="" /> <img
								src="images/blog/small/10.jpg" alt="" /> <img
								src="images/blog/small/12.jpg" alt="" /> <img
								src="images/blog/small/13.jpg" alt="" /> <img
								src="images/blog/small/17.jpg" alt="" /> <img
								src="images/blog/small/18.jpg" alt="" /> <img
								src="images/blog/small/19.jpg" alt="" />
						</div>
					</div>
				</div>
				<!-- DIV: SPONSOR END -->

				<!-- DIV: MRH START -->
				<div class="container clearfix bgcolor2">
					<div class="row topmargin-lg">
						<div class="heading-block noborder dark"
							style="margin-bottom: 15px;">
							<h3>Most Requested Hits</h3>
							<br />
						</div>
					</div>
					<div class="row clearfix">
						<div class="col-md-6">


							<!-- Song Lists Items
							============================================= -->
							<div class="songs-lists-wrap">
								<%
									ResultSet rs = null;
									Statement stmt = null;
									Connection conn = null;
									int cnt = 0;

									try {
										conn = ConnectionUtil.getConnection();
										stmt = conn.createStatement();
										rs = stmt.executeQuery(IndexOperations.GET_ALL_MRH);

										while (rs.next()) {
											cnt++;
								%>
								<div class="songs-list">
									<div class="songs-number"><%=rs.getInt("RANK")%></div>
									<div class="songs-image track-image">
										<img src="demos/music/tracks/poster-images/ibelieveinyou.jpg"
											alt="Image 1">
									</div>
									<div class="songs-name track-name"><%=rs.getString("TITLE")%><br>
										<span><%=rs.getString("ARTIST")%></span>
									</div>
								</div>
								<%
									if (cnt == 5) {
												break;
											}
										}
								%>
							</div>
						</div>

						<div class="col-md-6">
							<div class="songs-lists-wrap">

								<!-- List Items
								============================================= -->

								<%
									while (rs.next()) {
								%>
								<div class="songs-list">
									<div class="songs-number"><%=rs.getInt("RANK")%></div>
									<div class="songs-image track-image">
										<img src="demos/music/tracks/poster-images/ibelieveinyou.jpg"
											alt="Image 1">
									</div>
									<div class="songs-name track-name"><%=rs.getString("TITLE")%><br>
										<span><%=rs.getString("ARTIST")%></span>
									</div>
								</div>
								<%
									}
									} catch (Exception ex) {
										ex.printStackTrace();
									} finally {
										if (rs != null) {
											try {
												rs.close();
											} catch (SQLException e) {
												e.printStackTrace();
											}
										}
										if (stmt != null) {
											try {
												stmt.close();
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
							</div>
						</div>
					</div>
				</div>
				<!-- DIV: MRH END -->

				<div class="clear"></div>
				<br />

				<!-- DIV: DJ LIST START -->
				<div class="container clearfix">
					<div class="fancy-title title-border">
						<h3>Win Radio Manila DJs</h3>
					</div>

					<div class="row seven-cols">
						<%
							ResultSet rsDjList = null;
							Statement stmtDjList = null;
							Connection connDjList = null;

							try {
								connDjList = ConnectionUtil.getConnection();
								stmtDjList = connDjList.createStatement();
								rsDjList = stmtDjList.executeQuery(IndexOperations.GET_ALL_DJ);

								while (rsDjList.next()) {
						%>

						<div class="col-lg-1 col-md-3 col-sm-4 col-xs-6">
							<div class="staff-photo">
								<img src="http://placehold.it/150x190.jpg" data-toggle="modal"
									data-target="#<%=rsDjList.getString("ID_DJ")%>"
									cursor="pointer">
							</div>
							<div class="team-desc">
								<div class="team-title" id="djModalHeader">
									<h4><%=rsDjList.getString("DJ_NAME")%></h4>
								</div>
							</div>
						</div>
						<div class="modal fade bs-example-modal-lg"
							id="<%=rsDjList.getString("ID_DJ")%>" tabindex="-1" role="dialog"
							aria-labelledby="myLargeModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-lg">
								<div class="modal-body">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-hidden="true">&times;</button>
											<h4 class="modal-title" id="myModalLabel"><%=rsDjList.getString("DJ_NAME")%></h4>
										</div>
										<div class="modal-body">
											<div class="row">
												<div class="col-lg-5">
													<center>
														<img src="http://placehold.it/200x250.jpg">
													</center>
												</div>
												<div class="col-lg-7">
													<%=rsDjList.getString("DESCRIPTION")%>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<%
							}
							} catch (Exception ex) {
								ex.printStackTrace();
							} finally {
								if (rsDjList != null) {
									try {
										rsDjList.close();
									} catch (SQLException e) {
										e.printStackTrace();
									}
								}
								if (stmtDjList != null) {
									try {
										stmtDjList.close();
									} catch (SQLException e) {
										e.printStackTrace();
									}
								}
								if (connDjList != null) {
									try {
										connDjList.close();
									} catch (SQLException e) {
										e.printStackTrace();
									}
								}
							}
						%>


						<br />
					</div>
				</div>
				<!-- DIV: DJ LIST END -->

				<!-- DIV: WHAT'S HOT START -->
				<div class="section">
					<div class="container clear-bottommargin clearfix">

						<div class="row topmargin-sm clearfix">
							<div class="heading-block center">
								<h2>What's hot</h2>
							</div>

							<div class="col_one_third">
								<div class="feature-box media-box">
									<div class="fbox-media">
										<img src="images/services/1.jpg" alt="Why choose Us?">
									</div>
									<div class="fbox-desc">
										<h3>Win free movie passes!</h3>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit. Eligendi rem, facilis nobis voluptatum est voluptatem
											accusamus molestiae eaque perspiciatis mollitia.</p>
										<br />
										<center>
											<a href="#"
												class="button button-3d button-small button-rounded button-red">Read
												more</a>
										</center>
									</div>
								</div>
							</div>

							<div class="col_one_third">
								<div class="feature-box media-box">
									<div class="fbox-media">
										<img src="images/services/2.jpg" alt="Why choose Us?">
									</div>
									<div class="fbox-desc">
										<h3>Company events</h3>
										<p>Quos, non, esse eligendi ab accusantium voluptatem.
											Maxime eligendi beatae, atque tempora ullam. Vitae delectus
											quia, consequuntur rerum molestias quo.</p>
										<br />
										<center>
											<a href="#"
												class="button button-3d button-small button-rounded button-red">Read
												more</a>
										</center>
									</div>
								</div>
							</div>

							<div class="col_one_third col_last">
								<div class="feature-box media-box">
									<div class="fbox-media">
										<img src="images/services/3.jpg" alt="Why choose Us?">
									</div>
									<div class="fbox-desc">
										<h3>Concert tickets, anyone?</h3>
										<p>Porro repellat vero sapiente amet vitae quibusdam
											necessitatibus consectetur, labore totam. Accusamus
											perspiciatis asperiores labore esse ab accusantium ea.</p>
										<br />
										<center>
											<a href="#"
												class="button button-3d button-small button-rounded button-red">Read
												more</a>
										</center>
									</div>
								</div>
							</div>

						</div>

					</div>
				</div>
				<!-- DIV: WHAT'S HOT END -->

			</div>
			<!-- content-wrap end -->

		</section>
		<!-- #content end -->

		<!-- Footer
		============================================= -->
		<%@include file="main-footer.jsp"%>

	</div>
	<!-- #wrapper end -->

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