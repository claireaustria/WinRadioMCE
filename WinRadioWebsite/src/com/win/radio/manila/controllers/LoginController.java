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
		
		new ConnectionUtil();
		Connection conn = null;
		
		ResultSet resultSet = null;	
		try {
			conn = ConnectionUtil.getConnection();
			
			PreparedStatement pstmt = conn.prepareStatement("SELECT USERNAME, PASSWORD FROM ACCOUNT WHERE USERNAME = ?");
			pstmt.setString(1, username);
			resultSet = pstmt.executeQuery();
			
			while (resultSet.next()) {
				String rsUsername = resultSet.getString("USERNAME");
				String rsPassword = resultSet.getString("PASSWORD");
				
				if ((username.equals(rsUsername)) && (encryptedcode(password).equals(rsPassword))) {
					incorrect = "";
				} else if (!encryptedcode(password).equals(rsPassword)) {
					incorrect = "password";
				}
			}
			
			PrintWriter rspns = response.getWriter();
			rspns.println(incorrect);
			rspns.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} 
	}

	String encryptedcode(String password) {
		String hash = String.valueOf(password.hashCode());
		return hash;
	}
}
