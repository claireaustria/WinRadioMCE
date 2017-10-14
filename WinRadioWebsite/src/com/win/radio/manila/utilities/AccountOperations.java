package com.win.radio.manila.utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.win.radio.manila.models.AccountModel;

public class AccountOperations implements AccountCommands  {

	/* CONTROLLER FUNCTIONS */
	
	public static Integer addUser(AccountModel account){
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		Integer newId = 0;
		try {
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(ADD_ACCOUNT, Statement.RETURN_GENERATED_KEYS);
			pstmt.setTimestamp(1, account.getCreateDate());
			pstmt.setTimestamp(2, account.getUpdateDate());
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
			
			rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
			  newId = rs.getInt(1);
			}
		} catch (SQLException sqle){
			System.out.println("SQLException - addUser: " +sqle.getMessage());
			return newId;
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return newId;
	}
	
	public static boolean updateUser(AccountModel account) {
		
		PreparedStatement pstmt = null;
		Connection conn = null;
		try {
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(UPDATE_ACCOUNT);
			pstmt.setTimestamp(1, account.getUpdateDate());
			pstmt.setInt(2, account.getUpdateUser());	
			pstmt.setString(3, account.getCodType());	
			pstmt.setString(4, account.getUsername());	
			pstmt.setString(5, account.getEmail());	
			pstmt.setString(6, account.getLastName());	
			pstmt.setString(7, account.getFirstName());	
			pstmt.setString(8, account.getGender());	
			pstmt.setString(9, account.getMobileNo());	
			pstmt.setInt(10, account.getIdAccount());
			pstmt.executeUpdate(); 
		}	catch (SQLException sqle){
			System.out.println("SQLException - updateUser: " +sqle.getMessage());
			return false;
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return true;
	}
	
	public static boolean changePassword(AccountModel account) {
		PreparedStatement pstmt = null;
		Connection conn = null;
		try {
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(CHANGE_PASSWORD);
			pstmt.setTimestamp(1, account.getUpdateDate());
			pstmt.setInt(2, account.getUpdateUser());
			pstmt.setString(3, account.getPassword());
			pstmt.setInt(4, account.getIndChangePwd());
			pstmt.setInt(5, account.getIdAccount());	
			pstmt.executeUpdate(); 
		}	catch (SQLException sqle){
			System.out.println("SQLException - changePassword: " +sqle.getMessage());
			return false;
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return true;
	}
}
