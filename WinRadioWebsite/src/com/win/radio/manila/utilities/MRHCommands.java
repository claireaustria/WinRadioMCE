package com.win.radio.manila.utilities;

public interface MRHCommands {
	/* JSP SCRIPTS */
	public String GET_MRH_LIST = "SELECT RANK, TITLE, ARTIST " + 
			"FROM MOST_REQUESTED_HITS WHERE COD_REGION LIKE ? " +
			"ORDER BY RANK ASC LIMIT 10";
			
	/* CONTROLLER SCRIPTS */
	
	public String UPDATE_MRH = "UPDATE MOST_REQUESTED_HITS " +
			"SET UPDATE_DATE = ?, UPDATE_USER = ?, " +
			"TITLE = ?, ARTIST = ?, IMAGE = ? " +
			"WHERE RANK = ? AND COD_REGION = ?";
}
