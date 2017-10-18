package com.win.radio.manila.utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.win.radio.manila.models.CompanyDescriptionModel;

public class CompanyDescriptionOperations implements CompanyDescriptionCommands  {

	/* CONTROLLER FUNCTIONS */
	
	public static boolean addDescription(CompanyDescriptionModel companyDescription){
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		Integer newId = 0;
		try {
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(ADD_DESCRIPTION);
			pstmt.setTimestamp(1, companyDescription.getCreateDate());
			pstmt.setTimestamp(2, companyDescription.getUpdateDate());
			pstmt.setInt(3, companyDescription.getUpdateUser());
			pstmt.setString(4, companyDescription.getDescription());
			pstmt.setString(5, companyDescription.getContactPhone());
			pstmt.setString(6, companyDescription.getContactMobile());
			pstmt.setString(7, companyDescription.getContactEmail());
			pstmt.setString(8, companyDescription.getCodRegion());
			pstmt.executeUpdate(); 
			
			rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
			  newId = rs.getInt(1);
			}
		} catch (SQLException sqle){
			System.out.println("SQLException - addDescription: " +sqle.getMessage());
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
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return true;
	}
	
	public static boolean updateDescription(CompanyDescriptionModel companydescription) {
		
		PreparedStatement pstmt = null;
		Connection conn = null;
		try {
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(UPDATE_DESCRIPTION);
			pstmt.setTimestamp(1, companydescription.getUpdateDate());
			pstmt.setInt(2, companydescription.getUpdateUser());	
			pstmt.setString(3, companydescription.getDescription());	
			pstmt.setString(4, companydescription.getContactPhone());	
			pstmt.setString(5, companydescription.getContactMobile());	
			pstmt.setString(6, companydescription.getContactEmail());	
			pstmt.setInt(7, companydescription.getIdDescription());	
			pstmt.executeUpdate(); 
		}	catch (SQLException sqle){
			System.out.println("SQLException - updateDescription: " +sqle.getMessage());
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