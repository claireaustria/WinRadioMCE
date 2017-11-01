<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html dir="ltr" lang="en-US">
<head>

	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta name="author" content="SemiColonWeb" />

	<!-- Stylesheets
	============================================= -->
	<link href="http://fonts.googleapis.com/css?family=Lato:300,400,400italic,600,700|Raleway:300,400,500,600,700|Crete+Round:400italic" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="css/bootstrap.css" type="text/css" />
	<link rel="stylesheet" href="style.css" type="text/css" />
	<link rel="stylesheet" href="css/swiper.css" type="text/css" />
	<link rel="stylesheet" href="css/dark.css" type="text/css" />
	<link rel="stylesheet" href="css/font-icons.css" type="text/css" />
	<link rel="stylesheet" href="css/animate.css" type="text/css" />
	<link rel="stylesheet" href="css/magnific-popup.css" type="text/css" />

	<link rel="stylesheet" href="css/responsive.css" type="text/css" />
	<link rel="stylesheet" href="music.css" type="text/css" />
	
	<!-- Custom CSS -->
	<link rel="stylesheet" href="custom.css" type="text/css" />
	
	<meta name="viewport" content="width=device-width, initial-scale=1" />

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
		<header id="header" class="transparent-header full-header" data-sticky-class="not-dark">

			<div id="header-wrap">

				<div class="container clearfix">

					<div id="primary-menu-trigger"><i class="icon-reorder"></i></div>

					<!-- Logo
					============================================= -->
					<div id="logo">
						<a href="index.html" class="standard-logo" data-dark-logo="images/logo-dark.png"><img src="images/logo.png" alt="Canvas Logo"></a>
						<a href="index.html" class="retina-logo" data-dark-logo="images/logo-dark@2x.png"><img src="images/logo@2x.png" alt="Canvas Logo"></a>
					</div><!-- #logo end -->

					<!-- Primary Navigation
					============================================= -->
					<%@include file="main-nav.jsp" %>

				</div>

			</div>

		</header><!-- #header end -->

		<section id="slider" class="slider-parallax swiper_wrapper full-screen clearfix">
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
									<h2 data-caption-animate="fadeInUp">Welcome to Win Radio PH!</h2>
									<p data-caption-animate="fadeInUp" data-caption-delay="200">
										<a href="#" class="button button-border button-circle button-yellow button-light"><i class="icon-trash2"></i>Stream Now</a>
									</p>
								</div>
							</div>
							<div class="video-wrap">
								<video id="slide-video" poster="images/videos/explore.jpg" preload="auto" loop autoplay muted>
									<source src='images/videos/explore.webm' type='video/webm' />
									<source src='images/videos/explore.mp4' type='video/mp4' />
								</video>
								<div class="video-overlay" style="background-color: rgba(0,0,0,0.55);"></div>
							</div>
						</div>
					</div>
					<!-- 
					<div id="slider-arrow-left"><i class="icon-angle-left"></i></div>
					<div id="slider-arrow-right"><i class="icon-angle-right"></i></div>
					 -->
				</div>

				<a href="#" data-scrollto="#content" data-offset="100" class="dark one-page-arrow"><i class="icon-angle-down infinite animated fadeInDown"></i></a>

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
					    	<img class="first" src="images/blog/small/1.jpg" alt="" />
					    	<img src="images/blog/small/2.jpg" alt="" />
					    	<img src="images/blog/small/19.jpg" alt="" />
					    	<img src="images/blog/small/3.jpg" alt="" />
					    	<img src="images/blog/small/10.jpg" alt="" />					    	
					    	<img src="images/blog/small/12.jpg" alt="" />
					    	<img src="images/blog/small/13.jpg" alt="" />
					    	<img src="images/blog/small/17.jpg" alt="" />
					    	<img src="images/blog/small/18.jpg" alt="" />
					    	<img src="images/blog/small/19.jpg" alt="" />
					    </div>
				    </div>
				</div>
				<!-- DIV: SPONSOR END -->
				
				<!-- DIV: MRH START -->
				<div class="container clearfix bgcolor2">
					<div class="row topmargin-lg">
						<div class="heading-block noborder dark" style="margin-bottom: 15px;">
							<h3>Most Requested Hits</h3>
							<br />
						</div>
					</div>
					<div class="row clearfix">
						<div class="col-md-6">
							
	
							<!-- Song Lists Items
							============================================= -->
							<div class="songs-lists-wrap">
	
								<!-- List Items
								============================================= -->
								<div class="songs-list">
									<div class="songs-number">01</div>
									<div class="songs-image track-image">
										<img src="demos/music/tracks/poster-images/ibelieveinyou.jpg" alt="Image 1">
									</div>
									<div class="songs-name track-name">I Believe In You<br><span>Lost European</span></div>
								</div>
	
								<!-- List Items
								============================================= -->
								<div class="songs-list">
									<div class="songs-number">01</div>
									<div class="songs-image track-image">
										<img src="demos/music/tracks/poster-images/i-need-you-now.jpg" alt="Image 1">
									</div>
									<div class="songs-name track-name">I Believe In You<br><span>Lost European</span></div>
								</div>
		
								<!-- List Items
								============================================= -->
								<div class="songs-list">
									<div class="songs-number">01</div>
									<div class="songs-image track-image">
										<img src="demos/music/tracks/poster-images/ibelieveinyou.jpg" alt="Image 1">
									</div>
									<div class="songs-name track-name">I Believe In You<br><span>Lost European</span></div>
								</div>
								
								<!-- List Items
								============================================= -->
								<div class="songs-list">
									<div class="songs-number">01</div>
									<div class="songs-image track-image">
										<img src="demos/music/tracks/poster-images/ibelieveinyou.jpg" alt="Image 1">
									</div>
									<div class="songs-name track-name">I Believe In You<br><span>Lost European</span></div>
								</div>
	
								<!-- List Items
								============================================= -->
								<div class="songs-list">
									<div class="songs-number">01</div>
									<div class="songs-image track-image">
										<img src="demos/music/tracks/poster-images/ibelieveinyou.jpg" alt="Image 1">
									</div>
									<div class="songs-name track-name">I Believe In You<br><span>Lost European</span></div>
								</div>
	
							</div>
						</div>
	
						<div class="col-md-6">
							<div class="songs-lists-wrap">
	
								<!-- List Items
								============================================= -->
								<div class="songs-list">
									<div class="songs-number">01</div>
									<div class="songs-image track-image">
										<img src="demos/music/tracks/poster-images/ibelieveinyou.jpg" alt="Image 1">
									</div>
									<div class="songs-name track-name">I Believe In You<br><span>Lost European</span></div>
								</div>
	
								<!-- List Items
								============================================= -->
								<div class="songs-list">
									<div class="songs-number">01</div>
									<div class="songs-image track-image">
										<img src="demos/music/tracks/poster-images/ibelieveinyou.jpg" alt="Image 1">
									</div>
									<div class="songs-name track-name">I Believe In You<br><span>Lost European</span></div>
								</div>
	
								<!-- List Items
								============================================= -->
								<div class="songs-list">
									<div class="songs-number">01</div>
									<div class="songs-image track-image">
										<img src="demos/music/tracks/poster-images/ibelieveinyou.jpg" alt="Image 1">
									</div>
									<div class="songs-name track-name">I Believe In You<br><span>Lost European</span></div>
								</div>
	
								<!-- List Items
								============================================= -->
								<div class="songs-list">
									<div class="songs-number">01</div>
									<div class="songs-image track-image">
										<img src="demos/music/tracks/poster-images/ibelieveinyou.jpg" alt="Image 1">
									</div>
									<div class="songs-name track-name">I Believe In You<br><span>Lost European</span></div>
								</div>
	
								<!-- List Items
								============================================= -->
								<div class="songs-list">
									<div class="songs-number">01</div>
									<div class="songs-image track-image">
										<img src="demos/music/tracks/poster-images/ibelieveinyou.jpg" alt="Image 1">
									</div>
									<div class="songs-name track-name">I Believe In You<br><span>Lost European</span></div>
								</div>
	
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
			   			<div class="col-lg-1 col-md-3 col-sm-4 col-xs-6">
			    			<div class="staff-photo">
			    				<img src="images/team/3.jpg">
			    			</div>
			    			<div class="team-desc">
								<div class="team-title"><h4>Macho Bibbo</h4><span>CEO</span></div>
							</div>
			    		</div>
			    		<div class="col-lg-1 col-md-3 col-sm-4 col-xs-6">
			    			<div class="staff-photo">
			    				<img src="images/team/2.jpg">
			    			</div>
			    			<div class="team-desc">
								<div class="team-title"><h4>Ligaya</h4><span>CEO</span></div>
							</div>
			    		</div>
			    		<div class="col-lg-1 col-md-3 col-sm-4 col-xs-6">
			    			<div class="staff-photo">
			    				<img src="images/team/4.jpg">
			    			</div>
			    			<div class="team-desc">
								<div class="team-title"><h4>Rhiko Mambo</h4><span>CEO</span></div>
							</div>
			    		</div>
			    		<div class="col-lg-1 col-md-3 col-sm-4 col-xs-6">
			    			<div class="staff-photo">
			    				<img src="images/team/8.jpg">
			    			</div>
			    			<div class="team-desc">
								<div class="team-title"><h4>Tess Mosa</h4><span>CEO</span></div>
							</div>
			    		</div>
			    		<div class="col-lg-1 col-md-3 col-sm-4 col-xs-6">
			    			<div class="staff-photo">
			    				<img src="images/team/3.jpg">
			    			</div>
			    			<div class="team-desc">
								<div class="team-title"><h4>Justin Kiss</h4><span>CEO</span></div>
							</div>
			    		</div>
			    		<div class="col-lg-1 col-md-3 col-sm-4 col-xs-6">
			    			<div class="staff-photo">
			    				<img src="images/team/2.jpg">
			    			</div>
			    			<div class="team-desc">
								<div class="team-title"><h4>Kuya Jay Machete</h4><span>CEO</span></div>
							</div>
			    		</div>
						<div class="col-lg-1 col-md-3 col-sm-4 col-xs-6">
			    			<div class="staff-photo">
			    				<img src="http://placehold.it/150x167.jpg">
			    			</div>
			    			<div class="team-desc">
								<div class="team-title"><h4>Sisa Usisa</h4><span>CEO</span></div>
							</div>
			    		</div>
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
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi rem, facilis nobis voluptatum est voluptatem accusamus molestiae eaque perspiciatis mollitia.</p>
										<br />
										<center>
											<a href="#" class="button button-3d button-small button-rounded button-red">Read more</a>
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
										<p>Quos, non, esse eligendi ab accusantium voluptatem. Maxime eligendi beatae, atque tempora ullam. Vitae delectus quia, consequuntur rerum molestias quo.</p>
										<br />
										<center>
											<a href="#" class="button button-3d button-small button-rounded button-red">Read more</a>
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
										<p>Porro repellat vero sapiente amet vitae quibusdam necessitatibus consectetur, labore totam. Accusamus perspiciatis asperiores labore esse ab accusantium ea.</p>
										<br />
										<center>
											<a href="#" class="button button-3d button-small button-rounded button-red">Read more</a>
										</center>
									</div>
								</div>
							</div>

						</div>

					</div>
				</div>
				<!-- DIV: WHAT'S HOT END -->
			
			</div><!-- content-wrap end -->

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