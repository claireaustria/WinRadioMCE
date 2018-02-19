package com.win.radio.manila.utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.win.radio.manila.models.DJListModel;

public class DJListOperations implements DJListCommands {
	
	/* CONTROLLER FUNCTIONS */
	public static boolean addNewDJ(DJListModel djItem) {
		PreparedStatement pstmt = null;
		Connection conn = null;
		
		try {
			conn = ConnectionUtil.getConnection();
			pstmt= conn.prepareStatement(ADD_NEW_DJ);
			pstmt.setTimestamp(1, djItem.getCreateDate());
			pstmt.setTimestamp(2, djItem.getUpdateDate());
			pstmt.setInt(3, djItem.getUpdateUser());
			pstmt.setString(4, djItem.getDjName());
			pstmt.setString(5, djItem.getDescription());
			pstmt.setInt(6, djItem.getIdAccount());
			pstmt.setString(7, djItem.getCodRegion());
			
			pstmt.executeUpdate(); 
		}	catch (SQLException sqle){
			System.out.println("SQLException - addNewDJ: " +sqle.getMessage());
			return false;
		} 	finally {
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
	
	public static boolean updateDJ(DJListModel dj) {
		PreparedStatement pstmt = null;
		Connection conn = null;
		
		try {
			conn = ConnectionUtil.getConnection();
			pstmt= conn.prepareStatement(UPDATE_DJ);
			pstmt.setTimestamp(1, dj.getUpdateDate());
			pstmt.setInt(2, dj.getUpdateUser());
			pstmt.setString(3, dj.getDjName());
			pstmt.setString(4, dj.getDescription());
			pstmt.setInt(5, dj.getIdDJ());
			
			pstmt.executeUpdate(); 
		}	catch (SQLException sqle){
			System.out.println("SQLException - updateDJ: " +sqle.getMessage());
			return false;
		} 	finally {
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
	
	public static boolean setDjAccount(int idDj, int idAccount) {
		PreparedStatement pstmt = null;
		Connection conn = null;
		
		try {
			conn = ConnectionUtil.getConnection();
			pstmt= conn.prepareStatement(SET_DJ_ACCOUNT);
			pstmt.setInt(1, idDj);
			pstmt.setInt(2, idAccount);
			
			pstmt.executeUpdate(); 
		}	catch (SQLException sqle){
			System.out.println("SQLException - setDjAccount: " +sqle.getMessage());
			return false;
		} 	finally {
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
