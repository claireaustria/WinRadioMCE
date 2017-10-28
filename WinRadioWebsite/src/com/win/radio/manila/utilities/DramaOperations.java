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

	/* Marvin - Codes Start */

	public static ResultSet getAllQuestions() {
		ResultSet rs = null;

		try {
			Statement select = ConnectionUtil.getConnection().createStatement();
			rs = select.executeQuery(GET_ALL_QUESTION);
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return rs;
	}

	/* Marvin - Codes End */

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

	public static boolean updateQOTD(DramaModel question) {

		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;

		try {

			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(UPDATE_QUESTION);

			pstmt.setTimestamp(1, question.getUpdateDate());

			pstmt.executeUpdate();

		} catch (SQLException sqle) {
			System.out.println("SQLException - updateQOTD: " + sqle.getMessage());
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

	public static boolean updateQuestionStatus(DramaModel question) {

		PreparedStatement pstmt = null;
		Connection conn = null;

		try {

			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(UPDATE_QUESTION_STATUS);

			pstmt.setTimestamp(1, question.getUpdateDate());
			pstmt.setInt(2, question.getUpdateUser());

			pstmt.executeUpdate();
		} catch (SQLException sqle) {
			System.out.println("SQLException - updateQuestionStatus" + sqle.getMessage());
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

	public static boolean updateNewInd(DramaModel question) {
		try {
			PreparedStatement pstmt = ConnectionUtil.getConnection().prepareStatement(UPDATE_INDICATOR);
			pstmt.executeUpdate();
		} catch (SQLException sqle) {
			System.out.println("");
			return false;
		}
		return true;
	}
}
