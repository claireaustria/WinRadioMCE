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
	<title>Contact Us | Win Radio Manila</title>

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
							<li><a href="about-us.jsp"><div>About Us</div></a></li>
							<li class="current"><a href="contact-us.jsp"><div>Contact Us</div></a></li>
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
				<h1>contact us</h1>
			</div>

		</section><!-- #page-title end -->
		
		<!-- Content
		============================================= -->
		<section id="content">

			<div class="content-wrap">

				<div class="container clearfix">

					<!-- Contact Form
					============================================= -->
					<div class="col_half">

						<div class="fancy-title title-dotted-border">
							<h3>Send us an Email</h3>
						</div>

						<div class="contact-widget">

							<div class="contact-form-result"></div>

							<form class="nobottommargin" id="template-contactform">

								<div class="form-process"></div>

								<div class="col_half">
									<label for="template-contactform-name">Name <small>*</small></label>
									<input type="text" id="fullName" name="template-contactform-name" value="" class="sm-form-control required" />
								</div>

								<div class="col_half col_last">
									<label for="template-contactform-phone">Mobile No</label>
									<input type="text" id="mobileNo" name="template-contactform-phone" value="" class="sm-form-control" />
								</div>

								<div class="clear"></div>
								
								<div class="col_full col_last">
									<label for="template-contactform-email">Email <small>*</small></label>
									<input type="email" id="email" name="template-contactform-email" value="" class="required email sm-form-control" />
								</div>

								<div class="clear"></div>

								<div class="col_full col_last">
									<label for="template-contactform-subject">Subject <small>*</small></label>
									<input type="text" id="subject" name="template-contactform-subject" value="" class="required sm-form-control" />
								</div>
								
								<div class="clear"></div>

								<div class="col_full">
									<label for="template-contactform-message">Message <small>*</small></label>
									<textarea class="required sm-form-control" id="message" name="template-contactform-message" rows="6" cols="30"></textarea>
								</div>

								<div class="col_full hidden">
									<input type="text" id="template-contactform-botcheck" name="template-contactform-botcheck" value="" class="sm-form-control" />
								</div>

								<div class="col_full">
									<button type="button" id="submit-button" tabindex="5" value="Submit" class="button button-3d nomargin" onclick="sendInquiryEmail()">Submit message</button>
								</div>

							</form>
						</div>

					</div><!-- Contact Form End -->

					<!-- Google Map
					============================================= -->
					<div class="col_half col_last">

						<section id="google-map" class="gmap" style="height: 410px;"></section>

					</div><!-- Google Map End -->

					<div class="clear"></div>

					<!-- Contact Info
					============================================= -->
					<div class="row clear-bottommargin">

						<div class="col-md-3 col-sm-6 bottommargin clearfix">
							<div class="feature-box fbox-center fbox-bg fbox-plain">
								<div class="fbox-icon">
									<a href="#"><i class="icon-map-marker2"></i></a>
								</div>
								<h3>Our Headquarters<span class="subtitle">Mandaluyong, PH</span></h3>
							</div>
						</div>

						<div class="col-md-3 col-sm-6 bottommargin clearfix">
							<div class="feature-box fbox-center fbox-bg fbox-plain">
								<div class="fbox-icon">
									<a href="#"><i class="icon-phone3"></i></a>
								</div>
								<h3>Speak to Us<span class="subtitle">(123) 456 7890</span></h3>
							</div>
						</div>

						<div class="col-md-3 col-sm-6 bottommargin clearfix">
							<div class="feature-box fbox-center fbox-bg fbox-plain">
								<div class="fbox-icon">
									<a href="#"><i class="icon-facebook2"></i></a>
								</div>
								<h3>Facebook<span class="subtitle">WinRadioPH</span></h3>
							</div>
						</div>

						<div class="col-md-3 col-sm-6 bottommargin clearfix">
							<div class="feature-box fbox-center fbox-bg fbox-plain">
								<div class="fbox-icon">
									<a href="#"><i class="icon-twitter2"></i></a>
								</div>
								<h3>Twitter<span class="subtitle">winradioph</span></h3>
							</div>
						</div>

					</div><!-- Contact Info End -->


					<!-- Modals -->
					<div class="modal1" id="successModal">
						<div class="block divcenter" style="background-color: #FFF; max-width: 500px;">
							<div class="center" style="padding: 50px;">
								<h3>Your message was sent</h3>
								<p class="nobottommargin">
									Thank you for your message! We'll get back to you as soon as we can. 
								</p>
							</div>
							<div class="section center nomargin" style="padding: 30px;">
								<a href="#" class="button" onClick="$.magnificPopup.close();return false;">close</a>
							</div>
						</div>
					</div>
					
					<div class="modal1 mfp-hide" id="errorModal">
						<div class="block divcenter" style="background-color: #FFF; max-width: 500px;">
							<div class="center" style="padding: 50px;">
								<h3>Something went wrong</h3>
								<p class="nobottommargin">
									Oops, looks like we're experiencing some technical difficulties. Please try again.
								</p>
							</div>
							<div class="section center nomargin" style="padding: 30px;">
								<a href="#" class="button" onClick="$.magnificPopup.close();return false;">close</a>
							</div>
						</div>
					</div>
					<!-- Modals End -->
					
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
			address: 'Mandaluyong, Philippines',
			maptype: 'ROADMAP',
			zoom: 14,
			markers: [
				{
					address: "Mandaluyong, Philippines",
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
		
		function sendInquiryEmail() {
			var fullName=$("#fullName").val();
	    	var mobileNo=$("#mobileNo").val();
	    	var email=$("#email").val();
	    	var subject=$("#subject").val();
	    	var message=$("#message").val();
	    	
	    	$.ajax({
	            url:'${pageContext.request.contextPath}/sendInquiryController',
	            data: {fullName: fullName, mobileNo: mobileNo, email: email, subject: subject, message: message},
	            type:'post',
	            cache:false,
	            success:function(data){
	            	if ($.trim(data) == 'success') {
	            	    $("#successModal").modal('show');
	            	} else {
	            	    $("#errorModal").modal('show');
	            	}
	            },
	            error:function(){
            	    $("#errorModal").modal('show');
	            }
			});
		}

	</script>

</body>
</html>