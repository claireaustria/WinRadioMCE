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

public class AccountOperations implements AccountCommands  {

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
	
	public static ResultSet getAllUsers() {
		ResultSet rs = null;
		try{
			Statement select = getConnection().createStatement();
				rs = select.executeQuery(GET_ALL_USERS);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return rs;
	}
	
	public static ResultSet getAccountTypes() {
		ResultSet rs = null;
		try{
			Statement select = getConnection().createStatement();
				rs = select.executeQuery(GET_ACCOUNT_TYPES);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return rs;
	}
	
	public static ResultSet getIndChangePwd() {
		ResultSet rs = null;
		try{
			Statement select = getConnection().createStatement();
				rs = select.executeQuery(GET_IND_CHANGE_PWD);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return rs;
	}
	
	/* CONTROLLER FUNCTIONS */
	
	public static ResultSet getCredentials(String username) {
		ResultSet rs = null;
		try{
			PreparedStatement pstmt = getConnection().prepareStatement(GET_CREDENTIALS);
			pstmt.setString(1, username);
			rs = pstmt.executeQuery();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return rs;
	}
	
	public static ResultSet getUsernameIfExisting(String username) {
		ResultSet rs = null;
		try{
	
			PreparedStatement pstmt = getConnection().prepareStatement(GET_USERNAME);
			pstmt.setString(1, username);
			rs = pstmt.executeQuery();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return rs;
	}
	
	public static boolean addUser(AccountModel account){
		try {
			PreparedStatement pstmt = getConnection().prepareStatement(ADD_ACCOUNT);
			pstmt.setDate(1, account.getCreateDate());
			pstmt.setDate(2, account.getUpdateDate());
			pstmt.setString(3, account.getCodType());
			pstmt.setString(4, account.getUsername());
			pstmt.setString(5, account.getPassword());
			if (account.getCodType().equals(CodeUtil.COD_TYPE_DJ))
			{
				pstmt.setString(6, account.getScreenName());
			} else {
				pstmt.setString(6, account.getScreenName());
			}
			pstmt.setString(7, account.getLastName());
			pstmt.setString(8, account.getFirstName());
			pstmt.setString(9, account.getGender());
			pstmt.setString(10, account.getMobileNo());
			pstmt.setString(11, account.getEmail());
			pstmt.setString(12, account.getCodStatus());
			pstmt.setString(13, CodeUtil.COD_REGION_MNL);
			
			
			
			pstmt.executeUpdate(); 
		}		catch (SQLException sqle){
			System.out.println("SQLException - addUser: " +sqle.getMessage());
			return false;
		}
		return true;
	}
}
