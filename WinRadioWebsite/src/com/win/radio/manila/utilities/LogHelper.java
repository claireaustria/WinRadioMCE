package com.win.radio.manila.utilities;

import java.sql.Date;

import com.win.radio.manila.models.EventLogModel;
import com.win.radio.manila.models.TransactionLogModel;

public class LogHelper {
	
	private static final Date currentDateTime = new java.sql.Date(new java.util.Date().getTime());
	/*
	 * Used to store user activity.
	 * Eg: account creation/modification, blog posting
	 * 
	 * */
	public static void insertTransactionLogs(int idAccount, String strTransactionName, String strDescription, String codRegion) {
				
		TransactionLogModel transactionLog = new TransactionLogModel();
		transactionLog.setCreateDate(currentDateTime);
		transactionLog.setUpdateDate(currentDateTime);
		transactionLog.setUpdateUser(Integer.toString(idAccount));
		transactionLog.setTransactionName(strTransactionName);
		transactionLog.setDescription(strDescription);
		transactionLog.setCodRegion(codRegion);
		
		try{
			new LogOperations();
			LogOperations.addTransactionLog(transactionLog);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}
	
	/*
	 * Used to store back-end events and errors.
	 * 
	 * */
	public static void insertEventLogs(int idAccount, String strEventName, String strDescription) {
		
		EventLogModel eventLog = new EventLogModel();
		eventLog.setCreateDate(currentDateTime);
		eventLog.setUpdateDate(currentDateTime);
		eventLog.setUpdateUser(Integer.toString(idAccount));
		eventLog.setEventName(strEventName);
		eventLog.setDescription(strDescription);
		eventLog.setCodRegion(CodeUtil.COD_REGION_MNL);
		
		try{
			new LogOperations();
			LogOperations.addEventLog(eventLog);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
