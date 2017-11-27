package com.win.radio.manila.utilities;

public interface IndexCommands {

	public String GET_ALL_MRH = "SELECT * FROM MOST_REQUESTED_HITS WHERE COD_REGION = '"+ CodeUtil.COD_REGION_MNL +"' ORDER BY ID_MRH ASC";

}
