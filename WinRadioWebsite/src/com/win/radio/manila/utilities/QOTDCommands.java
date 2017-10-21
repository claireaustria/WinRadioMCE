package com.win.radio.manila.utilities;

public interface QOTDCommands {
	
	/* JSP SCRIPTS */
	
	/* Marvin - Codes Start */
	
	/* For drop down list in Post Question form */
	public String GET_ALL_DJ = "SELECT ID_DJ, DJ_NAME FROM DJLIST";
	
	/* For QOTD Maintenance List */
	public String GET_ALL_QUESTION = "SELECT FORMAT(Q.CREATE_DATE, 'MMM dd hh:ss') AS CREATE_DATE, Q.QUESTION, "
			+ "Q.ID_QUESTION, Q.IND_POST, A.USERNAME, D.DJ_NAME, FORMAT(Q.UPDATE_DATE, 'MMM dd hh:ss') "
			+ "AS UPDATE_DATE FROM QOTD Q "
			+ "LEFT JOIN ACCOUNT A ON Q.UPDATE_USER = A.ID_ACCOUNT "
			+ "LEFT JOIN DJLIST D ON Q.POST_OWNER = D.ID_DJ "
			+ "WHERE A.COD_REGION = '" + CodeUtil.COD_REGION_MNL + "' "
			+ "ORDER BY Q.ID_QUESTION DESC";
	
	/* CONTROLLER SCRIPTS */
	
	public String ADD_QUESTION = "INSERT INTO QOTD (CREATE_DATE, UPDATE_DATE, UPDATE_USER, "
			+ "QUESTION, POST_OWNER, IND_POST, COD_REGION) " +
			" VALUES (?, ?, ?, ?, ?, 1, ?)";
	
	public String UPDATE_INDICATOR = "UPDATE QOTD SET IND_POST = 0 WHERE IND_POST = 1";
	
	/* Marvin - Codes End */
	
}
