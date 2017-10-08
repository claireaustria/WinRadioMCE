package com.win.radio.manila.utilities;

public interface SocialMediaCommands {

	String DS_SOURCE="java:comp/env/jdbc/WinRadioDB";
	String CONNECTION_NOT_FOUND="Invalid connection. Unable to process request.";
	
	/* CONTROLLER SCRIPTS */
	public String ADD_NEW_SOCIAL_MEDIA = "INSERT INTO SOCIAL_MEDIA (CREATE_DATE, UPDATE_DATE, "+
		"UPDATE_USER, NAME, URL, REGION) VALUES (?, ?, ?, ?, ?, ?)"; 
	
	public String GET_SOCIAL_MEDIA_ACCTS = "SELECT ID_MEDIA, NAME, URL FROM SOCIAL_MEDIA " +
			"WHERE COD_REGION = '" + CodeUtil.COD_REGION_MNL + "'";
	
}
