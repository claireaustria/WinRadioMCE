package com.win.radio.manila.utilities;

public interface BannerCommands {

	/* JSP SCRIPTS */

	public String GET_BANNER_ADS = "SELECT TOP (10) UPDATE_DATE, UPDATE_USER, "
			+ "BRAND, IMAGE FROM BANNER WHERE COD_REGION = 'MNL' ORDER BY ID_AD ASC";

	/* CONTROLLER SCRIPTS */

}
