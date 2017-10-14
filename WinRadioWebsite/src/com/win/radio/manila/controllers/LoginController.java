package com.win.radio.manila.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.win.radio.manila.utilities.AccountOperations;
import com.win.radio.manila.utilities.ConnectionUtil;


@WebServlet("/loginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginController() {
        super();
    }
	 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String incorrect = "username";
				
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = null;
		
		try {
			
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(AccountOperations.GET_CREDENTIALS);
			pstmt.setString(1, username);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				String rsUsername = rs.getString("USERNAME");
				String rsPassword = rs.getString("PASSWORD");
				int rsIdAccount = rs.getInt("ID_ACCOUNT");
				String rsCodAcctType = rs.getString("COD_TYPE");
				int rsIndChangePwd = rs.getInt("IND_CHANGE_PWD");
				
				if ((username.equals(rsUsername)) && (encryptedcode(password).equals(rsPassword))) {
					incorrect = "";
					// Account session 
					HttpSession session = request.getSession();
					session.setAttribute("idAccount", rsIdAccount);
					session.setAttribute("userName", rsUsername);
					session.setAttribute("codType", rsCodAcctType);
					session.setAttribute("indChangePwd", rsIndChangePwd);
					
				} else if (!encryptedcode(password).equals(rsPassword)) {
					incorrect = "password";
				}
			}
			
			PrintWriter rspns = response.getWriter();
			rspns.println(incorrect);
			rspns.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
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
	}

	String encryptedcode(String password) {
		String hash = String.valueOf(password.hashCode());
		return hash;
	}
}
