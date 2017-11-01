package com.win.radio.manila.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/manila/admin/logout.html")
public class LogoutController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	public LogoutController() {
		super();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();  
        session.invalidate();  
		request.getSession(false);
		
        getServletContext().getRequestDispatcher("/manila/admin/adminLogin.jsp").forward(request,response);
	}	
}
