package com.win.radio.manila.utilities;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ConnectionUtil {
	
	@SuppressWarnings("unused")
	public static Connection getConnection(){
		Connection connection = null;		
		try{
			DataSource dataSource = 
			(DataSource) InitialContext.doLookup(CodeUtil.DS_SOURCE);
			connection = dataSource.getConnection();
		}catch (NamingException e){
			e.printStackTrace();
		}catch (SQLException e){
			e.printStackTrace();
		}
		return connection;
	}
	
}
