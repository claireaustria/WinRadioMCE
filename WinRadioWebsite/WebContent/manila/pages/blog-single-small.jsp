<%@page import="com.win.radio.manila.utilities.BlogContentCommands"%>
<%@page import="com.win.radio.manila.utilities.ConnectionUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
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
	<title>Bakit Nga Ba Tayo Iniiwan Ng Mahal Natin?</title>

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
	

		<!-- Content
		============================================= -->
		<section id="content">

			<div class="content-wrap">

				<div class="container clearfix">
					
					<%ResultSet rs = null;
            		PreparedStatement pstmt = null;
            		Connection conn = null;
            		
            		try{	 
                 	conn = ConnectionUtil.getConnection();
                 	pstmt = conn.prepareStatement(BlogContentCommands.GET_BLOG_POSTS);
                 	pstmt.setInt(1, Integer.valueOf(request.getParameter("idBlog")));
                 	pstmt.setString(2, "MNL");
                	rs = pstmt.executeQuery();
        				while(rs.next()) {
					%>

					<!-- Post Content
					============================================= -->
					<div class="postcontent nobottommargin clearfix">

						<div class="single-post nobottommargin">

							<!-- Single Post
							============================================= -->
							<div class="entry clearfix">

								<!-- Entry Title
								============================================= -->
								<div class="entry-title">
									<h2><%=rs.getString("TITLE") %></h2>
								</div><!-- .entry-title end -->

								<!-- Entry Meta
								============================================= -->
								<ul class="entry-meta clearfix">
									<li><%=rs.getString("DJ_NAME") %></li>
									<li><i class="icon-calendar3"></i> <%=rs.getString("DATE_POSTED") %></li>
									<li><a href="#"><i class="icon-comments"></i> 13 Comments</a></li>
								</ul><!-- .entry-meta end -->

								<!-- Entry Content
								============================================= -->
								<div class="entry-content notopmargin">

									<!-- Entry Image
									============================================= -->
									<div class="entry-image alignleft">
										<a href="#"><img src="img/blog.jpg" alt="Blog Single"></a>
									</div><!-- .entry-image end -->

									<p style="white-space: pre-wrap;"><%=rs.getString("CONTENT") %></p>
									<!-- Post Single - Content End -->

								
									<div class="clear"></div>

									<!-- Post Single - Share
									============================================= -->
									<div class="si-share noborder clearfix">
										<span>Share this Post:</span>
										<div>
											<a href="#" class="social-icon si-borderless si-facebook">
												<i class="icon-facebook"></i>
												<i class="icon-facebook"></i>
											</a>
											<a href="#" class="social-icon si-borderless si-twitter">
												<i class="icon-twitter"></i>
												<i class="icon-twitter"></i>
											</a>
											<a href="#" class="social-icon si-borderless si-email3">
												<i class="icon-email3"></i>
												<i class="icon-email3"></i>
											</a>
										</div>
									</div><!-- Post Single - Share End -->

								</div>
							</div><!-- .entry end -->


							<!-- Post Author Info
							============================================= -->
							<div class="panel panel-default">
								<div class="panel-heading">
									<h3 class="panel-title">Posted by <span><a href="#"><%=rs.getString("DJ_NAME") %></a></span></h3>
								</div>
								<div class="panel-body">
									<div class="author-image">
										<img src="http://placehold.it/150x190.jpg" alt="" class="img-circle">
									</div>
									<%=rs.getString("DJ_DESC") %>
								</div>
							</div><!-- Post Single - Author End -->
							<%	}
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
		            			if (pstmt != null) {
		            				try {
		            					pstmt.close();
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
									
							<div class="line"></div>

							<h4>Related Posts:</h4>

							<div class="related-posts clearfix">

								<div class="col_half nobottommargin">

									<div class="mpost clearfix">
										<div class="entry-image">
											<a href="#"><img src="images/blog/small/10.jpg" alt="Blog Single"></a>
										</div>
										<div class="entry-c">
											<div class="entry-title">
												<h4><a href="#">This is an Image Post</a></h4>
											</div>
											<ul class="entry-meta clearfix">
												<li><i class="icon-calendar3"></i> 10th July 2014</li>
												<li><a href="#"><i class="icon-comments"></i> 12</a></li>
											</ul>
											<div class="entry-content">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia nisi perferendis.</div>
										</div>
									</div>

									<div class="mpost clearfix">
										<div class="entry-image">
											<a href="#"><img src="images/blog/small/20.jpg" alt="Blog Single"></a>
										</div>
										<div class="entry-c">
											<div class="entry-title">
												<h4><a href="#">This is a Video Post</a></h4>
											</div>
											<ul class="entry-meta clearfix">
												<li><i class="icon-calendar3"></i> 24th July 2014</li>
												<li><a href="#"><i class="icon-comments"></i> 16</a></li>
											</ul>
											<div class="entry-content">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia nisi perferendis.</div>
										</div>
									</div>

								</div>

								<div class="col_half nobottommargin col_last">

									<div class="mpost clearfix">
										<div class="entry-image">
											<a href="#"><img src="images/blog/small/21.jpg" alt="Blog Single"></a>
										</div>
										<div class="entry-c">
											<div class="entry-title">
												<h4><a href="#">This is a Gallery Post</a></h4>
											</div>
											<ul class="entry-meta clearfix">
												<li><i class="icon-calendar3"></i> 8th Aug 2014</li>
												<li><a href="#"><i class="icon-comments"></i> 8</a></li>
											</ul>
											<div class="entry-content">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia nisi perferendis.</div>
										</div>
									</div>

									<div class="mpost clearfix">
										<div class="entry-image">
											<a href="#"><img src="images/blog/small/22.jpg" alt="Blog Single"></a>
										</div>
										<div class="entry-c">
											<div class="entry-title">
												<h4><a href="#">This is an Audio Post</a></h4>
											</div>
											<ul class="entry-meta clearfix">
												<li><i class="icon-calendar3"></i> 22nd Aug 2014</li>
												<li><a href="#"><i class="icon-comments"></i> 21</a></li>
											</ul>
											<div class="entry-content">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia nisi perferendis.</div>
										</div>
									</div>

								</div>

							</div>

							<!-- Comments
							============================================= -->
							<div id="comments" class="clearfix">

								<h3 id="comments-title">Comments</h3>

								<!-- Disqus Comments
								============================================= -->
								<div id="disqus_thread"></div>

							</div><!-- #comments end -->

						</div>

					</div><!-- .postcontent end -->

					<!-- Sidebar
					============================================= -->
					<div class="sidebar nobottommargin col_last clearfix">
						<div class="sidebar-widgets-wrap">

							<div class="widget widget-twitter-feed clearfix">

								<h4>Twitter Feed</h4>
								<ul class="iconlist twitter-feed" data-username="winradioph" data-count="2">
									<li></li>
								</ul>

								<a href="#" class="btn btn-default btn-sm fright">Follow Us on Twitter</a>

							</div>
						</div>

							
					</div><!-- .sidebar end -->

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

	<script type="text/javascript">
		/* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
		var disqus_shortname = 'canvas-html'; // required: replace example with your forum shortname

		/* * * DON'T EDIT BELOW THIS LINE * * */
		(function() {
			var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
			dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
			(document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
		})();

	</script>
	<!-- Disqus Comments end -->

</body>
</html>