package com.win.radio.manila.utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import com.win.radio.manila.models.BannerModel;
import com.win.radio.manila.models.DramaModel;

public class BannerOperations implements BannerCommands {

	/* JSP FUNCTIONS */

	/* CONTROLLER FUNCTIONS */
	
	public static boolean addSponsor(BannerModel banner) {
		
		PreparedStatement pstmt = null;
		Connection conn = null;
		
		try {
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(ADD_SPONSOR);
			
			pstmt.setTimestamp(1, banner.getCreateDate());
			pstmt.setTimestamp(2, banner.getUpdateDate());
			pstmt.setInt(3, banner.getUpdateUser());
			pstmt.setString(4, banner.getBrand());
			pstmt.setString(5, banner.getImage());
			pstmt.setString(6, banner.getStatus());
			pstmt.setString(7, banner.getCodRegion());
			pstmt.executeUpdate();
			
		} catch (SQLException sqle) {
			System.out.println("SQLException - addSponsor: " + sqle.getMessage());
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
	
	public static boolean updateSponsor(BannerModel banner) {
		PreparedStatement pstmt = null;
		Connection conn = null;
		
		try {
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(UPDATE_SPONSOR);
			
			pstmt.setTimestamp(1, banner.getUpdateDate());
			pstmt.setInt(2, banner.getUpdateUser());
			pstmt.setString(3, banner.getBrand());
			pstmt.setString(4, banner.getImage());
			pstmt.setInt(5, banner.getIdAd());
			
			pstmt.executeUpdate();
			
		} catch (SQLException sqle) {
			System.out.println("SQLException - updateBanner: " + sqle.getMessage());
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
	
	public static boolean updateSponsorStatus(BannerModel banner) {
		
		PreparedStatement pstmt = null;
		Connection conn = null;
		
		try {
			
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(UPDATE_SPONSOR_STATUS);
			
			pstmt.setTimestamp(1, banner.getUpdateDate());
			pstmt.setInt(2, banner.getUpdateUser());
			pstmt.setString(3, banner.getStatus());
			pstmt.setInt(4, banner.getIdAd());
			
			pstmt.executeUpdate();
			
		} catch (SQLException sqle) {
			System.out.println("SQLException - updateSponsorStatus" + sqle.getMessage());
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
