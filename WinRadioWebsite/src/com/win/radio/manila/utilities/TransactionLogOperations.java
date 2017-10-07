package com.win.radio.manila.utilities;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class TransactionLogOperations implements TransactionLogCommands {

	private static Connection getConnection(){
		Connection connection = null;
		
		try{
			DataSource dataSource = 
			(DataSource) InitialContext.doLookup(DS_SOURCE);
			connection = dataSource.getConnection();
		}catch (NamingException e){
			e.printStackTrace();
		}catch (SQLException e){
			e.printStackTrace();
		}
		return connection;
	}
	
	/* JSP FUNCTIONS */
	public static ResultSet getTransactionLogs() {
		ResultSet rs = null;
		try{
			Statement select = getConnection().createStatement();
				rs = select.executeQuery(GET_TRANSACTION_LOGS);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return rs;
	}
	
}
