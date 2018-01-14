package com.win.radio.manila.utilities;

public interface CompanyDescriptionCommands {
	/* JSP SCRIPTS */
	public String GET_DESCRIPTION = "SELECT ID_DESCRIPTION, UPDATE_DATE, UPDATE_USER, "
			+ "CONTACT_PHONE, CONTACT_MOBILE, CONTACT_EMAIL, DESCRIPTION, COD_REGION "
			+ "FROM company_description "
			+ "WHERE COD_REGION LIKE ?";
			
	/* CONTROLLER SCRIPTS */
	
	public String ADD_DESCRIPTION = "INSERT INTO company_description (CREATE_DATE, UPDATE_DATE, UPDATE_USER, " + 
			"DESCRIPTION, CONTACT_PHONE, CONTACT_MOBILE, CONTACT_EMAIL, COD_REGION) " + 
			"VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	
	public String UPDATE_DESCRIPTION = "UPDATE company_description "
			+ "SET UPDATE_DATE = ?, UPDATE_USER = ?, DESCRIPTION = ?, "
			+ "CONTACT_PHONE = ?, CONTACT_MOBILE = ?, CONTACT_EMAIL = ?"
			+ "WHERE ID_DESCRIPTION = ?";
}
