package com.win.radio.manila.utilities;

public interface LogCommands {

	String DS_SOURCE="java:comp/env/jdbc/WinRadioDB";
	String CONNECTION_NOT_FOUND="Invalid connection. Unable to process request.";
	
	/* CONTROLLER SCRIPTS */
	public String ADD_TRANSACTION_LOG = "INSERT INTO TRANSACTION_LOG (CREATE_DATE, UPDATE_DATE, "+
		"UPDATE_USER, TRANSACTION_NAME, DESCRIPTION, COD_REGION) VALUES (?, ?, ?, ?, ?, ?)"; 
	
	public String ADD_EVENT_LOG = "INSERT INTO EVENT_LOG (CREATE_DATE, UPDATE_DATE, "+
			"UPDATE_USER, EVENT_NAME, DESCRIPTION, COD_REGION) VALUES (?, ?, ?, ?, ?, ?)"; 
}
