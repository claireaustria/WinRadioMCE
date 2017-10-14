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

	/* JSP FUNCTIONS */
	
	/* Marvin - Codes Start 
	
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
	
	*/
	
	public static ResultSet getAllQuestions() {
		ResultSet rs = null;
		
		try {
			Statement select = ConnectionUtil.getConnection().createStatement();
			rs = select.executeQuery(GET_ALL_QUESTION);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		return rs;
	}
	
	/* Marvin - Codes End */
	
	/* CONTROLLER FUNCTIONS */
	
	public static boolean addQOTD(QOTDModel question) {
		try {
			PreparedStatement pstmt = ConnectionUtil.getConnection().prepareStatement(ADD_QUESTION);
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
	
	public static boolean updateNewInd(QOTDModel question) {
		try {
			PreparedStatement pstmt = ConnectionUtil.getConnection().prepareStatement(UPDATE_INDICATOR);
			pstmt.executeUpdate();
		} catch (SQLException sqle) {
			System.out.println("");
			return false;
		}
		return true;
	}
}
