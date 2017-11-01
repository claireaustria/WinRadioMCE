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

import com.win.radio.manila.utilities.ConnectionUtil;
import com.win.radio.manila.utilities.PSCommands;

@WebServlet("/psValueChecker")
public class ValueCheckerPSController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	public ValueCheckerPSController() {
		super();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter rspns = response.getWriter();
		String responseMessage = "";
		String psName = request.getParameter("programname");
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = null;
		
		try {
			conn = ConnectionUtil.getConnection();
			
			pstmt = conn.prepareStatement(PSCommands.GET_ALL_PS_NAME);
			pstmt.setString(1, psName);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				responseMessage = "Program name already taken";
			}
			
			rspns.println(responseMessage);
			rspns.close();
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) {
					rs.close();
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
