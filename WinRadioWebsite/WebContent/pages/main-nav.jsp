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
		<li class="${pageContext.request.requestURI eq '/WinRadioWebsite/pages/index.jsp' ? 'current' : ''}"><a class="" href="index.jsp?region=<%=request.getParameter("region") %>"><div>Home</div></a></li>
		<li class="${pageContext.request.requestURI eq '/WinRadioWebsite/pages/programs.jsp' ? 'current' : ''}"><a href="programs.jsp?region=<%=request.getParameter("region") %>"><div>Programs</div></a></li>
		<li class="${pageContext.request.requestURI eq '/WinRadioWebsite/pages/heart-stories.jsp' ? 'current' : ''}"><a href="heart-stories.jsp?region=<%=request.getParameter("region") %>"><div>Heart Stories</div></a></li>
		<li class="${pageContext.request.requestURI eq '/WinRadioWebsite/pages/dj-blogs.jsp' ? 'current' : ''}"><a href="dj-blogs.jsp?region=<%=request.getParameter("region") %>"><div>DJ Blogs</div></a></li>
		<li class="${pageContext.request.requestURI eq '/WinRadioWebsite/pages/about-us.jsp' ? 'current' : ''}"><a href="about-us.jsp?region=<%=request.getParameter("region") %>"><div>About Us</div></a></li>
		<li><a href=""><div>Stream Audio</div></a></li>		
	</ul>
	
	<!-- Top Cart
	============================================= -->
	<div id="top-cart">
		<a href="#" id="top-cart-trigger"><%=request.getParameter("region") %> <b class="caret"></b></a>
		<div class="top-cart-content">
			<div class="top-cart-title">
				<li>
					<ul><a href="${pageContext.request.requestURI}?region=MNL">Manila</a></ul>
					<ul><a href="${pageContext.request.requestURI}?region=DVO">Davao</a></ul>
					<ul><a href="${pageContext.request.requestURI}?region=ILO">Iloilo</a></ul>
				</li>
				<!--  <h5>Manila</h5>
				<h5>Cebu</h5>
				<h5>Iloilo</h5>
				<h5>Davao</h5>
				<h5>Cagayan de Oro</h5>-->
			</div>
		</div>
	</div><!-- #top-cart end -->
</nav>