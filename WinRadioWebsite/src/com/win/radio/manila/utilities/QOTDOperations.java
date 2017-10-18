package com.win.radio.manila.utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import com.win.radio.manila.models.QOTDModel;

public class QOTDOperations implements QOTDCommands {

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

	public static boolean addQOTD(QOTDModel question) {

		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		//Integer newQuestion = 0;

		try {

			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(ADD_QUESTION);

			pstmt.setTimestamp(1, question.getCreateDate());
			pstmt.setTimestamp(2, question.getUpdateDate());
			pstmt.setInt(3, question.getUpdateUser());
			pstmt.setString(4, question.getQuestion());
			pstmt.setInt(5, question.getPostOwner());
			pstmt.setString(6, question.getCodRegion());
			pstmt.executeUpdate();

		} catch (SQLException sqle) {
			System.out.println("SQLException - addQOTD: " + sqle.getMessage());
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

	public static boolean updateNewInd(QOTDModel question) {
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
