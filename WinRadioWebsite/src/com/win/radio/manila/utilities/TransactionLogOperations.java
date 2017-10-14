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
	
	/*CONTROLLER FUNCTIONS*/
	public static boolean addTransactionLog(int intIdAccount, String transactionName, String description, String codRegion){
		try {
			Date currentDateTime = new java.sql.Date(new java.util.Date().getTime());
			PreparedStatement pstmt = ConnectionUtil.getConnection().prepareStatement(ADD_TRANSACTION_LOG);
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
