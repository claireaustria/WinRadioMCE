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
import com.win.radio.manila.models.EventLogModel;
import com.win.radio.manila.models.SocialMediaModel;
import com.win.radio.manila.models.TransactionLogModel;

public class SocialMediaOperations implements SocialMediaCommands {

	private static Connection getConnection(){
		Connection connection = null;
		
		try{
			DataSource dataSource = 
			(DataSource) InitialContext.doLookup(DS_SOURCE);
			connection = dataSource.getConnection();
		}catch (NamingException e){
			e.printStackTrace();
		}catch (SQLException e){
			e.printStackTrace();
		}
		return connection;
	}
	
	/* CONTROLLER FUNCTIONS */
	public static boolean addSocialMediaAcct(SocialMediaModel soocialMediaAcct){
		try {
			PreparedStatement pstmt = getConnection().prepareStatement(ADD_NEW_SOCIAL_MEDIA);
			pstmt.setDate(1, soocialMediaAcct.getCreateDate());
			pstmt.setDate(2, soocialMediaAcct.getUpdateDate());
			pstmt.setString(3, soocialMediaAcct.getUpdateUser());
			pstmt.setString(4, soocialMediaAcct.getName());
			pstmt.setString(5, soocialMediaAcct.getUrl());
			pstmt.setString(6, soocialMediaAcct.getCodRegion());
			
			
			pstmt.executeUpdate(); 
		}		catch (SQLException sqle){
			System.out.println("SQLException - addSocialMediaAcct: " +sqle.getMessage());
			return false;
		}
		
		return true;
	}
}

