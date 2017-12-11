package com.win.radio.manila.utilities;

public interface BlogContentCommands {
	/* JSP SCRIPTS */
	public String GET_BLOG_POSTS = "SELECT DATE_FORMAT(B.CREATE_DATE, '%b %d, %Y %h:%i') as CREATE_DATE, " + 
			"DATE_FORMAT(B.UPDATE_DATE, '%b %d, %Y %h:%i') as UPDATE_DATE, " +
			"DATE_FORMAT(B.CREATE_DATE, '%b %d, %Y') as DATE_POSTED, " + 
			"B.ID_BLOG, B.POST_OWNER, D.ID_DJ, D.DJ_NAME, D.DESCRIPTION AS DJ_DESC, B.CONTENT, A.FIRST_NAME AS UPDATE_USER, " + 
			"B.TITLE, CONCAT(SUBSTRING(B.CONTENT,1,100), '...') AS FORMATTED_CONTENT, B.STATUS, B.COD_REGION, " + 
			"CONCAT(SUBSTRING(B.CONTENT,1,300), '...') AS BLOG_PREVIEW  " + 
			"FROM BLOG_CONTENT B " + 
			"LEFT JOIN DJLIST D ON B.POST_OWNER = D.ID_DJ " + 
			"LEFT JOIN ACCOUNT A ON B.UPDATE_USER = A.ID_ACCOUNT " + 
			"WHERE B.ID_BLOG LIKE ? AND B.COD_REGION LIKE ? " + 
			"ORDER BY B.ID_BLOG DESC";
			
	/* CONTROLLER SCRIPTS */
	
	public String UPDATE_BLOG_POST = "UPDATE BLOG_CONTENT " +
			"SET UPDATE_DATE = ?, UPDATE_USER = ?, TITLE = ?, CONTENT = ?, POST_OWNER = ?, " +
			"STATUS = ? WHERE ID_BLOG = ?";
	
	public String CREATE_BLOG_POST = "INSERT INTO BLOG_CONTENT (CREATE_DATE, UPDATE_DATE, UPDATE_USER, TITLE, CONTENT, POST_OWNER, STATUS, COD_REGION) " +
			"VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
}
