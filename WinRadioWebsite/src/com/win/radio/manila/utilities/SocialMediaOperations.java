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
import com.win.radio.manila.models.CompanyDescriptionModel;
import com.win.radio.manila.models.EventLogModel;
import com.win.radio.manila.models.SocialMediaModel;
import com.win.radio.manila.models.TransactionLogModel;

public class SocialMediaOperations implements SocialMediaCommands {

	/* CONTROLLER FUNCTIONS */
public static boolean updateSocialLink(SocialMediaModel social) {
		
		PreparedStatement pstmt = null;
		Connection conn = null;
		try {
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(UPDATE_SOCIAL_LINK);
			pstmt.setTimestamp(1, social.getUpdateDate());
			pstmt.setInt(2, social.getUpdateUser());	
			pstmt.setString(3, social.getUrl());	
			pstmt.setInt(4, social.getIdMedia());	
			pstmt.executeUpdate(); 
		}	catch (SQLException sqle){
			System.out.println("SQLException - updateSocialLink: " +sqle.getMessage());
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

