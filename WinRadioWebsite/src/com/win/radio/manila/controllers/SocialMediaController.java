package com.win.radio.manila.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/socialMediaController")
public class SocialMediaController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SocialMediaController() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//Date currentDateTime = new java.sql.Date(new java.util.Date().getTime());
		
	}

}
