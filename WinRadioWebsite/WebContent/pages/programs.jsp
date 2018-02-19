<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.win.radio.manila.utilities.ConnectionUtil"%>
<%@page import="com.win.radio.manila.utilities.IndexOperations"%>
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
	<title>Programs | Win Radio Manila</title>

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
				<h1>Programs</h1>
			</div>

		</section><!-- #page-title end -->

		<!-- Content
		============================================= -->
		<section id="content">

			<div class="content-wrap">

				<div class="container clearfix">

					<div id="side-navigation" class="tabs customjs">

						<div class="col_one_third nobottommargin">
							
							<ul class="sidenav">
								<%
									ResultSet rs = null;
									ResultSet rs2 = null;
									Statement select = null;
									Connection conn = null;
									
									try{
										conn = ConnectionUtil.getConnection();
										select = conn.createStatement();
										rs = select.executeQuery(IndexOperations.GET_ALL_PROGRAM_NAME);
										
										int 	cnt = 1;
										
										if(rs.next()){
								%>
								
								<li class="ui-tabs-active"><a href="#snav-content<%=cnt%>"><i class="icon-screen"></i><%=rs.getString("PROG_NAME")%><i class="icon-chevron-right"></i></a></li>
									
								<%	
										}
										
										while(rs.next()){
											cnt++;
								%>
								<li><a href="#snav-content<%=cnt%>"><i class="icon-magic"></i><%=rs.getString("PROG_NAME")%><i class="icon-chevron-right"></i></a></li>
								<%			
										}
								%>
							</ul>

						</div>

						<div class="col_two_third col_last nobottommargin">
			
							<!--<div id="snav-content1">
								<img class="alignright img-responsive" width="100%" src="img/prog-sched.jpg" alt="">
							</div>-->
								<%
										rs2 = select.executeQuery(IndexOperations.GET_ALL_PROGRAM_INFO);
										int cnt2 = 1;
										while(rs2.next()){
								%>
							<div id="snav-content<%=cnt2%>">
								<h3><%=rs2.getString("PROG_NAME")%></h3>
								<p class="lead" style="white-space: pre-wrap;"><%=rs2.getString("DESCRIPTION")%></p>
							</div>
							<%
										cnt2++;
										}
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
				            			if (rs2 != null) {
				            				try {
				            					rs2.close();
				            				} catch (SQLException e) {
				            					e.printStackTrace();
				            				}
				            			}
				            			if (select != null) {
				            				try {
				            					select.close();
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

	<script>
		$(function() {
			$( "#side-navigation" ).tabs({ show: { effect: "fade", duration: 400 } });
		});
	</script>

</body>
</html>