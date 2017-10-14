package com.win.radio.manila.utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.win.radio.manila.models.AccountModel;
import com.win.radio.manila.models.EventLogModel;
import com.win.radio.manila.models.TransactionLogModel;

public class LogOperations implements LogCommands {

	/* CONTROLLER FUNCTIONS */
	public static boolean addTransactionLog(TransactionLogModel transactionLog){
		try {
			PreparedStatement pstmt = ConnectionUtil.getConnection().prepareStatement(ADD_TRANSACTION_LOG);
			pstmt.setDate(1, transactionLog.getCreateDate());
			pstmt.setDate(2, transactionLog.getUpdateDate());
			pstmt.setString(3, transactionLog.getUpdateUser());
			pstmt.setString(4, transactionLog.getTransactionName());
			pstmt.setString(5, transactionLog.getDescription());
			pstmt.setString(6, transactionLog.getCodRegion());
			
			
			pstmt.executeUpdate(); 
		}		catch (SQLException sqle){
			System.out.println("SQLException - addTransactionLog: " +sqle.getMessage());
			return false;
		}
		
		return true;
	}
	
	public static boolean addEventLog(EventLogModel eventLog){
		try {
			PreparedStatement pstmt = ConnectionUtil.getConnection().prepareStatement(ADD_EVENT_LOG);
			pstmt.setDate(1, eventLog.getCreateDate());
			pstmt.setDate(2, eventLog.getUpdateDate());
			pstmt.setString(3, eventLog.getUpdateUser());
			pstmt.setString(4, eventLog.getEventName());
			pstmt.setString(5, eventLog.getDescription());
			pstmt.setString(6, eventLog.getCodRegion());
			
			
			pstmt.executeUpdate(); 
		}		catch (SQLException sqle){
			System.out.println("SQLException - addEventLog: " +sqle.getMessage());
			return false;
		}
		
		return true;
	}
}

