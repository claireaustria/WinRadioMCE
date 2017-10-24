package com.win.radio.manila.utilities;

public interface BlogContentCommands {
	/* JSP SCRIPTS */
	public String GET_BLOG_POSTS = "SELECT FORMAT(B.CREATE_DATE, 'MMM dd') + ' ' + CONVERT(varchar(15),CAST(B.CREATE_DATE AS TIME),100) as 'CREATE_DATE', B.ID_BLOG, B.POST_OWNER, D.DJ_NAME, " + 
			"B.TITLE, SUBSTRING(B.CONTENT, 1,100) + '...' AS FORMATTED_CONTENT, B.CONTENT, B.STATUS, B.COD_REGION " + 
			"FROM BLOG_CONTENT B " + 
			"LEFT JOIN DJLIST D ON B.POST_OWNER = D.ID_DJ " + 
			"WHERE B.ID_BLOG LIKE ? AND B.COD_REGION = ? " +
			"ORDER BY B.ID_BLOG DESC";
			
	/* CONTROLLER SCRIPTS */
	
	public String UPDATE_BLOG_POST = "UPDATE BLOG_CONTENT " +
			"SET UPDATE_DATE = ?, UPDATE_USER = ?, TITLE = ?, CONTENT = ?, POST_OWNER = ?, " +
			"STATUS = ? WHERE ID_BLOG = ?";
}
