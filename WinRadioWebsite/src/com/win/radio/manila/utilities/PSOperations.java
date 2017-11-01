package com.win.radio.manila.utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.win.radio.manila.models.ProgramModel;

public class PSOperations implements PSCommands{
	
	public static boolean addProgram(ProgramModel program){
		PreparedStatement pstmt = null;
		Connection conn= null;
		try {
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(ADD_PROGRAM);
			pstmt.setTimestamp(1, program.getCreateDate());
			pstmt.setTimestamp(2, program.getUpdateDate());
			pstmt.setInt(3, program.getUpdateUser());
			pstmt.setString(4, program.getTitle());
			pstmt.setString(5, program.getDescription());
			pstmt.setString(6, program.getSchedule());
			pstmt.setString(7, program.getProgramDj());
			pstmt.setString(8, program.getCodRegion());
			pstmt.setString(9, program.getStatus());
			pstmt.executeUpdate();
			
		} catch (SQLException sqle) {
			System.out.println("SQLException - addProgram: " + sqle.getMessage());
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
	
	public static boolean updateProgram(ProgramModel program) {
		PreparedStatement pstmt = null;
		Connection conn = null;
		try {
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(UPDATE_PROGRAM);
			pstmt.setTimestamp(1, program.getUpdateDate());
			pstmt.setInt(2, program.getUpdateUser());
			pstmt.setString(3, program.getTitle());
			pstmt.setString(4, program.getDescription());
			pstmt.setString(5, program.getSchedule());
			pstmt.setString(6, program.getProgramDj());
			pstmt.setString(7, program.getStatus());
			pstmt.setInt(8, program.getIdProgram());
			pstmt.executeUpdate();
		}catch(SQLException sqle) {
			System.out.println("SQLException - updateProgram: " + sqle.getMessage());
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
