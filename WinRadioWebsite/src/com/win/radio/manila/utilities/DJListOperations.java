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
			pstmt.setDate(1, djItem.getCreateDate());
			pstmt.setDate(2, djItem.getUpdateDate());
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
	
}
