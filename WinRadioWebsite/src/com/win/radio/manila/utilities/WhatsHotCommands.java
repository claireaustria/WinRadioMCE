package com.win.radio.manila.utilities;

public interface WhatsHotCommands {
	/* JSP SCRIPTS */
	public String GET_WHATS_HOT = "SELECT DATE_FORMAT(w.CREATE_DATE, '%b %d, %Y - %h:%i %p') as CREATE_DATE, " + 
			"DATE_FORMAT(w.UPDATE_DATE, '%b %d, %Y - %h:%i %p') as UPDATE_DATE, " + 
			"DATE_FORMAT(w.CREATE_DATE, '%b %d, %Y') as DATE_POSTED, " + 
			"w.ID_ENTRY, w.POST_OWNER, D.ID_DJ, D.DJ_NAME, D.DESCRIPTION AS DJ_DESC, w.CONTENT, A.FIRST_NAME AS UPDATE_USER, " + 
			"w.TITLE, CONCAT(SUBSTRING(w.CONTENT,1,100), '...') AS FORMATTED_CONTENT, w.STATUS, w.COD_REGION, " + 
			"CONCAT(SUBSTRING(w.CONTENT,1,300), '...') AS BLOG_PREVIEW  " + 
			"FROM whats_hot w " + 
			"LEFT JOIN djlist D ON w.POST_OWNER = D.ID_DJ " + 
			"LEFT JOIN account A ON w.UPDATE_USER = A.ID_ACCOUNT " + 
			"WHERE w.ID_ENTRY LIKE ? AND w.COD_REGION LIKE ? " + 
			"ORDER BY w.ID_ENTRY DESC";
			
	/* CONTROLLER SCRIPTS */
	
	public String UPDATE_BLOG_POST = "UPDATE BLOG_CONTENT " +
			"SET UPDATE_DATE = ?, UPDATE_USER = ?, TITLE = ?, CONTENT = ?, POST_OWNER = ?, " +
			"STATUS = ? WHERE ID_BLOG = ?";
	
	public String CREATE_ENTRY = "INSERT INTO BLOG_CONTENT (CREATE_DATE, UPDATE_DATE, UPDATE_USER, " +
			"TITLE, CONTENT, POST_OWNER, STATUS, PREVIEW, POSTING_DATE, URL, COD_REGION) " +
			"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
}
