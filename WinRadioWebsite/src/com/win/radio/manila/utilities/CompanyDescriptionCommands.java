package com.win.radio.manila.utilities;

public interface CompanyDescriptionCommands {
	/* JSP SCRIPTS */
	public String GET_DESCRIPTION = "SELECT ID_DESCRIPTION, UPDATE_DATE, UPDATE_USER, "
			+ "CONTACT_PHONE, CONTACT_MOBILE, CONTACT_EMAIL, DESCRIPTION, COD_REGION "
			+ "FROM COMPANY_DESCRIPTION "
			+ "WHERE COD_REGION = ?";
			
	/* CONTROLLER SCRIPTS */
	
	public String ADD_DESCRIPTION = "INSERT INTO COMPANY_DESCRIPTION (CREATE_DATE, UPDATE_DATE, UPDATE_USER, " + 
			"DESCRIPTION, CONTACT_PHONE, CONTACT_MOBILE, CONTACT_EMAIL, COD_REGION) " + 
			"VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	
	public String UPDATE_DESCRIPTION = "UPDATE COMPANY_DESCRIPTION "
			+ "SET UPDATE_DATE = ?, UPDATE_USER = ?, DESCRIPTION = ?, "
			+ "CONTACT_PHONE = ?, CONTACT_MOBILE = ?, CONTACT_EMAIL = ?"
			+ "WHERE ID_DESCRIPTION = ?";
}
