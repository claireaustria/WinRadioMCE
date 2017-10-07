package com.win.radio.manila.utilities;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionUtil {
	
	public static Connection getConnection() throws SQLException, ClassNotFoundException {
		Class.forName("net.sourceforge.jtds.jdbc.Driver");
		Connection conn = DriverManager.getConnection(
				"jdbc:jtds:sqlserver://localhost:1433/WinRadio", "sa",
				"12345");
		
		return conn;
	}
}
