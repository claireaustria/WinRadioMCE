package com.win.radio.manila.utilities;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ConnectionUtil {

	public static Connection getConnection() {		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			//Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/winradio?autoReconnect=true&useSSL=false", "root", "sa123");
			Connection conn = DriverManager.getConnection("jdbc:mysql://mysql3000.mochahost.com/winradio_winradiodb?autoReconnect=true&useSSL=false", "winradio_root", "sa123");
			return conn;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return null;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
}
