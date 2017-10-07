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
				
		ResultSet resultSet = null;	
		ResultSet resultSet2 = null;
		try {
			
			new AccountOperations();
			resultSet = AccountOperations.getCredentials(username);
			
			while (resultSet.next()) {
				String rsUsername = resultSet.getString("USERNAME");
				String rsPassword = resultSet.getString("PASSWORD");
				int rIdAccount = resultSet.getInt("ID_ACCOUNT");
				
				if ((username.equals(rsUsername)) && (encryptedcode(password).equals(rsPassword))) {
					incorrect = "";
					// Session for Account ID
					HttpSession session = request.getSession();
					session.setAttribute("AccountID", resultSet.getInt("ID_ACCOUNT"));
					
					// Get COD_PROFILE using Account ID
					new AccountOperations();
					resultSet2 = AccountOperations.getAccountProfile(rIdAccount);
					
					// Session for COD_PROFILE
					session.setAttribute("CodProfile", resultSet2.getString("COD_PROFILE"));
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
			try {
				if(resultSet!=null) {
					resultSet.close();
				}
				if(resultSet2!=null) {
					resultSet2.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	String encryptedcode(String password) {
		String hash = String.valueOf(password.hashCode());
		return hash;
	}
}
