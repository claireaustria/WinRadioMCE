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

@WebServlet("/checkIfUsernameExists")
public class CheckIfUsernameExistsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public CheckIfUsernameExistsController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter rspns = response.getWriter();
		String responseMessage = "";
		String username = request.getParameter("username");
	    
		new ConnectionUtil();
		Connection conn = null;
		ResultSet resultSet = null;
		
		try {
			conn = ConnectionUtil.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT USERNAME FROM ACCOUNT WHERE USERNAME = ?");
			pstmt.setString(1, username);
			resultSet = pstmt.executeQuery();
			
			while (resultSet.next()) {
				responseMessage = "Username already taken.";
			}
			
			rspns.println(responseMessage);
			rspns.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			try {
				if(conn!=null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
