package com.win.radio.manila.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.win.radio.manila.utilities.AccountCommands;
import com.win.radio.manila.utilities.ConnectionUtil;

@WebServlet("/checkIfValueExists")
public class CheckIfValueExistsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public CheckIfValueExistsController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter rspns = response.getWriter();
		String responseMessage = "";
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		Integer idAccount = Integer.valueOf(request.getParameter("idAccount"));
		String acctEmail = "";
		String acctUsername = "";
	    
		ResultSet resultSet = null;
		ResultSet rsExistingAccount = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmtExistingAccount = null;
		Connection conn = null;
		
		try {
			conn = ConnectionUtil.getConnection();
			
			pstmtExistingAccount = conn.prepareStatement(AccountCommands.GET_CONTACT_DETAILS);
			pstmtExistingAccount.setInt(1, idAccount);
			rsExistingAccount = pstmtExistingAccount.executeQuery();
			
			while (rsExistingAccount.next()) {
				acctEmail = rsExistingAccount.getString("EMAIL");
				acctUsername = rsExistingAccount.getString("USERNAME");
			}
			
			if ((!username.equals(acctUsername))&&(!username.equals("0"))) {
				pstmt = conn.prepareStatement(AccountCommands.GET_USERNAME);
				pstmt.setString(1, username);
				resultSet = pstmt.executeQuery();
				
				while (resultSet.next()) {
					responseMessage = "Username already taken.";
				}
			} else if ((!email.equals(acctEmail))&&!email.equals("0")) {
				pstmt = conn.prepareStatement(AccountCommands.GET_EMAIL);
				pstmt.setString(1, email);
				resultSet = pstmt.executeQuery();
				
				while (resultSet.next()) {
					responseMessage = "Email already taken.";
				}
			}
			
			rspns.println(responseMessage);
			rspns.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(resultSet!=null) {
					resultSet.close();
				}
				if(conn!=null) {
					conn.close();
				}
				if(pstmt != null) {
					pstmt.close();
				}
				if(rsExistingAccount != null) {
					rsExistingAccount.close();
				}
				if(pstmtExistingAccount != null) {
					pstmtExistingAccount.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
