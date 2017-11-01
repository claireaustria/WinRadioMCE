package com.win.radio.manila.utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import com.win.radio.manila.models.DramaModel;

public class DramaOperations implements DramaCommands {

	/* JSP FUNCTIONS */

	/* CONTROLLER FUNCTIONS */
	
	public static boolean addDrama(DramaModel drama) {
		PreparedStatement pstmt = null;
		Connection conn = null;
		
		try {
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(ADD_DRAMA);
			
			pstmt.setTimestamp(1, drama.getCreateDate());
			pstmt.setTimestamp(2, drama.getUpdateDate());
			pstmt.setInt(3, drama.getUpdateUser());
			pstmt.setString(4, drama.getTitle());
			pstmt.setString(5, drama.getDescription());
			pstmt.setString(6, drama.getFilename());
			pstmt.setString(7, drama.getImage());
			pstmt.setInt(8, drama.getStatus());
			pstmt.setString(9, drama.getCodRegion());
			pstmt.executeUpdate();
			
		} catch (SQLException sqle) {
			System.out.println("SQLException - addDrama: " + sqle.getMessage());
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

	public static boolean updateDrama(DramaModel drama) {
		PreparedStatement pstmt = null;
		Connection conn = null;
		
		try {
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(UPDATE_DRAMA);
			
			pstmt.setTimestamp(1, drama.getUpdateDate());
			pstmt.setInt(2, drama.getUpdateUser());
			pstmt.setString(3, drama.getTitle());
			pstmt.setString(4, drama.getDescription());
			pstmt.setString(5, drama.getFilename());
			pstmt.setString(6, drama.getImage());
			pstmt.setInt(7, drama.getIdEpisode());
			
			pstmt.executeUpdate();
			
		} catch (SQLException sqle) {
			System.out.println("SQLException - updateDrama: " + sqle.getMessage());
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
