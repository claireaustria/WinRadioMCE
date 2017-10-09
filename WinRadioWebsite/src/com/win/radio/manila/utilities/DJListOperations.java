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
	public static boolean addNewDJ(DJListModel djItem) {
		try {
			PreparedStatement pstmt = getConnection().prepareStatement(ADD_NEW_DJ);
			pstmt.setDate(1, djItem.getCreateDate());
			pstmt.setDate(2, djItem.getUpdateDate());
			pstmt.setString(3, djItem.getUpdateUser());
			pstmt.setString(4, djItem.getDjName());
			pstmt.setString(5, djItem.getDescription());
			pstmt.setString(6, djItem.getCodRegion());
			
			pstmt.executeUpdate(); 
		}	catch (SQLException sqle){
			System.out.println("SQLException - addNewDJ: " +sqle.getMessage());
			return false;
		}
		return true;
	}
	
}
