package com.win.radio.manila.utilities;

public interface PSCommands {

	public String GET_DJ_NAME = "SELECT D.DJ_NAME, D.ID_ACCOUNT FROM DJLIST D " + 
			"LEFT JOIN ACCOUNT A ON D.ID_ACCOUNT = A.ID_ACCOUNT " + 
			"WHERE A.COD_STATUS = '" + CodeUtil.COD_STATUS_ACTIVE + "' ";
}
