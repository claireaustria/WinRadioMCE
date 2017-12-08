<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    

<!-- Logo
============================================= -->
<div id="logo">
	<a href="index.jsp" class="standard-logo" data-dark-logo="img/logo.png"><img src="img/logo.png" alt="Win Radio Logo"></a>
	<a href="index.html" class="retina-logo" data-dark-logo="img/logo.png"><img src="img/logo.png" alt="Win Radio Logo"></a>
</div>
					
<!-- Navigation
============================================= -->
<nav id="primary-menu" class="dark">
	<ul>
		<li class="${pageContext.request.requestURI eq '/WinRadioWebsite/manila/pages/index.jsp' ? 'current' : ''}"><a class="" href="index.jsp"><div>Home</div></a></li>
		<li class="${pageContext.request.requestURI eq '/WinRadioWebsite/manila/pages/programs.jsp' ? 'current' : ''}"><a href="programs.jsp"><div>Programs</div></a></li>
		<li class="${pageContext.request.requestURI eq '/WinRadioWebsite/manila/pages/heart-stories.jsp' ? 'current' : ''}"><a href="heart-stories.jsp"><div>Heart Stories</div></a></li>
		<li class="${pageContext.request.requestURI eq '/WinRadioWebsite/manila/pages/dj-blogs.jsp' ? 'current' : ''}"><a href="dj-blogs.jsp"><div>DJ Blogs</div></a></li>
		<li class="${pageContext.request.requestURI eq '/WinRadioWebsite/manila/pages/about-us.jsp' ? 'current' : ''}"><a href="about-us.jsp"><div>About Us</div></a></li>
		<li><a href=""><div>Stream Audio</div></a></li>		
	</ul>
	
	<!-- Top Cart
	============================================= -->
	<div id="top-cart">
		<a href="#" id="top-cart-trigger">MNL <i class="fa fa-caret-down"></i></a>
		<div class="top-cart-content">
			<div class="top-cart-title">
				<h4>Change location</h4>
				<h5>Manila</h5>
				<h5>Cebu</h5>
				<h5>Iloilo</h5>
				<h5>Davao</h5>
				<h5>Cagayan de Oro</h5>
			</div>
		</div>
	</div><!-- #top-cart end -->
</nav>