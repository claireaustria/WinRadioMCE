package com.win.radio.manila.utilities;

public interface MRHCommands {
	/* JSP SCRIPTS */
	public String GET_MRH_LIST = "SELECT TOP (10) RANK, TITLE, ARTIST " + 
			"FROM MOST_REQUESTED_HITS WHERE COD_REGION = ? " +
			"ORDER BY RANK ASC";
			
	/* CONTROLLER SCRIPTS */
	
	public String UPDATE_MRH = "UPDATE MOST_REQUESTED_HITS " +
			"SET UPDATE_DATE = ?, UPDATE_USER = ?, " +
			"TITLE = ?, ARTIST = ?, IMAGE = ? " +
			"WHERE RANK = ? AND COD_REGION = ?";
}
