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

import com.win.radio.manila.utilities.AccountCommands;
import com.win.radio.manila.utilities.AccountOperations;
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
	    
		ResultSet resultSet = null;
		PreparedStatement pstmt = null;
		Connection conn = null;
		
		try {
			conn = ConnectionUtil.getConnection();
			if (!username.equals("0")) {
				pstmt = conn.prepareStatement(AccountCommands.GET_USERNAME);
				pstmt.setString(1, username);
				resultSet = pstmt.executeQuery();
				
				while (resultSet.next()) {
					responseMessage = "Username already taken.";
				}
			} else if (!email.equals("0")) {
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
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
