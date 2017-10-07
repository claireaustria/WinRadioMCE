<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.win.radio.manila.utilities.AccountOperations"%>
<%@include file="nav.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8">
	
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="Win Radio website">
	<meta name="author" content="Win Radio 2017">
	
	<title>Win Radio Admin</title>
	
    <!-- Bootstrap core CSS -->
    <link href="../core-css/bootstrap.min.css" rel="stylesheet">

    <!--Fonts-->
    <link href="../fonts/fonts.css" rel="stylesheet">
    
    <!-- Icons -->
    <link href="../core-css/font-awesome.css" rel="stylesheet">
    
    <!-- Plugin CSS -->
	<link href="../core-css/dataTables.bootstrap4.css" rel="stylesheet">
    
    <!-- Custom styles for this template -->
    <link href="custom-css/style.css" rel="stylesheet">
    <link href="custom-css/admin.css" rel="stylesheet">
</head>
<body>
	<div class="container-fluid" id="wrapper">
		<div class="row">
			
			<main class="col-xs-12 col-sm-8 offset-sm-4 col-lg-9 offset-lg-3 col-xl-10 offset-xl-2 pt-3 pl-4">
				<header class="page-header row justify-center">
					<div class="col-md-6 col-lg-8" >
						<h1 class="float-left text-center text-md-left">User Maintenance</h1>
					</div>
					
					<div class="dropdown user-dropdown col-md-6 col-lg-4 text-center text-md-right"><a class="btn btn-stripped dropdown-toggle" href="https://example.com" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<img src="img/profile-pic.jpg" alt="profile photo" class="circle float-left profile-photo" width="50" height="auto">
						
						<div class="username mt-1">
							<h4 class="mb-1">Username</h4>
							
							<h6 class="text-muted">Super Admin</h6>
						</div>
						</a>
						
						<div class="dropdown-menu dropdown-menu-right" style="margin-right: 1.5rem;" aria-labelledby="dropdownMenuLink"><a class="dropdown-item" href="#"><em class="fa fa-user-circle mr-1"></em> View Profile</a>
						     <a class="dropdown-item" href="#"><em class="fa fa-sliders mr-1"></em> Preferences</a>
						     <a class="dropdown-item" href="#"><em class="fa fa-power-off mr-1"></em> Logout</a></div>
					</div>
					
					<div class="clear"></div>
				</header>
								
				
				<!-- Buttons -->
				<div class="row">
					<div class="col-lg-12">
						<button type="submit" class="btn btn-primary btn-md float-right btn-options" id="btnNewUser">Create New User</button>
						<button type="submit" class="btn btn-primary btn-md float-right btn-options" id="btnModifyUser">Modify Details</button>
					</div>
				</div>
				
				<br />
				
				<!-- Users table -->
				<div class="row">
			        <div class="card mb-3">
			          <div class="card-body">
			            <div class="table-responsive">
			              <table class="table table-bordered" width="100%" id="dataTable" cellspacing="0">
			                <thead>
			                  <tr>
			                  	<th>Create Date</th>
			                    <th>Last Name</th>
			                    <th>First Name</th>
			                    <th>Account Type</th>
			                    <th>Username</th>
			                    <th>E-mail</th>
			                    <th>Account Status</th>
			                    <th>Status Date</th>
			                  </tr>
			                </thead>
			                <tbody>
			                 	<%
								try{	
								ResultSet rs = new AccountOperations().getAllUsers();
								while(rs.next()){
								
								%>
								<tr class="clickableRow">
									<td><%=rs.getString("CREATE_DATE") %></td>
									<td><%=rs.getString("LAST_NAME") %></td>	
									<td><%=rs.getString("FIRST_NAME") %></td>
									<td><%=rs.getString("ACCOUNT_TYPE") %></td>
									<td><%=rs.getString("USERNAME") %></td>
									<td><%=rs.getString("EMAIL") %></td>
									<td><%=rs.getString("ACCOUNT_STATUS") %></td>
									<td><%=rs.getString("UPDATE_DATE") %></td>
								</tr>
								<%}
								rs.close();  
								} catch (Exception e) {
									System.out.print(e.getMessage());
								e.printStackTrace();
								}
								%>
			                </tbody>
			              </table>
			            </div>
			          </div>  
			        </div>
		        </div>
			
			</main>
		</div>
	
	
	</div>

    <!-- Bootstrap core JavaScript -->
    <script src="../core-js/jquery-3.2.1.min.js"></script>
    <script src="../core-js/tether.min.js"></script>
    <script src="../core-js/bootstrap.min.js"></script>
    
    <script src="../core-js/jquery.dataTables.js"></script>
    <script src="../core-js/dataTables.bootstrap4.js"></script>
    <script src="custom-js/admin.js"></script>
    <script src="custom-js/sb-admin.min.js"></script>
   
    <script type="text/javascript">
    $(function() {
        
        /* Get all rows from your 'table' but not the first one 
         * that includes headers. */
        var rows = $('tr').not(':first');
        
        /* Create 'click' event handler for rows */
        rows.on('click', function(e) {
            
            /* Get current row */
            var row = $(this);
            
            /* Check if 'Ctrl', 'cmd' or 'Shift' keyboard key was pressed
             * 'Ctrl' => is represented by 'e.ctrlKey' or 'e.metaKey'
             * 'Shift' => is represented by 'e.shiftKey' */
            if ((e.ctrlKey || e.metaKey) || e.shiftKey) {
                /* If pressed highlight the other row that was clicked */
                row.addClass('highlight');
            } else {
                /* Otherwise just highlight one row and clean others */
                rows.removeClass('highlight');
                row.addClass('highlight');
            }
	            
	        });
	        
	        /* This 'event' is used just to avoid that the table text 
	         * gets selected (just for styling). 
	         * For example, when pressing 'Shift' keyboard key and clicking 
	         * (without this 'event') the text of the 'table' will be selected.
	         * You can remove it if you want, I just tested this in 
	         * Chrome v30.0.1599.69 */
	        $(document).bind('selectstart dragstart', function(e) { 
	            e.preventDefault(); return false; 
	        });
	        
	    });
    </script>
    
    
</body>
</html>
