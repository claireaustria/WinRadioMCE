package com.win.radio.manila.utilities;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Calendar;


public class TransactionLogOperations implements TransactionLogCommands {
	
	/*CONTROLLER FUNCTIONS*/
	public static boolean addTransactionLog(int intIdAccount, String transactionName, String description, String codRegion){
		
		PreparedStatement pstmt = null;
		Connection conn = null;
		
		try {
			Calendar cal = Calendar.getInstance();  
			java.sql.Timestamp timestamp = new java.sql.Timestamp(cal.getTimeInMillis());
			
			conn = ConnectionUtil.getConnection();
			
			pstmt = conn.prepareStatement(ADD_TRANSACTION_LOG);
			pstmt.setTimestamp(1, timestamp);
			pstmt.setTimestamp(2, timestamp);
			pstmt.setInt(3, intIdAccount);
			pstmt.setString(4, transactionName);
			pstmt.setString(5, description);
			pstmt.setString(6, codRegion);
			pstmt.executeUpdate(); 
		}	catch (SQLException sqle){
			System.out.println("SQLException - addTransactionLog: " +sqle.getMessage());
			return false;
		} finally {
			
			try {
				if (pstmt!=null) {
					pstmt.close();
				} 
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		return true;
	}
	
	
}
