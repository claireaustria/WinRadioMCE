<div class="dropdown user-dropdown col-md-6 col-lg-4 text-center text-md-right">
	<a class="btn btn-stripped dropdown-toggle" href="https://example.com" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	<img src="img/profile-pic.jpg" alt="profile photo" class="circle float-left profile-photo" width="50" height="auto">
	
	<div class="username mt-1">
		<h4 class="mb-1"><%=session.getAttribute("userName")%></h4>
		
		<h6 class="text-muted"><%=session.getAttribute("codName")%></h6>
	</div>
	</a>
	
	<div class="dropdown-menu dropdown-menu-right" style="margin-right: 1.5rem;" aria-labelledby="dropdownMenuLink"><a class="dropdown-item" href="adminUpdateProfile.jsp"><em class="fa fa-user-circle mr-1"></em> View Profile</a>
		<a class="dropdown-item" href="logout.html"><em class="fa fa-power-off mr-1"></em> Logout</a>
	</div>
</div>
						