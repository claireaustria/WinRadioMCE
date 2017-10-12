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
import com.win.radio.manila.models.QOTDModel;

public class QOTDOperations implements QOTDCommands  {

	private static Connection getConnection(){
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
	
	/* JSP FUNCTIONS */
	
	/* Marvin - Codes Start */
	
	public static ResultSet getAllDJ() {
		ResultSet rs = null;
		try {
			Statement select = getConnection().createStatement();
				rs = select.executeQuery(GET_ALL_DJ);
		} catch(Exception ex) {
			ex.printStackTrace();
		}
		return rs;
	}
	
	/* Marvin - Codes End */
	
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
	
	public static ResultSet getEmailIfExisting(String email) {
		ResultSet rs = null;
		try{
	
			PreparedStatement pstmt = getConnection().prepareStatement(GET_EMAIL);
			pstmt.setString(1, email);
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
			pstmt.setInt(3, account.getUpdateUser());
			pstmt.setString(4, account.getCodType());
			pstmt.setString(5, account.getUsername());
			pstmt.setString(6, account.getPassword());
			pstmt.setString(7, account.getLastName());
			pstmt.setString(8, account.getFirstName());
			pstmt.setString(9, account.getGender());
			pstmt.setString(10, account.getMobileNo());
			pstmt.setString(11, account.getEmail());
			pstmt.setString(12, account.getCodStatus());
			pstmt.setString(13, account.getCodRegion());
			pstmt.executeUpdate(); 
		}	catch (SQLException sqle){
			System.out.println("SQLException - addUser: " +sqle.getMessage());
			return false;
		}
		return true;
	}
	
	public static boolean addQOTD(QOTDModel question) {
		try {
			PreparedStatement pstmt = getConnection().prepareStatement(ADD_QUESTION);
			pstmt.setDate(1, question.getCreateDate());
			pstmt.setDate(2, question.getUpdateDate());
			pstmt.setInt(3, question.getUpdateUser());
			pstmt.setString(4, question.getQuestion());
			pstmt.setInt(5, question.getPostOwner());
			pstmt.setString(6, question.getCodRegion());
			pstmt.executeUpdate(); 
		} catch (SQLException sqle) {
			System.out.println("SQLException - addQOTD: " +sqle.getMessage());
			return false;
		}
		return true;
	}
}
