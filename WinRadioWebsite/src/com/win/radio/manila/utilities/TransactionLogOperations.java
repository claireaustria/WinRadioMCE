package com.win.radio.manila.utilities;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
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
	
	/*CONTROLLER FUNCTIONS*/
	public static boolean addTransactionLog(int intIdAccount, String transactionName, String description, String codRegion){
		try {
			Date currentDateTime = new java.sql.Date(new java.util.Date().getTime());
			PreparedStatement pstmt = getConnection().prepareStatement(ADD_TRANSACTION_LOG);
			pstmt.setDate(1, currentDateTime);
			pstmt.setDate(2, currentDateTime);
			pstmt.setInt(3, intIdAccount);
			pstmt.setString(4, transactionName);
			pstmt.setString(5, description);
			pstmt.setString(6, codRegion);
			pstmt.executeUpdate(); 
		}	catch (SQLException sqle){
			System.out.println("SQLException - addTransactionLog: " +sqle.getMessage());
			return false;
		}
		return true;
	}
	
	
}
