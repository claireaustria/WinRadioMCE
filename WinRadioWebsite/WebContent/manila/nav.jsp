<nav class="sidebar col-xs-12 col-sm-4 col-lg-3 col-xl-2 bg-faded sidebar-style-1">
	<h1 class="site-title"><a href="index.html"><em class="fa fa-rocket"></em> Win Radio</a></h1>
				
	<a href="#menu-toggle" class="btn btn-default" id="menu-toggle"><em class="fa fa-bars"></em></a>
				
	<ul class="nav nav-pills flex-column sidebar-nav">
		<li class="nav-item"><a class="nav-link ${pageContext.request.requestURI eq '/WinRadioWebsite/manila/admin.jsp' ? ' active' : ''}" href="admin.jsp"><em class="fa fa-dashboard"></em> Dashboard <span class="sr-only">(current)</span></a></li>
		<li class="nav-item"><a class="nav-link ${pageContext.request.requestURI eq '/WinRadioWebsite/manila/adminMRHMaintenance.jsp' ? ' active' : ''}" href="adminMRHMaintenance.jsp"><em class="fa fa-music"></em> Most Requested Hits</a></li>
		<li class="nav-item"><a class="nav-link ${pageContext.request.requestURI eq '/WinRadioWebsite/manila/adminDJMaintenance.jsp' ? ' active' : ''}" href="adminDJMaintenance.jsp"><em class="fa fa-headphones"></em> DJ List</a></li>
		<li class="nav-item"><a class="nav-link ${pageContext.request.requestURI eq '/WinRadioWebsite/manila/#.jsp' ? ' active' : ''}" href="#"><em class="fa fa-exclamation"></em> What's Hot </a></li>
		<li class="nav-item"><a class="nav-link ${pageContext.request.requestURI eq '/WinRadioWebsite/manila/adminProgramSchedule.jsp' ? ' active' : ''}" href="adminProgramSchedule.jsp"><em class="fa fa-film"></em> Program Sched</a></li>
		<li class="nav-item"><a class="nav-link ${pageContext.request.requestURI eq '/WinRadioWebsite/manila/#.jsp' ? ' active' : ''}" href="#"><em class="fa fa-file-audio-o"></em> Heart Stories </a></li>
		<li class="nav-item"><a class="nav-link ${pageContext.request.requestURI eq '/WinRadioWebsite/manila/adminDJBlog.jsp' ? ' active' : ''}" href="adminDJBlog.jsp"><em class="fa fa-pencil"></em> DJ Blogs </a> </li>
		<li class="nav-item"><a class="nav-link ${pageContext.request.requestURI eq '/WinRadioWebsite/manila/adminAboutUs.jsp' ? ' active' : ''}" href="adminAboutUs.jsp"><em class="fa fa-question"></em> About Us </a></li>
        <li class="nav-item"><a class="nav-link ${pageContext.request.requestURI eq '/WinRadioWebsite/manila/adminUserMaintenance.jsp' ? ' active' : ''}" href="adminUserMaintenance.jsp"><em class="fa fa-wrench"></em> User Maintenance</a></li>	
	</ul>
	
</nav>
