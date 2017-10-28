package com.win.radio.manila.utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.win.radio.manila.models.CompanyDescriptionModel;
import com.win.radio.manila.models.MRHModel;

public class MRHOperations implements MRHCommands  {

	/* CONTROLLER FUNCTIONS */
	
	public static boolean updateMRH(MRHModel mrhItem){
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(UPDATE_MRH);
			pstmt.setTimestamp(1, mrhItem.getUpdateDate());
			pstmt.setInt(2, mrhItem.getUpdateUser());
			pstmt.setString(3, mrhItem.getTitle());
			pstmt.setString(4, mrhItem.getArtist());
			pstmt.setString(5, mrhItem.getImage());
			pstmt.setInt(6, mrhItem.getRank());
			pstmt.setString(7, mrhItem.getCodRegion());
			pstmt.executeUpdate(); 
		} catch (SQLException sqle){
			System.out.println("SQLException - updateMRH: " +sqle.getMessage());
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
}