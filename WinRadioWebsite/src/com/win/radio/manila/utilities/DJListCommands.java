package com.win.radio.manila.utilities;

public interface DJListCommands {
	
	/*JSP SCRIPTS*/
	public String GET_ALL_DJ = "SELECT ID_DJ, DJ_NAME, DESCRIPTION FROM DJLIST WHERE COD_REGION = ?";

	/* CONTROLLER SCRIPTS */
	public String ADD_NEW_DJ = "INSERT INTO DJLIST (CREATE_DATE, UPDATE_DATE, UPDATE_USER, DJ_NAME, "
			+ "DESCRIPTION, ID_ACCOUNT, COD_REGION) VALUES (?, ?, ?, ?, ?, ?, ?)";
}
