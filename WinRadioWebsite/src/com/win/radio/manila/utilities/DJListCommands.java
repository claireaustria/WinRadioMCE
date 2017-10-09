package com.win.radio.manila.utilities;

public interface DJListCommands {

	String DS_SOURCE="java:comp/env/jdbc/WinRadioDB";
	String CONNECTION_NOT_FOUND="Invalid connection. Unable to process request.";
	
	/* CONTROLLER SCRIPTS */
	public String ADD_NEW_DJ = "INSERT INTO DJLIST (CREATE_DATE, UPDATE_DATE, UPDATE_USER, DJ_NAME, "
			+ "DESCRIPTION, COD_REGION) VALUES (?, ?, ?, ?, ?, ?)";
}
