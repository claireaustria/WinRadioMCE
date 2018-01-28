package com.win.radio.manila.utilities;

public interface DJListCommands {
	
	/*JSP SCRIPTS*/
	public String GET_ALL_DJ = "SELECT DJ.ID_DJ, A.ID_ACCOUNT, DJ.DJ_NAME, DJ.DESCRIPTION " + 
			"FROM DJLIST DJ " + 
			"LEFT JOIN ACCOUNT A ON DJ.ID_ACCOUNT = A.ID_ACCOUNT " + 
			"WHERE A.COD_STATUS = 'STATUS001' " +
			"AND DJ.ID_DJ LIKE ? AND DJ.COD_REGION = ? " +
			"ORDER BY ID_DJ DESC";

	/* CONTROLLER SCRIPTS */
	public String ADD_NEW_DJ = "INSERT INTO DJLIST (CREATE_DATE, UPDATE_DATE, UPDATE_USER, DJ_NAME, "
			+ "DESCRIPTION, ID_ACCOUNT, COD_REGION) VALUES (?, ?, ?, ?, ?, ?, ?)";
	
	public String UPDATE_DJ = "UPDATE DJLIST " +
			"SET UPDATE_DATE = ?, UPDATE_USER = ?, DJ_NAME = ?, DESCRIPTION = ? WHERE ID_DJ = ?";
	
	
}
