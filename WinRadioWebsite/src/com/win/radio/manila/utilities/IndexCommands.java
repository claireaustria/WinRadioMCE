package com.win.radio.manila.utilities;

public interface IndexCommands {

	public String GET_ALL_MRH = "SELECT * FROM MOST_REQUESTED_HITS WHERE COD_REGION = '"+ CodeUtil.COD_REGION_MNL +"' ORDER BY ID_MRH ASC";
	
	public String GET_ALL_PROGRAM_NAME = "SELECT PROG_NAME FROM PROGRAM WHERE STATUS = '"+ CodeUtil.COD_BLOG_STATUS_PUBLISHED +"' AND COD_REGION = '"+ CodeUtil.COD_REGION_MNL +"'";

	public String GET_ALL_PROGRAM_INFO = "SELECT * FROM PROGRAM WHERE STATUS = '"+ CodeUtil.COD_PS_STATUS_PUBLISHED + "' AND COD_REGION = '"+ CodeUtil.COD_REGION_MNL + "'";
}
