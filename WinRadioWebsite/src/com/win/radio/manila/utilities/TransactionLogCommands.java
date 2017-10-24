package com.win.radio.manila.utilities;

public interface TransactionLogCommands {
	
	/* JSP SCRIPTS */
	public String GET_TRANSACTION_LOGS = "SELECT TOP (5) FORMAT(T.CREATE_DATE, 'MMM dd') + ' ' + CONVERT(varchar(15),CAST(T.CREATE_DATE AS TIME),100) as 'CREATE_DATE', A.FIRST_NAME + ' ' + A.LAST_NAME + ' ' + T.DESCRIPTION AS 'EVENT' " + 
			"FROM TRANSACTION_LOG T " + 
			"LEFT JOIN ACCOUNT A ON T.UPDATE_USER = A.ID_ACCOUNT " + 
			"ORDER BY ID_TRANSACTION DESC";
	
	/*CONTROLLER SCRIPT*/
	public String ADD_TRANSACTION_LOG = "INSERT INTO TRANSACTION_LOG (CREATE_DATE, UPDATE_DATE, UPDATE_USER, "
			+ "TRANSACTION_NAME, DESCRIPTION, COD_REGION) VALUES (?, ?, ?, ?, ?, ?)";
}
